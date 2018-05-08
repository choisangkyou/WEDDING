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

/*
document.frm.arr_pidxs.value = arr_pids; //pidx
document.frm.arr_midxs.value = arr_mids; //midx
document.frm.arr_prices.value = arr_prices; //배열값 저장,
document.frm.arr_svcdates.value = arr_svcdates; //배열값 저장,
*/

String[] arr_pidxs = request.getParameterValues("arr_pidxs");
String[] arr_midxs = request.getParameterValues("arr_midxs");
String[] arr_prices = request.getParameterValues("arr_prices");
String[] arr_svcdates = request.getParameterValues("arr_svcdates");


RequestDispatcher dispatcher;


long time = System.currentTimeMillis(); 
SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
String r_Date = dayTime.format(new Date(time));
boolean result=false;

	Reservation resv = new Reservation();
	if(arr_pidxs.length > 0 ){
		for(int i =0; i < arr_pidxs.length; i++){
			//out.println("ii:"+ arr_pidxs[i]);//Number format exception 
			resv.setP_Idx(Integer.parseInt(arr_pidxs[i]));
			resv.setM_Idx(Integer.parseInt(arr_midxs[i]));
			resv.setR_Price(Integer.parseInt(arr_prices[i]));
			resv.setR_Date(r_Date);
			resv.setR_ServiceDate(arr_svcdates[i]);
			
			result = MemberDao.getInstance().insertReservation(resv);
			out.println("========= OK["+i+"] =========");
		}
	
		
	
		
		if(result){
			out.println("========= OK =========");
			//session.setAttribute("P_CATEGORY", p_category);
			%>
			<script>
			alert('예약완료 되었습니다.');
			</script>
			<%
			response.sendRedirect("index.jsp?cate=200");
		}else{
			//out.println("========= Fail =========");
		%>
			<script>
			alert('예약 실패!!');
			history.back();
			</script>
		<%
		}
	}

%>

</body>
</html>
