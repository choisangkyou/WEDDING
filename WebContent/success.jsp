<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원 가입 완료</title>
</head>
<body>
<%


	request.setCharacterEncoding("UTF-8");


	String email = (String)session.getAttribute("EMAIL");
	String password = (String)session.getAttribute("PASSWORD");
	String nickname = (String)session.getAttribute("NICKNAME");
	
%>
<h2>회원가입을 축하드립니다.</h2>
email:<%=email %><br>
password:<%=password.hashCode() %><br>
nickname:<%=nickname %><br>
<%String refURL = request.getHeader("referer");%>
<%=refURL %><br>
<input type="button" value="처음으로" onClick="location.href='index.jsp'">
</body>
</html>