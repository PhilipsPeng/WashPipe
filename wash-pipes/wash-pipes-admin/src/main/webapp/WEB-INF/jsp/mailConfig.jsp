<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<title>編輯mail</title>
<link rel="stylesheet" type="text/css" href="skin/css/base.css">
<link rel="stylesheet" type="text/css" href="css/examples.css">
<link href="css/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="js/jquery-impromptu.4.0.min.js"></script>
<script type="text/javascript" src="js/lin.validator.js"></script>

<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="ckeditor/adapters/jquery.js"></script>

<script type="text/javascript">
	$(function() {
		$("#mailConfigEditForm").validate({
			errorClass : "errors",
			rules : {
				subject : "required"
			},
			messages : {
				subject : "必填"
			}
		});
		
		$('#text').ckeditor($.noop, {
	    	customConfig: 'custom_config.js'
	    });
	});
	function cancelEdit() {
		history.back();
	}
</script>
</head>
<body leftmargin="8" topmargin="8">
	<form:form id="mailConfigEditForm" commandName="mailConfig"
		action="mailConfigEditSubmit.html" method="post">
		<table width="70%" align="center" border="0" cellpadding="3"
			cellspacing="1" bgcolor="#CBD8AC"
			style="margin-bottom: 8px; margin-top: 8px;">
			<tr bgcolor="#FFFFFF">
				<td bgcolor="#FFFFFF"><font color="red">*</font>主旨：
				</td>
				<td bgcolor="#FFFFFF"><form:input path="subject"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td bgcolor="#FFFFFF">內容：
				</td>
				<td bgcolor="#FFFFFF">
					<form:textarea 
						path="text" style="width: 620px;height: 350px" />
            			<script>
            			if(CKEDITOR.instances["text"]) {
            			    delete CKEDITOR.instances["text"];
            			    $('#text').ckeditor($.noop, {
            			    	customConfig: 'custom_config.js'
            			    });
            			}
            			</script>	
				</td>
			</tr>
			<form:hidden path="mailOrderNum"/>
			<form:hidden path="name"/>
			<form:hidden path="oid"/>
			<form:hidden path="projectGroup.id"/>
		</table>
		<table width="70%" align="center" border="0" cellpadding="3"
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