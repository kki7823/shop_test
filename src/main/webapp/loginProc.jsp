<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<jsp:useBean id="mMgr" class="com.gikim.mall.MemberMgr"/>
<%
    String id = request.getParameter("id");
    String pwd = request.getParameter("pwd");
    int mode = mMgr.loginMember(id,pwd);
    System.out.println("mode :"+mode);
    System.out.println("id : "+id);

    if(mode==0){
        response.sendRedirect("logError.jsp?mode=0");   //id : false
    }else if(mode==1){
        response.sendRedirect("logError.jsp?mode=1");   //id : ture, pw : false
    }else if(mode==2){
        session.setAttribute("idKey",id);   // id : true, pw : true
        response.sendRedirect("index.jsp");
    }
%>

