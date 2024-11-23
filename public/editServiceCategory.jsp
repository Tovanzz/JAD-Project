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

List<Map<String, String>> services = new ArrayList<>();

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
		String sqlStr = "SELECT * FROM service_category WHERE id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1, serviceCategoryId);
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		while (rs.next()) {
	Map<String, String> serviceCategory = new HashMap<>();
	serviceCategory.put("category", rs.getString("category"));
	serviceCategory.put("description", rs.getString("description"));
	serviceCategory.put("category_image_url", rs.getString("category_image_url"));
	double price = rs.getDouble("price_per_hour");
	String price_per_hour = String.format("%.2f", price);
	serviceCategory.put("price", price_per_hour);
	services.add(serviceCategory);
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
<title>Edit Service Category</title>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/form.css">
</head>
<body>

	<jsp:include page="header.jsp" />

	<%
	if (!services.isEmpty()) {
	%>
	
	<!-- Form to update service category -->
	<div class="album py-5 bg-light">
		<h2 class="display-6 text-center mb-4">
			Edit
			<%=services.get(0).get("category")%>
		</h2>
		<form action="updateServiceCategory.jsp" method="post">
			<p>Service Category</p>
			<input type="text" name="category"
				value="<%=services.get(0).get("category")%>" required>
			<p>Description</p>
			<textarea rows="10" cols="30" name="description" required><%=services.get(0).get("description")%></textarea>
			<p>Image URL</p>
			<input type="text" name="imageUrl"
				value="<%=services.get(0).get("category_image_url")%>" readonly>
			<p>Price</p>
			<input type="number" step="0.01" name="price"
				value="<%=services.get(0).get("price")%>" required><br>
			<button type="submit" class="btn" name="id"
				value=<%=serviceCategoryId%>>Edit</button>
		</form>
		<%
		} else {
		%>
		<p>No service category found. Please check the ID or try again
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
