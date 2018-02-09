<%@ Language=VBScript %>
<%
Dim sCurrYear
if Request.QueryString("y") = "" then
	sCurrYear = cstr(Year(date()))
else
	sCurrYear = Request.QueryString("y")
end if
%>
<script>
var txtHeader = 'Taxpayer Information'
var mToday = '<%= FormatDateTime(date, 2)%>'
var mTime = '<%= FormatDateTime(time, 4)%>'
</script>
<html>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<!--#Include File="../../Inc/Cache.htm"-->
<link REL="stylesheet" TYPE="text/css" href="../../Style/Font.css">
<link REL="stylesheet" TYPE="text/css" href="../../Style/Object.css">
<!--#Include File="../../Inc/ispFunctions.js.htm"-->
<script language="JavaScript" src="../../Inc/ispXmlProc.js.htm"></script>
<script language="JavaScript" src="ERN.js.htm"></script>
<title></title>
</head>
<body>
<!--#Include File="../../Inc/AppHeader.htm"-->

<xml id="oAcctInfo" src="../../xml/AcctTemplate.xml"></xml>
<xml id="oEmail" src="../../xml/email.xml"></xml>

<!--#Include File="ERN.htm"-->
<!--#Include File="ERNThankYou.htm"-->
</body>
</html>

