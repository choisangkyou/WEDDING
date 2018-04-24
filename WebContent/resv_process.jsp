<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="modal.Reservation" %>
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

String p_Idx = request.getParameter("pidx");
String m_Idx = request.getParameter("midx");
String r_ServiceDate = request.getParameter("r_servicedate");

RequestDispatcher dispatcher;


long time = System.currentTimeMillis(); 
SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
String r_Date = dayTime.format(new Date(time));


	Reservation resv = new Reservation();
	if(!m_Idx.equals("") && !p_Idx.equals("")){
		resv.setP_Idx(Integer.parseInt(p_Idx));
		resv.setM_Idx(Integer.parseInt(m_Idx));
		resv.setR_Date(r_Date);
		resv.setR_ServiceDate(r_ServiceDate);
		
	
		
		if(MemberDao.getInstance().insertReservation(resv)){
			out.println("========= OK =========");
			//session.setAttribute("P_CATEGORY", p_category);
			response.sendRedirect("index.jsp");
		}
	}else{
		out.println("========= Fail =========");
		%>
		<script>
		alert('로그인 하세요.');
		history.back();
		</script>
		<%
	}

%>


1:<%=p_Idx %><br>
2:<%=m_Idx %><br>
3:<%=r_Date %><br>
4:<%=r_ServiceDate %><br>

</body>
</html>
