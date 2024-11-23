<!--
    Author: Tan Rui Zhang Jovan
    Admin No: p2322951
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->

<%@page import="java.sql.*"%>
<%
//Initalised variables
String email = request.getParameter("email");
String confirmEmail;
if (email != null) {
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
		String strStr = "SELECT email FROM users WHERE email=?";
		PreparedStatement pstmt = conn.prepareStatement(strStr);
		pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		if (rs.next()) {
	confirmEmail = rs.getString("email");
	session.setAttribute("email", confirmEmail);
	response.sendRedirect("verifyPassword.jsp");
		} else {
	session.setAttribute("loginError", "Incorrect email. Try again");
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
<title>Forgot Password</title>
<link rel="stylesheet" href="css/login.css">

<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
</head>

<body>
	<div class="wrapper">
		<form action="forgotPassword.jsp" method="post">
			<p>Enter your email</p>
			<div class="input-box">
				<input type="email" placeholder="Email" name="email" required>
				<i class='bx bxs-envelope'></i>
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
			<button type="submit" class="btn" style="margin-top: 20px;">Confirm Email</button>
		</form>
	</div>
</body>
</html>