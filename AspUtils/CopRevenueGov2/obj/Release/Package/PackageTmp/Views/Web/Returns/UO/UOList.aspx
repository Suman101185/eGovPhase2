<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../../Content/Style/Font.css" />
<link rel="stylesheet" type="text/css" href="../../Content/Style/Object.css" />


<script type="text/javascript" language="javascript" src="../../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../../Content/Scripts/ispXmlProc.js"></script>

<script  language="javascript" type="text/javascript">
    var txtHeader = 'Taxpayer Information';
    var HasUOAccounts = true;



    function DisplayUOList() {
        //alert(ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0));
        //alert(ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0));
        ispXmlSetFieldVal(parent.MenuWin.oUOList, parent.DocWin.ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0), 'UO_INFO ACCOUNT_ID', '', 0);

        ispXmlSetFieldVal(parent.MenuWin.oUOList, ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0), 'UO_INFO ENTITY_ID', '', 0)
        //alert("after" + parent.MenuWin.oUOList.xml.xml);
        ispCallXMLForm(parent.MenuWin.oUOList, parent.MenuWin.oUOList, "UOListCall.asp", "");

        $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|U&O Account Request</Font>');
        $('#AppMessage').html('<BR>Enter the U&O account number and Select the submit button to retrieve a list of tax filings for that account');

        if (ispXmlGetRecCount(parent.MenuWin.oUOList, 'UO_ACCT', 'n') != 0) {

            UOList_PopAccounts();
            UOList_SetUOYears();
        }

    } //DisplayUOList

    function UOList_PopAccounts() {
        if (HasUOAccounts) {
            //Load dropdown with UO accounts
            var iCount = ispXmlGetRecCount(parent.MenuWin.oUOList, 'UO_ACCT', 'n');
            //alert("iCount:   " +  iCount);
            ddlUOAccount.options.length = iCount
            for (i = 0; i < iCount; i++) {
                //alert(ispXmlGetFieldVal(oUOList, 'UO_ACCT ACCOUNT_ID', '', i));
                //alert(ispXmlGetFieldVal(oUOList, 'UO_ACCT START_DATE', '', i));
                $(ddlUOAccount.options[i]).text(ispXmlGetFieldVal(parent.MenuWin.oUOList, 'UO_ACCT ACCOUNT_ID', '', i));
                // ddlUOAccount.options(i).STARTDATE = ispXmlGetFieldVal(oUOList, 'UO_ACCT START_DATE', '', i);
                $(ddlUOAccount.options[i]).attr("STARTDATE", ispXmlGetFieldVal(parent.MenuWin.oUOList, 'UO_ACCT START_DATE', '', i));
            }
        }
    } //UOList_PopAccounts

    function GetOUAccounts() {
    } //GetOUAccounts

    function GetList() {
        $('#divList').css("display", "block");
    }

    function GotoUO1(a) {
        ispXmlSetFieldVal(parent.MenuWin.oUOForm, 'INQ', 'UO_ACCT RETURN_STATUS', '', 0);
        ispXmlSetFieldVal(parent.MenuWin.oUOForm, $(ddlUOAccount.options[ddlUOAccount.selectedIndex]).text(), 'UO_ACCT ACCOUNT_ID', '', 0);
        // if (a.innerText == 'February' && ispCheckLeapYear(ddlUOYears.options(ddlUOYears.selectedIndex).innerText)) {
        if ($(a).text() == 'February' && ispCheckLeapYear($(ddlUOYears.options[ddlUOYears.selectedIndex]).text())) {
            ispXmlSetFieldVal(parent.MenuWin.oUOForm, $(ddlUOYears.options[ddlUOYears.selectedIndex]).text() + '0229', 'UO_ACCT PERIOD', '', 0);
        } else {
            // ispXmlSetFieldVal(oUOForm, ddlUOYears.options(ddlUOYears.selectedIndex).innerText + a.getAttribute('period'), 'UO_ACCT PERIOD', '', 0);
            ispXmlSetFieldVal(parent.MenuWin.oUOForm, $(ddlUOYears.options[ddlUOYears.selectedIndex]).text() + $(a).attr('period'), 'UO_ACCT PERIOD', '', 0);
        }
        //alert(parent.MenuWin.oUOForm.xml.xml);
        ispCallXMLForm(parent.MenuWin.oUOForm, parent.MenuWin.oUOForm, "UOFormCall.asp", "");
        //alert(parent.MenuWin.oUOForm.xml.xml);
        parent.DocWin.location.href = 'UO.asp'; //?a=' + oUOForm.xml
    }

    function ispCheckLeapYear(lYear) {
        lYear = parseInt(lYear);
        if (lYear % 4 == 0) {
            if (lYear % 100 != 0) {
                return true;
            } else {
                if (lYear % 400 == 0) {
                    return true;
                } else {
                    return false;
                }
            }
        }
        return false;
    } //ispCheckLeapYear

    function UOList_SetUOYears() {
        divList.style.display = 'none';
        divNoList.style.display = 'none';
        var iMaxYears = 10;
        var idx = ddlUOAccount.selectedIndex;
        var iStartYear = ispXmlGetFieldVal(parent.MenuWin.oUOList, 'UO_ACCT START_DATE', '', idx).substring(6);
        var iEndYear = ispXmlGetFieldVal(parent.MenuWin.oUOList, 'UO_ACCT END_DATE', '', idx).substring(6);

        if (iEndYear == '') {
            iEndYear = new Date().getFullYear();
        }

        if (iStartYear != '') {
            var iNumOfYears = iEndYear - iStartYear + 1;
            if (iNumOfYears < iMaxYears) {
                iMaxYears = iNumOfYears;
            }
            ddlUOYears.options.length = iMaxYears;
            for (i = 0; i < iMaxYears; i++) {
                if (ispXmlGetFieldVal(parent.MenuWin.oUOList, 'UO_ACCT FREQ_YEAR' + i, '', idx).toUpperCase() != 'X') {
                    $(ddlUOYears.options[i]).text(iEndYear - i);
                } else {
                    ddlUOYears.remove(0);
                }
            }
        } else {
            ddlUOYears.options.length = 0;
            ddlUOYears.remove(0);
        }
        if (ddlUOYears.options.length != 0) {
            $('#divList').css("display", "block");
            UOList_DisplayButtons();
        } else {
            //divNoList.style.display = 'block';
            $('#divNoList').css("display", "block");
        }

        $('#lblPropLoc').html(ispXmlGetFieldVal(parent.MenuWin.oUOList, 'UO_ACCT LOCATION', '', ddlUOAccount.selectedIndex));
        $('#lblStartDate').html(ispXmlGetFieldVal(parent.MenuWin.oUOList, 'UO_ACCT START_DATE', '', ddlUOAccount.selectedIndex));
        $('#lblEndDate').html(ispXmlGetFieldVal(parent.MenuWin.oUOList, 'UO_ACCT END_DATE', '', ddlUOAccount.selectedIndex));
    } //UOList_SetUOYears

    function UOList_DisplayButtons() {
        $('#rowJan').css("display", "none"); btnJan.setAttribute('period', '0131');
        $('#rowFeb').css("display", "none"); btnFeb.setAttribute('period', '0228');
        $('#rowMar').css("display", "none"); btnMar.setAttribute('period', '0331');
        $('#rowApr').css("display", "none"); btnApr.setAttribute('period', '0430');
        $('#rowMay').css("display", "none"); btnMay.setAttribute('period', '0531');
        $('#rowJun').css("display", "none"); btnJun.setAttribute('period', '0630');
        $('#rowJul').css("display", "none"); btnJul.setAttribute('period', '0731');
        $('#rowAug').css("display", "none"); btnAug.setAttribute('period', '0831');
        $('#rowSep').css("display", "none"); btnSep.setAttribute('period', '0930');
        $('#rowOct').css("display", "none"); btnOct.setAttribute('period', '1031');
        $('#rowNov').css("display", "none"); btnNov.setAttribute('period', '1130');
        $('#rowDec').css("display", "none"); btnDec.setAttribute('period', '1231');

        var sFreq = ispXmlGetFieldVal(parent.MenuWin.oUOList, 'UO_ACCT FREQ_YEAR' + ddlUOYears.selectedIndex, '', ddlUOAccount.selectedIndex);
        if (sFreq.toUpperCase() == "M") {
            $('#rowJan').css("display", "block");
            $('#rowFeb').css("display", "block");
            $('#rowMar').css("display", "block");
            $('#rowApr').css("display", "block");
            $('#rowMay').css("display", "block");
            $('#rowJun').css("display", "block");
            $('#rowJul').css("display", "block");
            $('#rowAug').css("display", "block");
            $('#rowSep').css("display", "block");
            $('#rowOct').css("display", "block");
            $('#rowNov').css("display", "block");
            $('#rowDec').css("display", "block");

        } else if (sFreq.toUpperCase() == "Q") {
            $('#rowMar').css("display", "block");
            $('#rowJun').css("display", "block");
            $('#rowSep').css("display", "block");
            $('#rowDec').css("display", "block");
        } else if (sFreq.toUpperCase() == "H") {
            $('#rowJun').css("display", "block");
            $('#rowDec').css("display", "block");
        }

    } //UOList_DisplayButtons
