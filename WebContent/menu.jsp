<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%
	request.setCharacterEncoding("UTF-8");

	//��ü
	String p_category = (String)session.getAttribute("P_CATEGORY"); //��ü���� ->pidx ��ü

	//ȸ�� 
	String email = (String)session.getAttribute("EMAIL");
	String password = (String)session.getAttribute("PASSWORD");
	String nickname = (String)session.getAttribute("NICKNAME");
	String meber_type = (String)session.getAttribute("MEMBER_TYPE");
			nickname +="��! �ݰ����ϴ�.";

	//String cate = request.getParameter("cate"); //�޴� ī�װ� ���а�.
			
%>

		<div id='toprightmenu' width="400px" align="right">
			<%
			if (email !=null && nickname !=null){
			%>
				<%=nickname%> <a href='logout.jsp'>�α׾ƿ�</a> <a href='modifyform.jsp'>��������</a> 
			<%}else{ %>
				<a href='loginform.jsp'>�α���</a> <a href='regform.jsp'>ȸ������</a> 
			<%} %>
			
			<%if (p_category !=null) {%>
				*Partner
			<%}else{%>
				<a href='pregform.jsp'>��ü���</a>
			<%} %>
		</div>
			
	
		<div id="logo" >
			<a href="index.jsp"><img src="images/logo.jpg" width=100px;></a>
		</div>


		<div class='menu'>
			<ul>
				<li>
					<a href='index.jsp?cate=about'>�Ϳ����</a>
				</li>

				<li class='active sub'>
					<a href='#'>��ü</a>
					<ul>
						<li class='sub'>
							<a href='index.jsp?cate=001'>���</a>
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
						<li class='sub'><a href='index.jsp?cate=002'>����</a></li>
						<li class='sub'><a href='index.jsp?cate=003'>�巹��</a></li>
							
					</ul>
				</li>
				
				<li>
					<a href='#'>����</a>
					<ul>
						<li class='sub'><a href='index.jsp?cate=200'>�����̱�</a></li>
					</ul>
				</li>
				
				
				<li>
					<a href='#'>������</a>
					<ul>
						<li class='sub'><a href='index.jsp?cate=100'>��������</a></li>
					</ul>
				</li>

			</ul>
		</div>
		
		