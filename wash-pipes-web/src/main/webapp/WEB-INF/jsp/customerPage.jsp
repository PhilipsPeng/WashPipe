<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<head>
<title>Small Business</title>

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
	<div class="container">
		<!-- Heading Row -->
		<div class="row">
			<div id="video_1" class="col-md-7" align="center">
				<br> 
				<a class="video" href="https://www.youtube.com/watch?v=y_YrgZwlzLI&feature=youtu.be"></a>
			</div>
			<!-- /.col-md-8 -->
			<div class="col-md-5">
				<div class="testbox">
					<form:form method="post" action="insertCustomer.html?id=${id}&projectGroupId=${projectGroupId}"
						commandName="customer">
						<label>姓名 : </label>
						<form:input path="name" />
						<label>電話 : </label>
						<form:input path="phone" />
						<br>
						<br>
						<label>方便與您聯絡的時間 : </label>
						<form:radiobutton path="holiday" value="0"/><label>假日 </label>
						<form:radiobutton path="holiday" value="1"/><label>非假日</label> 
						<br>
						<form:radiobutton path="contactInterval" value="MORNING"/>	 <label>早上 :  9:00 ~ 12:00 </label><br> 
						<form:radiobutton path="contactInterval" value="NOON"/>		 <label>中午 : 12:00 ~ 13:00 </label><br>
						<form:radiobutton path="contactInterval" value="AFTERNOON"/> <label>下午 : 13:00 ~ 17:00 </label><br> 
						<form:radiobutton path="contactInterval" value="NIGHT"/>	 <label> 晚上 : 17:00 ~ 21:00 </label><br>
						
						<a href="#" class="button" onclick="customerFormSubmit()">送出</a>
					</form:form>
				</div>
			</div>
			<!-- /.col-md-4 -->
		</div>

		<!-- Footer -->
		<footer>
			<div class="row">
				<div class="col-lg-12">Copyright &copy; Your Website 2015</div>
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
				width : 550,
				chromeless : 0,
				showTime : 0,
				showPlaylist : 0,
				showTitleOverlay : 0
			});

		})(this.jQuery);

		function customerFormSubmit() {
			var name = $('#name').val();
			var phone = $('#phone').val();
			if ($.trim(name).length == 0) {
				alert('請輸入姓名');
			}else if ($.trim(phone).length == 0) {
				alert('請輸入電話');
			}else {
				$('form').submit();
			}
		}

		</script>

</body>

</html>
