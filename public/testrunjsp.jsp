<%@page import="java.sql.*"%>
<%
int id = 0;
String name = "";

try {
	// Step1: Load JDBC Driver
	Class.forName("org.postgresql.Driver");

	// Step 2: Define Connection URL
	String connURL = "jdbc:postgresql://ep-late-flower-a15dwl0h.ap-southeast-1.aws.neon.tech/cleaningService?sslmode=require";
	String username = "neondb_owner";
	String password = "fbtpKBzO01Jl";

	// Step 3: Establish connection to URL
	Connection conn = DriverManager.getConnection(connURL, username, password);

	// Step 4: Create Statement object
	Statement stmt = conn.createStatement();

	// Step 5: Execute SQL Command
	String sqlStr = "SELECT * FROM users";
	ResultSet rs = stmt.executeQuery(sqlStr);

	// Step 6: Process Result
	while (rs.next()) {
		id = rs.getInt("id");
		name = rs.getString("name");
		out.println("ID: " + id + ", Name: " + name + "<br>");
	}

	// Step 7: Close connection
	conn.close();
} catch (Exception e) {
	out.println("Error :" + e);
}
%>