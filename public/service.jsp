<!--
    Author: Tan Rui Zhang Jovan
    Admin No: p2322951
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->
<%@page import="java.util.*, java.sql.*"%>
<%
//Initalised variables
Integer userRoleId = (Integer) session.getAttribute("userRoleId");
String id = request.getParameter("id");
String category = "";
String description = "";

List<Map<String, String>> services = new ArrayList<>();

if (id != null) {
	int serviceCategoryId = Integer.parseInt(id);

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
		String categoryQuery = "SELECT * FROM service_category WHERE id = ?";
		PreparedStatement pstmtCategory = conn.prepareStatement(categoryQuery);
		pstmtCategory.setInt(1, serviceCategoryId);
		ResultSet rsCategory = pstmtCategory.executeQuery();

		// Step 6: Process Result
		if (rsCategory.next()) {
	category = rsCategory.getString("category");
	description = rsCategory.getString("description");
		}

		// Step 5: Execute SQL Command
		String sqlStr = "SELECT * FROM service WHERE category_id = ? ORDER BY id";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1, serviceCategoryId);
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		while (rs.next()) {
	Map<String, String> service = new HashMap<>();
	service.put("serviceId", rs.getString("id"));
	service.put("service_name", rs.getString("service_name"));
	service.put("description", rs.getString("description"));
	service.put("image_url", rs.getString("image_url"));
	services.add(service);
		}

		conn.close();
	} catch (Exception e) {
		out.println("Error :" + e);
	}
}
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.84.0">
<title>Service Page</title>

<!-- Bootstrap core CSS -->
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>
</head>
<body>

	<!-- Include the header -->
	<jsp:include page="header.jsp" />

	<main>
		<section class="py-5 text-center container">
			<div class="row py-lg-5">
				<div class="col-lg-6 col-md-8 mx-auto">
					<h1 class="fw-light"><%=category%></h1>
					<%
					if (userRoleId != null && userRoleId == 1) {
					%>
					<form action="createService.jsp" method="get">
						<button type="submit" class="btn btn-sm btn-primary">Create
							services</button>
					</form>
					<%
					}
					%>
					<p class="lead text-muted"><%=description%></p>
				</div>
			</div>
		</section>

		<!-- Displaying of different services -->
		<div class="album py-5 bg-light">
			<div class="container">
				<div class="row row-cols-1 row-cols-md-3 g-4">
					<%
					for (Map<String, String> service : services) {
					%>
					<div class="col">
						<div class="card shadow-sm h-100">
							<!-- Replace the SVG placeholder with an actual image -->
							<img src="<%=service.get("image_url")%>" class="card-img-top"
								height="225" />
							<div class="card-body">
								<h2 class="text-center"><%=service.get("service_name")%></h2>
								<p class="card-text"><%=service.get("description")%></p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<form action="booking.jsp" method="get">
											<button type="submit" class="btn btn-sm btn-primary">Book
												Now</button>
										</form>
										<%
										if (userRoleId != null && userRoleId == 1) {
										%>
										<form action="editService.jsp" method="post">
											<button type="submit" class="btn btn-sm btn-warning"
												name="id" value=<%=service.get("serviceId")%>>Edit</button>
										</form>
										<form action="deleteService.jsp" method="post">
											<button type="submit" class="btn btn-sm btn-danger" name="id"
												value=<%=service.get("serviceId")%>>Delete</button>
										</form>
										<%
										}
										%>
									</div>
								</div>
							</div>
						</div>
					</div>
					<%
					}
					%>
				</div>
			</div>
		</div>
	</main>

	<!-- Include the footer -->
	<jsp:include page="footer.jsp" />

	<script src="assets/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
