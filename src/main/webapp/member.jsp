<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"> <!-- meta태그는 항상 처음에... -->
    <title>Simple Shopping Mall : 회원가입(member.jsp)</title>
    <link href="style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="script.js"></script>
</head>

<body bgcolor="#996600" topmargin="100">
<%@ include file="top.jsp" %>

<table width="75%" align="center" bgcolor="#ffff99">
    <tr>
        <td align="center" bgcolor="#ffffcc">

            <form action="memberInsert.jsp" method="post" name="regForm">
                <table width="95%" align="center" bgcolor="#ffff99" border="1">

                    <tr align="center" bgcolor="#996600">
                        <td colspan="3"><font color="#ffffff"><b>회원가입</b></font></td>
                    </tr>

                    <tr>
                        <td width="16%">아이디</td>
                        <td width="57%">
                            <input type="text" name="id" size="15" required="required"/>
                            <input type="button" value="아이디 중복확인" onclick="idCheck(this.form.id.value)"/>
                        </td>
                        <td width="27%">아이디 입력은 필수 입니다.</td>
                    </tr>

                    <tr>
                        <td>비밀번호</td>
                        <td><input type="password" name="pwd" size="15" required="required"/></td>
                        <td>비밀번호 입력은 필수입니다.</td>
                    </tr>

                    <tr>
                        <td>비밀번호 확인</td>
                        <td><input type="password" name="repwd" size="15" required="required"/></td>
                        <td>비밀번호 확인 입력은 필수입니다.</td>
                    </tr>

                    <tr>
                        <td>이름</td>
                        <td><input type="text" name="name" size="15" required="required"/></td>
                        <td>고객님의 실명을 입력해주세요</td>
                    </tr>

                    <tr>
                        <td>성별</td>
                        <td>
                            남<input type="radio" name="gender" value="1" checked="checked"/>
                            여<input type="radio" name="gender" value="2"/>
                        </td>
                        <td>성별을 선택하세요</td>
                    </tr>

                    <tr>
                        <td>생년월일</td>
                        <td><input type="text" name="birthday" size="10" placeholder="ex)880912" required="required"/>
                        </td>
                        <td>생년월일을 입력해주세요</td>
                    </tr>

                    <tr>
                        <td>이메일주소</td>
                        <td><input type="email" name="email" size="27" placeholder="abcd@domain.com"
                                   required="required"/></td>
                        <td>이메일을 입력해주세요</td>
                    </tr>

                    <tr>
                        <td>우편번호</td>
                        <td>
                            <input type="text" name="zipcode" size="8" required="required"/>
                            <input type="button" value="우편번호찾기" onclick="zipCheck()"/>
                        </td>
                        <td>우편번호를 검색하세요</td>
                    </tr>

                    <tr>
                        <td>주소</td>
                        <td><input type="text" name="address" size="40"/></td>
                        <td>주소를 적어주세요</td>
                    </tr>

                    <tr>
                        <td>직업</td>
                        <td>
                            <select name="job">
                                <option value="0" selected>선택하세요.</option>
                                <option value="회사원">회사원</option>
                                <option value="연구전문직">연구전문직</option>
                                <option value="교수학생">교수학생</option>
                                <option value="일반자영업">일반자영업</option>
                                <option value="공무원">공무원</option>
                                <option value="의료인">의료인</option>
                                <option value="법조인">법조인</option>
                                <option value="종교,언론,에술인">종교.언론/예술인</option>
                                <option value="농,축,수산,광업인">농/축/수산/광업인</option>
                                <option value="주부">주부</option>
                                <option value="무직">무직</option>
                                <option value="기타">기타</option>
                            </select>
                        </td>
                        <td>직업을 선택해주세요</td>
                    </tr>

                    <tr>
                        <td>취미</td>
                        <td>
                            <input type="checkbox" name="hobby" value="인터넷" checked="checked"/>인터넷
                            <input type="checkbox" name="hobby" value="여행"/>여행
                            <input type="checkbox" name="hobby" value="게임"/>게임
                            <input type="checkbox" name="hobby" value="영화"/>영화
                            <input type="checkbox" name="hobby" value="운동"/>운동
                            <input type="checkbox" name="hobby" value="음악"/>음악
                        </td>
                        <td>취미를 선택하세요</td>
                    </tr>

                    <tr>
                        <td colspan="3" align="center">
                            <input type="submit" value="회원가입" onclick="inputCheck()"/>
                            <input type="reset" value="다시쓰기"/>
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
