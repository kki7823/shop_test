<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.gikim.mall.ProductBean" %>
<%@ page import="com.gikim.mall.UtilMgr" %>

<jsp:useBean id="pMgr" class="com.gikim.mall.ProductMgr"/>
<%
    Vector<ProductBean> pvlist = pMgr.getProductList();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset=UTF-8">
    <title>Simple Shopping Mall : 상품목록(productList.jsp)</title>
    <link href="style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="script.js"></script>
</head>

<body bgcolor="#996600" topmargin="100">
<%@ include file="top.jsp" %>

<table width="75%" align="center" bgcolor="#ffff99">
    <tr>
        <td align="center" bgcolor="#ffffcc">

            <table width="95%" bgcolor="#ffff99" border="1">
                <tr align="center" bgcolor="#996600">
                    <th><font color="#ffffff">이름</font></th>
                    <th><font color="#ffffff">가격</font></th>
                    <th><font color="#ffffff">날짜</font></th>
                    <th><font color="#ffffff">재고</font></th>
                    <th><font color="#ffffff">상세보기</font></th>
                </tr>
                <%
                    for (int i = 0; i < pvlist.size(); i++) {
                        ProductBean pbean = pvlist.get(i);
                %>
                <!-- DB에서 조회 결과 값 출력 -->
                <tr align="center">
                    <td><%=pbean.getName()%>
                    </td>
                    <td><%=UtilMgr.monFormat(pbean.getPrice())%>
                    </td>
                    <td><%=pbean.getRdate()%>
                    </td>
                    <td><%=UtilMgr.monFormat(String.valueOf(pbean.getStock()))%>
                    </td>
                    <td><input type="button" value="상세보기" onclick="productDetail(<%=pbean.getNo()%>)"></td>
                </tr>
            <%
                }   //end of for
            %>
            </table>
        </td>
    </tr>
</table>

<form name="detail" method="post" action="productDetail.jsp">
    <input type="hidden" name="no"/>
</form>

<%@ include file="bottom.jsp" %>
</body>
</html>