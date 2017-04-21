package com.ms.tools.editor;


import java.beans.PropertyEditorSupport;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CustomDateEditor extends PropertyEditorSupport {

	public String getAsText() {
		Date value = (Date) getValue();
		if (null == value) {
			value = new Date();
		}
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return df.format(value);
	}

	public void setAsText(String text) throws IllegalArgumentException {
		Date value = null;
		int length = text.length();
		System.out.println(length);
		if (null != text && !text.equals("")) {
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (text.length()<12) {
				text += " 00:00:00";
			}
			if(text.length()==16){
				text += ":00";
			}

			try {
				value = df.parse(text);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		setValue(value);
	}
}
