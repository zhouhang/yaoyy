import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangbin on 2017/4/7.
 */
public class SupplierTest {


    public static void main(String[] args) {
        String val = "麦冬,知母,三棱,穿心莲,白芍,乌药,鸡内金,厚朴,桑椹,大黄,续断,大黄,关黄柏,升麻,大血藤,玉米须,钩藤,蜂房,合欢花,砂仁,广藿香,柴胡,柏子仁,酸枣仁,夏枯草,桃仁,苦杏仁,鳖甲,龟甲,鹿角,紫河车,淡竹叶,胖大海,苏木,莲子,龙骨,丹参,杜仲,柴胡,荆芥,蒲公英,黄芩,大枣,太子参,竹茹,皂角刺,肉苁蓉,山茱萸,薤白,桑叶,云芝,大腹皮,仙灵脾,钩藤,柏子仁,红花,橘络,五味子,黄柏,灵芝,白鲜皮,葛根,瓜蒌子,桔梗,金樱子,郁金,桑螵蛸,土鳖虫,蝉蜕,川牛膝,蒲黄,橘核,白扁豆,干姜,肉豆蔻,小茴香,石莲子,蒺藜,麦冬,栀子,化橘红,百部,苍术,赤芍,射干,升麻,木香,白果,谷芽,麦芽,牡丹皮,红花,甘草,甘草,白果,拳参,升麻,白头翁,南沙参,威灵仙,蝉蜕,乌梅,知母,款冬花,茜草,连翘,预知子,紫花地丁,川楝子,补骨脂,仙茅,大风子,木蝴蝶,西青果,芦荟,番泻叶,乳香,天竺黄,丹参,淫羊藿,茵陈,蒲公英,艾叶,泽兰,溪";

        String[] valArr =   val.split(",");

        Map<String,Integer> map = new HashMap<>();

        for(String v : valArr){
            if(map.containsKey(v)){
               map.put(v,map.get(v)+1);
            }else{
                map.put(v,1);
            }
        }

         map.forEach((String k, Integer v)->{
//             if(v.equals(1)){
//                 System.out.print(k+",");
//             }
             if(v.equals(3)){
                 System.out.print(k+",");
             }

         });


        //System.out.println(map.size());

    }
}
