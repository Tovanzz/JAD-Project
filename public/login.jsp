<%@page import="java.sql.*"%>
<%
int id = 0;
String name = request.getParameter("username");
String password = request.getParameter("password");
String loginError = null;

if (name != null && password != null) {
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
		String insertStr = "SELECT * FROM users WHERE name=? AND password=?";
		PreparedStatement pstmt = conn.prepareStatement(insertStr);
		pstmt.setString(1, name);
		pstmt.setString(2, password);
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		if (rs.next()) {
	id = rs.getInt("id");
	session.setAttribute("userRoleId", id);
	response.sendRedirect("index.jsp");
		} else {
	loginError = "Invalid username or password. Please try again.";
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
<title>Login</title>
<link rel="stylesheet" href="css/login.css">

<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
</head>

<body>
	<div class="wrapper">
		<form action="login.jsp" method="post">
			<h1>Login</h1>
			<div class="input-box">
				<input type="text" placeholder="Username" name="username" required>
				<i class='bx bxs-user'></i>
			</div>

			<div class="input-box">
				<input type="password" placeholder="Password" name="password"
					required> <i class='bx bxs-lock-alt'></i>
			</div>

			<div class="remember-forgot">
				<label><input type="checkbox"> Remember me</label> <a
					href="forgotPassword.html"> Forgot password?</a>
			</div>

			<%
			if (loginError != null) {
			%>
			<p style="color: red; text-align: center;"><%=loginError%></p>
			<%
			}
			%>
			<button type="submit" class="btn">Login</button>

			<div class="register-link">
				<p>
					Don't have an account? <a href="registerMember.html">Register</a>
				</p>
			</div>
		</form>
	</div>
</body>
</html>