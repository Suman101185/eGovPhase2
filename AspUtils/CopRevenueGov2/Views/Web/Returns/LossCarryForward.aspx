<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<html>
<head>
<%--<link type="text/css" rel="Stylesheet" href="../Content/Styles/Font.css" />
<link type="text/css" rel="Stylesheet" href="../Content/Styles/Object.css" />--%>
<script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispCoupon.js"></script>
    <%-- <link href="../Content/Styles/framestyle.css" rel="stylesheet" type="text/css" />--%>
<title></title>
</head>
<body>
    <%
        //Html.RenderAction("Progress", "INC");
        Html.RenderAction("LossCarryForward", "RETURNS");
    %>

</body>
</html>

