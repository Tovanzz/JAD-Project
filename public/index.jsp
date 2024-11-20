<%@page import="java.util.*, java.sql.*"%>
<%
String category;
String description;
String image_url;

List<Map<String, String>> services = new ArrayList<>();

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
	String sqlStr = "SELECT * FROM service_category ORDER BY id";
	ResultSet rs = stmt.executeQuery(sqlStr);

	// Step 6: Process Result
	while (rs.next()) {
		Map<String, String> service = new HashMap<>();
		service.put("category", rs.getString("category"));
		service.put("description", rs.getString("description"));
		service.put("image_url", rs.getString("category_image_url"));
		services.add(service);
	}

	conn.close();
} catch (Exception e) {
	out.println("Error :" + e);
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
<title>Album example Â· Bootstrap v5.0</title>

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
	<jsp:include page="header.html" />

	<main>
		<section class="py-5 text-center container">
			<div class="row py-lg-5">
				<div class="col-lg-6 col-md-8 mx-auto">
					<h1 class="fw-light">Album example</h1>
					<p class="lead text-muted">Something short and leading about
						the collection below—its contents, the creator, etc. Make it short
						and sweet, but not too short so folks don’t simply skip over it
						entirely.</p>
					<p>
						<a href="#" class="btn btn-primary my-2">Main call to action</a> <a
							href="#" class="btn btn-secondary my-2">Secondary action</a>
					</p>
				</div>
			</div>
		</section>

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
								alt="<%=service.get("category")%>" height="225" />

							<div class="card-body">
								<h2 class="text-center"><%=service.get("category")%></h2>
								<p class="card-text"><%=service.get("description")%></p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button type="button" class="btn btn-sm btn-outline-secondary">View</button>
										<%
										Integer userRoleId = (Integer) session.getAttribute("userRoleId");
										if (userRoleId != null && userRoleId == 1) {
										%>
										<button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
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
	<jsp:include page="footer.html" />

	<script src="assets/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
