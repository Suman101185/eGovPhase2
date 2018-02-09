<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>
<%
    string sCurrYear = string.Empty;
    if (Request.QueryString["y"] == "")
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
    <link rel="stylesheet" type="text/css" href="../../../../Content/Styles/Font.css">
    <link rel="stylesheet" type="text/css" href="../../../../Content/Styles/Object.css">
    <script language="javascript" type="text/javascript" src="../../../../Content/Scripts/ispFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../../../../Content/Scripts/Accounting.js"></script>

    <script language="javascript" type="text/javascript">
        var txtHeader = 'Taxpayer Information';
        var mToday = '<%= DateTime.Now.Date.ToString("m/d/y") %>';
    var mTime = '<%= DateTime.Now.Date.ToString("h:m") %>';
        var sCurrYear = '<%= sCurrYear %>';
    </script>
    <title></title>
</head>
<body>

    <% Html.RenderAction("AppHeader", "INC"); %>

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

           /*
                <!--#Include File="NPT2006.htm"-->
                <!--#Include File="NPT.js.htm"-->
                <!--#Include File="WrkA06.htm"-->
                <!--#Include File="WrkB06.htm"-->
                <!--#Include File="WrkC06.htm"-->
                <!--#Include File="WrkD06.htm"-->
                <!--#Include File="WrkE06.htm"-->
                <!--#Include File="WrkK06.htm"-->
                <!--#Include File="Page406.htm"-->
            * 
            * */
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
           /*
           <!--#Include File="NPT2007.htm"-->
           <!--#Include File="NPT.js07.htm"-->
           <!--#Include File="WrkA07.htm"-->
           <!--#Include File="WrkB07.htm"-->
           <!--#Include File="WrkC07.htm"-->
           <!--#Include File="WrkD07.htm"-->
           <!--#Include File="WrkE07.htm"-->
           <!--#Include File="WrkK07.htm"-->
           <!--#Include File="Page407.htm"-->
            * 
            * */
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

           /*
           <!--#Include File="NPT2008.htm"-->
           <!--#Include File="NPT.js08.htm"-->
           <!--#Include File="WrkA08.htm"-->
           <!--#Include File="WrkB08.htm"-->
           <!--#Include File="WrkC08.htm"-->
           <!--#Include File="WrkD08.htm"-->
           <!--#Include File="WrkE08.htm"-->
           <!--#Include File="WrkK08.htm"-->
           <!--#Include File="Page408.htm"-->
            * */
       }
       else if (sCurrYear == "2010")
       {
           /*
           <!--#Include File="2009NPT.htm"-->
           <!--#Include File="09NPT.js.htm"-->
           <!--#Include File="09WrkA.htm"-->
           <!--#Include File="09WrkB.htm"-->
           <!--#Include File="09WrkC.htm"-->
           <!--#Include File="09WrkD.htm"-->
           <!--#Include File="09WrkE.htm"-->
           <!--#Include File="09WrkK.htm"-->
           <!--#Include File="09Page4.htm"-->
           */

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
           /*
           <!--#Include File="10NPT.js.htm"-->
           <!--#Include File="2010NPT.htm"-->
           <!--#Include File="10WrkA.htm"-->
           <!--#Include File="10WrkB.htm"-->
           <!--#Include File="10WrkC.htm"-->
           <!--#Include File="10WrkD.htm"-->
           <!--#Include File="10WrkE.htm"-->
           <!--#Include File="10WrkK.htm"-->
           <!--#Include File="10Page4.htm"-->
            */

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
           /*
           <!--#Include File="11NPT.js.htm"-->
           <!--#Include File="2011NPT.htm"-->
           <!--#Include File="11WrkA.htm"-->
           <!--#Include File="11WrkB.htm"-->
           <!--#Include File="11WrkC.htm"-->
           <!--#Include File="11WrkD.htm"-->
           <!--#Include File="11WrkE.htm"-->
           <!--#Include File="11WrkK.htm"-->
           <!--#Include File="11Page4.htm"-->
            */

           Html.RenderAction("_11NPTjs", "NPT");
           Html.RenderAction("_2011NPT", "NPT");
           Html.RenderAction("_11WrkA", "NPT");
           Html.RenderAction("_11WrkB", "NPT");
           Html.RenderAction("_11WrkC", "NPT");
           Html.RenderAction("_11WrkD", "NPT");
           Html.RenderAction("_11WrkE", "NPT");
           Html.RenderAction("_11WrkK", "NPT");
           Html.RenderAction("_11Page4", "NPT");

       }
       else if (sCurrYear == "2013")
       {
           /*
           <!--#Include File="12NPT.js.htm"-->
           <!--#Include File="2012NPT.htm"-->
           <!--#Include File="12WrkA.htm"-->
           <!--#Include File="12WrkB.htm"-->
           <!--#Include File="12WrkC.htm"-->
           <!--#Include File="12WrkD.htm"-->
           <!--#Include File="12WrkE.htm"-->
           <!--#Include File="12WrkK.htm"-->
           <!--#Include File="12Page4.htm"-->
            */

           Html.RenderAction("_12NPTjs", "NPT");
           Html.RenderAction("_2012NPT", "NPT");
           Html.RenderAction("_12WrkA", "NPT");
           Html.RenderAction("_12WrkB", "NPT");
           Html.RenderAction("_12WrkC", "NPT");
           Html.RenderAction("_12WrkD", "NPT");
           Html.RenderAction("_12WrkE", "NPT");
           Html.RenderAction("_12WrkK", "NPT");
           Html.RenderAction("_12Page4", "NPT");

       }
    %>

    <!--EGOVWEB-69 EDD Added the ispCoupon Include below -->
    <script type="text/javascript" language="javascript" src="../../../../Content/Scripts/ispCoupon.js"></script>
    
    <% 
        Html.RenderAction("NPTThankYou", "NPT");
        Html.RenderAction("Progress", "Inc");
    %>

</body>
</html>
