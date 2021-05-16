<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adminLogin.jsp</title>
	<link href="../style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#996600" topmargin="100" >
	<%@ include file="top.jsp" %>

	<table width="75%" align="center"  bgcolor="#ffff99"  >
		<tr bordercolor="#ffff99">
			<td height="190">
				
				<form action="adminLoginProc.jsp" method="post">
					<table width="50%" border="1"  align="center" >
						<tr bordercolor="#ffff99">
							<td colspan="2" align="center">관리자 로그인</td>
						</tr>
						
						<tr align="center">
							<td width="47%">관리자 아이디</td>
							<td width="53%"><input type="text" name="admin_id" value="admin" required="required" /></td>
						</tr>
						
						<tr>
							<td>관리자 비밀번호</td>
							<td><input type="password" name="admin_pwd"  value="1234" required="required" /></td>
						</tr>
						
						<tr>
							<td colspan="2" align="center">
								<input type="submit" value="관리자 로그인" />
								<input type="reset" value="취소"  />
							</td>
						</tr>
						
					</table>
				</form>
			
			</td>
		</tr>
	</table>

	<%@ include file="bottom.jsp" %>
</body>
</html>