<%@page import="java.util.*, java.sql.*"%>
<%
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
		double price = rs.getDouble("package_price");
		String packagePrice = String.format("%.2f", price);
		serviceCategory.put("package_price", packagePrice);
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
<title>Pricing Example</title>

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
					<h1 class="fw-light">Pricing Example</h1>
					<p class="lead text-muted">Quickly build an effective pricing
						table for your potential customers with this Bootstrap example.
						It’s built with default Bootstrap components and utilities with
						little customization.</p>
					<p>
						<a href="#" class="btn btn-primary my-2">Main Call to Action</a> <a
							href="#" class="btn btn-secondary my-2">Secondary Action</a>
					</p>
				</div>
			</div>
		</section>

		<%
		String bookingError = (String) session.getAttribute("bookingError");
		if (bookingError != null) {
		%>
		<div class="alert alert-success" role="alert"
			style="text-align: center;">
			<%=bookingError%>
		</div>
		<%
		session.removeAttribute("bookingError");
		}
		%>
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
									$<%=serviceCategory.get("package_price")%><small
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

		<h2 class="display-6 text-center mb-4">Compare Plans</h2>
		<div class="table-responsive">
			<table class="table text-center">
				<thead>
					<tr>
						<th style="width: 34%;"></th>
						<th style="width: 22%;">Free</th>
						<th style="width: 22%;">Pro</th>
						<th style="width: 22%;">Enterprise</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row" class="text-start">Public</th>
						<td>&#10004;</td>
						<td>&#10004;</td>
						<td>&#10004;</td>
					</tr>
					<tr>
						<th scope="row" class="text-start">Private</th>
						<td></td>
						<td>&#10004;</td>
						<td>&#10004;</td>
					</tr>
					<!-- Add more rows as needed -->
				</tbody>
			</table>
		</div>
	</main>

	<!-- Render Footer -->
	<jsp:include page="footer.html" />
	<!--
	<script> 
 document.addEventListener('DOMContentLoaded', () => { 
        const bookNowButtons = document.querySelectorAll('.book-now-btn'); 
 
        bookNowButtons.forEach(button => { 
            button.addEventListener('click', () => { 
                const serviceName = button.getAttribute('data-service-name'); 
                const servicePrice = button.getAttribute('data-service-price'); 
 
                // Ensure the values are correctly logged 
                console.log('serviceName:', serviceName); 
                console.log('servicePrice:', servicePrice); 
 
                const params = new URLSearchParams(); 
                params.append('serviceName', serviceName); 
                params.append('servicePrice', servicePrice); 
 
                fetch('/JAD_Project/add-to-cart', { 
                    method: 'POST', 
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' }, 
                    body: params.toString() 
                }) 
 
 
                .then(response => response.json()) 
                .then(data => { 
                    if (data.success) { 
                        document.getElementById('cart-badge').textContent = data.itemCount; 
                        alert(`Added "${serviceName}" to cart! Total items: ${data.itemCount}`); 
                    } else { 
                        alert('Failed to add to cart. Please try again.'); 
                    } 
                }) 
                .catch(error => console.error('Error:', error)); 
            }); 
        }); 
    }); 
 </script>
 -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>