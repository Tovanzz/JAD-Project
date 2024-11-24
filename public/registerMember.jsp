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
<style>
/* Styles for the back arrow */
a {
	position: fixed; 
	top: 20px; 
	left: 20px; 
	z-index: 1000; 
}

svg {
	width: 48px; 
	height: 48px; 
	fill: beige; 
}
</style>
</head>

<body>
	<a href="javascript:void(0);" onclick="history.back();"
		style="color: #fff; text-decoration: none;"> <svg
			xmlns="http://www.w3.org/2000/svg" width="24" height="24"
			fill="currentColor" class="bi bi-arrow-left-circle-fill"
			viewBox="0 0 16 16">
            <path
				d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0m3.5 7.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5z" />
        </svg>
	</a>

	<div class="wrapper">
		<form action="/JAD-CA1/RegisterMembershipServlet" method="post">
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
			<button type="submit" class="btn" style="margin-top: 20px;">Register</button>
		</form>
	</div>
</body>

</html>
