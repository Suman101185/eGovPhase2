<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<script runat="server">

    CopMvcUtil util = new CopMvcUtil();
    RevFuncSrv rev_func_srv = new RevFuncSrv();
    FuncSrv func_srv = new FuncSrv();
    XMLUtil xmlProc = new XMLUtil();
</script>



<html>
<head>
    <script type="text/javascript" language="javascript">

        var txtHeader = 'Taxpayer Information';
        var mToday = '<%= VB.FormatDateTime(DateTime.Now, 2)%>';
    var mTime = '<%= VB.FormatDateTime(DateTime.Now, 4)%>';

</script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispCoupon.js"></script>
    <link rel="Stylesheet" type="text/css" href="~/Content/Styles/Font.css"/>
    <link rel="Stylesheet" type="text/css" href="~/Content/Styles/Object.css"/>
    <title></title>
</head>
<body>

    <%
        
        string sCurrYear = string.Empty;
        if (!string.IsNullOrEmpty(Request.QueryString["y"].ToString()))
        {
            sCurrYear = System.DateTime.Now.Year.ToString();
        }
        else
        {
            sCurrYear = Request.QueryString["y"].ToString();

        }

        Html.RenderAction("AppHeader", "INC");
        
         if (sCurrYear == "2011")
        {
            Html.RenderAction("Tobacco2010", "RETURNS");
        }
        else if (sCurrYear == "2012")
        {
            Html.RenderAction("Tobacco2011", "RETURNS");
        }
        else if (sCurrYear == "2013")
        {
            Html.RenderAction("Tobacco2012", "RETURNS");
        }
         Html.RenderAction("ispCoupon", "INC");
        Html.RenderAction("Progress", "INC");
        Html.RenderAction("Cache", "INC");
        Html.RenderAction("TobaccoThankYou", "RETURNS");
     
    %>
</body>
</html>
