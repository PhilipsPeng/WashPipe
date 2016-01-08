<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="X-UA-Compatible" content="IE=5">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache"> 
<meta http-equiv="cache-control" content="no-cache, must-revalidate"> 
<meta http-equiv="expires" content="0">
<link rel="stylesheet" href="skin/css/base.css" type="text/css" />
<link rel="stylesheet" href="skin/css/menu.css" type="text/css" />
<link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<title>水管達人管理系統</title>
<head>
<style>
body
{
  scrollbar-base-color:#C0D586;
  scrollbar-arrow-color:#FFFFFF;
  scrollbar-shadow-color:DEEFC6;
}
</style>
</head>
<script type="text/javascript">
	$(function() {
		$.cookie("isBack", "0");
	});
</script>
<frameset rows="60,*" cols="*" frameborder="no" border="0" framespacing="0">
  <frame src="top.html" name="topFrame" scrolling="no">
  <frameset cols="180,*" name="btFrame" frameborder="NO" border="0" framespacing="0">
    <frame src="menu.html" noresize name="menu" scrolling="yes">
        <frame src="template.html" rows="*,40" noresize name="main" scrolling="yes">
       <!-- 可以再放入頁腳 -->
  </frameset>  
</frameset>
<noframes>
	<body>您的瀏覽器不支持框架！</body>
</noframes>
</html>