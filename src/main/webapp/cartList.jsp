<%@ page import="java.util.Hashtable" %>
<%@ page import="com.gikim.mall.OrderBean" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.gikim.mall.ProductBean" %>
<%@ page import="com.gikim.mall.UtilMgr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="cMgr" scope="session" class="com.gikim.mall.CartMgr"/>
<jsp:useBean id="pMgr" class="com.gikim.mall.ProductMgr"/>
<%
    if (session.getAttribute("idKey") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Simple Shopping Mall : 장바구니(cartList.jsp) </title>
    <link href="style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="script.js" ></script>
</head>

<body bgcolor="#996600" topmargin="100">
<%@ include file="top.jsp" %>
<table width="75%" align="center" bgcolor="#ffff99">
    <tr>
        <td align="center" bgcolor="#ffffcc">
            <table width="95%" align="center" bgcolor="#ffff99" border="1">
                <tr align="center" bgcolor="#996600">
                    <td><font color="#ffffff">제품</font></td>
                    <td><font color="#ffffff">수량</font></td>
                    <td><font color="#ffffff">가격</font></td>
                    <td><font color="#ffffff">수정/삭제</font></td>
                    <td><font color="#ffffff">조회</font></td>
                </tr>
                <%
                    int totalPrice = 0;
                    Hashtable<Integer, OrderBean> hCart = cMgr.getCartList();
                    if (hCart.isEmpty()) {
                %>
                <tr>
                    <td colspan="5" align="center">장바구니가 비어있습니다.</td>
                </tr>
                <%
                } else {
                    Enumeration<Integer> hCartKey = hCart.keys();
                    while (hCartKey.hasMoreElements()) {
                        OrderBean order = hCart.get(hCartKey.nextElement());
                        int productNo = order.getProductNo();
                        ProductBean pbean = pMgr.getProduct(productNo);
                        int price = pbean.getPrice();
                        int quantity = order.getQuantity();
                        int subTotal = price * quantity;
                        totalPrice += subTotal;
                        String pName = pbean.getName();
                %>
                <tr align="center">
                    <form method="post" action="cartProc.jsp">
                        <input type="hidden" name="productNo" value="<%=productNo%>"/>
                        <input type="hidden" name="flag"/>
                        <td><%=pName%></td>
                        <td>
                            <input name="quantity" value="<%=quantity%>" size="3">개
                        </td>
                        <td><%=UtilMgr.monFormat(String.valueOf(subTotal))%>원</td>
                        <td>
                            <input type="button" value="수정" size="3" onclick="cartUpdate(this.form)">
                            <input type="button" value="삭제" size="3" onclick="cartDelete(this.form)">
                        </td>
                        <td>
                            <a href="javascript:productDetail('<%=productNo%>')">상세보기</a>
                        </td>
                    </form>
                </tr>
                <%
                    }   //end-of while
                %>
                <tr>
                    <td colspan="4" align="right">
                        총 주문금액 : <%=UtilMgr.monFormat(String.valueOf(totalPrice))%>원
                    </td>
                    <td align="center">
                        <a href="orderProc.jsp">주문하기</a>
                    </td>
                </tr>
                <%
                    }   //end-of else
                %>
            </table>
            <form name="detail" method="post" action="productDetail.jsp">
                <input type="hidden" name="no"/>
            </form>
        </td>
    </tr>
</table>

<%@ include file="bottom.jsp" %>
</body>
</html>