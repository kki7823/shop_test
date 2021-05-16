<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>orderMgr.jsp</title>
	<link href="../style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#996600" topmargin="100">
	<%@ include file="top.jsp" %>
	
	<table width="75%" align="center" bgcolor="#ffff99">
		<tr>
			<td align="center" bgcolor="#ffffcc">
			
				<table width="95%" align="center"  bgcolor="#ffff99"  border="1">
					<tr align="center" bgcolor="#996600">
						<td><font color="#ffffff">주문번호</font></td>
						<td><font color="#ffffff">주문고객</font></td>
						<td><font color="#ffffff">주문제품</font></td>
						<td><font color="#ffffff">주문수량</font></td>
						<td><font color="#ffffff">주문날짜</font></td>
						<td><font color="#ffffff">주문상태</font></td>
						<td><font color="#ffffff">상세보기</font></td>
					</tr>
					
					<tr>
						<td colspan="7" align="center">주문 내역이 없습니다.</td>
					</tr>
					
					<tr>
						<td colspan="7" align="center">
							<a href="#">상세보기</a>
						</td>
					</tr>
				</table>
			
			</td>
		</tr>
	</table>
	
	<%@ include file="bottom.jsp" %>
</body>
</html>