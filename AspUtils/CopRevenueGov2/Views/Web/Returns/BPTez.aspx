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

    function loadpage() {
        if ($.browser.mozilla || $.browser.firefox || $.browser.opera || $.browser.safari || $.browser.chrome) {
            
                try {
                    var iFrameID = parent.window.frames['ifrmDocwin'];

                    $(iFrameID).height($(iFrameID).contents().find("html").height() + 70);
                }
                catch (ee) {
                    var iFrameID1 = parent.document.getElementById('ifrmDocwin');

                    iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";

                }
            }           
        
        else {
            var iFrameID1 = parent.document.getElementById('ifrmDocwin');
            iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";

        }


    } // binoy
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
<%--<link type="text/css" rel="Stylesheet" href="../Content/Styles/Font.css" />
<link type="text/css" rel="Stylesheet" href="../Content/Styles/Object.css" />--%>
<title></title>
</head>
<body onload="loadpage()">

    <%
        //Html.RenderAction("AppHeader", "INC");       

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
        
         else if (sCurrYear == "2014")
        {
            //    <!--#include file="BPTez2013.htm" -->
            //<!--#Include File="13BIRT_19_3800Message.htm"-->
            //<!--#Include File="13BIRTWrkShtN.htm"-->	
                                                          
            Html.RenderAction("BPTez2013", "Returns");
            Html.RenderAction("_13BIRT_19_3800Message", "Returns");
            Html.RenderAction("_13BIRTWrkShtN", "Returns");        
        }
        else if (sCurrYear == "2015")
        {
            //    <!--#include file="BPTez2013.htm" -->
            //<!--#Include File="13BIRT_19_3800Message.htm"-->
            //<!--#Include File="13BIRTWrkShtN.htm"-->	

            Html.RenderAction("BPTez2014", "Returns");

            //Html.RenderAction("BPTez_WorkSheetSEZ_2014", "Returns");
        }
        else if (sCurrYear == "2016")
        {
            //    <!--#include file="BPTez2013.htm" -->
            //<!--#Include File="13BIRT_19_3800Message.htm"-->
            //<!--#Include File="13BIRTWrkShtN.htm"-->	

            Html.RenderAction("BPTez2015", "Returns");

            //Html.RenderAction("BPTez_WorkSheetSEZ_2014", "Returns");
        }
        
    %>
	
        <script src="../Content/Scripts/ispCoupon.js" language="javascript" type="text/javascript"></script>

    <%
       // Html.RenderAction("SchoolThankYou", "Returns", new { id = sCurrYear });
        Html.RenderAction("BPTezThankYou", "Returns", new { id = sCurrYear });
        Html.RenderAction("Progress", "INC");         
        
    %>


</body>
</html>

