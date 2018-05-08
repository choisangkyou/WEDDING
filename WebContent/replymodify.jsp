<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="modal.Notice" %>
<%@ page import="modal.Reply" %>
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

String r_memo = request.getParameter("r_memo");
String r_idx = request.getParameter("r_idx");
String p_idx = request.getParameter("p_idx");
String r_writer = request.getParameter("r_writer");



RequestDispatcher dispatcher;


long time = System.currentTimeMillis(); 
SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
String r_date = dayTime.format(new Date(time));

 
 Reply reply = new Reply();
 reply.setR_idx(Integer.parseInt(r_idx));
 reply.setP_idx(Integer.parseInt(p_idx));
 reply.setR_writer(r_writer);
 reply.setR_date(r_date);
 reply.setR_memo(r_memo);

 
 boolean result=false;
 if(MemberDao.getInstance().ReplyModify(reply)){  //댓글 수정
 	result = true;
	response.sendRedirect("index.jsp?cate=100");
 }else{
	 out.println("Notice Update Error");
 }

%>

<%//=n_notice %>
</body>
</html>
