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
    <link href="../../Content/Styles/framestyle.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../../Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="../../Content/Scripts/ispFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../../Content/Scripts/ispCoupon.js"></script>
    <script type="text/javascript" language="javascript" src="../../Content/Scripts/Accounting.js"></script>
  <%--  <link rel="Stylesheet" type="text/css" href="../../Content/Styles/Font.css" />
    <link rel="Stylesheet" type="text/css" href="../../Content/Styles/Object.css" />--%>

    <script type="text/javascript" language="javascript">

        parent.$g.loadXmlAsync('XML/email', parent.parseXml_xmlEmail);
        parent.$g.loadXmlAsync('XML/BPTlfReturn', parent.parseXml_xmlBPTlfTemplate);
        parent.$g.loadXmlAsync('XML/BPTlfReturn_2014', parent.parseXml_xmlBPTlfTemplate_2014);
        parent.$g.loadXmlAsync('XML/AcctTemplate', parent.parseXml_xmlTemplate);

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
                return parent.getEventSource(evt);
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

            return parent.getEventSource(src);
        }
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
<body onload="DisplayBPTlfReturn();">

    <%

        // Html.RenderAction("AppHeader", "INC");

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
            //Html.RenderAction("_10SchdA", "BPT_LF");
            //Html.RenderAction("_10SchdB", "BPT_LF");
            //Html.RenderAction("_10SchdC1", "BPT_LF");
            //Html.RenderAction("_10SchdD", "BPT_LF");
            //Html.RenderAction("_10SchdE", "BPT_LF");
        }
        else if (sCurrYear == "2012")
        {
            Html.RenderAction("_11BPTlfjs", "BPT_LF");
            Html.RenderAction("_11BPTlf", "BPT_LF");
            //Html.RenderAction("_11SchdA", "BPT_LF");
            //Html.RenderAction("_11SchdB", "BPT_LF");
            //Html.RenderAction("_11SchdC1", "BPT_LF");
            //Html.RenderAction("_11SchdD", "BPT_LF");
            //Html.RenderAction("_11SchdE", "BPT_LF");
        }
        else if (sCurrYear == "2013")
        {
            Html.RenderAction("_12BIRTlfjs", "BPT_LF");
            Html.RenderAction("_12BIRTlf", "BPT_LF");
            //Html.RenderAction("_12SchdA", "BPT_LF");
            //Html.RenderAction("_12SchdB", "BPT_LF");
            //Html.RenderAction("_12SchdC1", "BPT_LF");
            //Html.RenderAction("_12SchdD", "BPT_LF");
            //Html.RenderAction("_12SchdE", "BPT_LF");
            //Html.RenderAction("_12BIRT_19_3800Message", "BPT_LF");
            //Html.RenderAction("_12WrkShtN", "BPT_LF");
        }
        else if (sCurrYear == "2014")
        {

            Html.RenderAction("_13BIRTlfjs", "BPT_LF");
            Html.RenderAction("_13BIRTlf", "BPT_LF");
            //Html.RenderAction("_13SchdA", "BPT_LF");
            //Html.RenderAction("_13SchdB", "BPT_LF");
            //Html.RenderAction("_13SchdC1", "BPT_LF");
            //Html.RenderAction("_13SchdD", "BPT_LF");
            //Html.RenderAction("_13SchdE", "BPT_LF");
            //Html.RenderAction("_13BIRT_19_3800Message", "BPT_LF");
            //Html.RenderAction("_13WrkShtN", "BPT_LF"); 
        }
        else if (sCurrYear == "2015")
        {

            Html.RenderAction("_14BIRTlfjs", "BPT_LF");
            Html.RenderAction("_14BIRTlf", "BPT_LF");
          
        }

        Html.RenderAction("BPTlfThankYou", "BPT_LF", new { id = sCurrYear });
        Html.RenderAction("Progress", "INC"); 

    %>

    <script src="../../Content/Scripts/ispCoupon.js" language="javascript" type="text/javascript"></script>


</body>
</html>

