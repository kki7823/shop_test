<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="mMgr" class="com.gikim.mall.MemberMgr"/>
<%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    boolean check = mMgr.checkId(id);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 존재 확인 : idCheck.jsp</title>
    <script type="text/javascript" src="script.js"></script>
    <link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#ffffcc">
<%--DB로부터 아이디의 존재 여부를 확인하여 사용자에게 사용가능 여부를 알려주는 역할 담당--%>
<br/>
<div align="center">
    <b><%=id%></b>
    <%
        if(check){
            out.print("는 이미 존재하는 아이디 입니다. ");
        }else {
            out.print("는 사용 가능한 아이디 입니다. ");
        }
    %>
    <a href="javascript:this.close();">닫기</a>
</div>

</body>
</html>