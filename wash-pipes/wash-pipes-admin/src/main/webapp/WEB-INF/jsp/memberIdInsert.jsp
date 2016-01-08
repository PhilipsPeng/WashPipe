<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<title>新增會員ID</title>
<link rel="stylesheet" type="text/css" href="skin/css/base.css">
<link rel="stylesheet" type="text/css" href="css/examples.css">
<link href="css/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="js/jquery-impromptu.4.0.min.js"></script>
<script type="text/javascript" src="js/lin.validator.js"></script>

<script type="text/javascript">
	$(function() {
		$("#memberIdInsertForm").validate({
			errorClass : "errors",
			rules : {
				id : {
					required : true,
					memberIdIsExist : true
				},
				identificationId : {
					required : true,
					TWIDCheck : true
				},
				name : "required"
			},
			messages : {
				id : {
					required : "必填"
				},
				identificationId : {
					required : "必填"
				},
				name : "必填"
			}
		});
	});
	
	function cancelEdit() {
		history.back();
	}
</script>
</head>
<body leftmargin="8" topmargin="8">
	<form:form id="memberIdInsertForm" commandName="memberId"
		action="memberIdInsertSubmit.html" method="post">
		<table width="40%" align="center" border="0" cellpadding="3"
			cellspacing="1" bgcolor="#CBD8AC"
			style="margin-bottom: 8px; margin-top: 8px;">
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF"><font color="red">*</font>會員ID：
				</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="id"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF"><font color="red">*</font>身份證字號：
				</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input
						path="identificationId" style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF"><font color="red">*</font>姓名：
				</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="name"
						style="width: 200px;" /></td>
			</tr>
		</table>
		<table width="40%" align="center" border="0" cellpadding="3"
			cellspacing="1" bgcolor="#CBD8AC"
			style="margin-bottom: 8px; margin-top: 8px;">
			<tr bgcolor="#FFFFFF">
				<td width="100%" bgcolor="#FFFFFF">
					<button class="mybutton" onclick="cancelEdit()">
						取消
					</button>
					&nbsp;&nbsp;
					<form:button class="mybutton">
						儲存
					</form:button>
			</tr>
		</table>
	</form:form>
</body>
</html>