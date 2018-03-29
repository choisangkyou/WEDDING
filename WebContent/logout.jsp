<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="modal.Member" %>
<%@ page import="modal.MemberDao" %>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import ="java.util.List" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!-- 로그아웃 -->
<%
/*
request.setCharacterEncoding("UTF-8");
String email = (String)session.getAttribute("EMAIL");
String password = (String)session.getAttribute("PASSWORD");
String nickname = (String)session.getAttribute("NICKNAME");
*/
session.invalidate();
response.sendRedirect("index.jsp");
%>
<%//=email %>
<%//=nickname %>


</body>
</html>