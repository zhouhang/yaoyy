import com.ms.Application;
import com.ms.dao.model.User;
import com.ms.service.UserService;
import com.ms.service.properties.SystemProperties;
import com.ms.service.properties.WechatProperties;
import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.kefu.WxMpKefuMessage;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * Created by wangbin on 2016/12/2.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@org.springframework.boot.test.context.SpringBootTest(classes = Application.class)
public class SpringBootTest {

    @Autowired
    private UserService userService;


    @Test
    public void userTest(){

        List<User> userList = userService.findAll();
        System.out.println(userList);
    }



}
