<!--
    Author: Tan Rui Zhang Jovan
    Admin No: p2322951
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->
<%@page import="java.util.*, java.sql.*"%>
<%
//Initalised variables
String serviceIdForCategory = request.getParameter("serviceCategoryList");
String service = request.getParameter("serviceName");
String description = request.getParameter("description");
String imageUrl = request.getParameter("imageUrl");
int noOfServiceCategory = 0;
int service_id_for_category = 0;

List<String> services = new ArrayList<>();
List<Integer> services_category_id = new ArrayList<>();

//Step1: Load JDBC Driver
Class.forName("org.postgresql.Driver");

// Step 2: Define Connection URL
String connURL = "jdbc:postgresql://ep-late-flower-a15dwl0h.ap-southeast-1.aws.neon.tech/cleaningService?sslmode=require";
String dbUsername = "neondb_owner";
String dbPassword = "fbtpKBzO01Jl";

// Step 3: Establish connection to URL
Connection conn = DriverManager.getConnection(connURL, dbUsername, dbPassword);

// Step 4: Create Statement object
Statement stmt = conn.createStatement();

if (service != null && !service.trim().isEmpty() && description != null && !description.trim().isEmpty()
		&& imageUrl != null && !imageUrl.trim().isEmpty()) {
	service_id_for_category = Integer.parseInt(serviceIdForCategory);
	try {
		// Step 5: Execute SQL Command
		String insertStr = "INSERT INTO service (category_id, service_name, description, image_url) VALUES (?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(insertStr);
		pstmt.setInt(1, service_id_for_category);
		pstmt.setString(2, service);
		pstmt.setString(3, description);
		pstmt.setString(4, imageUrl);
		int count = pstmt.executeUpdate();

		// Step 6: Process Result
		if (count > 0) {
	session.setAttribute("createSuccessfully", "Created successfully!");
	response.sendRedirect("index.jsp");
		}
		conn.close();
	} catch (Exception e) {
		out.println("Error: " + e);
	}
} else {
	String sqlStr = "SELECT * FROM service_category ORDER BY id";
	ResultSet rs = stmt.executeQuery(sqlStr);

	// Step 6: Process Result
	while (rs.next()) {
		noOfServiceCategory++;
		services_category_id.add(rs.getInt("id"));
		services.add(rs.getString("category"));
	}
}
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Create Service</title>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/form.css">
</head>
<body>

	<jsp:include page="header.jsp" />
	
	<!-- Form to create service -->
	<div class="album py-5 bg-light">
		<h2 class="display-6 text-center mb-4">Create New Service</h2>
		<form action="createService.jsp" method="post">
			<select name="serviceCategoryList" size="<%=noOfServiceCategory%>"
				required>
				<%
				for (int i = 0; i < services.size(); i++) {
					int serviceCategoryId = services_category_id.get(i);
					String serviceName = services.get(i);
				%>
				<option value="<%=serviceCategoryId%>"><%=serviceName%></option>
				<%
				}
				%>
			</select><br>
			<p>Service Name</p>
			<input type="text" name="serviceName" required>
			<p>Description</p>
			<textarea rows="10" cols="30" name="description" required></textarea>
			<p>Image URL</p>
			<input type="text" name="imageUrl" value="img/default cleaning.jpg"
				readonly> <br>
			<button type="submit" class="btn">Create</button>
		</form>
	</div>
	<jsp:include page="footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
