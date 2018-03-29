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
<!-- 회원 로그인 -->
<% 
request.setCharacterEncoding("EUC-KR"); 

String user_email = request.getParameter("EMAIL");
String user_password = request.getParameter("PASSWORD");
RequestDispatcher dispatcher;


	Member member = new Member();
	List<Member> list = MemberDao.getInstance().selectOneData(user_email, user_password);

	String email =null;
	String nickName =null;
	String memberType = null;
	
	if(list.size() > 0){
		email = list.get(0).getEmail();
		nickName = list.get(0).getNickName();
		memberType = list.get(0).getType();
		
		session.setAttribute("EMAIL", email);
		session.setAttribute("NICKNAME",nickName);
		session.setAttribute("MEMBER_TYPE", memberType);
		
		response.sendRedirect("index.jsp");
	}
		//result = true;

	/*
	if(result){
		response.sendRedirect("success.jsp");
	
	}else{
		dispatcher = request.getRequestDispatcher("loginform.jsp");
		dispatcher.include(request, response);
	}
*/


%>
<%//=list.size() %>
<%=user_email %>
<%= user_password%><br>

<%=email %>
<%=nickName %>
<%= memberType%>

</body>
</html>