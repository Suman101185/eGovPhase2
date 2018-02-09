<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>
<%
    string sCurrYear = string.Empty;
    if( CopMvcUtil.GetString(this.Request.QueryString["y"]) == "")
    {
        sCurrYear = DateTime.Now.Year.ToString();
    }
    else
    {
        sCurrYear = Request.QueryString["y"];
    }
%>



<html>
<head>
    <%--<link type="text/css" rel="Stylesheet" href="../../Content/Styles/Font.css" />
<link type="text/css" rel="Stylesheet" href="../../Content/Styles/Object.css" />--%>

<link type="text/css" rel="Stylesheet" href="../../Content/Styles/framestyle.css" />
<script type="text/javascript" language="javascript" src="../../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../../Content/Scripts/ispXmlProc.js"></script>
<script type="text/javascript" language="javascript" src="../../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../../Content/Scripts/ispCoupon.js"></script>
<script src ="../../Content/Scripts/Accounting.js" type="text/javascript" language="javascript"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/jquery.browser.min.js"></script>
    <script language="javascript" type="text/javascript">
        var txtHeader = 'Taxpayer Information';
        var mToday = '<%= DateTime.Now.Date.ToString("m/d/y") %>';
        var mTime = '<%= DateTime.Now.Date.ToString("h:m") %>';
        var sCurrYear = '<%= sCurrYear %>';
        function loadpage() {
            
                try {
                    var iFrameID = parent.window.frames['ifrmDocwin'];

                    $(iFrameID).height($(iFrameID).contents().find("html").height() + 70);
                }
                catch (ee) {
                    var iFrameID1 = parent.document.getElementById('ifrmDocwin');

                    iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";

                }
           


        } // binoy
    </script>
    <title></title>
</head>
<body onload="loadpage()">

   <%-- <% Html.RenderAction("AppHeader", "INC"); %>--%>

    <% if (sCurrYear == "2007")
       {
          
           Html.RenderAction("NPT2006", "NPT");
           Html.RenderAction("NPTjs", "NPT");
           Html.RenderAction("WrkA06", "NPT");
           Html.RenderAction("WrkB06", "NPT");
           Html.RenderAction("WrkC06", "NPT");
           Html.RenderAction("WrkD06", "NPT");
           Html.RenderAction("WrkE06", "NPT");
           Html.RenderAction("WrkK06", "NPT");
           Html.RenderAction("Page406", "NPT");

       }
       else if (sCurrYear == "2008")
       {

           Html.RenderAction("NPT2007", "NPT");
           Html.RenderAction("NPTjs07", "NPT");
           Html.RenderAction("WrkA07", "NPT");
           Html.RenderAction("WrkB07", "NPT");
           Html.RenderAction("WrkC07", "NPT");
           Html.RenderAction("WrkD07", "NPT");
           Html.RenderAction("WrkE07", "NPT");
           Html.RenderAction("WrkK07", "NPT");
           Html.RenderAction("Page407", "NPT");
           
       }
       else if (sCurrYear == "2009")
       {

           Html.RenderAction("NPT2008", "NPT");
           Html.RenderAction("NPTjs08", "NPT");
           Html.RenderAction("WrkA08", "NPT");
           Html.RenderAction("WrkB08", "NPT");
           Html.RenderAction("WrkC08", "NPT");
           Html.RenderAction("WrkD08", "NPT");
           Html.RenderAction("WrkE08", "NPT");
           Html.RenderAction("WrkK08", "NPT");
           Html.RenderAction("Page408", "NPT");

           
       }
       else if (sCurrYear == "2010")
       {
           Html.RenderAction("_2009NPT", "NPT");
           Html.RenderAction("_09NPTjs", "NPT");
           Html.RenderAction("_09WrkA", "NPT");
           Html.RenderAction("_09WrkB", "NPT");
           Html.RenderAction("_09WrkC", "NPT");
           Html.RenderAction("_09WrkD", "NPT");
           Html.RenderAction("_09WrkE", "NPT");
           Html.RenderAction("_09WrkK", "NPT");
           Html.RenderAction("_09Page4", "NPT");

       }
       else if (sCurrYear == "2011")
       {
           Html.RenderAction("_10NPTjs", "NPT");
           Html.RenderAction("_2010NPT", "NPT");
           Html.RenderAction("_10WrkA", "NPT");
           Html.RenderAction("_10WrkB", "NPT");
           Html.RenderAction("_10WrkC", "NPT");
           Html.RenderAction("_10WrkD", "NPT");
           Html.RenderAction("_10WrkE", "NPT");
           Html.RenderAction("_10WrkK", "NPT");
           Html.RenderAction("_10Page4", "NPT");

       }
       else if (sCurrYear == "2012")
       {
           Html.RenderAction("_11NPTjs", "NPT");
           Html.RenderAction("_2011NPT", "NPT");          

       }
       else if (sCurrYear == "2013")
       {
           Html.RenderAction("_12NPTjs", "NPT");
           Html.RenderAction("_2012NPT", "NPT");         

       }
       else if (sCurrYear == "2014")
       {
           Html.RenderAction("_13NPT_js", "NPT");
           Html.RenderAction("_2013NPT", "NPT");          
       }
       else if (sCurrYear == "2015")
       {
           Html.RenderAction("_14NPT_js", "NPT");
           Html.RenderAction("_2014NPT", "NPT");
          
       }
       else if (sCurrYear == "2016")
       {
           Html.RenderAction("_15NPT_js", "NPT");
           Html.RenderAction("_2015NPT", "NPT");
         
       }
    %>
   <%-- <script type="text/javascript" language="javascript" src="../../Content/Scripts/ispCoupon.js"></script>--%>
    
    <% 
        Html.RenderAction("NPTThankYou", "Returns", new { id = sCurrYear });
        Html.RenderAction("Progress", "INC");
        
    %>

</body>
</html>
