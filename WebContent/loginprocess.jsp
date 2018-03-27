<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="modal.Member" %>
<%@ page import="modal.MemberDao" %>
<%@ page import="java.util.regex.Pattern"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!-- 회원 로그인 -->
<% 
request.setCharacterEncoding("EUC-KR"); 

String user_email = request.getParameter("EMAIL");
String user_password = request.getParameter("PASSWORD");
RequestDispatcher dispatcher;


	Member member = new Member();
	member.setEmail(user_email);
	member.setPassword(user_password);


	boolean result=false;
	if(MemberDao.getInstance().selectOne(member)){
		session.setAttribute("EMAIL", user_email);
		session.setAttribute("PASSWORD",user_password);
		result = true;
	}

	
	if(result){
		response.sendRedirect("success.jsp");
	
	}else{
		dispatcher = request.getRequestDispatcher("loginform.jsp");
		dispatcher.include(request, response);
	}



%>

</body>
</html>