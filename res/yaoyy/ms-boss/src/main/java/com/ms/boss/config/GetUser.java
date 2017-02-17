package com.ms.boss.config;

import com.ms.dao.model.Member;
import com.ms.service.enums.RedisEnum;
import com.sucai.compentent.logs.api.GetLogUser;
import com.sucai.compentent.logs.api.LogUser;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;

/**
 * Author: koabs
 * 2/16/17.
 */
@Component
public class GetUser implements GetLogUser {

    @Override
    public LogUser getLogUser() {
        LogUser user = new LogUser();
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession httpSession = attr.getRequest().getSession(true); // true == allow create
        if (httpSession != null) {
            Member mem = (Member) httpSession.getAttribute(RedisEnum.MEMBER_SESSION_BOSS.getValue());
            if (mem!= null) {
                user.setUserId(Long.valueOf(mem.getId()));
                user.setUserName(mem.getUsername());
            }
        }
        return user;
    }

}
