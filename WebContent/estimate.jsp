
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="modal.Partner" %>
<%@ page import="modal.MemberDao" %>
<%@ page import ="java.util.List" %>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Ϳ� ����</title>
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
// ������ üũ �Լ�
function check() {
	var arr_pids = new Array();
	var arr_mids = new Array();
	var arr_prices = new Array();
	var arr_svcdates = new Array();
	var j=0;
$('input:checkbox[name="partner"]').each(function() {
	
   // this.checked = true; //checked ó��

    if(this.checked){//checked ó���� �׸��� ��
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
		document.frm.arr_prices.value = arr_prices; //�迭�� ����,
		document.frm.arr_svcdates.value = arr_svcdates; //�迭�� ����,
		document.frm.submit();
	}else{
		alert('������ ��ü�� üũ �ϼ���.');
	}

}



</script>
<body>
<%
//String cate = request.getParameter("cate"); //ī�װ� ���а�.
%>
<%
String cate = request.getParameter("cate"); //ī�װ� ���а�.

Partner partner = new Partner();
List<Partner> list = MemberDao.getInstance().PartnerAll("all");//��� ��ü ����Ʈ

%>
<%//=cate%>
<%//=list.size() %>
<form action="resv_ArrProcess.jsp" method="POST" name="frm" id="frm">
<table cellspacing='0'>
	<tr>
		<th>��ü��</th>
		<th>��ȭ��ȣ</th>
		<th>�Ұ�</th>
		<th>����</th>
		<th>����(��������)</th>
	</tr>
    <%if (list.size()>0){ 
    	for(int i =0; i<list.size(); i++){%>
	<tr>
		<td><input type="checkbox" id="partner" name="partner" value="<%=list.get(i).getP_Idx()%>"/><%=list.get(i).getName() %></td>
		<td><%=list.get(i).getPhone() %></td>
		<td><img src="images/<%=list.get(i).getPhoto1()%>" width="400"/><br><%=list.get(i).getIntroduce() %></td>
		<td><input type="hidden" id="r_price" name="r_price" value="<%=list.get(i).getPrice()%>"/><%=list.get(i).getPrice() %></td>
		<td width="100">
		�ؼ��� �ް����ϴ� ��¥�� �Ʒ� ó�� �Է��ϼ���.<br>
		��)2018-04-12 14:00 <br><br><input type="text" name="r_servicedate" id="r_servicedate"/><br><br>
		
		  <input type="hidden" name="pidx"  id="pidx"  value="<%=list.get(i).getP_Idx()%>">
		  <input type="hidden" name="midx"  id="midx" value="<%=list.get(i).getM_Idx()%>">
		<!--  <input type="submit" value="�����ϱ�" class="submit">-->
		  
		  
	</tr>
	<%	}
    } %>
	<tr class='even'>
		<td colspan="5">
		<input type="text" name="arr_pidxs" id="arr_pidxs" value=""/>
		<input type="text" name="arr_midxs" id="arr_midxs" value=""/>
		<input type="text" name="arr_prices" id="arr_prices" value=""/>
		<input type="text" name="arr_svcdates" id="arr_svcdates" value=""/>
		
		<input type="button" onClick="check();" value="�����ϱ�"/>
		
		
		</td>
		
	</tr>
	

	
</table>
</form>

</body>
</html>

