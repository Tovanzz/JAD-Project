<!--
    Author: Tan Rui Zhang Jovan, GERALD SIM KANG LE
    Admin No: p2322951, p2209319
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->

<%@page import="java.util.*, java.sql.*"%>
<%
//Initalised variables
Integer userId = (Integer) session.getAttribute("userId");
List<Map<String, String>> bookings = new ArrayList<>();

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
	String sqlStr = "SELECT " + "b.id," + "s.service_name, " + "b.date_for_service, " + "b.start_time_for_service, "
	+ "b.end_time_for_service, " + "sc.price_per_hour, "
	+ "(EXTRACT(EPOCH FROM (b.end_time_for_service - b.start_time_for_service)) / 3600) * sc.price_per_hour AS total_price "
	+ "FROM booking b " + "JOIN service s ON b.service_id = s.id "
	+ "JOIN service_category sc ON s.category_id = sc.id " + "WHERE b.user_id = ? " + "ORDER BY b.id";
	PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	pstmt.setInt(1, userId);
	ResultSet rs = pstmt.executeQuery();

	// Step 6: Process Result
	while (rs.next()) {
		Map<String, String> booking = new HashMap<>();
		booking.put("cart_id", rs.getString("id"));
		booking.put("service_name", rs.getString("service_name"));
		booking.put("date_for_service", rs.getString("date_for_service"));
		booking.put("start_time_for_service", rs.getString("start_time_for_service"));
		booking.put("end_time_for_service", rs.getString("end_time_for_service"));
		booking.put("total_price", rs.getString("total_price"));
		bookings.add(booking);
	}

	conn.close();
} catch (Exception e) {
	out.println("Error :" + e);
}
%>

<!doctype html>
<html lang="en">
<head>
<title>Your Cart</title>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="header.jsp" />

	<main class="container py-5">
		<h1>Your Cart</h1>

		<%
		if (bookings.isEmpty()) {
		%>
		<div id="hero-section" class="alert alert-info text-center">
			<h3>Your cart is empty</h3>
			<p>It looks like you haven't added any services to your cart.
				Please visit our services page to book a service.</p>
		</div>
		<%
		} else {
		%>
		<!-- Cart Items Table -->
		<table id="cart-table" class="table table-striped">
			<thead>
				<tr>
					<th>Service Name</th>
					<th>Date</th>
					<th>Start Time</th>
					<th>End Time</th>
					<th>Price</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Map<String, String> booking : bookings) {
				%>
				<tr>
					<td><%=booking.get("service_name")%></td>
					<td><%=booking.get("date_for_service")%></td>
					<td><%=booking.get("start_time_for_service")%></td>
					<td><%=booking.get("end_time_for_service")%></td>
					<%
					Double price = Double.parseDouble(booking.get("total_price"));
					%>
					<td><%=String.format("%.2f", price)%></td>
					<td><form action="deleteCart.jsp" method="get">
							<button type="submit" class="btn btn-sm btn-danger" name="bookingId"
								value=<%=booking.get("cart_id")%>>Cancel Booking</button>
						</form></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		}
		%>
	</main>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
