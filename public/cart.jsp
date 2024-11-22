<%@page import="java.util.*, java.sql.*"%>
<%
Integer userRoleId = (Integer) session.getAttribute("userRoleId");
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
	String sqlStr = "SELECT s.service_name, b.date_for_service, b.time_for_service FROM booking b JOIN service s ON b.service_id = s.id WHERE b.user_id = ? ORDER BY b.id";
	PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	pstmt.setInt(1, userRoleId);
	ResultSet rs = pstmt.executeQuery();

	// Step 6: Process Result
	while (rs.next()) {
		Map<String, String> booking = new HashMap<>();
		booking.put("service_name", rs.getString("service_name"));
		booking.put("date_for_service", rs.getString("date_for_service"));
		booking.put("time_for_service", rs.getString("time_for_service"));
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
					<th>Time</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Map<String, String> booking : bookings) {
				%>
				<tr>
					<td><%=booking.get("service_name")%></td>
					<td><%=booking.get("date_for_service")%></td>
					<td><%=booking.get("time_for_service")%></td>
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
	<!-- 
	<script>
document.addEventListener('DOMContentLoaded', () => {
    // Fetch cart items from the server
    fetch('/JAD_Project/get-cart')
        .then(response => response.json())
        .then(cartItems => {
            console.log('Cart items response:', cartItems);  // Log the full response to ensure it's correct

            const cartTable = document.getElementById('cart-table');
            const cartBody = document.getElementById('cart-items');
            const heroSection = document.getElementById('hero-section');

            // Check if cart is empty
            if (cartItems && Array.isArray(cartItems.cart) && cartItems.cart.length === 0) {
                console.log('Cart is empty');
                heroSection.style.display = 'block';
                cartTable.style.display = 'none';  // Hide the table
            } else {
                console.log('Populating the table with cart items');
                cartTable.style.display = 'table';
                cartItems.cart.forEach(item => {
                    console.log('Item:', item);  // Log each item to check if price exists

                    const row = document.createElement('tr');

                    // Create cells for each piece of data
                    const nameCell = document.createElement('td');
                    nameCell.textContent = item.name || 'Unknown';  // Display name or 'Unknown' if not available

                    // Log to ensure price is present
                    console.log('Price:', item.price);  

                    const priceCell = document.createElement('td');
                    if (item.price) {
                        priceCell.textContent = "$"+ item.price;  // Display price if available
                    } else {
                        priceCell.textContent = 'N/A';  // Fallback if no price is available
                    }

                    const actionsCell = document.createElement('td');
                    const removeButton = document.createElement('button');
                    removeButton.textContent = 'Remove';
                    removeButton.className = 'btn btn-danger btn-sm';
                    removeButton.addEventListener('click', () => {
                        removeCartItem(item.name);  // Function to remove the item from the cart
                    });

                    actionsCell.appendChild(removeButton);

                    // Append cells to the row
                    row.appendChild(nameCell);
                    row.appendChild(priceCell);
                    row.appendChild(actionsCell);

                    // Append row to the table body
                    cartBody.appendChild(row);

                    // Log to confirm the row is appended
                    console.log('Row appended:', row);
                });
            }
        })
        .catch(error => {
            console.error('Error fetching cart:', error);
        });
});

// Function to remove a cart item
function removeCartItem(serviceName) {
    fetch('/JAD_Project/remove-from-cart', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `serviceName=${serviceName}`  // Send the service name to remove
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert(`Removed "${serviceName}" from cart!`);
            location.reload();  // Reload the page to reflect changes
        } else {
            alert('Failed to remove item from cart. Please try again.');
        }
    })
    .catch(error => console.error('Error removing item:', error));
}
</script>
-->

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
