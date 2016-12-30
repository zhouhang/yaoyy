import com.ms.Application;
import com.ms.service.properties.SystemProperties;
import com.ms.service.properties.WechatProperties;
import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.bean.kefu.WxMpKefuMessage;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by wangbin on 2016/12/2.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@org.springframework.boot.test.context.SpringBootTest(classes = Application.class)
public class SpringBootTest {

    @Autowired
    private WxMpService wxService;


    @Test
    public void sendKeFuMessage() {
        try {
            WxMpKefuMessage.WxArticle article1 = new WxMpKefuMessage.WxArticle();
            article1.setDescription("王彬 提交了一个新的寄样申请 " +
                    "\n\n商品：三棱 去毛统个、长2cm-6cm、直径2cm-4cm" +
                    "\n姓名：王彬" +
                    "\n手机号：18801285391" +
                    "\n地区：湖北武汉" +
                    "\n\n请在后台寄样列表查看");


            article1.setTitle("新寄样申请通知");


            WxMpKefuMessage message  = WxMpKefuMessage
                    .NEWS()
                    .toUser("oQmRps5sNt0QHgYpqGggc2xqRQB0")
                    .addArticle(article1)
                    .build();
            wxService.getKefuService().sendKefuMessage(message);
        }catch (Exception e){
            e.printStackTrace();
        }

    }



}
