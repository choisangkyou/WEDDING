package modal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;

import java.util.List;

import com.mysql.jdbc.Statement;



public class MemberDao {
	/*long time = System.currentTimeMillis(); 

	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");

	String str = dayTime.format(new Date(time));
*/
	
	private static MemberDao instance;
	private  Connection conn;
	
	String driverName ="com.mysql.jdbc.Driver";
	//String url ="jdbc:mysql://localhost:3306/wowwedding";
	String url = "jdbc:mysql://127.0.0.1:3306/wowwedding?useSSL=true&verifyServerCertificate=false";//SSL 에러발생시..
	 
	String user="root";
	String password ="0000";
	
	public static MemberDao getInstance() {
		if(instance == null)
			instance = new MemberDao();
		return instance;
	}

	private MemberDao() {
		try{
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, user, password);
		}catch (ClassNotFoundException e){
			System.out.println("mysql jdbc driver can't loading..");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("커넥션이 연결하지 못하였습니다.");
		}
	}
	
	/*modify Member */
	public boolean modifyMember(Member member) throws SQLException {
		boolean result =false;
		String sql = "update member ";
			   sql += " set m_Email= ? ,m_Phone =? ,m_Password =?,m_Type = ?,m_NickName =? , m_Type=?";
			   sql += "	where m_idx=?";
		PreparedStatement ps =null;
		
		try {
			/*m_Idx(AI),p_Idx,m_Email,m_Phone,m_Password,m_Type,m_Status,m_NickName
			 * */
			ps =  conn.prepareStatement(sql);
			
			ps.setString(1, member.getEmail());
			ps.setString(2, member.getMobile());
			ps.setString(3, member.getPassword());
			ps.setString(4, member.getType());
			ps.setString(5, member.getNickName());
			ps.setString(6, member.getType());
			ps.setInt(7, member.getmIdx());
			
			System.out.println("sql:"+ps.toString());
			
			int row = ps.executeUpdate();
			if(row>0) {
				result = true;
				//System.out.println("등록 되었습니다.");
			}
			
		} catch (SQLException e) {
			System.out.println("SQL Error: ModifyMember()");
		}finally {
			 if(ps !=null) {		ps.close();		}
			// if(conn != null) {	conn.close();	 }
		}
		
		return result;
		
	}
	
	
	/*insert Member */
	public boolean insertMember(Member member) throws SQLException {
		boolean result =false;
		String sql_append = "insert into member  (m_Email,m_Phone,m_Password,m_Type,m_NickName) ";
			   sql_append += "	 values(?,?,?,?,?)";
		PreparedStatement ps =null;
		
		try {
			/*m_Idx(AI),p_Idx,m_Email,m_Phone,m_Password,m_Type,m_Status,m_NickName
			 * */
			ps =  conn.prepareStatement(sql_append);
			
			ps.setString(1, member.getEmail());
			ps.setString(2, member.getMobile());
			ps.setString(3, member.getPassword());
			ps.setString(4, member.getType());
			ps.setString(5, member.getNickName());
			
			//System.out.println("sql:"+ps.toString());
			
			int row = ps.executeUpdate();
			if(row>0) {
				result = true;
				//System.out.println("등록 되었습니다.");
			}
			
		} catch (SQLException e) {
			System.out.println("SQL Error: insertMember()");
		}finally {
			 if(ps !=null) {		ps.close();		}
			 if(conn != null) {	conn.close();	 }
		}
		
		return result;
		
	}
	
	
	/*insert Partner */
	public boolean insertPartner(Partner partner) throws SQLException {
		boolean result =false;
		String sql_append = "insert into partner  (m_Idx,p_Name,p_Category,p_Phone,p_Address,p_Introduce,p_Operation,p_Price,p_Photo1)";
				sql_append += " values(?,?,?,?,?,?,?,?,?) ";

		
		// System.out.println("sql:"+sql_append);
				
		PreparedStatement ps =null;
		ResultSet rs=null;
		try {
			/*m_Idx(AI),p_Idx,m_Email,m_Phone,m_Password,m_Type,m_Status,m_NickName
			 * */
			ps =  conn.prepareStatement(sql_append);
			int m_idx = partner.getM_Idx();
			ps.setInt(1,m_idx);
			ps.setString(2, partner.getName());
			ps.setString(3, partner.getCategory());
			ps.setString(4, partner.getPhone());
			ps.setString(5, partner.getAddress());
			ps.setString(6, partner.getIntroduce());
			ps.setString(7,partner.getOperation());
			ps.setInt(8, partner.getPrice());
			ps.setString(9,partner.getPhoto1());
			//ps.setInt(11,partner.getM_Idx());
			
			
			int row = ps.executeUpdate();
		
			
			System.out.println("ROW:"+row +"sql:"+ps.toString());

			if(row>0) {
				result = true;
				boolean up = MemberOneUpdate(m_idx);
				if(up) {
					System.out.println("up success");
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL Error: insertPartner()");
		}finally {
			 if(ps !=null) {		ps.close();		}
			// if(conn != null) {	conn.close();	 }
		}
		
		return result;
		
	}
	
	/*insert Reservation */
	public boolean insertReservation(Reservation resv) throws SQLException {
		/*
	 SELECT `reservation`.`r_Idx`,
    `reservation`.`m_Idx`,
    `reservation`.`p_Idx`,
    `reservation`.`r_Date`,
    `reservation`.`r_ServiceDate`,
    `reservation`.`r_Confirm`,
    `reservation`.`r_Price`,
    `reservation`.`r_Status`
FROM `wowwedding`.`reservation`;
	 */
		boolean result =false;
		String sql_append = "insert into reservation (m_Idx,p_Idx,r_Date,r_ServiceDate,r_Price)";
				sql_append += " values(?,?,?,?,?) ";

		
		 System.out.println("sql:"+sql_append);
				
		PreparedStatement ps =null;
		ResultSet rs=null;
		try {
			
			ps =  conn.prepareStatement(sql_append);
			
			ps.setInt(1,resv.getM_Idx());
			ps.setInt(2, resv.getP_Idx());
			ps.setString(3, resv.getR_Date());
			ps.setString(4, resv.getR_ServiceDate());
			ps.setInt(5, resv.getR_Price());
			
			int row = ps.executeUpdate();
		
			
			//System.out.println("ROW:"+row +"sql:"+ps.toString());

			if(row>0) {
				result = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL Error: insert Reservation()");
		}finally {
			 if(ps !=null) {		ps.close();		}
			// if(conn != null) {	conn.close();	 }
		}
		
		return result;
		
	}
	
	
	
	// member p_idx 업데이트 

	public boolean MemberOneUpdate(int midx) throws SQLException {
		boolean result =false;
		String  sql_append = " update member ";
			   sql_append += " set p_idx = LAST_INSERT_ID()";  
			   sql_append += " where m_idx = ?";

			   System.out.println("sql:"+sql_append);
				
		PreparedStatement ps =null;
		ResultSet rs=null;
		
		try {
			
			ps =  conn.prepareStatement(sql_append);
			
			ps.setInt(1,midx);
		
			int row = ps.executeUpdate();
			System.out.println("ROW:"+row +"sql:"+ps.toString());
			
			if(row>0) {
				result = true;
				
				System.out.println("업데이트 되었습니다.");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL Error: MemberOneUpdate()");
		}finally {
			 if(ps !=null) {		ps.close();		}
			// if(conn != null) {	conn.close();	 }
		}
		
		return result;
		
	}
	
	
	/*select One Member */
	public boolean selectOne(Member member) throws SQLException {
		boolean result =false;
		String sql_append = "select * FROM  member where m_Email =? and m_Password =?";
		PreparedStatement ps =null;
		ResultSet rs =null;
		
		try {
			/*m_Idx(AI),p_Idx,m_Email,m_Phone,m_Password,m_Type,m_Status,m_NickName
			 * */
			ps =  conn.prepareStatement(sql_append);
			
			ps.setString(1, member.getEmail());
			ps.setString(2, member.getPassword());
			
			System.out.println("sql:"+ps.toString());
			
			rs = ps.executeQuery();
			if(rs.next()) {
				result = true;
				
			}
			
		} catch (SQLException e) {
			System.out.println("SQL Error: selectOne()");
		}finally {
			 if(ps !=null) {		ps.close();		}
			 //if(conn != null) {	conn.close();	 }
		}
		
		return result;
		
	}
	
	/*select OneData Member */
	public List<Member> selectOneData(String email, String pwd) throws SQLException {
		//boolean result =false;
		String sql = "select * FROM  member where m_Email ='"+email +"' and m_Password ='" + pwd +"'";
		PreparedStatement ps =null;
		ResultSet rs =null;
		List<Member> list = new ArrayList<Member>();
		System.out.println("sql:"+sql);
		
		try {
			/*m_Idx(AI),p_Idx,m_Email,m_Phone,m_Password,m_Type,m_Status,m_NickName
			 * */
			ps =  conn.prepareStatement(sql);
			
			//ps.setString(1, member.getEmail());
			//ps.setString(2, member.getPassword());
			
			System.out.println("sql:"+ps.toString());
			
			rs = ps.executeQuery();
			if(rs.next()) {
				Member member  =new Member();
				member.setmIdx(rs.getInt(1));
				member.setpIdx(rs.getInt(2));
				member.setEmail(rs.getString("m_Email"));
				member.setMobile(rs.getString("m_Phone"));
				member.setNickname(rs.getString("m_NickName"));
				member.setType(rs.getString("m_Type"));
				member.setPassword(rs.getString("m_Password"));
				list.add(member);
				
			}
			
			
		} catch (SQLException e) {
			System.out.println("SQL Error: selectOneData()");
		}finally {
			 if(ps !=null)
				 ps.close();
			if(rs !=null) 
				rs.close();
			
			 //if(conn != null)  conn.close();	 
		}
		
		return list;
		
	}
	
	
	/* Member select All */
	public List<Member> selectAll() throws SQLException {
		
		String sql = "select * From member ";
		
		List<Member> list = new ArrayList<Member>();
		PreparedStatement ps =null;
		ResultSet rs =null;
		try {
			
			ps = conn.prepareStatement(sql);
			rs= ps.executeQuery();
			while(rs.next()) {
				Member member = new Member();
				//member.setId(rs.getString("id"));
				member.setPassword(rs.getString("password"));
				//member.setName("name");
				//member.setEmail("email");
				//member.setMobile("mobile");
				//member.setBirthday("birthday");
				list.add(member);
				
			}
			
						
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("SQL Error: select All()");
			
		}finally {
			if(rs !=null) {		rs.close();		}
			 if(ps !=null) {		ps.close();		}
			// if(conn != null) {	conn.close();	 }
			 
		}
		
		
		return list;
		
	}
	
	
	//업체 카테고리 코드 리스트 

	/* Category List */
	public List<Category> CategoryList() throws SQLException {
		
		String sql = "select * From category ";
		
		List<Category> list = new ArrayList<Category>();
		PreparedStatement ps =null;
		ResultSet rs =null;
		try {
			
			ps = conn.prepareStatement(sql);
			rs= ps.executeQuery();
			while(rs.next()) {
				Category category = new Category();
				category.setCode(rs.getString("ct_Code"));
				category.setDescript(rs.getString("ct_Descript"));
				category.setUse(rs.getInt(3));
				list.add(category);
				
			}
			
						
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("SQL Error: Catetory List()");
			
		}finally {
			 if(ps != null)
			        ps.close();
			    if(rs != null)
			        rs.close();
			   // if(conn != null)    conn.close();
			 
		}
		
		
		return list;
		
	}
	
	/* Reply select All */
	public List<Reply> ReplyAll(int p_idx) throws SQLException {
		
		String sql = "select * From reply where p_idx =? ";
		
		List<Reply> list = new ArrayList<Reply>();
		PreparedStatement ps =null;
		ResultSet rs =null;
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_idx);
			rs= ps.executeQuery();
			while(rs.next()) {
				Reply reply = new Reply();
				reply.setP_idx(rs.getInt("p_idx"));
				reply.setR_idx(rs.getInt("r_idx"));
				reply.setR_date(rs.getString("r_date"));
				reply.setR_writer(rs.getString("r_writer"));
				reply.setR_memo(rs.getString("r_memo"));
				
				list.add(reply);
				
			}
			
						
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("SQL Error: Reply All()");
			
		}finally {
			if(rs !=null) {		rs.close();		}
			 if(ps !=null) {		ps.close();		}
			// if(conn != null) {	conn.close();	 }
			 
		}
		
		
		return list;
		
	}
	
	

	/*게시글 댓글 입력 */
	public boolean insertReply(Reply reply) throws SQLException {
		boolean result =false;
		String sql_append = "insert into reply  (p_idx,r_date,r_writer,r_memo)";
				sql_append += " values(?,?,?,?) ";

		
		// System.out.println("sql:"+sql_append);
				
		PreparedStatement ps =null;
		ResultSet rs=null;
		try {
			/*m_Idx(AI),p_Idx,m_Email,m_Phone,m_Password,m_Type,m_Status,m_NickName
			 * */
			ps =  conn.prepareStatement(sql_append);
			
			ps.setInt(1,reply.getP_idx());
			ps.setString(2, reply.getR_date());
			ps.setString(3, reply.getR_writer());
			ps.setString(4, reply.getR_memo());
			int row = ps.executeUpdate();
		
			
			System.out.println("ROW:"+row +"sql:"+ps.toString());

			if(row>0) {
				result = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL Error: insertReply()");
		}finally {
			 if(ps !=null) {		ps.close();		}
			// if(conn != null) {	conn.close();	 }
		}
		
		return result;
		
	}
	
	
	//공지사항 전체보기

	public List<Notice> NoticeAll() throws SQLException {
		//boolean result =false;
		String sql = "select * FROM  notice " ;
		PreparedStatement ps =null;
		//Statement st =null;
		ResultSet rs =null;
		List<Notice> list = new ArrayList<Notice>();
		
		System.out.println("sql:"+sql);
		
		try {
			ps =  conn.prepareStatement(sql);
			
			//ps.setInt(1, Integer.parseInt(idx));
		
			rs = ps.executeQuery();
			int i=0;	
			rs.beforeFirst();
			if(rs.next()) {
				Notice notice  =new Notice();
				notice.setN_idx(rs.getInt("n_Idx"));
				notice.setN_notice(rs.getString("n_Notice"));
				notice.setN_date(rs.getString("n_Date"));
				notice.setN_writer(rs.getString("n_Writer"));
				list.add(notice);
				System.out.println("count:"+ i++);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL Error: NoticeOne()");
		}finally {
			 if(ps !=null)
				 ps.close();
			if(rs !=null) 
				rs.close();
			
			 //if(conn != null)  conn.close();	 
		}
		
		return list;
		
	}
	
	

	//공지사항 글수정(업데이트)

	public boolean NoticeModify(Notice notice) throws SQLException {
		boolean result =false;
		
		String sql = "update notice ";
		   sql += " set n_Notice= ? ,n_Date=?";
		   sql += "	where n_Idx=?";
		   
		PreparedStatement ps =null;
		ResultSet rs =null;
		//List<Notice> list = new ArrayList<Notice>();
		//System.out.println("args:"+ idx);
		System.out.println("sql:"+sql);
		
		try {
			ps =  conn.prepareStatement(sql);
			
			ps.setString(1,notice.getN_notice());
			ps.setString(2, notice.getN_date());
			ps.setInt(3, notice.getN_idx());
					
			int row = ps.executeUpdate();//ps.executeQuery();
								
			if(row>0) {
				result = true;
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL Error: Notice Update Error()");
		}finally {
			 if(ps !=null)
				 ps.close();
			if(rs !=null) 
				rs.close();
			
			 //if(conn != null)  conn.close();	 
		}
		
		return result;
		
	}
	
	
	
	//공지사항 하나의글 보기

			public List<Notice> NoticeOne(int idx) throws SQLException {
				//boolean result =false;
				String sql = "select * FROM  notice where n_Idx=? " ;
				PreparedStatement ps =null;
				ResultSet rs =null;
				List<Notice> list = new ArrayList<Notice>();
				//System.out.println("args:"+ idx);
				System.out.println("sql:"+sql);
				
				try {
					ps =  conn.prepareStatement(sql);
					ps.setInt(1, idx);
				
					rs = ps.executeQuery();
										
					if(rs.next()) {
						Notice notice  =new Notice();
						notice.setN_idx(rs.getInt("n_Idx"));
						notice.setN_notice(rs.getString("n_Notice"));
						notice.setN_date(rs.getString("n_Date"));
						notice.setN_writer(rs.getString("n_Writer"));
						list.add(notice);
					}
					
					
				} catch (SQLException e) {
					e.printStackTrace();
					System.out.println("SQL Error: NoticeOne()");
				}finally {
					 if(ps !=null)
						 ps.close();
					if(rs !=null) 
						rs.close();
					
					 //if(conn != null)  conn.close();	 
				}
				
				return list;
				
			}
			
	
			
		
	
	//업체 리스트 

	public List<Partner> PartnerAll(String category) throws SQLException {
		//boolean result =false;
		String sql = "select * FROM  partner where p_Category =?" ;
		PreparedStatement ps =null;
		ResultSet rs =null;
		List<Partner> list = new ArrayList<Partner>();
		System.out.println("args:"+ category);
		System.out.println("sql:"+sql);
		
		try {
			ps =  conn.prepareStatement(sql);
			ps.setString(1, category);
		
			rs = ps.executeQuery();
			if(rs.next()) {
				Partner partner  =new Partner();
				partner.setP_Idx(rs.getInt(1));
				partner.setM_Idx(rs.getInt(2));
				partner.setName(rs.getString("p_Name"));
				partner.setPhone(rs.getString("p_Phone"));
				partner.setAddress(rs.getString("p_Address"));
				partner.setIntroduce(rs.getString("p_Introduce"));
				partner.setOperation(rs.getString("p_Operation"));
				partner.setPrice(rs.getInt("p_Price"));
				partner.setPhoto1(rs.getString("p_Photo1"));
				list.add(partner);
				
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL Error: PartnerAll()");
		}finally {
			 if(ps !=null)
				 ps.close();
			if(rs !=null) 
				rs.close();
			
			 //if(conn != null)  conn.close();	 
		}
		
		return list;
		
	}
	
	
	
}