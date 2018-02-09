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
        

</script>  
    
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



      
        Html.RenderAction("Progress", "INC");
        Html.RenderAction("WageThankYou", "RETURNS", new { id = sCurrYear });

        if (sCurrYear == "2011")
        {
            Html.RenderAction("Wage2010", "RETURNS");
        }
        if (sCurrYear == "2012")
        {
            Html.RenderAction("Wage2011", "RETURNS");
        }
        if (sCurrYear == "2013")
        {
            Html.RenderAction("Wage2012", "RETURNS");
        }
       
        if (sCurrYear == "2014")
        {
            Html.RenderAction("Wage2013", "RETURNS");
        }
        else if (sCurrYear == "2015")
        {
            Html.RenderAction("Wage2014", "RETURNS");
        }
        else if (sCurrYear == "2016")
        {
            Html.RenderAction("Wage2015", "RETURNS");
        }
        else if (sCurrYear == "2017")
        {
            Html.RenderAction("Wage2016", "RETURNS");
        }
        else if (sCurrYear == "2018")
        {
            Html.RenderAction("Wage2017", "RETURNS");
        }
        
     
    %>
</body>
</html>
