<!--
    Author: Tan Rui Zhang Jovan
    Admin No: p2322951 
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->

<%@page import="java.sql.*"%>
<%
//Initalised variables
int id = 0;
String oldPassword = request.getParameter("oldPassword");
String newPassword = request.getParameter("newPassword");
String confirmNewPassword = request.getParameter("confirmNewPassword");
String email = (String) session.getAttribute("email");

if (oldPassword != null && email != null) {
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

		String sqlStr = "SELECT * FROM users WHERE password=? AND email=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, oldPassword);
		pstmt.setString(2, email);
		ResultSet rs = pstmt.executeQuery();

		if (rs.next()) {
	if (newPassword.equals(confirmNewPassword)) {

		// Step 5: Execute SQL Command
		String updateStr = "UPDATE users SET password=? WHERE email=?";
		PreparedStatement pstmt1 = conn.prepareStatement(updateStr);
		pstmt1.setString(1, confirmNewPassword);
		pstmt1.setString(2, email);
		int count = pstmt1.executeUpdate();

		// Step 6: Process Result
		if (count > 0) {
			response.sendRedirect("login.jsp");
		}
	} else {
		session.setAttribute("loginError", "New password and confirm new password does not match. Try again");
	}
		} else {
	session.setAttribute("loginError", "Old password is not correct. Try again");
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
<title>Create New Password</title>
<link rel="stylesheet" href="css/login.css">

<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
</head>

<body>
	<div class="wrapper">
		<form action="verifyPassword.jsp" method="post">
			<p>Enter your old Password</p>
			<div class="input-box">
				<input type="password" placeholder="Password" name="oldPassword"
					required> <i class='bx bxs-lock-alt'></i>
			</div>

			<p>Enter your new Password</p>
			<div class="input-box">
				<input type="password" placeholder="New Password" name="newPassword"
					required> <i class='bx bxs-lock-alt'></i>
			</div>

			<p>Confirm your new Password</p>
			<div class="input-box">
				<input type="password" placeholder="Confirm New Password"
					name="confirmNewPassword" required> <i
					class='bx bxs-lock-alt'></i>
			</div>

			<%
			String loginError = (String) session.getAttribute("loginError");
			if (loginError != null) {
				session.removeAttribute("loginError");
			%>
			<p
				style="color: white; text-align: center; border: 3px solid #EE6B6E; border-radius: 20px; background-color: #EE6B6E;"><%=loginError%></p>
			<%
			}
			%>
			<button type="submit" class="btn" style="margin-top: 20px;">Create
				New Password</button>
		</form>

	</div>
</body>
</html>