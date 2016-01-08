<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.wash.pipes.core.model.Member;" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<title>銷售列表</title>

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

<script>
	var localData = ${localData};

	$(document).ready(function() {
		jQuery("#list").jqGrid({
			datatype : "local",
			data : localData,
			height : 300,
			width : document.body.clientWidth - 46,
			colNames : [ '姓名', '電話', '聯絡時間', '狀態', '' ],
			colModel : [{
				name : 'name',
				index : 'name',
				width : 60,
				align : "center"
			}, {
				name : 'phone',
				index : 'phone',
				width : 80,
				align : "center"
			}, {
				name : 'contactInterval',
				index : 'contactInterval',
				width : 60,
				align : "center"
			}, {
				name : 'status',
				index : 'status',
				width : 60,
				align : "center"
			}, {
				name : 'holiday',
				index : 'holiday',
				width : 60,
				align : "center",
				hidden : true
			}],
			<%
			Member member = (Member)session.getAttribute("loginMember");
			if(member.getAuth().equals("0")) {%>
			multiselect: true,
			<%}%>
			cmTemplate: { sortable: false },
			gridComplete : function() {
				var ids = jQuery("#list").jqGrid('getDataIDs');
				for ( var i = 0; i < ids.length; i++) {
					var cl = ids[i];
					var row = $("#list").jqGrid('getRowData', cl);
					var holidayText = '';
					var contactIntervalText = '';
					var statusText = '';
					if(row.holiday=='0') {
						holidayText="假日";
					}else if(row.holiday=='1') {
						holidayText="非假日";
					}
					
					if(row.contactInterval=='MORNING') {
						contactIntervalText="早上 : 09:00 ~ 12:00";
					}else if(row.contactInterval=='NOON') {
						contactIntervalText="中午 : 12:00 ~ 13:00";
					}else if(row.contactInterval=='AFTERNOON'){			
						contactIntervalText="下午 : 13:00 ~ 17:00";						
					}else {
						contactIntervalText="晚上 : 17:00 ~ 21:00";
					}
					
					if(row.status=='0') {
						statusText="施工中";
					}else if(row.status=='1') {
						statusText="收款完成";
					}else if(row.status=='2'){			
						statusText="獎金發放";					
					}else {
						statusText="N/A";
					}
					
					jQuery("#list").jqGrid('setRowData', ids[i], {
						contactInterval : holidayText + contactIntervalText,
						status : statusText
					});
				}
			},
			caption : "銷售列表"
		}); // jqGrid
		
		$("#id").change(function() {
			$("#customerSelectForm").submit();
		});
		
		$("#working").click(function() {
			var rowIds = $("#list").jqGrid('getGridParam','selarrrow');
		    if (rowIds.length > 0) {
		    	$("#ids").val(rowIds);
		    	$("#status").val(0);
		    	$("#updateStatusForm").submit();
		    }else {
		      	alert("請先勾選資料");
		    }
		 }); 
		$("#receivables").click(function() {
			var rowIds = $("#list").jqGrid('getGridParam','selarrrow');
		    if (rowIds.length > 0) {
		    	$("#ids").val(rowIds);
		    	$("#status").val(1);
		    	$("#updateStatusForm").submit();
		    }else {
		      	alert("請先勾選資料");
		    }
		 });
		$("#bonuses").click(function() {
			var rowIds = $("#list").jqGrid('getGridParam','selarrrow');
		    if (rowIds.length > 0) {
		    	$("#ids").val(rowIds);
		    	$("#status").val(2);
		    	$("#updateStatusForm").submit();
		    }else {
		      	alert("請先勾選資料");
		    }
		 });
	});
	
	
</script>

</head>
<body leftmargin="8" topmargin="8">
	<form:form id="customerSelectForm" commandName="projectGroup"
		action="customerList.html" method="post">
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
			<c:if test="${loginMember.auth == 0 }">
			<td align="right" class='title'>
				<input type="button" class='mybutton' id="working" value="施工">
				<input type="button" class='mybutton' id="receivables" value="收款">
				<input type="button" class='mybutton' id="bonuses" value="獎金發放">
			</td>
			</c:if>
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
	<form name="updateStatusForm" id="updateStatusForm" action="updateCustomerStatus.html" method="post">
		<input type="hidden" id="ids" name="ids" />
		<input type="hidden" id="status" name="status" />
	</form>
</body>

</html>