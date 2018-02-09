<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<%
//'EGOVWEB-74 Created 2011.03.29
string sCurrYear = string.Empty;
string sFreq=string.Empty;
string sPage=string.Empty;
if(CopMvcUtil.GetString(this.Request.QueryString["y"]) == "")
{
	sCurrYear = DateTime.Now.Year.ToString();
}
else
{
	sCurrYear = CopMvcUtil.GetString(this.Request.QueryString["y"]);
}
if(CopMvcUtil.GetString(this.Request.QueryString["y"]) != "")
{
    sFreq= CopMvcUtil.GetString(this.Request.QueryString["f"]);
}
if(CopMvcUtil.GetString(this.Request.QueryString["page"]) != "")
{
	sPage =  CopMvcUtil.GetString(this.Request.QueryString["page"]);
}
%>

<html>
<head>
<title></title>
      <link href="../Content/Styles/framestyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" rel="Stylesheet" href="../Content/Styles/Font.css" />
<link type="text/css" rel="Stylesheet" href="../Content/Styles/Object.css" />
<script language="javascript" type="text/javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script language="javascript" type="text/javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispCoupon.js"></script>
      <script type="text/javascript" language="javascript" src="../Content/Scripts/jquery.browser.min.js"></script>


<script language="javascript" type="text/javascript">
    var txtHeader = 'Taxpayer Information';
    var mToday = '<%= VB.FormatDateTime(DateTime.Now, 2)%>';
    var mTime = '<%= VB.FormatDateTime(DateTime.Now, 4)%>';
    var sCurrYear = '<%= sCurrYear%>';
    var sFormXml = '<%= CopMvcUtil.Session("EOLFORMXML")%>';

    var negTaxDue = false;
    var gUserAddr = '<%=  CopMvcUtil.GetString(this.Request.ServerVariables["REMOTE_ADDR"]) %>';

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
<script language="javascript" type="text/javascript" src="../Content/Scripts/Accounting.js"></script>


</head>
<body onload="loadpage()">

<%--<% Html.RenderAction("AppHeader", "INC"); %>  --%>
    <%
        if (sPage == "new")
        {
            Html.RenderAction("UO2013Form", "UO");
            Html.RenderAction("UOThankYouNew", "UO", new { id = sCurrYear });
        }
        else
        {
            if (sPage == "old")
            {
                Html.RenderAction("UO2011Form", "UO");
                Html.RenderAction("UOThankYou", "UO", new { id = sCurrYear });

            }
        }   
    %>  
    <script language="javascript" type="text/javascript" src="../Content/Scripts/ispCoupon.js"></script>
<%--<%  Html.RenderAction("Progress", "Inc"); %> --%>
   

</body>
</html>
