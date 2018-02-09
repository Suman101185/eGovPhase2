<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<%
string  sCurrYear = string.Empty;
if(Request.QueryString["y"] == "" )
{
	sCurrYear = DateTime.Now.Year.ToString();
}
else
{
	sCurrYear = Request.QueryString["y"];
}

%>

<script type="text/javascript" language="javascript">
    var txtHeader = 'Taxpayer Information';
    var mToday = '<%= DateTime.Now.Date.ToString("m/d/y") %>';
    var mTime = '<%= DateTime.Now.Date.ToString("h:m") %>';
    var sCurrYear = '<%= sCurrYear %>';
    var sCurrWrkSht = '';
</script>

<html>
<head>
<script src="../Content/Scripts/JqueryMin.js" type="text/javascript"></script>
<script src ="../Content/Scripts/ispFunctions.js" type="text/javascript" language="javascript"></script>
<script src ="../Content/Scripts/ispXmlProc.js" type="text/javascript" language="javascript"></script>
<script src ="../Content/Scripts/Accounting.js" type="text/javascript" language="javascript"></script>
<link type="text/css" rel="Stylesheet" href="../Content/Styles/Font.css" />
<link type="text/css" rel="Stylesheet" href="../Content/Styles/Object.css" />
<title></title>
</head>
<body>

    <%
        Html.RenderAction("AppHeader", "INC");       

        if(sCurrYear == "2007")
        {
            Html.RenderAction("BPTez2006", "Returns"); 
        }
        else if (sCurrYear == "2008")
        {
            Html.RenderAction("BPTez2007", "Returns"); 
        }
        else if (sCurrYear == "2009")
        {
            Html.RenderAction("BPTez2008", "Returns"); 
        }
        else if (sCurrYear == "2010")
        {
            Html.RenderAction("BPTez2009", "Returns"); 
        }
        else if (sCurrYear == "2011")
        {
            Html.RenderAction("BPTez2010", "Returns"); 
        }
        else if (sCurrYear == "2012")
        {
            Html.RenderAction("BPTez2011", "Returns"); 
        }
        else if (sCurrYear == "2013")
        {
            Html.RenderAction("BPTez2012", "Returns");
            Html.RenderAction("_12BIRT_19_3800Message", "Returns");
            Html.RenderAction("_12BIRTWrkShtN", "Returns");        
        }                                              
        
    %>
	
        <script src="../Content/Scripts/ispCoupon.js" language="javascript" type="text/javascript"></script>

    <%
        Html.RenderAction("BPTezThankYou", "Returns");
        Html.RenderAction("Progress", "INC");         
        
    %>


</body>
</html>

