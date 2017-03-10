package com.ms.service.observer;

import com.google.common.base.Strings;
import com.ms.dao.SendSampleDao;
import com.ms.dao.model.*;
import com.ms.dao.vo.PayRecordVo;
import com.ms.dao.vo.PickCommodityVo;
import com.ms.dao.vo.PickVo;
import com.ms.dao.vo.SendSampleVo;
import com.ms.service.*;
import com.ms.service.enums.MessageEnum;
import com.ms.service.sms.SmsUtil;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.kefu.WxMpKefuMessage;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Author: koabs
 * 12/5/16.
 * 消费消息监听器
 */
@Component
public class MsgProducerListener implements ApplicationListener<MsgProducerEvent>{

    @Autowired
    private MessageService messageService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private WxMpService wxService;

    @Autowired
    private PickService pickService;

    @Autowired
    SendSampleService sendSampleService;

    @Autowired
    PayRecordService payRecordService;

    @Autowired
    UserService userService;

    @Autowired
    SmsUtil smsUtil;

    @Autowired
    SendSampleDao sendSampleDao;

    @Override
    @Async
    public void onApplicationEvent(MsgProducerEvent event) {
        Message message = new Message();
        message.setType(event.getType().get());
        message.setEventId(event.getEventId());
        message.setContent(event.getContent());
        message.setUserId(event.getUserId());
        message.setIsMember(event.getIsMember());

        //供应商商品消息 直接保存
        Integer[] supplierM = {30,31,32};
        List<Integer> supplierMS = Arrays.asList(supplierM);
        if (supplierMS.contains(event.getType().get())){
            messageService.create(message);
            return;
        }

        // 1. 判断消息处理类型 客服,用户
        // 2. 客服 存入数据库中待消费
        // 3. 用户发送微信或者短信消息
        Integer[] cs = {6,7,0,1};
        List<Integer> csL = Arrays.asList(cs);
        if (csL.contains(event.getType().get())){
            Integer[] ms = {0,1};
            List<Integer> msL = Arrays.asList(ms);
            if (msL.contains(event.getType().get())) {
                //客服消息通知 只有选货登记和寄样时才保存消息到数据库.
                messageService.create(message);
            }

            List<Member> memberList =memberService.findOpenIdNotNull();
            SendMsg msg;
            // 选货单
            if (event.getType() == MessageEnum.PICK) {
                PickVo pickVo = pickService.findVoById(event.getEventId());
                msg = MsgBuild.build(pickVo,MessageEnum.PICK);
            } else if (event.getType() == MessageEnum.SAMPLE) { //寄样
                SendSampleVo sendSampleVo = sendSampleService.findDetailById(event.getEventId());
                msg = MsgBuild.build(sendSampleVo);
            } else {
                PayRecordVo vo = payRecordService.findVoById(event.getEventId());
                msg = MsgBuild.build(vo,event.getType());
            }
            //发送微信消息给绑定微信的人
            memberList.forEach(m-> {
                sendMessage(msg, m.getOpenid());
            });
        } else {
            // 用户提交寄样申请发送确认消息.
            if (event.getType() == MessageEnum.SAMPLE_C) {
                SendSample sendSample = sendSampleDao.findById(event.getEventId());
                try {
                    smsUtil.sendSample(event.getContent(), sendSample.getPhone());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return;
            }
            // 寄样申请通过发送通知消息.
            if (event.getType() == MessageEnum.SAMPLE_CONFIRM) {
                SendSample sendSample = sendSampleDao.findById(event.getEventId());
                try {
                    smsUtil.sendSampleConfirm(sendSample.getNickname(), sendSample.getPhone());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return;
            }

            //用户消息通知
            User user = userService.findById(event.getUserId());
            PickVo pickVo = pickService.findVoById(event.getEventId());
            SendMsg msg = MsgBuild.build(pickVo, event.getType());
            if (!Strings.isNullOrEmpty(user.getOpenid())) {
                // openId 不为空发送微信消息
                sendMessage(msg, user.getOpenid());
            }
            // 判断发货发送短信
            // 支付成功发送短信通知用户
            Integer[] custom = {3,4,9};
            List<Integer> customL = Arrays.asList(custom);
            if (customL.contains(event.getType().get())) {
                String text;
                if (event.getType() == MessageEnum.PICK_CONFIRM){
                    text = MsgBuild.buildSMS(pickVo);
                } else {
                    text = "【药优优】" + msg.content;
                }
                // 发送短信
                try {
                    smsUtil.sendPickConfirm(text, user.getPhone());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public void sendMessage(SendMsg msg,String openId) {
            try {
                WxMpKefuMessage.WxArticle article1 = new WxMpKefuMessage.WxArticle();
                article1.setDescription(msg.content);
                article1.setTitle(msg.title);

                if (!Strings.isNullOrEmpty(msg.url)) {
                    article1.setUrl(msg.url);
                }

                WxMpKefuMessage message = WxMpKefuMessage
                        .NEWS()
                        .toUser(openId)
                        .addArticle(article1)
                        .build();
                wxService.getKefuService().sendKefuMessage(message);
            } catch (Exception e) {
                e.printStackTrace();
            }
    }
}
