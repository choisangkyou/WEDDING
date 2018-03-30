<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="modal.Partner" %>
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

String m_idx = (String)session.getAttribute("M_IDX");


String p_name = request.getParameter("P_NAME");
String p_phone = request.getParameter("P_PHONE");
String p_address = request.getParameter("P_ADDRESS");
String p_price = request.getParameter("P_PRICE");
String p_operation = request.getParameter("P_OPERATION");
String p_category = request.getParameter("P_CATEGORY");
String p_introduce = request.getParameter("P_INTRODUCE"); 


%>
<%//=user_email %><br>
<%

	Partner partner = new Partner();
	if(!m_idx.equals(null))	partner.setM_Idx(Integer.parseInt(m_idx));
	partner.setAddress(p_address);
	partner.setCategory(p_category);
	partner.setIntroduce(p_introduce);
	partner.setName(p_name);
	partner.setOperation(p_operation);
	partner.setPhone(p_phone);
	partner.setPrice(Integer.parseInt(p_price));
	
%>
<%//=member.getEmail() %>
<%	
	boolean result=false;
	if(MemberDao.getInstance().insertPartner(partner)){
		session.setAttribute("P_CATEGORY", p_category);
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