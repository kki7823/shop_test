<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Simple Shopping Mall:index.jsp</title>
    <link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#996600" topmargin="100">
<%@ include file="top.jsp" %>

<table width="75%" align="center" bgcolor="#ffff99" height="100%">
    <%
        if (session.getAttribute("idKey") != null) {
    %>
    <tr>
        <td><%=session.getAttribute("idKey")%>님 방문해 주셔서 감사합니다.</td>
    </tr>
    <%
    } else {
        System.out.println(id);
    %>
    <tr>
        <td align="center">로그인하신 후, 이용해주세요</td>
    </tr>
    <%
        }
    %>
</table>

<%@ include file="bottom.jsp" %>
</body>
</html>