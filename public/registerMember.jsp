<!--
    Author: Tan Rui Zhang Jovan
    Admin No: p2322951
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->
<%@page import="java.sql.*"%>
<%
//Initalised variables
int id = 2;
String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

if (name != null && !name.trim().isEmpty() && email != null && !email.trim().isEmpty() && password != null
		&& !password.trim().isEmpty()) {

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
		String insertStr = "INSERT INTO users (name, email, password, user_role_id) VALUES(?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(insertStr);
		pstmt.setString(1, name);
		pstmt.setString(2, email);
		pstmt.setString(3, password);
		pstmt.setInt(4, id);
		int count = pstmt.executeUpdate();

		// Step 6: Process Result
		if (count > 0) {
	session.setAttribute("userRoleId", id);
	response.sendRedirect("index.jsp");
		}
		conn.close();
	} catch (Exception e) {
		out.println("Error :" + e);
	}
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Register Membership</title>
<link rel="stylesheet" href="css/login.css">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
</head>

<body>
	<div class="wrapper">
		<form action="registerMember.jsp" method="post">
			<h1>Register Membership</h1>
			<div class="input-box">
				<input type="text" placeholder="Username" name="name" required>
				<i class='bx bxs-user'></i>
			</div>

			<div class="input-box">
				<input type="email" placeholder="Email" name="email" required>
				<i class='bx bxs-envelope'></i>
			</div>

			<div class="input-box">
				<input type="password" placeholder="Password" name="password"
					required> <i class='bx bxs-lock-alt'></i>
			</div>
			<p>
				<a href="login.jsp" style="color: #fff; text-decoration: none;"><strong>Back
						to login</strong></a>
			</p>
			<button type="submit" class="btn" style="margin-top: 20px;">Register</button>
		</form>
	</div>
</body>
</html>