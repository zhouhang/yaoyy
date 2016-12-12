package com.ms.service.observer;

import com.ms.dao.model.Member;
import com.ms.dao.model.Message;
import com.ms.service.MemberService;
import com.ms.service.MessageService;
import com.ms.service.enums.MessageEnum;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.kefu.WxMpKefuMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

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
                des="有人提交选货单";
                title="您有新的消息";
                sendMessage(des,title,m.getOpenid());
            }
            /**
             * 寄样
             */
            else if(event.getType()== MessageEnum.SAMPLE){
                des="有人提交寄样";
                title="您有新的消息";
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
