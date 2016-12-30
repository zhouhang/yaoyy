package com.ms.service.observer;

import com.ms.dao.model.Member;
import com.ms.dao.model.Message;
import com.ms.dao.vo.PickCommodityVo;
import com.ms.dao.vo.PickVo;
import com.ms.dao.vo.SendSampleVo;
import com.ms.service.MemberService;
import com.ms.service.MessageService;
import com.ms.service.PickService;
import com.ms.service.SendSampleService;
import com.ms.service.enums.MessageEnum;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.kefu.WxMpKefuMessage;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
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

    @Override
    public void onApplicationEvent(MsgProducerEvent event) {
        Message message = new Message();
        message.setType(event.getType().get());
        message.setEventId(event.getEventId());
        message.setContent(event.getContent());
        message.setUserId(event.getUserId());
        /**
         * 发送微信消息给绑定微信的人
         */

        messageService.create(message);
        List<Member> memberList =memberService.findOpenIdNotNull();
        memberList.forEach(m->{
            /**
             * 选货单
             */
            String des="";
            String title="";
            if(event.getType()== MessageEnum.PICK){
                PickVo pickVo=pickService.findVoById(event.getEventId());
                List<String> names=new ArrayList<>();
                pickVo.getPickCommodityVoList().forEach(c->{
                    names.add(c.getName());
                });
                des=pickVo.getNickname() +" 提交了一个新订货登记通知 " +
                        "\n\n商品：" + StringUtils.join(names,",")+
                        "\n姓名：" +pickVo.getNickname()+
                        "\n手机号：" +pickVo.getPhone()+
                        "\n\n请在后台选货单列表查看";




                title="新订货登记通知";
                sendMessage(des,title,m.getOpenid());
            }
            /**
             * 寄样
             */
            else if(event.getType()== MessageEnum.SAMPLE){
                SendSampleVo sendSampleVo=sendSampleService.findDetailById(event.getEventId());
                List<String> names=new ArrayList<>();
                sendSampleVo.getCommodityList().forEach(c->{
                    names.add(c.getName() + ' ' + c.getOrigin() + ' ' + c.getSpec());
                });
                des=sendSampleVo.getNickname() +" 新寄样申请通知 " +
                        "\n\n商品：" +StringUtils.join(names,"\n")+
                        "\n姓名：" +sendSampleVo.getNickname()+
                        "\n手机号：" +sendSampleVo.getPhone()+
                        "\n地区：" +sendSampleVo.getArea()+
                        "\n\n请在后台寄样列表查看";
                title="新寄样申请通知";
                sendMessage(des,title,m.getOpenid());
            }
        });

    }

    public void sendMessage(String des,String title,String openId) {
        try {
            WxMpKefuMessage.WxArticle article1 = new WxMpKefuMessage.WxArticle();
            article1.setDescription(des);
            article1.setTitle(title);


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
