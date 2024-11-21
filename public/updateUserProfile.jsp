<%@page import="java.sql.*"%>
<%
Integer userRoleId = (Integer) session.getAttribute("userRoleId");
if (userRoleId == null) {
	response.sendRedirect("login.jsp");
}

String name = request.getParameter("name");
String email = request.getParameter("email");

try {
	Class.forName("org.postgresql.Driver");
	String connURL = "jdbc:postgresql://ep-late-flower-a15dwl0h.ap-southeast-1.aws.neon.tech/cleaningService?sslmode=require";
	String dbUsername = "neondb_owner";
	String dbPassword = "fbtpKBzO01Jl";
	Connection conn = DriverManager.getConnection(connURL, dbUsername, dbPassword);

	String updateQuery = "UPDATE users SET name = ?, email = ? WHERE id = ?";
	PreparedStatement pstmt = conn.prepareStatement(updateQuery);
	pstmt.setString(1, name);
	pstmt.setString(2, email);
	pstmt.setInt(3, userRoleId);

	int rows = pstmt.executeUpdate();
	conn.close();

	if (rows > 0) {
		response.sendRedirect("userProfile.jsp");
	} else {
		out.println("Failed to update profile.");
	}
} catch (Exception e) {
	out.println("Error: " + e.getMessage());
}
%>
