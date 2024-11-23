<!--
    Author: Tan Rui Zhang Jovan, GERALD SIM KANG LE
    Admin No: p2322951, p2209319
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->
<%@page import="java.util.*, java.sql.*"%>
<%

//Initalised variables
Integer userRoleId = (Integer) session.getAttribute("userRoleId");
Integer userId = (Integer) session.getAttribute("userId");
String userName = "";
String userRole = "";
int noOfBooking = 0;

List<Map<String, String>> servicesCategory = new ArrayList<>();

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
	if (userId != null) {
		String userQuery = "SELECT u.name, r.role " + "FROM users u " + "JOIN user_role r ON u.user_role_id = r.id "
		+ "WHERE u.id = ?";
		PreparedStatement pstmt = conn.prepareStatement(userQuery);
		pstmt.setInt(1, userId); // Use the user's auto-incremented ID
		ResultSet rsUser = pstmt.executeQuery();

		// Step 6: Process Result
		if (rsUser.next()) {
	userName = rsUser.getString("name");
	userRole = rsUser.getString("role");
		}

		// Step 5: Execute SQL Command
		String sqlStr1 = "SELECT * FROM booking WHERE user_id = ?";
		PreparedStatement pstmt1 = conn.prepareStatement(sqlStr1);
		pstmt1.setInt(1, userId);
		ResultSet rs1 = pstmt1.executeQuery();

		// Step 6: Process Result
		while (rs1.next()) {
	noOfBooking++;
		}
		session.setAttribute("noOfBooking", noOfBooking);
	}

	// Step 5: Execute SQL Command
	String sqlStr = "SELECT * FROM service_category ORDER BY id";
	ResultSet rs = stmt.executeQuery(sqlStr);

	// Step 6: Process Result
	while (rs.next()) {
		Map<String, String> serviceCategory = new HashMap<>();
		serviceCategory.put("service_category_id", rs.getString("id"));
		serviceCategory.put("category", rs.getString("category"));
		serviceCategory.put("description", rs.getString("description"));
		serviceCategory.put("image_url", rs.getString("category_image_url"));
		servicesCategory.add(serviceCategory);
	}

	conn.close();
} catch (Exception e) {
	out.println("Error :" + e);
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.84.0">
<title>Home Page</title>

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

	<!-- Welcome Modal -->
	<div class="modal fade" id="welcomeModal" tabindex="-1"
		aria-labelledby="welcomeModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="welcomeModalLabel">Welcome Back!</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>
						Hello, <b><%=userName%></b>!
					</p>
					<p>
						You are logged in as a <b><%=userRole%></b>.
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<main>
	<!-- Error messages -->
		<%
		String successMessage = (String) session.getAttribute("successMessage");
		if (successMessage != null) {
		%>
		<div class="alert alert-success" role="alert"
			style="text-align: center;">
			<%=successMessage%>
		</div>
		<%
		session.removeAttribute("successMessage");
		}
		%>

		<%
		String createSuccessfully = (String) session.getAttribute("createSuccessfully");
		if (createSuccessfully != null) {
		%>
		<div class="alert alert-success" role="alert"
			style="text-align: center;">
			<%=createSuccessfully%>
		</div>
		<%
		session.removeAttribute("createSuccessfully");
		}
		%>

		<%
		String updateSuccessfully = (String) session.getAttribute("updateSuccessfully");
		if (updateSuccessfully != null) {
		%>
		<div class="alert alert-success" role="alert"
			style="text-align: center;">
			<%=updateSuccessfully%>
		</div>
		<%
		session.removeAttribute("updateSuccessfully");
		}
		%>

		<%
		String deleteSuccessfully = (String) session.getAttribute("deleteSuccessfully");
		if (deleteSuccessfully != null) {
		%>
		<div class="alert alert-success" role="alert"
			style="text-align: center;">
			<%=deleteSuccessfully%>
		</div>
		<%
		session.removeAttribute("deleteSuccessfully");
		}
		%>

		<section class="py-5 text-center container">
			<div class="row py-lg-5">
				<div class="col-lg-6 col-md-8 mx-auto">
					<h1 class="fw-light">About Us</h1>
					<p class="lead text-muted">At Dust Be Gone, we specialize in
						creating clean, comfortable, and inviting spaces for homes and
						businesses. Our professional team is dedicated to delivering
						top-quality cleaning solutions tailored to meet your needs.
						Whether it is a sparkling home, a spotless office, or a
						deep-cleaning project, we are here to ensure your environment
						shines with cleanliness and care. Discover the difference of a
						truly clean space because you deserve the best!</p>
				</div>
			</div>
			<!-- Showing different service category -->
			<h2 style="text-align: center; padding-bottom: 20px;">Service
				Category</h2>
			<%
			if (userRoleId != null && userRoleId == 1) {
			%>
			<form action="createServiceCategory.jsp" method="get">
				<button type="submit" class="btn btn-sm btn-primary">Create Service Category</button>
			</form>
			<%
			}
			%>
		</section>

		<div class="album py-5 bg-light">
			<div class="container">
				<div class="row row-cols-1 row-cols-md-3 g-4">
					<%
					for (Map<String, String> serviceCategory : servicesCategory) {
					%>
					<div class="col">
						<div class="card shadow-sm h-100">
							<!-- Replace the SVG placeholder with an actual image -->
							<img src="<%=serviceCategory.get("image_url")%>"
								class="card-img-top" alt="<%=serviceCategory.get("category")%>"
								height="225" />

							<div class="card-body">
								<h2 class="text-center"><%=serviceCategory.get("category")%></h2>
								<p class="card-text"><%=serviceCategory.get("description")%></p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<form action="service.jsp" method="get">
											<button type="submit" class="btn btn-sm btn-primary"
												name="id"
												value=<%=serviceCategory.get("service_category_id")%>>View</button>
										</form>
										<%
										if (userRoleId != null && userRoleId == 1) {
										%>
										<form action="editServiceCategory.jsp" method="post">
											<button type="submit" class="btn btn-sm btn-warning"
												name="id"
												value=<%=serviceCategory.get("service_category_id")%>>Edit</button>
										</form>
										<form action="deleteServiceCategory.jsp" method="post">
											<button type="submit" class="btn btn-sm btn-danger" name="id"
												value=<%=serviceCategory.get("service_category_id")%>>Delete</button>
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
	<script>
		// Show the welcome modal only if the user just logged in
		window.onload = function() {
			const justLoggedIn =
	<%=session.getAttribute("justLoggedIn") != null ? "true" : "false"%>
		;
			if (justLoggedIn) {
				const modal = new bootstrap.Modal(document
						.getElementById('welcomeModal'));
				modal.show();
	<%session.removeAttribute("justLoggedIn");%>
		// Clear the attribute
			}
		};
	</script>

</body>
</html>
