<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


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
    string gUserAddr = CopMvcUtil.GetString(Request.ServerVariables["REMOTE_ADDR"]);
%>

<html>
<head>
    <script type="text/javascript" language="javascript" src="../../Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="../../Content/Scripts/ispFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../../Content/Scripts/ispXmlProc.js"></script>
    <script type="text/javascript" language="javascript" src="../../Content/Scripts/ispCoupon.js"></script>
    <script type="text/javascript" language="javascript" src="../../Content/Scripts/Accounting.js"></script>
    <link rel="Stylesheet" type="text/css" href="../../Content/Styles/Font.css" />
    <link rel="Stylesheet" type="text/css" href="../../Content/Styles/Object.css" />

    <script type="text/javascript" language="javascript">

        parent.MenuWin.loadXmlAsync('../xml/email', parent.MenuWin.parseXml_xmlEmail);
        parent.MenuWin.loadXmlAsync('../XML/BPTlfReturn', parent.MenuWin.parseXml_xmlBPTlfTemplate);
        parent.MenuWin.loadXmlAsync('../XML/AcctTemplate', parent.MenuWin.parseXml_xmlTemplate);

        var txtHeader = 'Taxpayer Information';
        var mToday = '<%= DateTime.Now.Date.ToString("m/d/y") %>';
        var mTime = '<%= DateTime.Now.Date.ToString("h:m") %>';
        var sCurrYear = '<%= sCurrYear%>';
        var sCurrWrkSht = '';
        var dBPTNetRate;
        var dBPTGrossRate;
        var dBPTWholesaleRate;
        var dBPTManufacturerRate;
        var dBPTRetailerRate;
        var negTaxDue = false;
        var amntNegDue = 0;
        var sCurrWrkSht = '';
        var sPrevWrkSht = '';


        function getActiveElement() {
            var maxdepth = 9;
            var i = 0;

            var evt_buff;
            var evt = window.event;
            var src;

            if (evt) {
                //for IE
                return parent.MenuWin.getEventSource(evt);
            }
            else {
                evt = arguments.callee;
                for (i = 0; i < maxdepth; i++) {
                    if (evt != undefined) {
                        evt_buff = evt;
                        evt = evt.caller;
                    }
                    else {
                        src = evt_buff.arguments[0];
                        if (src) {
                            break;
                        }
                        src = null;
                        break;
                    }
                }
            }

            return parent.MenuWin.getEventSource(src);
        }


    </script>
    <title></title>
</head>
<body onload="DisplayBPTlfReturn();">

    <%

        Html.RenderAction("AppHeader", "INC");

        if (sCurrYear == "2009" || sCurrYear == "2010")
        {
            Html.RenderAction("BPTlfjs09", "BPT_LF");
            Html.RenderAction("BPTlf2009", "BPT_LF");
            Html.RenderAction("SchdA09", "BPT_LF");
            Html.RenderAction("SchdB09", "BPT_LF");
            Html.RenderAction("SchdC109", "BPT_LF");
            Html.RenderAction("SchdD09", "BPT_LF");
            Html.RenderAction("SchdE09", "BPT_LF");
        }
        else if (sCurrYear == "2011")
        {
            Html.RenderAction("_10BPTlfjs", "BPT_LF");
            Html.RenderAction("_10BPTlf", "BPT_LF");
            Html.RenderAction("_10SchdA", "BPT_LF");
            Html.RenderAction("_10SchdB", "BPT_LF");
            Html.RenderAction("_10SchdC1", "BPT_LF");
            Html.RenderAction("_10SchdD", "BPT_LF");
            Html.RenderAction("_10SchdE", "BPT_LF");
        }
        else if (sCurrYear == "2012")
        {
            Html.RenderAction("_11BPTlfjs", "BPT_LF");
            Html.RenderAction("_11BPTlf", "BPT_LF");
            Html.RenderAction("_11SchdA", "BPT_LF");
            Html.RenderAction("_11SchdB", "BPT_LF");
            Html.RenderAction("_11SchdC1", "BPT_LF");
            Html.RenderAction("_11SchdD", "BPT_LF");
            Html.RenderAction("_11SchdE", "BPT_LF");
        }
        else if (sCurrYear == "2013")
        {
            Html.RenderAction("_12BIRTlfjs", "BPT_LF");
            Html.RenderAction("_12BIRTlf", "BPT_LF");
            Html.RenderAction("_12SchdA", "BPT_LF");
            Html.RenderAction("_12SchdB", "BPT_LF");
            Html.RenderAction("_12SchdC1", "BPT_LF");
            Html.RenderAction("_12SchdD", "BPT_LF");
            Html.RenderAction("_12SchdE", "BPT_LF");
            Html.RenderAction("_12BIRT_19_3800Message", "BPT_LF");
            Html.RenderAction("_12WrkShtN", "BPT_LF");
        }


        Html.RenderAction("BPTlfThankYou", "Returns");
        Html.RenderAction("Progress", "INC"); 
                                              
    
    
    %>

    <script src="../../Content/Scripts/ispCoupon.js" language="javascript" type="text/javascript"></script>


</body>
</html>

