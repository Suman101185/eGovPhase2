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
  <%--  <link rel="Stylesheet" type="text/css" href="../Content/Styles/Font.css"/>
    <link rel="Stylesheet" type="text/css" href="../Content/Styles/Object.css"/>--%>

    <script type="text/javascript" language="javascript">

        var txtHeader = 'Taxpayer Information';
        var mToday = '<%= VB.FormatDateTime(DateTime.Now, 2)%>';
        var mTime = '<%= VB.FormatDateTime(DateTime.Now, 4)%>';
        //alert("openning window");
        //window.open("../Content/Scripts/ispFunctions.js");
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

        //Html.RenderAction("AppHeader", "INC");
        
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
         else if (sCurrYear == "2014")
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
        Html.RenderAction("Progress", "INC");
        Html.RenderAction("TobaccoThankYou", "RETURNS", new { id = sCurrYear });
     
    %>
</body>
</html>
