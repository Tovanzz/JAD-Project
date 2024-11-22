<%@page import="java.util.*, java.sql.*"%>
<%
// Initialize variables
Integer id = null;
String category = "Unknown Category";
String description = "Description not available.";
String packagePrice = "0.00";
String service = "No service";
int count = 0;
List<String> services = new ArrayList<>();
List<Integer> services_id = new ArrayList<>();
Integer userRoleId = (Integer) session.getAttribute("userRoleId");
try {
	// Parse ID from request parameter
	if (request.getParameter("id") != null && userRoleId != null) {
		id = Integer.parseInt(request.getParameter("id"));

		// Database connection details
		Class.forName("org.postgresql.Driver");
		String connURL = "jdbc:postgresql://ep-late-flower-a15dwl0h.ap-southeast-1.aws.neon.tech/cleaningService?sslmode=require";
		String dbUsername = "neondb_owner";
		String dbPassword = "fbtpKBzO01Jl";

		// Establish connection
		Connection conn = DriverManager.getConnection(connURL, dbUsername, dbPassword);

		// Query database
		String sqlStr = "SELECT category, description, package_price FROM service_category WHERE id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setInt(1, id);
		ResultSet rs = pstmt.executeQuery();

		// Process result
		if (rs.next()) {
	category = rs.getString("category");
	description = rs.getString("description");
	double price = rs.getDouble("package_price");
	packagePrice = String.format("%.2f", price);
		}

		String sqlStr2 = "SELECT id, service_name FROM service WHERE category_id = ? ORDER BY id";
		PreparedStatement pstmt1 = conn.prepareStatement(sqlStr2);
		pstmt1.setInt(1, id);
		ResultSet rs1 = pstmt1.executeQuery();

		while (rs1.next()) {
	count++;
	services_id.add(rs1.getInt("id"));
	services.add(rs1.getString("service_name"));
		}

		conn.close();
	} else {
		session.setAttribute("bookingError", "You must be a member to book.");
		response.sendRedirect("booking.jsp");
	}
} catch (NumberFormatException e) {
	out.println("<p>Error: Invalid ID format. Please provide a valid service ID.</p>");
} catch (Exception e) {
	out.println("<p>Error: Unable to fetch service details. Please try again later.</p>");
}
%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Booking Service</title>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/bookingService.css">
</head>
<body>
	<!-- Include header -->
	<jsp:include page="header.jsp" />

	<main>
		<section class="py-5 text-center container">
			<div class="row py-lg-5">
				<div class="col-lg-6 col-md-8 mx-auto">
					<div class="card mb-4 rounded-3 shadow-sm">
						<div class="card-header py-3">
							<h4 class="my-0 fw-normal"><%=category%></h4>
						</div>
						<div class="card-body">
							<h1 class="card-title pricing-card-title">
								$<%=packagePrice%><small class="text-muted fw-light">/hr</small>
							</h1>
							<p><%=description%></p>
						</div>
					</div>
				</div>

				<h2 class="display-6 text-center mb-4">Booking Appointment</h2>
				<form action="bookingDetails.jsp" method="post">
					<p>Choose your service</p>
					<select name="serviceList" size="<%=count%>" required>
						<%
						for (int i = 0; i < services.size(); i++) {
							int serviceId = services_id.get(i);
							String serviceName = services.get(i);
						%>
						<option value="<%=serviceId%>"><%=serviceName%></option>
						<%
						}
						%>
					</select><br>
					<p>Select your date for cleaning</p>
					<input type="date" name="date" required>
					<p>Choose your timing</p>
					<input type="time" name="time" required>
					<button type="submit" class="btn">Add booking to cart</button>
				</form>
			</div>
		</section>
	</main>
</body>
</html>
