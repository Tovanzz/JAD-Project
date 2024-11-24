<!--
    Author: Tan Rui Zhang Jovan
    Admin No: p2322951
    Class: DIT/FT/2A/23
    Date:  23 November 2024 
-->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Login</title>
    <link rel="stylesheet" href="css/login.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
    <div class="wrapper">
        <form action="/JAD_Project/LoginServlet" method="post">
            <h1>Login</h1>
            <div class="input-box">
                <input type="text" placeholder="Username" name="username" required>
                <i class='bx bxs-user'></i>
            </div>
            <div class="input-box">
                <input type="password" placeholder="Password" name="password" required>
                <i class='bx bxs-lock-alt'></i>
            </div>
            <div class="remember-forgot">
                <label><input type="checkbox"> Remember me</label>
                <a href="forgotPassword.jsp">Forgot password?</a>
            </div>
            <% String loginError = (String) session.getAttribute("loginError"); %>
            <% if (loginError != null) { %>
            <p style="color: white; text-align: center; border: 3px solid #EE6B6E; border-radius: 20px; background-color: #EE6B6E;"><%=loginError%></p>
            <% session.removeAttribute("loginError"); } %>
            <button type="submit" class="btn" style="margin-top: 20px;">Login</button>
            <div class="register-link">
                <p>Don't have an account? <a href="registerMember.jsp">Register</a></p>
            </div>
        </form>
    </div>
</body>
</html>