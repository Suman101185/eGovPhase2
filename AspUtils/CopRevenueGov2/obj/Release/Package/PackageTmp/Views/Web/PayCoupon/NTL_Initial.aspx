<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<HTML>

<HEAD>

<script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>

<link rel="Stylesheet" href="../Content/Styles/Font.css" />
<link rel="Stylesheet" href="../Content/Styles/Object.css" />


<script language="javascript"  type="text/javascript">

    var oCouponInfo = parent.MenuWin.getXmlDocObj();
    parent.MenuWin.loadXmlAsync('../XML/PayCoupon', load_oCouponInfo);
    function load_oCouponInfo(xml) {
        oCouponInfo.xml = xml;
    }
    function DisplayNTL() {

        $('#AppHeader').text('No Tax Liability');
        //AppMessage.innerText = "Complete this screen to file a no wage tax liabilty coupon for the period selected."
        $('#AppMessage').text('Complete this screen to file a no wage tax liabilty coupon for the period selected.');
        //alert('in');
        $('#PrtCoupAcctID').text('Wage Tax - ' + ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "WAGE_NTL ACCOUNT_ID", "", 0));

        //alert('in');
        //PrtCoupAcctID.innerText = 'Wage Tax - ' + 
        //	ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "WAGE_NTL/ACCOUNT_ID", "", 0)
        var lsPeriod = ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "WAGE_NTL PERIOD", "", 0);
        if (lsPeriod.substr(4, 2) == '01') {
            lsPeriod = 'January ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
        } else if (lsPeriod.substr(4, 2) == '02') {
            lsPeriod = 'February ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
        } else if (lsPeriod.substr(4, 2) == '03') {
            lsPeriod = 'March ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
        } else if (lsPeriod.substr(4, 2) == '04') {
            lsPeriod = 'April ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
        } else if (lsPeriod.substr(4, 2) == '05') {
            lsPeriod = 'May ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
        } else if (lsPeriod.substr(4, 2) == '06') {
            lsPeriod = 'June ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
        } else if (lsPeriod.substr(4, 2) == '07') {
            lsPeriod = 'July ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
        } else if (lsPeriod.substr(4, 2) == '08') {
            lsPeriod = 'August ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
        } else if (lsPeriod.substr(4, 2) == '09') {
            lsPeriod = 'September ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
        } else if (lsPeriod.substr(4, 2) == '10') {
            lsPeriod = 'October ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
        } else if (lsPeriod.substr(4, 2) == '11') {
            lsPeriod = 'November ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
        } else if (lsPeriod.substr(4, 2) == '12') {
            lsPeriod = 'December ' + lsPeriod.substr(6, 2) + ', ' + lsPeriod.substr(0, 4)
        }		//if
        //EGOVWEB-61 EDD 2011.02.04 Last week payment must be 12/31/ccyy per Nancy Needs to be redisplayed as 31
        if (lsPeriod.substr(0, 11) == 'December 30') {
            lsPeriod = lsPeriod.replace('30', '31');
            //		alert(lsPeriod)
        }		//if
        //PrtCoupPeriod.innerText = lsPeriod
        $('#PrtCoupPeriod').text(lsPeriod);
        //PrtEntityName.innerText = ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "ENTITY_INFO/NAME", '', 0)
        $('#PrtEntityName').text(ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "ENTITY_INFO NAME", '', 0));
        var info = ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "ENTITY_INFO ADDRESS1", '', 0) +
                '<br>' + ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "ENTITY_INFO CITY", '', 0) + ', ' +
                ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "ENTITY_INFO STATE", '', 0) + ' ' +
                ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "ENTITY_INFO ZIP_CODE", '', 0)
        $('#PrtEntityAddr').html(info);
        /*PrtEntityAddr.innerHTML = ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "ENTITY_INFO ADDRESS1", '', 0) +
                '<br>' + ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "ENTITY_INFO CITY", '', 0) + ', ' +
                ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "ENTITY_INFO STATE", '', 0) + ' ' +
                ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, "ENTITY_INFO ZIP_CODE", '', 0)*/
    }		//DisplayNTL

    function SubmitNTL() {
        //	var xmlNTL = new ActiveXObject("MSXML.DOMDocument")
        $('#AppError').html('');
        var validerr = ValidatePreparer();

        $('#AppError').text(validerr);

        if (validerr != '') {
            return
        }		//if

        ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, "", "ERROR_INFO ERROR", '', 0);
        ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, "", "ERROR_INFO MESSAGE", '', 0);
        ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, "N", "ENTITY_INFO FUNCTION_CODE", '', 0);
        //alert('in');
        PopulatePreparerXML(parent.MenuWin.xmlPayCoupon, "WAGE_NTL");

        //EGOVWEB-61
        for (i = 199; i > 0; i--) {
            if (ispXmlGetFieldVal(parent.MenuWin.xmlPayCoupon, 'TAX_ACCT ACCOUNT', "", i) == '0') {

                //ispXmlRemoveNode(parent.MenuWin.xmlPayCoupon, 'PAYCOUPON', 0, 'TAX_ACCT', i);
                $(parent.MenuWin.xmlPayCoupon.xml).find('PAYCOUPON TAX_ACCT').eq(i).remove();

            } else {
            }		//if
        }		//for


        ispCallXMLForm(parent.MenuWin.xmlPayCoupon, oCouponInfo, "PayCouponRecv", "");

        if (ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO MESSAGE', "", 0) == "") {
            //alert("1");
            $('#divNTL_Init').css("display", "none");
            $('#divNtlThankYou').css("display", "block");
            //divNtlThankYou.style.display = "block"
            //lblPeriod.innerText = PrtCoupPeriod.innerText
            $('#lblPeriod').text($('#PrtCoupPeriod').text());
            $('#lblName').text(ispXmlGetFieldVal(oCouponInfo, 'ENTITY_INFO NAME', "", 0));
            $('#lblAcctNo').text(ispXmlGetFieldVal(oCouponInfo, "WAGE_NTL ACCOUNT_ID", "", 0));
            $('#lblConfirmNo').text(ispXmlGetFieldVal(oCouponInfo, 'WAGE_NTL ADJ_REF_NO', "", 0));
        } else {

            //AppError.innerText = ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO/MESSAGE', "", 0)
            $('#AppError').text(ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO MESSAGE', "", 0));
        }		//if
    }		//SubmitNTL

    function DoThankYou() {
        //	Clear Account XML so the Main Page Displays
        //parent.MenuWin.xmlAccount.loadXML(parent.MenuWin.xmlTemplate.xml)
        parent.MenuWin.xmlAccount = parent.MenuWin.xmlTemplate;
        //parent.MenuWin.mnuLogPayCoupon.className = 'mnuNormal'
        $(parent.MenuWin.mnuLogPayCoupon).addClass('mnuNormal');
        parent.DocWin.location.href = '../login/Main';
    }		//DoThankYou

    function ReturnToSelection() {
        parent.DocWin.location.href = 'PayCoupon';
    }		//ReturnToSelection
