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
       <link href="../Content/Styles/framestyle.css" rel="stylesheet" type="text/css" />
<script src="../Content/Scripts/JqueryMin.js" type="text/javascript" language="javascript"></script>
<script src ="../Content/Scripts/ispFunctions.js" type="text/javascript" language="javascript"></script>
<script src ="../Content/Scripts/ispXmlProc.js" type="text/javascript" language="javascript"></script>
<script src ="../Content/Scripts/Accounting.js" type="text/javascript" language="javascript"></script>
<script src="../Content/Scripts/ispCoupon.js" type="text/javascript" language="javascript" ></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/jquery.browser.min.js"></script>

<title></title>
</head>
<body>

    <%
        if (sCurrYear == "2011") //2010 BPTezReturns 
        {
            Html.RenderAction("BPTez2010", "Returns");
            Html.RenderAction("_10BIRT_19_3800Message", "Returns");
            Html.RenderAction("_10BIRTWrkShtN", "Returns");
        }


        if (sCurrYear == "2012") //2011 BPTezReturns 
        {
            Html.RenderAction("BPTez2011", "Returns");
            Html.RenderAction("_11BIRT_19_3800Message", "Returns");
            Html.RenderAction("_11BIRTWrkShtN", "Returns");
        } 
        
        if (sCurrYear == "2013")
        {
            Html.RenderAction("BPTez2012", "Returns");
            Html.RenderAction("_12BIRT_19_3800Message", "Returns");
            Html.RenderAction("_12BIRTWrkShtN", "Returns");        
        } 
        
         else if (sCurrYear == "2014")
        {                                                                      
            Html.RenderAction("BPTez2013", "Returns");
            Html.RenderAction("_13BIRT_19_3800Message", "Returns");
            Html.RenderAction("_13BIRTWrkShtN", "Returns");        
        }
        else if (sCurrYear == "2015")
        {
            Html.RenderAction("BPTez2014", "Returns");
           
        }
        else if (sCurrYear == "2016")
        {
            Html.RenderAction("BPTez2015", "Returns");
            
        }

        else if (sCurrYear == "2017")
        {
            Html.RenderAction("BPTez2016", "Returns");
           
        }

        else if (sCurrYear == "2018")
        {
            Html.RenderAction("BPTez2017", "Returns");

        }
        
    %>
	
        <script src="../Content/Scripts/ispCoupon.js" language="javascript" type="text/javascript"></script>

    <%
        Html.RenderAction("BPTezThankYou", "Returns", new { id = sCurrYear });
        Html.RenderAction("Progress", "INC");         
        
    %>


</body>
</html>

