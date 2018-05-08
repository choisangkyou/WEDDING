
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="modal.Partner" %>
<%@ page import="modal.MemberDao" %>
<%@ page import ="java.util.List" %>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>와우 웨딩</title>
<script src="http://code.jquery.com/jquery-1.4.4.js"></script>

<style type="text/css">
body{
	font-family:Arial, Helvetica, sans-serif;
	margin:0 auto ;
}
a:link {
	color: #666;
	font-weight: bold;
	text-decoration:none;
}
a:visited {
	color: #666;
	font-weight:bold;
	text-decoration:none;
}
a:active,
a:hover {
	color: #bd5a35;
	text-decoration:underline;
}


table a:link {
	color: #666;
	font-weight: bold;
	text-decoration:none;
}
table a:visited {
	color: #999999;
	font-weight:bold;
	text-decoration:none;
}
table a:active,
table a:hover {
	color: #bd5a35;
	text-decoration:underline;
}
table {
	font-family:Arial, Helvetica, sans-serif;
	color:#666;
	font-size:12px;
	text-shadow: 1px 1px 0px #fff;
	background:#eaebec;
	margin:20px;
	border:#ccc 1px solid;

	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	border-radius:3px;

	-moz-box-shadow: 0 1px 2px #d1d1d1;
	-webkit-box-shadow: 0 1px 2px #d1d1d1;
	box-shadow: 0 1px 2px #d1d1d1;
}
table th {
	padding:15px;
	border-top:1px solid #fafafa;
	border-bottom:1px solid #e0e0e0;

	background: #ededed;
	background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#ebebeb));
	background: -moz-linear-gradient(top,  #ededed,  #ebebeb);
}
table th:first-child{
	text-align: left;
	padding-left:20px;
}
table tr:first-child th:first-child{
	-moz-border-radius-topleft:3px;
	-webkit-border-top-left-radius:3px;
	border-top-left-radius:3px;
}
table tr:first-child th:last-child{
	-moz-border-radius-topright:3px;
	-webkit-border-top-right-radius:3px;
	border-top-right-radius:3px;
}
table tr{
	text-align: center;
	padding-left:20px;
}
table tr td:first-child{
	text-align: left;
	padding-left:20px;
	border-left: 0;
}
table tr td {
	padding:12px;
	border-top: 1px solid #ffffff;
	border-bottom:1px solid #e0e0e0;
	border-left: 1px solid #e0e0e0;
	
	background: #fafafa;
	background: -webkit-gradient(linear, left top, left bottom, from(#fbfbfb), to(#fafafa));
	background: -moz-linear-gradient(top,  #fbfbfb,  #fafafa);
}
table tr.even td{
	background: #f6f6f6;
	background: -webkit-gradient(linear, left top, left bottom, from(#f8f8f8), to(#f6f6f6));
	background: -moz-linear-gradient(top,  #f8f8f8,  #f6f6f6);
}
table tr:last-child td{
	border-bottom:0;
}
table tr:last-child td:first-child{
	-moz-border-radius-bottomleft:3px;
	-webkit-border-bottom-left-radius:3px;
	border-bottom-left-radius:3px;
}
table tr:last-child td:last-child{
	-moz-border-radius-bottomright:3px;
	-webkit-border-bottom-right-radius:3px;
	border-bottom-right-radius:3px;
}
table tr:hover td{
	background: #f2f2f2;
	background: -webkit-gradient(linear, left top, left bottom, from(#f2f2f2), to(#f0f0f0));
	background: -moz-linear-gradient(top,  #f2f2f2,  #f0f0f0);	
}

</style>

</head>
<script>
// 예약폼 체크 함수
function check() {
	var arr_pids = new Array();
	var arr_mids = new Array();
	var arr_prices = new Array();
	var arr_svcdates = new Array();
	var j=0;
$('input:checkbox[name="partner"]').each(function() {
	
   // this.checked = true; //checked 처리

    if(this.checked){//checked 처리된 항목의 값
    	arr_pids[j] = this.value;
    	arr_mids[j] =  document.frm.midx[j].value;
    	arr_prices[j] =  document.frm.r_price[j].value;// $("input[name='r_price']")[j].value;
    	arr_svcdates[j] = $("input[name='r_servicedate']")[j].value; //$("#r_servicedate").get(j).value;//document.frm.r_servicedate[j].value;
    	 j++;

    }

});

	
	if(arr_pids.length > 0){
		document.frm.arr_pidxs.value = arr_pids; //pidx
		document.frm.arr_midxs.value = arr_mids; //midx
		document.frm.arr_prices.value = arr_prices; //배열값 저장,
		document.frm.arr_svcdates.value = arr_svcdates; //배열값 저장,
		document.frm.submit();
	}else{
		alert('예약할 업체를 체크 하세요.');
	}

}



</script>
<body>
<%
//String cate = request.getParameter("cate"); //카테고리 구분값.
%>
<%
String cate = request.getParameter("cate"); //카테고리 구분값.

Partner partner = new Partner();
List<Partner> list = MemberDao.getInstance().PartnerAll("all");//모든 업체 리스트

%>
<%//=cate%>
<%//=list.size() %>
<form action="resv_ArrProcess.jsp" method="POST" name="frm" id="frm">
<table cellspacing='0'>
	<tr>
		<th>업체명</th>
		<th>전화번호</th>
		<th>소개</th>
		<th>가격</th>
		<th>예약(서비스일자)</th>
	</tr>
    <%if (list.size()>0){ 
    	for(int i =0; i<list.size(); i++){%>
	<tr>
		<td><input type="checkbox" id="partner" name="partner" value="<%=list.get(i).getP_Idx()%>"/><%=list.get(i).getName() %></td>
		<td><%=list.get(i).getPhone() %></td>
		<td><img src="images/<%=list.get(i).getPhoto1()%>" width="400"/><br><%=list.get(i).getIntroduce() %></td>
		<td><input type="hidden" id="r_price" name="r_price" value="<%=list.get(i).getPrice()%>"/><%=list.get(i).getPrice() %></td>
		<td width="100">
		※서비스 받고자하는 날짜를 아래 처럼 입력하세요.<br>
		예)2018-04-12 14:00 <br><br><input type="text" name="r_servicedate" id="r_servicedate"/><br><br>
		
		  <input type="hidden" name="pidx"  id="pidx"  value="<%=list.get(i).getP_Idx()%>">
		  <input type="hidden" name="midx"  id="midx" value="<%=list.get(i).getM_Idx()%>">
		<!--  <input type="submit" value="예약하기" class="submit">-->
		  
		  
	</tr>
	<%	}
    } %>
	<tr class='even'>
		<td colspan="5">
		<input type="text" name="arr_pidxs" id="arr_pidxs" value=""/>
		<input type="text" name="arr_midxs" id="arr_midxs" value=""/>
		<input type="text" name="arr_prices" id="arr_prices" value=""/>
		<input type="text" name="arr_svcdates" id="arr_svcdates" value=""/>
		
		<input type="button" onClick="check();" value="예약하기"/>
		
		
		</td>
		
	</tr>
	

	
</table>
</form>

</body>
</html>

