<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gikim.mall.ProductBean" %>
<%@ page import="com.gikim.mall.UtilMgr" %>
<jsp:useBean id="pMgr" class="com.gikim.mall.ProductMgr"/>
<%
    request.setCharacterEncoding("UTF-8");
    int no = Integer.parseInt(request.getParameter("no"));
    ProductBean pbean = pMgr.getProduct(no);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Simple Shopping Mall</title>
    <link href="style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="script.js"></script>
</head>
<body bgcolor="#996600" topmargin="100">

<%@ include file="top.jsp" %>
<form name="detail" action="cartProc.jsp">
    <table width="75%" align="center" bgcolor="#ffff99">
        <tr>
            <td align="center" bgcolor="#ffffcc">
                <table width="95" bgcolor="#ffff99" border="1">
                    <tr bgcolor="#996600">
                        <td colspan="3" align="center">
                            <font color="#ffffff"><%=pbean.getName()%>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            <img src="data/<%=pbean.getImage()%>" height="150" width="150">
                        </td>
                        <td width="30%" valign="top">
                            <table>
                                <tr>
                                    <td><b>상품 이름 : <%=pbean.getName()%>
                                    </b></td>
                                </tr>
                                <tr>
                                    <td><b>가 격 : <%=UtilMgr.monFormat(pbean.getPrice())%>
                                    </b>원
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>수 량 : </b><input name="quantity" size="5" value="1"/></td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <input type="submit" value="장바구니 담기">
                                    </td>
                                </tr>
                            </table>
                            <input type="hidden" name="productNo" value="<%=pbean.getNo()%>">
                            <input type="hidden" name="flag" value="insert">
                        </td>
                        <td width="50%" valign="top">
                            <b>상세설명</b><br/>
                            <pre><%=pbean.getDetail()%></pre>
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
    </table>
</form>
<%@ include file="bottom.jsp"%>
</body>
</html>
