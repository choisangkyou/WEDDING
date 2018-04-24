
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="modal.Reply" %>
<%@ page import="modal.Notice" %>
<%@ page import="modal.MemberDao" %>
<%@ page import ="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>공지사항</title>


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

<body>
<%
//String cate = request.getParameter("cate"); //카테고리 구분값.
%>
<%
String cate = request.getParameter("cate");
String p_idx = request.getParameter("n_idx");// 댓글 parent index 
String r_memo = request.getParameter("reply"); //댓글
String r_writer = request.getParameter("n_writer"); //글쓴이(=email)

Date date = new Date();
String r_date = date.toString();
		

Reply reply = new Reply();
reply.setP_idx(Integer.parseInt(p_idx));
reply.setR_date(r_date);
reply.setR_writer(r_writer);
reply.setR_memo(r_memo);

boolean result=false;
if(MemberDao.getInstance().insertReply(reply)){  //댓글 입력
/* 	session.setAttribute("EMAIL", user_email);
	session.setAttribute("PASSWORD",user_password);
	session.setAttribute("NICKNAME",user_nickname);
	session.setAttribute("MEMBER_TYPE",user_type);//[0]신랑,[1]신부,[2]업체 */
	result = true;
}


List<Notice> list = MemberDao.getInstance().NoticeOne(Integer.parseInt(p_idx)); //원글


%>
<%=list.size() %>
<%=p_idx%>
<%=r_writer%><!-- 로그인 체크 -->

<table cellspacing='0'>
	<tr>
		<th>index</th>
		<th>날짜</th>
		<th>내용</th>
		<th>글쓴이</th>

	</tr>
    <%if (list.size() > 0){ %>
	<tr>
		<td><%=list.get(0).getN_idx()%></td>
		<td><%=list.get(0).getN_date()%></td>
		<td><%=list.get(0).getN_notice() %></td>
		<td><%=list.get(0).getN_writer() %></td>
				
	</tr>
	<%} %>
	
	<%
	List<Reply> re = MemberDao.getInstance().ReplyAll(Integer.parseInt(p_idx));
	if (re.size() > 0){	
		for(int i=0; i< re.size(); i++){
			
			%>
			<tr>
				<td colspan="4" >Re:
					<input type=hidden name="n_idx" value="<%=p_idx%>" >
					<input type=text name="reply" value="<%=re.get(i).getR_memo() %>"  size="60">
					<input type="submit"  onClick="location.href='modifyreply.jsp?n_idx=<%=re.get(i).getR_idx()%>'" value="수정" class="submit">
				</td>		
			</tr>
			<%
		}
	} %>
	<form action="appendreply.jsp" method="POST">
	<tr>
		<td colspan="4" >Re:  
			<input type=hidden name="n_writer" value="<%=r_writer%>" >
			<input type=text name="reply" value=""  size="60">
			<input type=hidden name="n_idx" value="<%=list.get(0).getN_idx() %>"  size="60">
			<input type="submit"  value="입력" class="submit">
		</td>		
	</tr>
	</form>
	
</table>


</body>
</html>

