<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="modal.Notice" %>
<%@ page import="modal.MemberDao" %>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import ="java.util.List" %>

<%@ page import ="java.text.SimpleDateFormat"%>
<%@ page import ="java.util.Date"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!-- 회원 로그인 -->
<% 
request.setCharacterEncoding("EUC-KR"); 

String n_notice = request.getParameter("notice");
String n_idx = request.getParameter("n_idx");


RequestDispatcher dispatcher;


long time = System.currentTimeMillis(); 
SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
String n_date = dayTime.format(new Date(time));


 Notice notice = new Notice();
 notice.setN_idx(Integer.parseInt(n_idx));
 notice.setN_notice(n_notice);
 notice.setN_date(n_date);
 
 boolean result=false;
 if(MemberDao.getInstance().NoticeModify(notice)){  //원문 수정
 	result = true;
	response.sendRedirect("index.jsp?cate=100");
 }else{
	 out.println("Notice Update Error");
 }

%>

<%=n_notice %>
</body>
</html>
