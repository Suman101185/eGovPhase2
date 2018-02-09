 <%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<script runat="server">

    CopMvcUtil util = new CopMvcUtil();
    RevFuncSrv rev_func_srv = new RevFuncSrv();
    FuncSrv func_srv = new FuncSrv();
    XMLUtil xmlProc = new XMLUtil();
</script>



<html>
<head>
     <link href="../Content/Styles/framestyle.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispCoupon.js"></script>
    <script language="javascript" type="text/javascript" src="../Content/Scripts/Accounting.js"></script>
     <script type="text/javascript" language="javascript" src="../Content/Scripts/jquery.browser.min.js"></script>
 
    <script type="text/javascript" language="javascript">

        var txtHeader = 'Taxpayer Information';
        var mToday = '<%= VB.FormatDateTime(DateTime.Now, 2)%>';
        var mTime = '<%= VB.FormatDateTime(DateTime.Now, 4)%>';
      
        function loadpage() {
          
                var iFrameID1 = parent.document.getElementById('ifrmDocwin');
                iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";           


        }
</script>

    <title></title>
</head>
<body onload="loadpage()">

    <%
        
        string sCurrYear = string.Empty;
        if (CopMvcUtil.GetString(this.Request.QueryString["y"]) == "")
        {
            sCurrYear = System.DateTime.Now.Year.ToString();
        }
        else
        {
            sCurrYear = Request.QueryString["y"].ToString();

        }
        if (sCurrYear == "2011")
        {
            Html.RenderAction("Tobacco2010", "RETURNS");
        }
        if (sCurrYear == "2012")
        {
            Html.RenderAction("Tobacco2011", "RETURNS");
        }
        if (sCurrYear == "2013")
        {
            Html.RenderAction("Tobacco2012", "RETURNS");
        }     
     
         if (sCurrYear == "2014")
         {
             Html.RenderAction("Tobacco2013", "RETURNS");
         }
         else if (sCurrYear == "2015")
         {
             Html.RenderAction("Tobacco2014", "RETURNS");
         }
         else if (sCurrYear == "2016")
         {
             Html.RenderAction("Tobacco2015", "RETURNS");
         }
         else if (sCurrYear == "2017")
         {
             Html.RenderAction("Tobacco2016", "RETURNS");
         }
         else if (sCurrYear == "2018")
         {
             Html.RenderAction("Tobacco2017", "RETURNS");
         }
        Html.RenderAction("Progress", "INC");
        Html.RenderAction("TobaccoThankYou", "RETURNS", new { id = sCurrYear });
     
    %>
</body>
</html>