</script>
</head>
<%
    Html.RenderAction("AppHeader", "INC");
    /*  <!--#Include File="../../Inc/AppHeader.htm"--> */
%>   

<body onload="DisplayUOList()">
	<div style="margin-left:4%; width:90%">
	<br />
	<label class="lblInstrNormal" style="margin-left:15px">Select U&O Account ID:</label> 
	<select class='inpNormal' id="ddlUOAccount" onchange="UOList_SetUOYears()" style="width:100px">
		<option></option>
	</select>
	<br />
	<div style="margin-top:10px">
		<label class="lblInstrNormal" style="margin-left:30px">Property Location: </label>
		<label class='inpNormal' id="lblPropLoc"></label>
		<label class="lblInstrNormal" style="margin-left:15px">Start Date: </label>
		<label class='inpNormal' id="lblStartDate"></label>
		<label class="lblInstrNormal" style="margin-left:15px">End Date: </label>
		<label class='inpNormal' id="lblEndDate"></label>
	</div>

	<div id="divNoList"	style="display:none; margin-left:30px; margin-top:20px">
		<label style="color:Red">No U&O return frequency found</label>
	</div>
	
	<div id="divList" style="display:none; margin-left:15px; margin-top:20px">
		<table border="0">
			<tr>
				<td style="width:30px"></td>
				<td style="width:40px"></td>
				<td style="width:100px"></td>
			</tr>
			<tr>
				<td colspan="3">
					<label class="lblInstrNormal">Select U&O Year:</label> 
					<select class='inpNormal' id="ddlUOYears" onchange="UOList_SetUOYears()" style="width:60px">
						<option></option>
					</select></td>
			</tr>
			<tr id="rowJan">
				<td></td>
				<td><button id="btnJan" onclick="GotoUO1(this)" style="width:120px">January</button></td>
			</tr>
			<tr id="rowFeb">
				<td></td>
				<td><button id="btnFeb" onclick="GotoUO1(this)" style="width:120px">February</button></td>
			</tr>
			<tr id="rowMar">
				<td></td>
				<td><button id="btnMar" onclick="GotoUO1(this)" style="width:120px">March</button></td>
			</tr>
			<tr id="rowApr">
				<td></td>
				<td><button id="btnApr" onclick="GotoUO1(this)" style="width:120px">April</button></td>
			</tr>
			<tr id="rowMay">
				<td></td>
				<td><button id="btnMay" onclick="GotoUO1(this)" style="width:120px">May</button></td>
			</tr>
			<tr id="rowJun">
				<td></td>
				<td><button id="btnJun" onclick="GotoUO1(this)" style="width:120px">June</button></td>
			</tr>
			<tr id="rowJul">
				<td></td>
				<td><button id="btnJul" onclick="GotoUO1(this)" style="width:120px">July</button></td>
			</tr>
			<tr id="rowAug">
				<td></td>
				<td><button id="btnAug" onclick="GotoUO1(this)" style="width:120px">August</button></td>
			</tr>
			<tr id="rowSep">
				<td></td>
				<td><button id="btnSep" onclick="GotoUO1(this)" style="width:120px">September</button></td>
			</tr>
			<tr id="rowOct">
				<td></td>
				<td><button id="btnOct" onclick="GotoUO1(this)" style="width:120px">October</button></td>
			</tr>
			<tr id="rowNov">
				<td></td>
				<td><button id="btnNov" onclick="GotoUO1(this)" style="width:120px">November</button></td>
			</tr>
			<tr id="rowDec">
				<td></td>
				<td><button id="btnDec" onclick="GotoUO1(this)" style="width:120px">December</button></td>
			</tr>
		</table>
	</div>
	</div>
</body>
</html>
