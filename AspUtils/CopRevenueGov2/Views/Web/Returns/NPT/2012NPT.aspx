<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>

    <title></title>
    <style>
        .inpNormal, .inpReadOnlyRt, .inpError {
            text-align: right;
        }
    </style>
</head>
<body onload="DisplayNPTReturn()">
    <div id="NPT" style="DISPLAY: none; VISIBILITY: visible" name="NPT">

        <table class="tblShowBorder" width="90%" bgcolor="whitesmoke" style="MARGIN-LEFT: 4%" border="0"
            cellspacing="0" cellpadding="0" id="TABLE1">
            <tr>
                <td width="2%"></td>
                <td width="8%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
            </tr>

            <tr>
                <td>&nbsp;</td>
                <td>
                    <label class="lblInstrNormal">Name:&nbsp;</label>
                </td>
                <td colspan="10">
                    <label id="lblName" class="lblTextBlack" nowrap></label>
                </td>
                <td colspan="3" align="right">
                    <label id="lblAccountType" class="lblInstrNormal">Account No.: &nbsp;</label></td>
                <td colspan="4">
                    <label id="lblAccountId" class="lblTextBlack"></label>
                </td>
            </tr>

            <tr>
                <td>&nbsp;</td>
                <td>
                    <label class="lblInstrNormal">Address:&nbsp;</label>
                </td>
                <td colspan="10">
                    <label id="lblAddress" class="lblTextBlack"></label>
                </td>
                <td colspan="3" align="right">
                    <label id="lblEntityType" class="lblInstrNormal">EIN: &nbsp;</label></td>
                <td colspan="4">
                    <label id="lblEntityId" class="lblTextBlack"></label>
                </td>
            </tr>
        </table>

        <table style="MARGIN-LEFT: 4%; TOP: 205px; LEFT: 43px" border="0" width="90%">
            <tr>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
            </tr>
        </table>
    </div>
    <!--NPT-->
    <div id="NPT_BPT_msg" style="DISPLAY: none; VISIBILTY: visible" name="NPT_BPT_msg" align="center">
        <br>
        <br>
        <br>
        Your 2012 BIRT return must be filed prior to filing your 2012 NPT Return.<br>
        To fill out your 2012 BIRT form, Please select BIRT from the side menu.
    </div>
    <div id="NPT_Page1" style="DISPLAY: none; VISIBILTY: visible" name="NPT_Page1">
        <table style="MARGIN-LEFT: 4%; TOP: 205px; LEFT: 43px" border="0" width="90%">
            <tr>
                <td align="left" colspan="12" nowrap>
                    <input id="chkAmended" type="checkbox" onclick="chkAmended_onclick()">
                    <label class="lblTextBlacksmall">Check if amended return.</label>
                </td>
                <td colspan="6">
                    <label class="lblTextBlacksmall">
                        If your business terminated in 
				<script>document.write(sCurrYear - 1)</script>
                        ,
					enter the termination date here:</label>
                </td>
                <td colspan="2" style="VERTICAL-ALIGN: bottom">
                    <input class="inpNormal"
                        id="txtTermDate" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="10"
                        onblur="return txtTermDate_onblur()">
                </td>
                <td width="20%"></td>
            </tr>
            <tr>
                <td align="left" colspan="12" nowrap></td>
                <td colspan="6">
                    <label class="lblTextBlacksmall">
                        If applicable, enter percentage from
					Worksheet D, Line 3:</label><br>
                    <label id="lnkWrkD" class="lblLink" style="FONT-SIZE: 7pt" onclick="if($('#chkAmended').is(':checked')== true){ShowPage('WrkD')}">Click here for Worksheet D</label>

                </td>
                <td colspan="2" style="VERTICAL-ALIGN: bottom">
                    <input class="inpNormal"
                        id="txtPercentage" onchange='ValidateWorksheet("Page1")' onfocus="SetFocus()" maxlength="3">%
                </td>
            </tr>
        </table>
        <table class="tblShowBorder" cellspacing="0" cellpadding="0" border="0" style="MARGIN-LEFT: 4%" id="TABLE2" width="90%">
            <tr height="0">
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
                <td width="5%"></td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">1.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">Residents Taxable Income or Loss from Page 2, Worksheet A, Line 4</label>
                    <label id="lnkWrkA" class="lblLink" style="FONT-SIZE: 7pt" onclick="if(!this.disabled){ShowPage('WrkA')}">Click here for Worksheet A</label></td>
                </TD>
		<td colspan="3">
            <input class="inpNormal" id="txtNPT1" onchange='ValidateWorksheet("Page1")'
                onfocus="SetFocus()" maxlength="10" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">2.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal" id="msgNPT1_2">Line 1 X ###</label>
                </td>
                <td colspan="3" style="text-align: right;">
                    <label class="inpReadOnlyRt" id="lblNPT2" style="WIDTH: 100%"></label>
                </td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">3.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">Non-Residents Taxable Income or Loss from Page 2, Worksheet B, Line 6</label>
                    <label id="lnkWrkB" class="lblLink" style="FONT-SIZE: 7pt" onclick="if(!this.disabled){ShowPage('WrkB')}">Click here for Worksheet B</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtNPT3" onchange='ValidateWorksheet("Page1")'
                        onfocus="SetFocus()" maxlength="10" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">4.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal" id="msgNPT1_4">Line 3 X ###</label>
                </td>
                <td colspan="3" style="text-align: right;">
                    <label class="inpReadOnlyRt" id="lblNPT4" style="WIDTH: 100%"></label>
                </td>
            </tr>

            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">5.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">Tax Due (Line 2 plus Line 4)</label></td>
                <td colspan="3" style="text-align: right;">
                    <label class="inpReadOnlyRt" id="lblNPT5" style="WIDTH: 100%"></label>
                </td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">6a.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">60% Business Income & Receipts Tax credit </label>
                    <!--from Worksheet K, Line 4-->
                    <!--<label id="lnkWrkK" class="lblLink" style="FONT-SIZE: 7pt" onclick="if(!this.disabled){ShowPage('WrkK')}">Click here for Worksheet K</label>-->
                </td>
                <td colspan="3" style="text-align: right;">
                    <label class="inpReadOnlyRt" id="lblNPT6a"
                        style="WIDTH: 100%">
                    </label>
                </td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">6b.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        Estimated payments and other credits from 
						Worksheet E, Line 4</label>
                    <label id="lnkWrkE" class="lblLink" style="FONT-SIZE: 7pt" onclick="if(!this.disabled){ShowPage('WrkE')}">Click here for Worksheet E</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtNPT6b" onchange='ValidateWorksheet("Page1")'
                        onfocus="SetFocus()" maxlength="10" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">6c.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">Total payments and credits (Line 6a plus Line 6b)</label>
                </td>
                <td colspan="3" style="text-align: right;">
                    <label class="inpReadOnlyRt" id="lblNPT6c" style="WIDTH: 100%"></label>
                </td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">7.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">Net Tax Due (Line 5 minus Line 6c)</label></td>
                <td colspan="3" style="text-align: right;">
                    <label class="inpReadOnlyRt" id="lblNPT7" style="WIDTH: 100%"></label>
                </td>
            </tr>
            <tr class="rowDataOdd" valign="top">
                <td>
                    <label class="lblInstrNormal">8.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        Interest and Penalty<br>
                        (Cumulative % from Instruction Sheet multiplied by Line 7)</label></td>
                </TD>
		<td colspan="3">
            <input class="inpNormal" id="txtNPT8" onchange='ValidateWorksheet("Page1")'
                onfocus="SetFocus()" maxlength="10" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">9.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        <u>TOTAL DUE</u> including Interest and Penalty
					(Line 7 plus Line 8)</label></td>
                <td colspan="3" style="text-align: right;">
                    <label class="inpReadOnlyRt" id="lblNPT9" style="WIDTH: 100%"></label>
                </td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">10.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">Tax Overpaid (Line 6c is greater than Line 5)</label></td>
                <td colspan="3" style="text-align: right;">
                    <label class="inpReadOnlyRt" id="lblNPT10" style="WIDTH: 100%"></label>
                </td>
            </tr>
            <tr class="rowDataEven" valign="top">
                <td>
                    <label class="lblInstrNormal">11.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        Enter 50% of Worksheet C, Line 3.<br>
                        <b>This line is <u>not</u> used to remit estimated payments</b></label>
                    <label id="lnkWrkC" class="lblLink" style="FONT-SIZE: 7pt" onclick="if(!this.disabled){ShowPage('WrkC')}">Click here for Worksheet C</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtNPT11" onchange='ValidateWorksheet("Page1")'
                        onfocus="SetFocus()" maxlength="10" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">12.</label></td>
                <td colspan="19">
                    <label class="lblInstrNormal">
                        <u>OVERPAYMENT OPTIONS</u> If Line 10 is greater than Line 11, 
					enter the amount to be:</label></td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">&nbsp;&nbsp;A.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">Refunded. Do not file a separate refund petition</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtNPT12a" onchange='ValidateWorksheet("Page1")'
                        onfocus="SetFocus()" maxlength="10" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataOdd">
                <td>
                    <label class="lblInstrNormal">&nbsp;&nbsp;B.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        Applied to the 
				<script>document.write(sCurrYear - 1)</script>
                        Business Income & Receipts Tax Return</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtNPT12b" onchange='ValidateWorksheet("Page1")'
                        onfocus="SetFocus()" maxlength="10" style="WIDTH: 100%"></td>
            </tr>
            <tr class="rowDataEven">
                <td>
                    <label class="lblInstrNormal">&nbsp;&nbsp;C.</label></td>
                <td colspan="16">
                    <label class="lblInstrNormal">
                        Applied to the
                <%-- need to check it --%>
                        <%  Response.Write("2012");%>
					Net Profits Tax</label></td>
                <td colspan="3">
                    <input class="inpNormal" id="txtNPT12c" onchange='ValidateWorksheet("Page1")'
                        onfocus="SetFocus()" maxlength="10" style="WIDTH: 100%"></td>
            </tr>
        </table>

        <table style="MARGIN-LEFT: 4%" border="0" width="90%">
            <tr>
                <td width="80%">
                    <% Html.RenderAction("PreparerSection", "INC"); %></td>
                <td valign="bottom" align="right">
                    <p style="MARGIN-BOTTOM: 10px">
                        <input id="btnNPTPrint" type="button" value="Print" language="javascript"
                            onclick="return btnNPTPrint_onclick()">&nbsp;&nbsp;
			<input id="btnNPTSubmit" type="button" value="Submit" language="javascript"
                onclick="return btnNPTSubmit_onclick()">&nbsp;&nbsp;
                    </p>
                </td>
            </tr>

        </table>
    </div>
    <!--NPT_Page1-->

</body>
</html>

