<!--
    Author:GERALD SIM KANG LE
    Admin No: p2209319
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->

<%@page import="java.sql.*"%>
<%
//Initalised variables
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
	response.sendRedirect("login.jsp");
}

String userName = "";
String userEmail = "";
String userRole = "";
String userPhone = "";
String userAddress = "";
String userDob = "";

try {
	Class.forName("org.postgresql.Driver");
	String connURL = "jdbc:postgresql://ep-late-flower-a15dwl0h.ap-southeast-1.aws.neon.tech/cleaningService?sslmode=require";
	String dbUsername = "neondb_owner";
	String dbPassword = "fbtpKBzO01Jl";
	Connection conn = DriverManager.getConnection(connURL, dbUsername, dbPassword);

	String query = "SELECT u.name, u.email, u.phone_number, u.address, u.date_of_birth, r.role " + "FROM users u "
	+ "JOIN user_role r ON u.user_role_id = r.id " + "WHERE u.id = ?";
	PreparedStatement pstmt = conn.prepareStatement(query);
	pstmt.setInt(1, userId);
	ResultSet rs = pstmt.executeQuery();

	if (rs.next()) {
		userName = rs.getString("name");
		userEmail = rs.getString("email");
		userPhone = rs.getString("phone_number");
		userAddress = rs.getString("address");
		userDob = rs.getDate("date_of_birth") != null ? rs.getDate("date_of_birth").toString() : "";
		userRole = rs.getString("role");
	}
	conn.close();
} catch (Exception e) {
	out.println("Error: " + e.getMessage());
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Profile</title>
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
}

.profile-header {
	background-color: #007bff;
	color: white;
	padding: 2rem 1rem;
	border-radius: 0.5rem;
	text-align: center;
}

.profile-header img {
	width: 120px;
	height: 120px;
	object-fit: cover;
	border-radius: 50%;
	border: 4px solid #fff;
}

.profile-card {
	background: #fff;
	border-radius: 0.5rem;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	padding: 1.5rem;
	margin-top: -50px;
}

.info-section {
	margin-bottom: 1.5rem;
}

.info-section h6 {
	font-weight: bold;
	color: #333;
}

.info-section p {
	margin: 0;
	color: #666;
}

.btn-edit {
	color: #007bff;
	background-color: transparent;
	border: none;
	cursor: pointer;
	font-size: 1rem;
}

#saveChangesBtn {
	display: none;
	margin-top: 1rem;
}
</style>
<script> 
        function toggleField(inputId) { 
            const input = document.getElementById(inputId); 
            input.readOnly = !input.readOnly; 
 
            // Enable save button if any field is editable 
            const saveBtn = document.getElementById("saveChangesBtn"); 
            const fields = document.querySelectorAll('.form-control'); 
            const isEditable = Array.from(fields).some(field => !field.readOnly); 
 
            saveBtn.style.display = isEditable ? "block" : "none"; 
        } 
    </script>
</head>
<body>
	<jsp:include page="header.jsp" />

	<div class="container mt-5">
		<!-- Profile Header -->
		<div class="profile-header">
			<img src="img/user profile.jpg" alt="Profile Picture">
			<h2><%=userName%></h2>
			<p class="mb-0"><%=userRole%></p>
		</div>

		<!-- Profile Details Card -->
		<div class="profile-card">
			<form action="updateUserProfile.jsp" method="post">
				<div class="row">
					<!-- Left Column: Name, Email, Role -->
					<div class="col-md-6">
						<div class="info-section d-flex align-items-center">
							<h6 class="me-3">Name:</h6>
							<input type="text" id="name" name="name"
								class="form-control w-50 me-2" value="<%=userName%>" readonly>
							<button type="button" class="btn-edit"
								onclick="toggleField('name')">Edit</button>
						</div>
						<div class="info-section d-flex align-items-center">
							<h6 class="me-3">Email:</h6>
							<input type="email" id="email" name="email"
								class="form-control w-50 me-2" value="<%=userEmail%>" readonly>
							<button type="button" class="btn-edit"
								onclick="toggleField('email')">Edit</button>
						</div>
						<div class="info-section d-flex align-items-center">
							<h6 class="me-3">Role:</h6>
							<input type="text" class="form-control w-50 me-2"
								value="<%=userRole%>" readonly>
						</div>
					</div>

					<!-- Right Column: Phone, Address, Birthday -->
					<div class="col-md-6">
						<div class="info-section d-flex align-items-center">
							<h6 class="me-3">Phone:</h6>
							<input type="text" id="phone" name="phone"
								class="form-control w-50 me-2" value="<%=userPhone%>" readonly>
							<button type="button" class="btn-edit"
								onclick="toggleField('phone')">Edit</button>
						</div>
						<div class="info-section d-flex align-items-center">
							<h6 class="me-3">Address:</h6>
							<input type="text" id="address" name="address"
								class="form-control w-50 me-2" value="<%=userAddress%>" readonly>
							<button type="button" class="btn-edit"
								onclick="toggleField('address')">Edit</button>
						</div>
						<div class="info-section d-flex align-items-center">
							<h6 class="me-3">Birthday:</h6>
							<input type="date" id="dob" name="dob"
								class="form-control w-50 me-2" value="<%=userDob%>" readonly>
							<button type="button" class="btn-edit"
								onclick="toggleField('dob')">Edit</button>
						</div>
					</div>
				</div>

				<!-- Save Changes Button -->
				<div class="text-center">
					<button type="submit" class="btn btn-success w-100"
						id="saveChangesBtn">Save Changes</button>
				</div>
			</form>
		</div>
	</div>

	<jsp:include page="footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>