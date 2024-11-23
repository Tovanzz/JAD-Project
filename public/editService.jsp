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
int serviceId = 0;

List<Map<String, String>> services = new ArrayList<>();

if (id != null) {
	serviceId = Integer.parseInt(id);
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
		String sqlStr = "SELECT * FROM service WHERE id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1, serviceId);
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		if (rs.next()) {
	Map<String, String> service = new HashMap<>();
	service.put("service_name", rs.getString("service_name"));
	service.put("description", rs.getString("description"));
	service.put("service_image_url", rs.getString("image_url"));
	services.add(service);
		}
		conn.close();
	} catch (Exception e) {
		out.println("Error: " + e);
	}
}
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Edit Service</title>
<link rel="stylesheet" href="css/form.css">
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

	<jsp:include page="header.jsp" />

	<%
	if (!services.isEmpty()) {
	%>
	
	<!-- Form to update service -->
	<div class="album py-5 bg-light">
		<h2 class="display-6 text-center mb-4">
			Edit
			<%=services.get(0).get("service_name")%>
		</h2>
		<form action="updateService.jsp" method="post">
			<p>Service Name</p>
			<input type="text" name="serviceName"
				value="<%=services.get(0).get("service_name")%>" required>
			<p>Description</p>
			<textarea rows="10" cols="30" name="description" required><%=services.get(0).get("description")%></textarea>
			<p>Image URL</p>
			<input type="text" name="imageUrl"
				value="<%=services.get(0).get("service_image_url")%>" readonly>
			<br>
			<button type="submit" class="btn" name="id"
				value=<%=serviceId%>>Edit</button>
		</form>
		<%
		} else {
		%>
		<p>No service found. Please check the ID or try again
			later.</p>
		<%
		}
		%>
	</div>
	<jsp:include page="footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
