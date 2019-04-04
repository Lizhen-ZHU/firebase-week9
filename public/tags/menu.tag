<menu>
	<ul>
		<li>
			<a href="#about">about</a>
		</li>
		<li>
			<a href="#memes">memes</a>
		</li>
		<li>
			<a href="#admin">admin</a>
		</li>
	</ul>

	<script>
	</script>

	<style>
		:scope {
			display: block;
			background-color: #DDD;
			margin: 0;
			padding: 0;
		}
		ul {
			list-style: none;
			padding-left: 0;
			display: flex;
			margin-bottom: 0;
			border-bottom: 1px solid #FFF;
		}
		li {
			background-color: #333;
			position: relative;
			flex-grow: 1;
			text-align: center;
		}
		li:not(:last-child) {
			border-right: 1px solid #FFF;
		}
		li > a {
			box-sizing: border-box;
			display: inline-block;
			padding: 15px;
			cursor: pointer;
			width: 100%;
			color: #FFF;
			transition: background-color .5s;
		}
		li > a:hover {
			background-color: #ffc107;
			color: #FFF;
		}
		li > a:visited {
			color: #FFF;
		}
		.current {
			background-color: #f44336;
		}
	</style>
</menu>
