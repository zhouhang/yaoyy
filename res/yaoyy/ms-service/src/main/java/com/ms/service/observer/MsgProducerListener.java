package com.ms.service.observer;

import com.google.common.base.Strings;
import com.ms.dao.model.Member;
import com.ms.dao.model.Message;
import com.ms.dao.model.PayRecord;
import com.ms.dao.model.User;
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

    @Override
    public void onApplicationEvent(MsgProducerEvent event) {
        Message message = new Message();
        message.setType(event.getType().get());
        message.setEventId(event.getEventId());
        message.setContent(event.getContent());
        message.setUserId(event.getUserId());
        // 1. 判断消息处理类型 客服,用户
        // 2. 客服 存入数据库中待消费
        // 3. 用户发送微信或者短信消息
        Integer[] cs = {6,7,0,1};
        List<Integer> csL = Arrays.asList(cs);
        if (csL.contains(event.getType())){
            //客服消息通知
            messageService.create(message);
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
            //用户消息通知
            User user = userService.findById(event.getUserId());
            if (!Strings.isNullOrEmpty(user.getOpenid())){
                // openId 不为空发送微信消息
                SendMsg msg;
                PickVo pickVo = pickService.findVoById(event.getEventId());
                if (pickVo != null) {
                    msg = MsgBuild.build(pickVo, event.getType());
                    sendMessage(msg, user.getOpenid());
                }

            }

            if (event.getType() == MessageEnum.PICK_CONFIRM){
                PickVo pickVo = pickService.findVoById(event.getEventId());
                // 发送短信
                try {
                    smsUtil.sendPickConfirm(MsgBuild.buildSMS(pickVo), user.getPhone());
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

            if (!Strings.isNullOrEmpty(msg.url)){
                article1.setUrl(msg.url);
            }

            WxMpKefuMessage message  = WxMpKefuMessage
                    .NEWS()
                    .toUser(openId)
                    .addArticle(article1)
                    .build();
            wxService.getKefuService().sendKefuMessage(message);
        }catch (Exception e){
            e.printStackTrace();
        }

    }





}
