package com.ms.tools.utils.gson.adapter;





import com.google.gson.*;
import org.apache.commons.lang.StringUtils;

import java.io.IOException;
import java.lang.reflect.Type;

/**
 * Created by xiao on 2016/11/25.
 */
public class StringDefaultAdapter  implements  JsonDeserializer<String> {


    @Override
    public String deserialize(JsonElement jsonElement, Type type, JsonDeserializationContext jsonDeserializationContext) throws JsonParseException {
        String text=jsonElement.getAsString();
        return htmlEncode(text);
    }

    public static String htmlEncode(String source) {
        if (source == null) {
            return "";
        }
        String html = "";
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < source.length(); i++) {
            char c = source.charAt(i);
            switch (c) {
                case '<':
                    buffer.append("&lt;");
                    break;
                case '>':
                    buffer.append("&gt;");
                    break;
                case '&':
                    buffer.append("&amp;");
                    break;
                case '"':
                    buffer.append("&quot;");
                    break;
                case 10:
                case 13:
                    break;
                default:
                    buffer.append(c);
            }
        }
        html = buffer.toString();
        return html;
    }



}