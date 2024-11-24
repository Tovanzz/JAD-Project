<!--
    Author: Tan Rui Zhang Jovan, GERALD SIM KANG LE
    Admin No: p2322951, p2209319
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->

<%@page import="java.util.*, java.sql.*"%>
<%
//Initalised variables
String id;
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
	String sqlStr = "SELECT * FROM service_category ORDER BY id";
	ResultSet rs = stmt.executeQuery(sqlStr);

	// Step 6: Process Result
	while (rs.next()) {
		Map<String, String> serviceCategory = new HashMap<>();
		serviceCategory.put("id", rs.getString("id"));
		serviceCategory.put("service_category", rs.getString("category"));
		serviceCategory.put("description", rs.getString("description"));
		double price = rs.getDouble("price_per_hour");
		String price_per_hour = String.format("%.2f", price);
		serviceCategory.put("price_per_hour", price_per_hour);
		servicesCategory.add(serviceCategory);
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
<title>Booking</title>

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

	<!-- Include header HTML -->
	<jsp:include page="header.jsp" />

	<main>
		<section class="py-5 text-center container">
			<div class="row py-lg-5">
				<div class="col-lg-6 col-md-8 mx-auto">
					<h1 class="fw-light">About booking</h1>
					<p class="lead text-muted">Booking a cleaning service allows
						you to schedule professional cleaning for your home or office. You
						can select from a range of services such as regular cleaning, deep
						cleaning, or specialized tasks like carpet or window cleaning. The
						booking process typically includes choosing a convenient time,
						providing details about the space to be cleaned, and confirming
						your payment. Many services also offer customizable options to
						meet specific needs, ensuring a thorough and personalized cleaning
						experience.</p>
				</div>
			</div>
		</section>

		<!-- Error message -->
		<%
		String bookingError = (String) session.getAttribute("bookingError");
		if (bookingError != null) {
		%>
		<div id="errorPopup" class="modal fade" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title text-danger">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								fill = "red" class="bi bi-exclamation-triangle-fill me-2" viewBox="0 0 16 16">
                        <path
									d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5m.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2" />
                    </svg>
							Error
						</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body text-center">
						<p class="text-danger"><%=bookingError%></p>
					</div>
				</div>
			</div>
		</div>
		<%
		session.removeAttribute("bookingError");
		}
		%>

		<!-- Different bookings options for cleaning service -->
		<div class="album py-5 bg-light">
			<div class="container">
				<div class="row row-cols-1 row-cols-md-3 mb-3 text-center">
					<%
					for (Map<String, String> serviceCategory : servicesCategory) {
					%>
					<div class="col">
						<div class="card mb-4 rounded-3 shadow-sm">
							<div class="card-header py-3">
								<h4 class="my-0 fw-normal"><%=serviceCategory.get("service_category")%></h4>
							</div>
							<div class="card-body">
								<h1 class="card-title pricing-card-title">
									$<%=serviceCategory.get("price_per_hour")%><small
										class="text-muted fw-light">/hr</small>
								</h1>
								<p>
									<%=serviceCategory.get("description")%></p>
								<form action="bookingService.jsp" method="post">
									<input type="hidden" name="id"
										value=<%=serviceCategory.get("id")%>>
									<button type="submit"
										class="w-100 btn btn-lg btn-outline-primary book-now-btn">
										Book Now</button>
								</form>
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

	<!-- Render Footer -->
	<jsp:include page="footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			const errorPopup = new bootstrap.Modal(document
					.getElementById('errorPopup'));
			errorPopup.show();
		});
	</script>

</body>
</html>