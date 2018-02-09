<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%
string sCurrYear = string.Empty;
if(Request.QueryString["y"] == "" )
    {
	    sCurrYear = DateTime.Now.Year.ToString();
    }
else
    {
	    sCurrYear = Request.QueryString["y"];
    }
%>
<script type="text/javascript">
    var txtHeader = 'Taxpayer Information';
    var mToday = '<%= DateTime.Now.Date.ToString("m/d/y") %>';
    var mTime = '<%= DateTime.Now.Date.ToString("h:m") %>';
</script>
<html>
<head>
<link REL="stylesheet" TYPE="text/css" href="../../Content/Styles/Font.css">
<link REL="stylesheet" TYPE="text/css" href="../../Content/Styles/Object.css">
<script language="JavaScript" type="text/javascript" src="../../Content/Scripts/ispFunctions.js"></script>
<script language="JavaScript" type="text/javascript" src="../../Content/Scripts/ispXmlProc.js"></script>
<script language="JavaScript" type="text/javascript" src="ERN.js.htm"></script>
<title></title>
</head>
<body>
<% Html.RenderAction("AppHeader", "INC"); %>

<xml id="oAcctInfo" src="../../xml/AcctTemplate.xml"></xml>
<xml id="oEmail" src="../../xml/email.xml"></xml>

<% Html.RenderAction("ERN", "ERN"); %>
<% Html.RenderAction("ERNThankYou", "ERN"); %>
</body>
</html>

