<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<html>
<head>
<script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispCoupon.js"></script>   
<title></title>
</head>
<body>
    <%       
        Html.RenderAction("LossCarryForward", "RETURNS");
    %>

</body>
</html>

