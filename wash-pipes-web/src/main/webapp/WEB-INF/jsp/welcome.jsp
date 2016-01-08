<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<head>
<title>歡迎光臨</title>

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/small-business.css" rel="stylesheet">

<link
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/black-tie/jquery-ui.css"
	rel="stylesheet" />
<link
	href="http://fonts.googleapis.com/css?family=Droid+Sans&amp;subset=latin"
	rel="stylesheet" />
<link href="css/youtube-player.css" rel="stylesheet" />
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600'
	rel='stylesheet' type='text/css'>
<link
	href="//netdna.bootstrapcdn.com/font-awesome/3.1.1/css/font-awesome.css"
	rel="stylesheet">
<style type="text/css">
.entry {
	padding: 1em;
	border: 1px solid #aaa;
	margin-bottom: 1em;
}
</style>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
	<!-- Page Content -->
	<div align="right"><a href="http://www.washpipes.com/admin">後台管理系統&nbsp;&nbsp;&nbsp;</a></div>
	<div class="container">

		<div class="row">
			<div class="col-lg-12">
				<div id="banner" class="well text-center">${title}</div>
			</div>
		</div>

		<!-- Heading Row -->
		<div class="row">
			<div id="video" class="col-md-7" align="center">
				<br> 
				<a class="video" href="${youtubeLinkOne}"></a> 
				<br> 
				<a class="video" href="${youtubeLinkTwo}"></a>
			</div>
			<!-- /.col-md-8 -->
			
			<div class="col-md-5">
				<div class="testbox">
					<form:form method="post" action="insertContactInfo.html?id=${id}&projectGroupId=${projectGroup}"
						commandName="contactInfo">
						<label id="icon" for="name"><i class="icon-user"></i></label>
						<form:input path="name" placeholder="你希望我怎麼稱呼你?" />
						<label id="icon" for="name"><i class="icon-envelope "></i></label>
						<form:input path="email" placeholder="你一定會看的email信箱?" />
						<p>※${submitText}</p>
						<a href="#" class="button" onclick="contactFormSubmit()">送出</a>
						<br>
					</form:form>
				</div>
			</div>
			<!-- /.col-md-4 -->
		</div>
		<br>
		<h3>${underText}</h3>
		<!-- Footer -->
		<footer>
			<div class="row">
				<div class="col-lg-12">Copyright &copy; Your Website 2014</div>
			</div>
		</footer>

	</div>
	
				
		
	<!-- /.container -->

	<!-- jQuery -->
	<script src="js/jquery.js"></script>
	<script
		src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
	<script src="js/jquery.youtube.player.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

	<script type="text/javascript">
		
		(function($) {
			$('a.video').player({
				width : 500,
				chromeless : 0,
				showTime : 0,
				showPlaylist : 0,
				showTitleOverlay : 0
			});

		})(this.jQuery);

		function contactFormSubmit() {
			var sEmail = $('#email').val();
			if ($.trim(sEmail).length == 0) {
				alert('Please enter valid email address');
			}
			if (validateEmail(sEmail)) {
				$('form').submit();
			} else {
				alert('Invalid Email Address');
			}
		}

		function validateEmail(sEmail) {
			var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
			return filter.test(sEmail);
		}
		</script>

</body>

</html>
