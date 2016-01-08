<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>mail列表</title>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<link rel="stylesheet" type="text/css" media="screen"
	href="css/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" media="screen"
	href="css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="skin/css/base.css">
<link rel="stylesheet" type="text/css" href="css/prettyCheckboxes.css">
<link rel="stylesheet" type="text/css" href="css/examples.css">

<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/i18n/grid.locale-zh_TW.js"></script>
<script type="text/javascript" src="js/jquery-impromptu.4.0.min.js"></script>
<script type="text/javascript" src="js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="js/jquery.tablednd.js"></script>
<script type="text/javascript" src="js/jquery.contextmenu.js"></script>
<script type="text/javascript" src="js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/lin.validator.js"></script>

<script type="text/javascript">
var localData = ${localData};

$(document).ready(function() {
	jQuery("#list").jqGrid({
		datatype : "local",
		data : localData,
		height : 300,
		width : document.body.clientWidth - 46,
		colNames : [ '序號', '名稱', '', '操作'],
		colModel : [ {
			name : 'mailOrderNum',
			index : 'mailOrderNum',
			width : 90,
			align : "center"
		}, {
			name : 'name',
			index : 'name',
			width : 100,
			align : "center"
		}, {
			name : 'id',
			index : 'id',
			width : 60,
			align : "center",
			hidden : true
		}, {
			name : 'operation',
			index : 'operation',
			width : 40,
			align : "center"
		}],
		cmTemplate: { sortable: false },
		gridComplete : function() {
			var ids = jQuery("#list").jqGrid('getDataIDs');
			for ( var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				//var row = $("#list").jqGrid('getRowData', cl);
				var updateBtn = "<input  type='button' value='編輯' class='mybutton' onclick=\"editMailDetail('"
					+ cl + "');\" />&nbsp";
				jQuery("#list").jqGrid('setRowData', ids[i], {
					operation : updateBtn
				});
			}
		},
		caption : "mail內容列表"
	}); 
	
	$("#id").change(function() {
		$("#mailConfigSelectForm").submit();
	});
	
});

function editMailDetail(oid) {
	$("#oid").val(oid);	
	$("#mailConfigForm").submit();			
}
</script>
</head>
<body leftmargin="8" topmargin="8">
	<form:form id="mailConfigSelectForm" commandName="projectGroup"
		action="mailConfigList.html" method="post">
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
	<table width="98%"  align="center" border="0">
		<tr>
			
		</tr>
	</table>
	<table width="98%" id="viewtable" align="center" border="0"
		cellpadding="3" cellspacing="1" bgcolor="#CBD8AC"
		style="margin-bottom: 8px; margin-top: 8px">

		<tr bgcolor='#FFFFFF'>
			<td>
				<table id="list" width="98%">
					<tr>
						<td />
					</tr>
				</table>
				<div id="pager"></div>
			</td>
		</tr>
	</table>
	<form id="mailConfigForm" action="mailConfig.html" method="post">
		<input id="oid" name="oid" type="hidden" />
	</form>
</body>
</html>