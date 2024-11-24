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
<title>Register Membership</title>
<link rel="stylesheet" href="css/login.css">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
</head>

<body>
	<div class="wrapper">
		<form action="/JAD_Project/RegisterMembershipServlet" method="post">
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