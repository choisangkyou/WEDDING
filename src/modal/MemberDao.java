package modal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



public class MemberDao {
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
	
	
	//업체 리스트 

	public List<Partner> PartnerAll(String category) throws SQLException {
		//boolean result =false;
		String sql = "select * FROM  partner where p_Category =?" ;
		PreparedStatement ps =null;
		ResultSet rs =null;
		List<Partner> list = new ArrayList<Partner>();
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