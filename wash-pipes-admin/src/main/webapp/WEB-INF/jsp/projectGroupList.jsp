<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<title>文案群組列表</title>

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

<script>
	var localData = ${localData};

	$(document).ready(function() {
		jQuery("#list").jqGrid({
			datatype : "local",
			data : localData,
			height : 300,
			width : document.body.clientWidth - 46,
			colNames : [ '文案群組ID', '文案群組名稱', 'Mail封數', 
			             'Mail時間間隔(天)', '建立時間', '操作'],
			colModel : [ {
				name : 'id',
				index : 'id',
				width : 60,
				align : "center"
			}, {
				name : 'name',
				index : 'name',
				width : 90,
				align : "center"
			}, {
				name : 'mailNum',
				index : 'mailNum',
				width : 60,
				align : "center"
			}, {
				name : 'mailJobDay',
				index : 'mailJobDay',
				width : 60,
				align : "center"
			}, {
				name : 'createTime',
				index : 'createTime',
				width : 60,
				align : "center"
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
					var deleteBtn = '';
					var updateBtn = "<input  type='button' value='修改' class='mybutton' onclick=\"updateProjectGroup('"
						+ cl + "');\" />&nbsp";
					if(cl!='default') {
						deleteBtn = "<input  type='button' value='刪除' class='mybutton' onclick=\"deleteProjectGroup('"
						+ cl + "');\" />";
					}
					
					jQuery("#list").jqGrid('setRowData', ids[i], {
						operation : updateBtn + deleteBtn
					});
				}
			},
			caption : "文案群組列表"
		}); 

	});
	
	function insertProjectGroup() {
		$("#projectGroupInsertForm").submit();
	}
	
	function updateProjectGroup(projectGroup) {
		$("#updateProjectGroupId").val(projectGroup);
		$("#projectGroupUpdateForm").submit();
	}
	
	function deleteProjectGroup(projectGroup) {
		//var projectGroupListGrid = $('#list'),
		//selRows = projectGroupListGrid.jqGrid('getGridParam','selarrrow');
		$("#id").val(projectGroup);
		$.prompt('刪除文案群組將一併刪除相關文案及Mail設定，確定刪除?',{
			buttons:[
				{title: '是',value:true},
				{title: '否',value:false}
				], 
			submit: function(e,v,m,f){ 
				if(v){
					 $("#projectGroupDeleteForm").submit();
				}
			}
		});
	}
	
	
</script>

</head>
<body leftmargin="8" topmargin="8">
	<table width="98%"  align="center" border="0">
		<tr>
			<td align="right" class='title'>
				<input type="button" class='mybutton' id="dlrbtn" value="新增"
					onclick="insertProjectGroup()">
			</td>
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
	
	<form id="projectGroupInsertForm" action="projectGroupInsert.html" method="post">
	</form>
	
	<form id="projectGroupUpdateForm" action="projectGroupUpdate.html" method="post">
		<input id="updateProjectGroupId" name="updateProjectGroupId" type="hidden" />
	</form>
	
	<form id="projectGroupDeleteForm" action="projectGroupDelete.html" method="post">
		<input id="id" name="id" type="hidden" />
	</form>
</body>

</html>