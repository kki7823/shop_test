package com.gikim.mall;

import java.text.DateFormat;
import java.text.NumberFormat;
import java.util.Date;
import java.util.StringTokenizer;

public class UtilMgr {
    public static String getContent(String comment){
        return br("","<br/>",comment);
    }

    public static String br(String first,String brTag, String comment){
        StringBuffer buffer = new StringBuffer();
        StringTokenizer st = new StringTokenizer(comment,"\n");
        int count = st.countTokens();
        buffer.append(first);
        int i =1;
        while (st.hasMoreTokens()){
            if(i==count){
                buffer.append(st.nextToken());
            }else {
                buffer.append(st.nextToken()).append(brTag);
            }
            i++;
        }
        return buffer.toString();
    }

    public static String monFormat(String b){
        String won;
        double bb = Double.parseDouble(b);
        won = NumberFormat.getIntegerInstance().format(bb);
        return won;
    }

    public static String monFormat(int b){
        String won;
        double bb = b;
        won = NumberFormat.getIntegerInstance().format(bb);
        return won;
    }

    public static String getDay(){
        Date now = new Date();
        DateFormat df = DateFormat.getDateInstance();
        return df.format(now).toString();
    }

}