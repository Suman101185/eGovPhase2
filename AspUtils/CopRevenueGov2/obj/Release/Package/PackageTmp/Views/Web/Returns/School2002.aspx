<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<script>
var txtHeader = 'Taxpayer Information'
</script>
<html>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<!--#Include File="../Inc/Cache.htm"-->
<!--#Include File="../Inc/Styles.htm"-->
<!--#Include File="../Inc/ispFunctions.js.htm"-->
<script language='JavaScript' src='../Inc/ispXmlProc.js.htm'></script>
<script language='JavaScript'>
//<!---
function window_onload() {
	DisplaySchool02Return()
}		//window_onload
//--->
</script>
<title></title>
</head>
<body onload="window_onload()">
<!--#Include File="../Inc/AppHeader.htm"-->

<xml id="oAcctInfo" src="../xml/AcctTemplate.xml"></xml>
<xml id="oEmail" src="../xml/email.xml"></xml>

<!--#Include File="School2002.htm"-->
<!--#Include File="SchoolThankYou.htm"-->
<!--#Include File="../Inc/Cache.htm"-->
</body>
</html>

