import com.ms.Application;
import com.ms.service.properties.WechatProperties;
import me.chanjar.weixin.mp.api.WxMpConfigStorage;
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
    private WechatProperties wechatProperties;

    @Autowired
    private WxMpConfigStorage configStorage;

    @Test
    public void contextLoads() {

        String appid = configStorage.getAppId();

        String testVal =   wechatProperties.getAppId();
        System.out.println("----------------------------------"+testVal+"-----------------");
    }

}
