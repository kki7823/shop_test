<%--
  Created by IntelliJ IDEA.
  User: gimgyeong-il
  Date: 2021/05/06
  Time: 1:46 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="mBean" class="com.gikim.mall.MemberBean" scope="request"/>
<jsp:setProperty name="mBean" property="*"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memberInsert.jsp src="script.js"</title>
    <script type="text/javascript" src="script.js"></script>
    <link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#996600">

<%@ include file="top.jsp" %>
<table width="75%" align="center" bgcolor="#ffff99">
    <tr>
        <td align="center" bgcolor="#ffffcc">
            <table width="95%" align="center" bgcolor="#ffff99" border="1">
                <form action="memberProc.jsp" method="post" name="regForm">
                    <tr align="center" bgcolor="#996600">
                        <td colspan="3">
                            <font color="#ffffff">
                                <b>
                                    <jsp:getProperty property="name" name="mBean"/>
                                    회원님이 작성하신 내용입니다. 확인해주세요.
                                </b>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td>아이디</td>
                        <td>
                            <input type="text" name="id" value="<jsp:getProperty property="id" name="mBean"/>"/>
                        </td>
                    </tr>
                    <tr>
                        <td>비밀번호</td>
                        <td>
                            <input type="password" name="pwd" value="<jsp:getProperty name="mBean" property="pwd"/>"/>
                        </td>
                    </tr>
                    <tr>
                        <td>이름</td>
                        <td>
                            <input type="text" name="name" value="<jsp:getProperty name="mBean" property="name"/>"/>
                        </td>
                    </tr>
                    <tr>
                        <td>성별</td>
                        <td>
                            남<input type="radio" name="gender"
                                    value="1" <%=mBean.getGender().equals("1") ? "checked" : "남" %> />
                            여<input type="radio" name="gender"
                                    value="2" <%=mBean.getGender().equals("2") ? "checked" : "여" %> />
                        </td>
                    </tr>
                    <tr>
                        <td>생년월일</td>
                        <td>
                            <input type="text" name="birthday"
                                   value="<jsp:getProperty name="mBean" property="birthday"/>"/>
                        </td>
                    </tr>
                    <tr>
                        <td>이메일</td>
                        <td>
                            <input type="email" name="email" value="<jsp:getProperty name="mBean" property="email"/>"/>
                        </td>
                    </tr>
                    <tr>
                        <td>우편번호</td>
                        <td>
                            <input type="text" name="zipcode"
                                   value="<jsp:getProperty name="mBean" property="zipcode"/>"/>
                        </td>
                    </tr>
                    <tr>
                        <td>주소</td>
                        <td>
                            <input type="text" name="address"
                                   value="<jsp:getProperty name="mBean" property="address"/>"/>
                        </td>
                    </tr>
                    <tr>
                        <td>직업</td>
                        <td>
                            <input type="text" name="job" value="<jsp:getProperty name="mBean" property="job"/>"/>
                        </td>
                    </tr>
                    <tr>
                        <td>취미</td>
                        <td>
                            <%
                                if (mBean.getHobby() != null) {
                                    String[] list = {"인터넷", "여행", "게임", "영화", "운동"};
                                    String[] hobbys = mBean.getHobby();

                                    for (int i = 0; i < hobbys.length; i++) {
                                        out.print("<input type=checkbox name=hobby checked value=" + hobbys[i] + " />" + hobbys[i]);
                                    }
                                } else {
                                    out.print("선택된 취미가 없습니다.");
                                }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" value="확인완료"/>
                            <input type="button" value="다시쓰기" onclick="history.back()"/>
                        </td>
                    </tr>
                </form>
            </table>
        </td>
    </tr>
</table>

</body>
</html>