</script>
</HEAD>

<BODY onload="DisplayNTL()">
	<DIV style="Display: block;" Id="divNTL_Init" Name="divNTL_Init">

    <%
        Html.RenderAction("AppHeader", "INC");    
    %>

	<table cellSpacing="0" cellPadding="0"  border="0" style="Margin-left: 0px; Width: 80%; Top: 0px;" id="frmNTL_Init">
		<tr style ="Font-size: 10pt; Font-family: Arial;" >
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
			<td width="5%"><p>&nbsp;</p></td>
		</tr>	
		<tr style ="Font-size: 8pt; Font-family: Arial;">
			<td colspan=20 ><p>&nbsp;</p></td></tr>
		<tr style ="Font-size: 12pt; Font-family: Arial;">
			<td colspan=3 ><p>&nbsp;</p></td>
			<td colspan=6 align=left border="1" borderColor=black style="Border-right: Thin 
				Solid; Border-top: Thin Solid; Font-size: 12pt; Border-left: Thin Solid;">
				&nbsp;Account Number:</td>
			<td colspan=8 align=left border="1" borderColor=black style="Border-right: Thin Solid; 
				Border-top: Thin Solid; Padding-left: 10px; Font-size: 12pt;" class=lbltext 
				id="PrtCoupAcctID" ></td>
	   		<td colspan=3 ><p>&nbsp;</p></td></tr>
		<tr style ="Font-size: 12pt; Font-family: Arial;">
			<td colspan=3 ><p>&nbsp;</p></td>
			<td colspan=6 align=left border="1" borderColor=black style="Border-right: Thin Solid; Border-top: Thin 
				Solid; Font-size: 12pt; Border-left: Thin Solid;"> &nbsp;Period:</td>
			<td colspan=8 align=left border="1" borderColor=black style="Border-right: Thin Solid;
				 Border-top: Thin Solid; Padding-left: 10px;" id="PrtCoupPeriod" ></td>
	   		<td colspan=3 width="5%"><p>&nbsp;</p></td></tr>
		<tr style ="Font-size: 12pt; Font-family: Arial;">
			<td colspan=3 ><p>&nbsp;</p></td>
			<td colspan=6 align=left borderColor=black border="1" style="Border-right: Thin Solid; 
				Border-top: Thin Solid; Font-size: 12pt; Border-left: Thin Solid; 
				Border-bottom: Thin Solid;">&nbsp;Amount Owed:</td>
			<td colspan=8 align=left border="1" borderColor=black style="Border-right: Thin Solid; 
				Border-top: Thin Solid; Padding-left: 10px; Border-bottom: Thin Solid;"><p>$0.00</p></td>
	   		<td colspan=3><p>&nbsp;</p></td></tr>
		<tr style ="Font-size: 12pt; Padding-top: 10px; Font-family: Arial;">
			<td colspan=3 ><p>&nbsp;</p></td>
			<td colspan=6 align=left style="Padding-left: 10px; Font-size: 12pt; Width: 250px; Border-top-style: None;
				 Border-right-style: None; Border-left-style: None; Height: 18px; Border-bottom-style: None;"
				      
    type="lbltext" size="36" 
    id="PrtEntityName" 
    class=lbltext valign=top></td>
			<td colspan=8 align=left style="Padding-left: 10px; Font-size: 12pt; Width: 250px; Border-top-style: None;
				 Border-right-style: None; Border-left-style: None; Height: 18px; Border-bottom-style: None;"
				      
    type="lbltext" size="36" id="PrtEntityAddr" 
    class=lbltext></td>
			<td colspan=3  ><p>&nbsp;</p></td></tr>		  
	  <TR style ="Font-size: 6pt; Font-family: Arial;">
			<td colspan=20 align=left>&nbsp;</td></TR>
		<tr style ="Font-size: 12pt; Font-family: Arial;">
			<td colspan=20>

            <%
                Html.RenderAction("PreparerSection", "INC");    
            %>                

			</td><tr>
		<tr style ="Font-size: 12pt; Font-family: Arial;">
			<td colspan=20><p>&nbsp;</p></td><tr>
		<tr style ="Font-size: 10pt; Font-family: Arial;">
			<td colspan=20><p><FONT color=red size=5pt>*</FONT> You must complete all fields before clicking the Submit NTL button.</p></td><tr>
		<tr style ="Font-size: 12pt; Font-family: Arial;">
			<td colspan=20><p>&nbsp;</p></td><tr>
		<tr style ="Font-size: 14pt;" id="coup2">
			<td colspan=4><p>&nbsp;</p></td>
			<td colspan=3><p><INPUT id=btnNtlSubmit onclick=SubmitNTL() type=button value="Submit NTL"></p></td>
			<td colspan=4><p>&nbsp;</p></td>
			<td colspan=3><p><INPUT id=btnNtlCancel onclick=ReturnToSelection() type=button value=Cancel></p></td>
		 	<td colspan=6><p>&nbsp;</p></td></tr>
	 </table>
	</DIV>

    <%
        Html.RenderAction("NTL_ThankYou", "PayCoupon");    
    %>
	
</BODY>

</HTML>
