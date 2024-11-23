<!--
    Author: Tan Rui Zhang Jovan
    Admin No: p2322951
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->
<%@page import="java.util.*, java.sql.*"%>
<%
//Initalised variables
String category = request.getParameter("category");
String description = request.getParameter("description");
String price = request.getParameter("price");
String imageUrl = request.getParameter("imageUrl");

if (category != null && !category.trim().isEmpty() && description != null && !description.trim().isEmpty() && price != null
		&& !price.trim().isEmpty()) {

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
		String sqlStr = "INSERT INTO service_category (category, description, category_image_url, price_per_hour) VALUES (?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, category);
		pstmt.setString(2, description);
		pstmt.setString(3, imageUrl);
		Double priceCategory = Double.parseDouble(price); 
		pstmt.setDouble(4, priceCategory);
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
}
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Create Service Category</title>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/form.css">
</head>
<body>

	<jsp:include page="header.jsp" />
	
	<!-- Form to create service category -->
	<div class="album py-5 bg-light">
		<h2 class="display-6 text-center mb-4">Create Service Category</h2>
		<form action="createServiceCategory.jsp" method="post">
			<p>Service Category</p>
			<input type="text" name="category" required>
			<p>Description</p>
			<textarea rows="10" cols="30" name="description" required></textarea>
			<p>Image URL</p>
			<input type="text" name="imageUrl" value="img/default cleaning.jpg"
				readonly>
			<p>Price</p>
			<input type="number" step="0.01" name="price" required><br>
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
