<app>

	<!-- menu bar -->
	<menu></menu>

	<!-- Content Components -->
	<!-- The riot show conditional will show an HTML element if the condition specified is true.
	Otherwise the HTML element will be hidden.
	If hidden, the HTML element will still be part of the HTML / DOM. -->
	<memes show={ page === "memes" }></memes>
	<admin show={ page === "admin" }></admin>
	<about show={ page === "about" }></about>

	<script>
		var that = this;

		// default page when the website first loads
		// show about page upon first loading the site
		this.page = "about";

		// Routing Function
		// When user clicks a menu bar item, url changes
		//route function below gets triggered
		//page variable updates
		route(function(urlFragment) {
			// console.log(urlFragment);
			that.page = urlFragment;
			that.update();
		});

		// Start the router and execute it [true]
		route.start(true);
	</script>



</app>
