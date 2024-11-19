<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.84.0">
<title>Pricing Example</title>

<!-- Bootstrap core CSS -->
<link href="assets/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>

<!-- Custom styles for this template -->
<link href="css/pricing.css" rel="stylesheet">
</head>
<body>

	<!-- Include header HTML -->
	<jsp:include page="header.html" />
	
	<main>
		<section class="py-5 text-center container">
			<div class="row py-lg-5">
				<div class="col-lg-6 col-md-8 mx-auto">
					<h1 class="fw-light">Pricing Example</h1>
					<p class="lead text-muted">Quickly build an effective pricing
						table for your potential customers with this Bootstrap example.
						It’s built with default Bootstrap components and utilities with
						little customization.</p>
					<p>
						<a href="#" class="btn btn-primary my-2">Main Call to Action</a> <a
							href="#" class="btn btn-secondary my-2">Secondary Action</a>
					</p>
				</div>
			</div>
		</section>

		<div class="album py-5 bg-light">
			<div class="container">
				<div class="row row-cols-1 row-cols-md-3 mb-3 text-center">
					<div class="col">
						<div class="card mb-4 rounded-3 shadow-sm">
							<div class="card-header py-3">
								<h4 class="my-0 fw-normal">Home Cleaning</h4>
							</div>
							<div class="card-body">
								<h1 class="card-title pricing-card-title">
									$16<small class="text-muted fw-light">/hr</small>
								</h1>
								<ul class="list-unstyled mt-3 mb-4">
									<li>10 users included</li>
									<li>2 GB of storage</li>
									<li>Email support</li>
									<li>Help center access</li>
								</ul>
								<button type="button"
									class="w-100 btn btn-lg btn-outline-primary">Sign up
									for free</button>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card mb-4 rounded-3 shadow-sm">
							<div class="card-header py-3">
								<h4 class="my-0 fw-normal">Office Cleaning</h4>
							</div>
							<div class="card-body">
								<h1 class="card-title pricing-card-title">
									$30<small class="text-muted fw-light">/hr</small>
								</h1>
								<ul class="list-unstyled mt-3 mb-4">
									<li>20 users included</li>
									<li>10 GB of storage</li>
									<li>Priority email support</li>
									<li>Help center access</li>
								</ul>
								<button type="button" class="w-100 btn btn-lg btn-primary">Get
									Started</button>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card mb-4 rounded-3 shadow-sm border-primary">
							<div
								class="card-header py-3 text-white bg-primary border-primary">
								<h4 class="my-0 fw-normal">Carpet & Upholstrey Cleaning</h4>
							</div>
							<div class="card-body">
								<h1 class="card-title pricing-card-title">
									$45<small class="text-muted fw-light">/mo</small>
								</h1>
								<ul class="list-unstyled mt-3 mb-4">
									<li>30 users included</li>
									<li>15 GB of storage</li>
									<li>Phone and email support</li>
									<li>Help center access</li>
								</ul>
								<button type="button" class="w-100 btn btn-lg btn-primary">Contact
									Us</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<h2 class="display-6 text-center mb-4">Compare Plans</h2>
		<div class="table-responsive">
			<table class="table text-center">
				<thead>
					<tr>
						<th style="width: 34%;"></th>
						<th style="width: 22%;">Free</th>
						<th style="width: 22%;">Pro</th>
						<th style="width: 22%;">Enterprise</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row" class="text-start">Public</th>
						<td>&#10004;</td>
						<td>&#10004;</td>
						<td>&#10004;</td>
					</tr>
					<tr>
						<th scope="row" class="text-start">Private</th>
						<td></td>
						<td>&#10004;</td>
						<td>&#10004;</td>
					</tr>
					<!-- Add more rows as needed -->
				</tbody>
			</table>
		</div>
	</main>

	<!-- Render Footer -->
	<jsp:include page="footer.html" />

	<script src="assets/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
