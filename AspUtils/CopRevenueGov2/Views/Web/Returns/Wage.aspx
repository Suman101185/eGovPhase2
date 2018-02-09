<%@  Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<script runat="server">

    CopMvcUtil util = new CopMvcUtil();
    RevFuncSrv rev_func_srv = new RevFuncSrv();
    FuncSrv func_srv = new FuncSrv();
    XMLUtil xmlProc = new XMLUtil();

    string sCurrYear = string.Empty;
    string txtHeader = string.Empty;
    string mToday = string.Empty;
    string mTime = string.Empty;

</script>



<html>
<head>
      <link href="../Content/Styles/framestyle.css" rel="stylesheet" type="text/css" />
    <script src ="../Content/Scripts/Accounting.js" type="text/javascript" language="javascript"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispCoupon.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/jquery.browser.min.js"></script>
     <script type="text/javascript" language="javascript">

         var txtHeader = 'Taxpayer Information';
         var mToday = '<%= VB.FormatDateTime(DateTime.Now, 2)%>';
         var mTime = '<%= VB.FormatDateTime(DateTime.Now, 4)%>';
         //function loadpage() {
         //    if ($.browser.mozilla || $.browser.firefox || $.browser.opera || $.browser.safari || $.browser.chrome) {
         //        try {
         //            var iFrameID = parent.window.frames['ifrmDocwin'];

         //            $(iFrameID).height($(iFrameID).contents().find("html").height() + 70);
         //        }
         //        catch (ee) {
         //            var iFrameID1 = parent.document.getElementById('ifrmDocwin');

         //            iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";

         //        }
         //    }
         //    else {
         //        var iFrameID1 = parent.document.getElementById('ifrmDocwin');
         //        iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";

         //    }


         //} // binoy
        

</script>
    

   <%-- <link rel="Stylesheet" type="text/css" href="../Content/Styles/Font.css"/>
    <link rel="Stylesheet" type="text/css" href="../Content/Styles/Object.css"/>--%>
    
    <title></title>
</head>
<body>

    <%
        if (string.IsNullOrEmpty(Request.QueryString["y"]))
        {
            sCurrYear = System.DateTime.Now.Year.ToString();
        }
        else
        {
            sCurrYear = Request.QueryString["y"].ToString();

        }



       // Html.RenderAction("AppHeader", "INC");
        Html.RenderAction("Progress", "INC");
        Html.RenderAction("WageThankYou", "RETURNS", new { id = sCurrYear });        
      
        if (sCurrYear == "2003")
        {
            Html.RenderAction("PageMaintenance", "WEB");
        }
        else if (sCurrYear == "2004")
        {
            Html.RenderAction("PageMaintenance", "WEB");
        }
        else if (sCurrYear == "2005")
        {
            Html.RenderAction("PageMaintenance", "WEB");
        }
        else if (sCurrYear == "2006")
        {
            Html.RenderAction("PageMaintenance", "WEB");
        }
        else if (sCurrYear == "2007")
        {
            Html.RenderAction("Wage2006", "RETURNS");
        }
        else if (sCurrYear == "2008")
        {
            Html.RenderAction("Wage2007", "RETURNS");
        }
        else if (sCurrYear == "2009")
        {
            Html.RenderAction("Wage2008", "RETURNS");

        }
        else if (sCurrYear == "2010")
        {

            Html.RenderAction("Wage2009", "RETURNS");
        }
        else if (sCurrYear == "2011")
        {
            Html.RenderAction("Wage2010", "RETURNS");
        }
        else if (sCurrYear == "2012")
        {
            Html.RenderAction("Wage2011", "RETURNS");
        }
        else if (sCurrYear == "2013")
        {
            Html.RenderAction("Wage2012", "RETURNS");
        }
        else if (sCurrYear == "2014")
        {
            Html.RenderAction("Wage2013", "RETURNS");
        }
        else if (sCurrYear == "2015")
        {
            Html.RenderAction("Wage2014", "RETURNS");
        }// binoy
        else if (sCurrYear == "2016")
        {
            Html.RenderAction("Wage2015", "RETURNS");
        }
       // Html.RenderAction("PreparerSection", "INC");   
     
    %>
</body>
</html>
