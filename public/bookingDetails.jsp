<%@page import="java.text.SimpleDateFormat, java.util.Date, java.sql.*"%>
<%
String service = request.getParameter("serviceList");
int service_id = Integer.parseInt(service);
Integer userRoleId = (Integer) session.getAttribute("userRoleId");
String date = request.getParameter("date");
java.sql.Date sqlDate = null;
try {
    // Convert the String to java.util.Date
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date utilDate = sdf.parse(date);

    // Convert to java.sql.Date
    sqlDate = new java.sql.Date(utilDate.getTime());
} catch (Exception e) {
    out.println("Error parsing date: " + e.getMessage());
}

String time = request.getParameter("time");
java.sql.Time sqlTime = java.sql.Time.valueOf(time + ":00");

if (service != null && date != null && time != null) {

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
		String insertStr = "INSERT INTO booking (user_id, service_id, date_for_service, time_for_service) VALUES(?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(insertStr);
		pstmt.setInt(1, userRoleId);
		pstmt.setInt(2, service_id);
		pstmt.setDate(3, sqlDate);
		pstmt.setTime(4, sqlTime);
		int count = pstmt.executeUpdate();

		// Step 6: Process Result
		if (count > 0) {
	session.setAttribute("successMessage", "Booking successful! Added to cart");
	response.sendRedirect("index.jsp");
		}
		conn.close();
	} catch (Exception e) {
		out.println("Error :" + e);
	}
} else {
	response.sendRedirect("bookingService.jsp");
}
%>