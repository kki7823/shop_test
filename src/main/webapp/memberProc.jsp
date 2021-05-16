<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mMgr" class="com.gikim.mall.MemberMgr"/>
<jsp:useBean id="mBean" class="com.gikim.mall.MemberBean"/>
<jsp:setProperty name="mBean" property="*"/>
<%
    boolean flag = mMgr.insertMember(mBean);
%>

<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 확인</title>
    <link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#ffffcc">
<br/>
<br/>
<div align="center">
    <%
        if(flag){
            out.print("<b>회원가입을 축하 드립니다.</b><p>");
            out.print("<a href=login.jsp>로그인</a>");
        }else {
            out.print("<b>다시 입력하여 주십시오</b><p>");
            out.print("<a href=member.jsp>다시가입</a>");
        }
    %>
</div>

</body>
</html>
