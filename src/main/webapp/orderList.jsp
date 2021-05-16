<%@ page import="java.util.Vector" %>
<%@ page import="com.gikim.mall.OrderBean" %>
<%@ page import="com.gikim.mall.ProductBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="orderMgr" class="com.gikim.mall.OrderMgr"/>
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
    <title>Simple Shopping Mall : 주문내역(orderList.jsp)</title>
    <link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#996600" topmargin="100">
<%@ include file="top.jsp" %>

<table width="75%" align="center" bgcolor="#ffff99">
    <tr>
        <td align="center" bgcolor="#ffffcc">
            <table width="95%" bgcolor="#ffff99" border="1">
                <tr bgcolor="#996600" align="center">
                    <td><font color="#ffffff">주문번호</font></td>
                    <td><font color="#ffffff">주문제품</font></td>
                    <td><font color="#ffffff">주문수량</font></td>
                    <td><font color="#ffffff">주문날짜</font></td>
                    <td><font color="#ffffff">주문상태</font></td>
                </tr>
                <%
                    Vector<OrderBean> vlist = orderMgr.getOrder(id);
                    if (vlist.isEmpty()) {
                %>
                <tr align="center">
                    <td colspan="5">주문하신 내역이 없습니다.</td>
                </tr>
                <%
                } else {
                    for (int i = 0; i < vlist.size(); i++) {
                        OrderBean order = vlist.get(i);
                        int productNo = order.getProductNo();
                        ProductBean pbean = pMgr.getProduct(productNo);
                %>
                <tr align="center">
                    <td><%=order.getNo()%>
                    </td>
                    <td><a href="javascript:productDetail('<%=productNo%>')"><%=pbean.getName()%>
                    </a></td>
                    <td><%=order.getQuantity()%>
                    </td>
                    <td><%=order.getRdate()%>
                    </td>
                    <td>
                        <%
                            switch (order.getState()) {
                                case "1":
                                    out.print("접수중");
                                    break;
                                case "2":
                                    out.print("접수");
                                    break;
                                case "3":
                                    out.print("입금확인");
                                    break;
                                case "4":
                                    out.print("배송준비");
                                    break;
                                case "5":
                                    out.print("배송중");
                                    break;
                                case "6":
                                    out.print("완료");
                                    break;
                            }   //end-of switch
                        %>
                    </td>
                </tr>
                <%
                        }   //end-of for
                    }   //end-of if else
                %>
            </table>
        </td>
    </tr>
</table>

<%@ include file="bottom.jsp" %>
<form name="detail" method="post" action="productDetail.jsp">
    <input type="hidden" name="no">
</form>
</body>
</html>