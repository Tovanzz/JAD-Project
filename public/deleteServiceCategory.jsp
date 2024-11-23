<!--
    Author: Tan Rui Zhang Jovan
    Admin No: p2322951
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->

<%@page import="java.util.*, java.sql.*"%>
<%
//Initalised variables
String id = request.getParameter("id");
int serviceCategoryId = 0;

if (id != null) {
	serviceCategoryId = Integer.parseInt(id);
	try {
		// Step1: Load JDBC Driver
		Class.forName("org.postgresql.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:postgresql://ep-late-flower-a15dwl0h.ap-southeast-1.aws.neon.tech/cleaningService?sslmode=require";
		String dbUsername = "neondb_owner";
		String dbPassword = "fbtpKBzO01Jl";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL, dbUsername, dbPassword);

		// Step 4: Create Statement object
		Statement stmt = conn.createStatement();

		// Step 5: Execute SQL Command
		String sqlStr = "Delete FROM service_category WHERE id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1, serviceCategoryId);
		int count = pstmt.executeUpdate();

		// Step 6: Process Result
		if (count > 0) {
		session.setAttribute("deleteSuccessfully", "Deleted successfully!");
		response.sendRedirect("index.jsp");
		}
		conn.close();
	} catch (Exception e) {
		out.println("Error: " + e);
	}
}
%>

