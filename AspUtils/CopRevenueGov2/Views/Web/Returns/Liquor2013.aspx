<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
    <script type="text/javascript">
        function LiquorCheck() {
            alert(parent.$g.xmlLiquor);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlLiquor, 'INQ', 'LIQUOR_INFO RETURN_STATUS', '', 0);
           
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlLiquor, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', "", 0), 'SCHOOL_INFO ACCOUNT_ID', '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlLiquor, '12/31/2013', 'LIQUOR_INFO PERIOD', '', 0)
            ispCallXMLForm(parent.$g.xmlLiquor, parent.$g.xmlLiquor, "LiquorReturn", "");
            $('#LIQU').text(parent.$g.xmlLiquor);
        }

    </script>
    

</head>
<body>
    <div id="Liqour"></div>
   
  <input id="LiqourSubmit" type="button" value="Submit" onclick="LiquorCheck();">
  <label id="LIQU"></label>

</body>

</html>
