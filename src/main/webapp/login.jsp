<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Simple Shopping Mall : 로그인(login.jsp)</title>
    <link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#996600" topmargin="100">
<%@ include file="top.jsp" %>

<form action="loginProc.jsp" method="post">
    <table width="75%" align="center" bgcolor="#ffff99">
        <tr bordercolor="#ffff99">
            <td height="190">

                <table width="50%" border="1" align="center">
                    <tr bordercolor="#ffff66">
                        <td colspan="2" align="center">로그인</td>
                    </tr>

                    <tr align="center">
                        <td width="47%">아이디</td>
                        <td width="53%"><input type="text" name="id" required="required"/></td>
                    </tr>

                    <tr>
                        <td align="center">비밀번호</td>
                        <td align="center"><input type="password" name="pwd" required="required"/></td>
                    </tr>

                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" value="login"/>
                            <input type="reset" value="reset"/>
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
    </table>
</form>

<%@ include file="bottom.jsp" %>
</body>
</html>