<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.gikim.mall.ZipcodeBean" %>

<jsp:useBean id="mMgr" class="com.gikim.mall.MemberMgr"/>
<%
    request.setCharacterEncoding("UTF-8");
    String search = request.getParameter("search");
    String road = null;
    Vector<ZipcodeBean> vlist = null;

    if (search.equals("y")) {
        road = request.getParameter("road");
        vlist = mMgr.zipcodeRead(road);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>우편번호 검색 : zipSearch.jsp</title>
    <link href="style.css" type="text/css" rel="stylesheet">

    <script type="text/javascript">
        function roadSearch() {
            frm = document.zipFrm;
            frm.action = "zipSearch.jsp";
            frm.submit();
        }

        function sendAdd(zipcode, addr) {
            opener.document.regForm.zipcode.value = zipcode;    //member.jsp 내부
            opener.document.regForm.address.value = addr;   //member.jsp 내부
            self.close();
        }
    </script>
</head>
<body bgcolor="ffffcc">

<div align="center">
    <form name="zipFrm" method="post">
        <table>
            <tr>
                <td>
                    도로명 입력 <input type="text" name="road" required="required"/>
                    <input type="button" value="검색" onclick="roadSearch()"/>
                </td>
            </tr>
            <!-- 검색결과 시작-->
            <%
                if (search.equals("y")) {
                    if (vlist.isEmpty()) {
            %>
            <tr>
                <td align="center">검색된 결과가 없습니다.</td>
            </tr>
            <%
            } else {
            %>
            <tr>
                <td align="center">* 검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</td>
            </tr>
            <%
                for (int i = 0; i < vlist.size(); i++) {
                    ZipcodeBean zBean = vlist.get(i);
                    String rZipcode = zBean.getZipcode();
                    String rCity = zBean.getCity();
                    String rRegion = zBean.getRegion();
                    String rRoad = zBean.getRoad();
                    String adds = rCity + " " + rRegion + " " + rRoad + " ";
            %>
            <tr>
                <td>
                    <a href="#" onclick="javascript:sendAdd('<%=rZipcode%>','<%=adds%>')">
                        <%=rZipcode + " " + adds%>
                    </a>
                </td>
            </tr>
            <%
                        }// end of  for (int i = 0; i < vlist.size(); i++)
                    }// end of if(vlist.isEmpty())
                }// end of if(search.equals("y"))
            %>
            <!-- 검색결과 끝-->
            <tr>
                <td align="center">
                    <a href="#" onclick="self.close()">닫기</a>
                </td>
            </tr>
        </table>
        <input type="hidden" name="search" value="y"/>
    </form>
</div>

</body>
</html>