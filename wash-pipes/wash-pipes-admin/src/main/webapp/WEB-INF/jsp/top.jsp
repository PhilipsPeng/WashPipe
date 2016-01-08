<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" > 
<meta http-equiv="Cache-Control" content="no-cache" > 
<META HTTP-EQUIV="Expires" CONTENT="-1">
<title>top</title>
<link href="skin/css/base.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.tools.min.js"></script>

<style>
body { padding:0px; margin:0px; }
#tpa {
color: #009933;
margin:0px;
padding:0px;
float:right;
padding-right:10px;
}

#tpa dd {
margin:0px;
padding:0px;
float:left;
margin-right:2px;
}

#tpa dd.ditem {
margin-right:8px;
}

#tpa dd.img {
  padding-top:6px;
}

div.item
{
  text-align:center;
background:url(skin/images/frame/topitembg.gif) 0px 3px no-repeat;
width:82px;
height:26px;
line-height:28px;
}

.itemsel {
  width:80px;
  text-align:center;
  background:#226411;
border-left:1px solid #c5f097;
border-right:1px solid #c5f097;
border-top:1px solid #c5f097;
height:26px;
line-height:28px;
}

*html .itemsel {
height:26px;
line-height:26px;
}

a:link,a:visited {
 text-decoration: underline;
}

.item a:link, .item a:visited {
font-size: 12px;
color: #ffffff;
text-decoration: none;
font-weight: bold;
}

.itemsel a:hover {
color: #ffffff;
font-weight: bold;
border-bottom:2px solid #E9FC65;
}

.itemsel a:link, .itemsel a:visited {
font-size: 12px;
color: #ffffff;
text-decoration: none;
font-weight: bold;
}

.itemsel a:hover {
color: #ffffff;
border-bottom:2px solid #E9FC65;
}

.rmain {
  padding-left:10px;
  /* background:url(skin/images/frame/toprightbg.gif) no-repeat; */
}
</style>
</head>
<body bgColor='#ffffff'>
<table width="100%" border="0" cellpadding="0" cellspacing="0" background="skin/images/frame/topbg.gif">
  <tr>
    <td width='20%' height="50"><!-- img src="img/logo.png"/> --></td>
    <td width='80%' align="right" valign="bottom">
    <table width="750" border="0" cellspacing="0" cellpadding="0">
      <tr>
      <td align="right" height="26" style="padding-right:10px;line-height:26px;">
        您好：${loginMember.name}<span class="username" id="username"></span>，歡迎使用水管達人管理系統！${message2.url}
   <!--       [<a href="" target="_blank">網站主頁</a>]
        [<a href="" target="_blank">修改密碼</a>]
        -->
        [<a href="logout.html" target="_parent">登出</a>]&nbsp;
      </td>
      </tr>
      <tr>
        <td align="right" height="34" class="rmain">
  
        <!--  
<dl id="tpa">
<dd class='img'><a href="javascript:ChangeMenu(-1);"><img vspace="5" src="skin/images/frame/arrl.gif" border="0" width= "5" height="8" alt="縮小左框架" title="縮小左框架" /></a></dd>
<dd class='img'><a href="javascript:ChangeMenu(0);"><img vspace="3" src="skin/images/frame/arrfc.gif" border="0" width=" 12" height="12" alt="顯示/隱藏左框架" title="顯示/隱藏左框架" /></a></dd>
<dd class='img' style="margin-right:10px;"><a href="javascript:ChangeMenu(1);"><img vspace="5" src="skin/images/frame/arrr. gif" border="0" width="5" height="8" alt="增大左框架" title="增大左框架" /></a></dd>
<dd><div class='itemsel' id='item1' onMouseMove="mv(this,'move',1);" onMouseOut="mv(this,'o',1);"><a href= "menu.asp" onclick="changeSel(1)" target="menu">主菜單</a></div></dd>
<dd><div class='item' id='item2' onMouseMove="mv(this,'m',2);" onMouseOut="mv(this,'o',2);"><a href= "menu.html" onclick="changeSel(2)" target="menu">內容髮布</a></div></dd>
<dd><div class='item' id='item8' onMouseMove="mv(this,'m',8);" onMouseOut="mv(this,'o',8);"><a href= "menu.html" onclick="changeSel(8)" target="menu">插件模塊</a></div></dd>
<dd><div class='item' id='item4' onMouseMove="mv(this,'m',4);" onMouseOut="mv(this,'o',4);"><a href= "menu.html" onclick="changeSel(4)" target="menu">HTML更新</a></div></dd>
<dd><div class='item' id='item5' onMouseMove="mv(this,'m',5);" onMouseOut="mv(this,'o',5);"><a href= "menu.html" onclick="changeSel(5)" target="menu">系統設置</a></div></dd>
<dd><div class='item' id='item9' onMouseMove="mv(this,'m',9);" onMouseOut="mv(this,'o',9);"><a href= "main.html" onclick="changeSel(9)" target="main">後台主頁</a></div></dd>
-->
</dl>
</td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>