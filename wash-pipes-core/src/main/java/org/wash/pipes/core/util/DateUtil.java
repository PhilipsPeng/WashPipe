package org.wash.pipes.core.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class DateUtil {
	
	public static String currentTime() {
		TimeZone time = TimeZone.getTimeZone("GMT+8"); 
		time = TimeZone.getDefault();
//		System.out.println(time);
		TimeZone.setDefault(time);
		Calendar calendar = Calendar.getInstance();
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Date date = calendar.getTime(); 
		String str = sdf.format(date);
//		System.out.println(str);
		
		return str;
	}
}
