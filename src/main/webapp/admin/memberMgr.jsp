<%@ page import="java.util.Vector" %>
<%@ page import="com.gikim.mall.MemberBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="mMgr" class="com.gikim.mall.MemberMgr"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memberMgr.jsp</title>
    <link href="../style.css" rel="stylesheet" type="text/css">
    <script language="JavaScript" src="script.js"></script>
</head>

<body bgcolor="#996600" topmargin="100">
<%@ include file="top.jsp" %>
<%
    Vector<MemberBean> vlist = mMgr.getMemberList();
%>

<table width="75%" align="center" bgcolor="#ffff99">
    <tr>
        <td align="center" bgcolor="#ffffcc">

            <table width="95%" align="center" bgcolor="#ffff99" border="1">
                <tr align="center" bgcolor="#996600">
                    <th><font color="#ffffff">회원이름</font></th>
                    <th><font color="#ffffff">회원아이디</font></th>
                    <th><font color="#ffffff">회원비밀번호</font></th>
                    <th><font color="#ffffff">회원성별</font></th>
                    <th><font color="#ffffff">회원생년월일</font></th>
                    <th><font color="#ffffff">회원이메일</font></th>
                    <th><font color="#ffffff">수정</font></th>
                    <th><font color="#ffffff">메일보내기</font></th>
                </tr>
                <%
                    for (int i = 0; i < vlist.size(); i++) {
                        MemberBean mBean = vlist.get(i);
                %>
                <tr align="center">
                    <td><%=mBean.getName()%>
                    </td>
                    <td><%=mBean.getId()%>
                    </td>
                    <td><%=mBean.getPwd()%>
                    </td>
                    <td><%=mBean.getGender().equals("1") ? "남자" : "여자"%>
                    </td>
                    <td><%=mBean.getBirthday()%>
                    </td>
                    <td><%=mBean.getEmail()%>
                    </td>
                    <td><font color="FFFFFF">
                        <a href="javascript:update('<%=mBean.getId()%>')">수정하기</a>
                    </font></td>
                    <td><font color="FFFFFF">
                        <a href="sendAccount.jsp?id=<%=mBean.getId()%>">메일 보내기</a>
                    </font></td>
                </tr>
                    <%}%>
            </table>

        </td>
    </tr>
</table>

<%@ include file="bottom.jsp" %>
<form name="update" method="post" action="memberUpdate.jsp">
    <input type="hidden" name="id"/>
</form>
</body>
</html>