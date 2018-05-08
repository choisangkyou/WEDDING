<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%
	request.setCharacterEncoding("UTF-8");

	//업체
	String p_category = (String)session.getAttribute("P_CATEGORY"); //업체구분 ->pidx 대체

	//회원 
	String email = (String)session.getAttribute("EMAIL");
	String password = (String)session.getAttribute("PASSWORD");
	String nickname = (String)session.getAttribute("NICKNAME");
	String meber_type = (String)session.getAttribute("MEMBER_TYPE");
			nickname +="님! 반갑습니다.";

	//String cate = request.getParameter("cate"); //메뉴 카테고리 구분값.
			
%>

		<div id='toprightmenu' width="400px" align="right">
			<%
			if (email !=null && nickname !=null){
			%>
				<%=nickname%> <a href='logout.jsp'>로그아웃</a> <a href='modifyform.jsp'>정보수정</a> 
			<%}else{ %>
				<a href='loginform.jsp'>로그인</a> <a href='regform.jsp'>회원가입</a> 
			<%} %>
			
			<%if (p_category !=null) {%>
				*Partner
			<%}else{%>
				<a href='pregform.jsp'>업체등록</a>
			<%} %>
		</div>
			
	
		<div id="logo" >
			<a href="index.jsp"><img src="images/logo.jpg" width=100px;></a>
		</div>


		<div class='menu'>
			<ul>
				<li>
					<a href='index.jsp?cate=about'>와우웨딩</a>
				</li>

				<li class='active sub'>
					<a href='#'>업체</a>
					<ul>
						<li class='sub'>
							<a href='index.jsp?cate=001'>장소</a>
							<!-- <ul>
								<li>
									<a href='#'>place1</a>
								</li>
								<li class='last'>
									<a href='#'>place2</a>
								</li>
							</ul>
							-->
						</li>
						<li class='sub'><a href='index.jsp?cate=002'>포토</a></li>
						<li class='sub'><a href='index.jsp?cate=003'>드레스</a></li>
							
					</ul>
				</li>
				
				<li>
					<a href='#'>견적</a>
					<ul>
						<li class='sub'><a href='index.jsp?cate=200'>견적뽑기</a></li>
					</ul>
				</li>
				
				
				<li>
					<a href='#'>고객센터</a>
					<ul>
						<li class='sub'><a href='index.jsp?cate=100'>공지사항</a></li>
					</ul>
				</li>

			</ul>
		</div>
		
		