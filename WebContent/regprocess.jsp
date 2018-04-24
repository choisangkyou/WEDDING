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
<!-- 회원 등록 -->
<% 
request.setCharacterEncoding("EUC-KR"); 

String user_email = request.getParameter("EMAIL");
String user_password = request.getParameter("PASSWORD");
String user_password2 = request.getParameter("PASSWORD2");
String user_nickname = request.getParameter("NICKNAME");
String user_mobile = request.getParameter("MOBILE");
String user_type = request.getParameter("TYPE"); 


%>
<%//=user_email %><br>
<%

	Member member = new Member();
	member.setEmail(user_email);
	member.setPassword(user_password);
	member.setNickname(user_nickname);
	member.setMobile(user_mobile);
	member.setType(user_type);

%>
<%//=member.getEmail() %>
<%	
	boolean result=false;
	if(MemberDao.getInstance().insertMember(member)){
		session.setAttribute("EMAIL", user_email);
		session.setAttribute("PASSWORD",user_password);
		session.setAttribute("NICKNAME",user_nickname);
		session.setAttribute("MEMBER_TYPE",user_type);//[0]신랑,[1]신부,[2]업체
		result = true;
	}

	
	if(result){
		response.sendRedirect("index.jsp");
	//dispatcher = request.getRequestDispatcher("joinForm.jsp");
	//dispatcher.include(request, response);
	}



%>

</body>
</html>