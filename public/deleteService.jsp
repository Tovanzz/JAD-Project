<%@page import="java.sql.*"%>
<%
int id = 0;
String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

if (name != null && !name.trim().isEmpty() && email != null && !email.trim().isEmpty() && password != null
		&& !password.trim().isEmpty()) {

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
		String insertStr = "DELETE service WHERE id = ?";
		PreparedStatement pstmt = conn.prepareStatement(insertStr);
		pstmt.setInt(1, serviceId);
		int count = pstmt.executeUpdate();

		// Step 6: Process Result
		if (count > 0) {
	response.sendRedirect("index.jsp");
		}
		conn.close();
	} catch (Exception e) {
		out.println("Error :" + e);
	}
}
%>
