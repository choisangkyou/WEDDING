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
	String url ="jdbc:mysql://localhost:3306/wowwedding";
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
			 if(conn != null) {	conn.close();	 }
		}
		
		return result;
		
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
			 if(conn != null) {	conn.close();	 }
			 
		}
		
		
		return list;
		
	}
	
	
	
}