<!--
    Author:GERALD SIM KANG LE
    Admin No: p2209319
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->

<%@page import="java.sql.*"%>
<%
//Initalised variables
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
	response.sendRedirect("login.jsp");
	return;
}

// Get updated values from the form 
String name = request.getParameter("name");
String email = request.getParameter("email");
String phone = request.getParameter("phone");
String address = request.getParameter("address");
String dob = request.getParameter("dob"); // Format should be YYYY-MM-DD 

try {
	// Load the PostgreSQL Driver 
	Class.forName("org.postgresql.Driver");
	String connURL = "jdbc:postgresql://ep-late-flower-a15dwl0h.ap-southeast-1.aws.neon.tech/cleaningService?sslmode=require";
	String dbUsername = "neondb_owner";
	String dbPassword = "fbtpKBzO01Jl";
	Connection conn = DriverManager.getConnection(connURL, dbUsername, dbPassword);

	// Update query to include phone, address, and date of birth (explicitly cast dob) 
	String updateQuery = "UPDATE users SET name = ?, email = ?, phone_number = ?, address = ?, date_of_birth = CAST(? AS DATE) WHERE id = ?";
	PreparedStatement pstmt = conn.prepareStatement(updateQuery);
	pstmt.setString(1, name);
	pstmt.setString(2, email);
	pstmt.setString(3, phone);
	pstmt.setString(4, address);
	pstmt.setString(5, dob); // dob should be in YYYY-MM-DD format 
	pstmt.setInt(6, userId);

	int rows = pstmt.executeUpdate();
	conn.close();

	// Redirect to the profile page on success 
	if (rows > 0) {
		response.sendRedirect("userProfile.jsp");
	} else {
		out.println("Failed to update profile.");
	}
} catch (Exception e) {
	out.println("Error: " + e.getMessage());
}
%>