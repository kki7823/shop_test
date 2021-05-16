<%@ page import="java.util.Hashtable" %>
<%@ page import="com.gikim.mall.OrderBean" %>
<%@ page import="java.util.Enumeration" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="cMgr" scope="session" class="com.gikim.mall.CartMgr"/>
<jsp:useBean id="pMgr" class="com.gikim.mall.ProductMgr"/>
<jsp:useBean id="orderMgr" class="com.gikim.mall.OrderMgr"/>
<%
    String msg = "";
    Hashtable<Integer, OrderBean> hCart = cMgr.getCartList();
    Enumeration<Integer> hCartKey = hCart.keys();
    if(!hCart.isEmpty()){
        while (hCartKey.hasMoreElements()){
            OrderBean order = hCart.get(hCartKey.nextElement());
            orderMgr.insertOrder(order);
            pMgr.reduceProduct(order);
            cMgr.deleteCart(order);
        }
        msg = "주문처리 하였습니다.";
    }else {
        msg = "장바구니가 비었습니다.";
    }
%>
<script>
    alert("<%=msg%>");
    location.href="orderList.jsp";
</script>
