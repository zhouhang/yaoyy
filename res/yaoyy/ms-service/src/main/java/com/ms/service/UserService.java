package com.ms.service;

import com.github.pagehelper.PageInfo;
import com.ms.dao.model.User;
import com.ms.dao.vo.UserDetailVo;
import com.ms.dao.vo.UserVo;
import me.chanjar.weixin.mp.bean.result.WxMpUser;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;

public interface UserService extends ICommonService<User>{


    public PageInfo<UserVo> findByParams(UserVo userVo,Integer pageNum,Integer pageSize);

    public UserVo findByPhone(String phone);
    public UserVo findByOpenId(String openId);

    public UserVo findById(Integer id);

    public void disable(Integer id);

    public void enable(Integer id);

    public void login(Subject subject, UsernamePasswordToken token);

    public void logout();

    public User loginSms(String phone, String code);

    public void register(String phone, String code, String password);

    public UserVo sign(UserVo userVo, UserDetailVo userDetailVo);

    public User registerWechat(String phone,String openId,String nickname,String headImgUrl);

    public void sendRegistSms(String phone);

    public void sendLoginSms(String phone);

    public void sendResetPasswordSms(String phone);

    public void resetPassword(String phone, String code, String password);

    /**
     * 供应商登入
     * @param subject
     * @param token
     * @param wxMpUser
     */
    void login(Subject subject, UsernamePasswordToken token, WxMpUser wxMpUser);

    public PageInfo<UserVo> findVoByParams(UserVo userVo,Integer pageNum,Integer pageSize);

    public void signSave(UserVo userVo);
}
