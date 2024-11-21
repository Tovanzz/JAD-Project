<header>
	<!-- Collapsible Navbar -->
	<div class="collapse bg-dark" id="navbarHeader">
		<div class="container">
			<div class="row">
				<div class="col-sm-8 py-4">
					<h4 class="text-white">Services</h4>
					<p class="text-muted">Explore our offerings, book your cleaning
						service, and provide feedback to help us serve you better.</p>
					<div class="dropdown">
						<button class="btn btn-primary dropdown-toggle" type="button"
							id="servicesDropdown" data-bs-toggle="dropdown"
							aria-expanded="false">Explore Services</button>
						<ul class="dropdown-menu" aria-labelledby="servicesDropdown">
							<li><a class="dropdown-item" href="index.jsp">Available
									Services</a></li>
							<li><a class="dropdown-item" href="booking.jsp">Book
									Appointments</a></li>
							<li><a class="dropdown-item" href="#">Provide Feedback</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li class="dropdown-header">Cleaning Services</li>
							<li><a class="dropdown-item" href="#">Home Cleaning</a></li>
							<li><a class="dropdown-item" href="#">Office Cleaning</a></li>
							<li><a class="dropdown-item" href="#">Carpet &
									Upholstery Cleaning</a></li>
						</ul>
					</div>
				</div>

				<div class="col-md-4 text-end py-4">
					<%
					Integer userRoleId = (Integer) session.getAttribute("userRoleId");
					if (userRoleId != null) {
					%>
					<!-- Display SVG for logged-in users -->
					<a href="userProfile.jsp"
						class="text-white text-decoration-none me-3" title="Edit Profile">
						<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
							fill="currentColor" class="bi bi-person-circle text-white me-3"
							viewBox="0 0 16 16">
                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" />
                            <path fill-rule="evenodd"
								d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1" />
                        </svg>
					</a>
					<form action="logout.jsp" method="post" class="d-inline-block">
						<button class="btn btn-danger" type="submit">Logout</button>
					</form>
					<%
					} else {
					%>
					<!-- Display Login/Sign-Up buttons for guests -->
					<form action="login.jsp" class="d-inline-block">
						<button class="btn btn-info me-2" type="submit">Login</button>
					</form>
					<form action="registerMember.html" class="d-inline-block">
						<button class="btn btn-primary" type="submit">Sign Up</button>
					</form>
					<%
					}
					%>
				</div>
			</div>
		</div>
	</div>

	<!-- Navbar -->
	<div class="navbar navbar-dark bg-dark shadow-sm">
		<div class="container">
			<a href="/" class="navbar-brand d-flex align-items-center"> <svg
					xmlns="http://www.w3.org/2000/svg" width="20" height="20"
					fill="currentColor" class="bi bi-server me-2" viewBox="0 0 16 16">
                    <path
						d="M1.333 2.667C1.333 1.194 4.318 0 8 0s6.667 1.194 6.667 2.667V4c0 1.473-2.985 2.667-6.667 2.667S1.333 5.473 1.333 4z" />
                    <path
						d="M1.333 6.334v3C1.333 10.805 4.318 12 8 12s6.667-1.194 6.667-2.667V6.334a6.5 6.5 0 0 1-1.458.79C11.81 7.684 9.967 8 8 8s-3.809-.317-5.208-.876a6.5 6.5 0 0 1-1.458-.79z" />
                    <path
						d="M14.667 11.668a6.5 6.5 0 0 1-1.458.789c-1.4.56-3.242.876-5.21.876-1.966 0-3.809-.316-5.208-.876a6.5 6.5 0 0 1-1.458-.79v1.666C1.333 14.806 4.318 16 8 16s6.667-1.194 6.667-2.667z" />
                </svg> <strong>Cleaning Services</strong>
			</a>

			<div class="d-flex align-items-center">
				<a href="cart.jsp"
					class="text-decoration-none text-white position-relative me-3">
					<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
						fill="white" class="bi bi-cart-fill" viewBox="0 0 16 16">
                        <path
							d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2" />
                    </svg> <span id="cart-badge"
					class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">0</span>
				</a>

				<!-- Navbar Toggler -->
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarHeader"
					aria-controls="navbarHeader" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
			</div>
		</div>
	</div>
</header>
