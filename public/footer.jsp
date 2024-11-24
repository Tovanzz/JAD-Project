<!--
    Author: GERALD SIM KANG LE
    Admin No: p2209319
    Class: DIT/FT/2A/23
    Date: 23 November 2024
-->

<footer class="text-muted py-5">
    <div class="container text-center">
        <!-- Mission Statement -->
        <p class="mb-3">Creating spotless spaces, one clean at a time!</p>

        <!-- Back to Top -->
        <p class="mb-3">
            <a href="#" class="text-decoration-none">Back to top</a>
        </p>

        <!-- Quick Links Section -->
        <p class="mb-3 fw-bold">Quick links:</p>
        <div class="d-flex flex-wrap justify-content-center gap-3">
            <a href="index.jsp" class="text-decoration-none">Home</a>
            <a href="booking.jsp" class="text-decoration-none">Booking Appointment</a>
            <a href="service.jsp?id=1" class="text-decoration-none">Home Cleaning</a>
            <a href="service.jsp?id=2" class="text-decoration-none">Office Cleaning</a>
            <a href="service.jsp?id=3" class="text-decoration-none">Carpet & Upholstery Cleaning</a>
        </div>

        <!-- Copyright Notice -->
        <p class="mt-4 mb-0">
            &copy; <span id="year"></span> Dust Be Gone. All rights reserved.
        </p>
    </div>
</footer>

<script>
    // Dynamically set the current year
    document.getElementById('year').textContent = new Date().getFullYear();
</script>
