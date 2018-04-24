package modal;

public class Reservation {
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

	 * */
	private int r_Idx;
	private int m_Idx;
	private int p_Idx;
	private String r_Date;
	private String r_ServiceDate;
	private short r_Confirm;
	private int r_Price;
	private short r_Status;
	public int getR_Idx() {
		return r_Idx;
	}
	public void setR_Idx(int r_Idx) {
		this.r_Idx = r_Idx;
	}
	public int getM_Idx() {
		return m_Idx;
	}
	public void setM_Idx(int m_Idx) {
		this.m_Idx = m_Idx;
	}
	public int getP_Idx() {
		return p_Idx;
	}
	public void setP_Idx(int p_Idx) {
		this.p_Idx = p_Idx;
	}
	public String getR_Date() {
		return r_Date;
	}
	public void setR_Date(String r_Date) {
		this.r_Date = r_Date;
	}
	public String getR_ServiceDate() {
		return r_ServiceDate;
	}
	public void setR_ServiceDate(String r_ServiceDate) {
		this.r_ServiceDate = r_ServiceDate;
	}
	public short getR_Confirm() {
		return r_Confirm;
	}
	public void setR_Confirm(short r_Confirm) {
		this.r_Confirm = r_Confirm;
	}
	public int getR_Price() {
		return r_Price;
	}
	public void setR_Price(int r_Price) {
		this.r_Price = r_Price;
	}
	public short getR_Status() {
		return r_Status;
	}
	public void setR_Status(short r_Status) {
		this.r_Status = r_Status;
	}
	
	
	
}
