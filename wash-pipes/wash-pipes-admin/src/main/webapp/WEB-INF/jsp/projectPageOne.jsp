<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>文案設定</title>
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
		$("#projectPageOneUpdateForm").validate({
			errorClass : "errors",
			rules : {
				title : "required"
			},
			messages : {
				title: "必填"
			}
		});
		
		$("#id").change(function() {
			$("#projectPageOneSelectForm").submit();
		});
		
	});
	
	function selectUnDisable() {
		$('#id').attr("disabled", false); 
	}
	
	function cancelEdit() {
		history.back();
	}
</script>
</head>
<body leftmargin="8" topmargin="8">
	<form:form id="projectPageOneSelectForm" commandName="projectGroup"
		action="projectPageOne.html" method="post">
		<table width="40%" align="center" border="0" cellpadding="3"
			cellspacing="1" bgcolor="#CBD8AC"
			style="margin-bottom: 8px; margin-top: 8px;">
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF"><font color="red">*</font>文案群組：
				</td>
				<td width="70%" bgcolor="#FFFFFF">
					<form:select path="id">
						<form:option value="NONE" label="--- Select ---"/>
						<form:options items="${projectGroupList}" 
							itemValue="id" itemLabel="name"/>
					</form:select>
				</td>
			</tr>
		</table>
	</form:form>
	<br/><br/>
	<c:if test="${projectPageOne.id!=null}">
		<form:form id="projectPageOneUpdateForm" commandName="projectPageOne"
			action="projectPageOneUpdateSubmit.html" method="post">
			<table width="70%" align="center" border="0" cellpadding="3"
				cellspacing="1" bgcolor="#CBD8AC"
				style="margin-bottom: 8px; margin-top: 8px;">
				<tr bgcolor="#FFFFFF">
					<td width="20%" bgcolor="#FFFFFF"><font color="red">*</font>文案群組：
					</td>
					<td width="80%" bgcolor="#FFFFFF">
						${projectGroupName}
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td width="20%" bgcolor="#FFFFFF"><font color="red">*</font>標題：
					</td>
					<td width="80%" bgcolor="#FFFFFF"><form:input path="title"
							style="width: 700px;" /></td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td width="20%" bgcolor="#FFFFFF">Youtube連結1：</td>
					<td width="80%" bgcolor="#FFFFFF"><form:input
							path="youtubeLinkOne" style="width: 700px;" /></td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td width="20%" bgcolor="#FFFFFF">Youtube連結2：</td>
					<td width="80%" bgcolor="#FFFFFF"><form:input
							path="youtubeLinkTwo" style="width: 700px;" /></td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td width="20%" bgcolor="#FFFFFF">送出說明 ：</td>
					<td width="80%" bgcolor="#FFFFFF">
						<form:textarea path="submitText" style="width: 700px;" /></td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td width="20%" bgcolor="#FFFFFF">頁面下說明：</td>
					<td width="80%" bgcolor="#FFFFFF">
						<form:textarea path="underText" style="width: 700px;" /></td>
				</tr>
			</table>
			<table width="70%" align="center" border="0" cellpadding="3"
				cellspacing="1" bgcolor="#CBD8AC"
				style="margin-bottom: 8px; margin-top: 8px;">
				<tr bgcolor="#FFFFFF">
					<td width="100%" bgcolor="#FFFFFF">
						<form:button class="mybutton" onclick="selectUnDisable()">
							儲存
						</form:button>
					</td>
				</tr>
			</table>
			<form:hidden path="id"/>
		</form:form>
	</c:if>

</body>
</html>