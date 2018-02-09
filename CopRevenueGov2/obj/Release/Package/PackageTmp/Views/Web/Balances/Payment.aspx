<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="System.IO" %>

<script runat="server">

double dDelinqAmt=0, PeriodInt=0, PeriodPen=0, PeriodOther=0,PeriodBalance=0, PeriodPrin=0;
string [] acctdata = new string[1];

</script>

<%
	CopRevenueGov2.Service.EOL_TIPSACCT acctinfo = null;
	
    string NonFilingCntStr = string.Empty;
	//dim result, tmpPrincipal, tmpInt, tmpPen, tmpOther
	
    double CreditAmt = 0.0d;
    int NonFilingCnt=0;
    int i=0;
        
	
	if(CopMvcUtil.Session("AccNum") == "")
    {
		if(CopMvcUtil.GetString(Request.Form["AccountNumber"]) != "" )
        {
			Session["AccNum"] = CopMvcUtil.GetString(Request.Form["AccountNumber"]);
		}
    }
	
	NonFilingCnt = 0;

	if(CopMvcUtil.Session("AccNum") != "" )
    {
		acctinfo = (CopRevenueGov2.Service.EOL_TIPSACCT)VB.CreateObject("EOL.TIPSACCT");
		acctinfo.ServerAddress = "ETB135:18024@RPC/SRV4/CALLNAT";
		acctinfo.RTTIE002(CopMvcUtil.Session("AccNum"), ref acctdata);

string  strDriveLetter, strPath, strFileToSend;

strDriveLetter = VB.Left(CopMvcUtil.GetString(Request.ServerVariables["PATH_TRANSLATED"]),1);

if(strDriveLetter=="I" )
{
	strPath = @"\\Isp_Domain_nt\data\Cop\Revenue\";
}
else
{
	strPath = strDriveLetter + @":\Cop\Revenue\";
}

strFileToSend = strPath + CopMvcUtil.Session("AccNum") + ".Payment.txt";
        
StreamWriter DebugFile = File.CreateText(strFileToSend);
for(i = 0; i<81; i++)
{
	DebugFile.WriteLine(acctdata[i]);
}
        DebugFile.Close();

		for(i = 2; i<81; i++)
        {
			if(VB.len(acctdata[i]) > 40 )
            {
				string tmpPrincipal = VB.mid(acctdata[i],26,15).Trim();
				if(tmpPrincipal != "")
                {
					CreditAmt = CreditAmt + CopMvcUtil.GetDouble(tmpPrincipal);
				}
            }


			if(VB.len(acctdata[i]) > 55)
            {
				string tmpInt = VB.mid(acctdata[i],41,15).Trim();
				if(tmpInt != "" )
                {
					CreditAmt = CreditAmt + CopMvcUtil.GetDouble(tmpInt);
				}
                }
							
			if(VB.len(acctdata[i]) > 55)
            {
				string tmpPen = VB.mid(acctdata[i],56,15).Trim();
                
				if(tmpPen != "")
                {
					CreditAmt = CreditAmt + CopMvcUtil.GetDouble(tmpPen);
				}
            }

			if(VB.len(acctdata[i]) > 55)
            {
				string tmpOther = VB.mid(acctdata[i],71,15).Trim();
                
				if(tmpOther != "")
                {
					CreditAmt = CreditAmt + CopMvcUtil.GetDouble(tmpOther);
				}
            }
		}

		for(i = 22; i<22; i++)
        {
			if(VB.len(acctdata[i]) > 40 )
            {
				string tmpPrincipal = VB.mid(acctdata[i],26,15).Trim();
				if(tmpPrincipal != "" )
                {
					dDelinqAmt = dDelinqAmt + CopMvcUtil.GetDouble(tmpPrincipal);
				}
            }

			if(VB.len(acctdata[i]) > 55 )
            {
				string tmpInt = VB.mid(acctdata[i],41,15).Trim();
				if(tmpInt != "")
                {
					dDelinqAmt = dDelinqAmt + CopMvcUtil.GetDouble(tmpInt);
				}
            }
							
			if(VB.len(acctdata[i]) > 55)
            {
				string tmpPen = VB.mid(acctdata[i],56,15).Trim();
                
				if(tmpPen != "" )
                {
					dDelinqAmt = dDelinqAmt + CopMvcUtil.GetDouble(tmpPen);
				}
            }

			if(VB.len(acctdata[i]) > 55 )
            {
				string tmpOther = VB.mid(acctdata[i],71,15).Trim();
                
				if(tmpOther != "" )
                {
					dDelinqAmt = dDelinqAmt + CopMvcUtil.GetDouble(tmpOther);
				}
            }
        }

		for (i = 42; i< 61; i++)
        {
			if(VB.len(acctdata[i]) > 0 )
            {
				NonFilingCnt = NonFilingCnt + 1;
			}
        }

		if(NonFilingCnt > 0 )
        {
			NonFilingCntStr = NonFilingCnt + " periods";
        }
		else
        {
			NonFilingCntStr = "0 periods";
		}

		dDelinqAmt = CopMvcUtil.GetDouble(VB.FormatCurrency(dDelinqAmt, 2));
		CreditAmt = CopMvcUtil.GetDouble(VB.FormatCurrency(CreditAmt, 2));
%>

<HTML>
<HEAD>
<link rel="stylesheet" TYPE="text/css" href="../Content/Styles/Font.css">
<link rel="stylesheet" TYPE="text/css" href="../Content/Styles/Object.css">
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>

<TITLE></TITLE>
<script ID="clientEventHandlersJS" LANGUAGE="javascript" type="text/javascript">
    var txtHeader = 'Taxpayer Information'


    function Format() {
        var x, int, dec, result, resultOut

        if (event.srcElement.value == '') {
            return
        }

        result = new Array()
        resultOut = new String
        x = new String(event.srcElement.value)


        if (x.slice(0, 1) == '$') {
            x = x.slice(1)
        }

        if (x.indexOf('.') == -1) {
            int = x
            dec = '.00'
        } else {
            int = new String(x.slice(0, x.indexOf('.')))
            dec = new String(x.slice(x.indexOf('.'), x.indexOf('.') + 3))
            if (dec.length < 3) {
                dec = dec + '0'
            }
        }

        var j = 0
        for (i = 0; i < int.length; i++) {
            x = int.slice((int.length - 1 - i), (int.length - i))
            if ((i % 3) == 0 && i != int.length) {
                result[j] = ','
                j++
            }
            result[j] = x
            j++
        }
        result.reverse()

        for (i = 0; i < (result.length - 1) ; i++) {
            resultOut += result[i]
        }

        resultOut = '$' + resultOut + dec
        event.srcElement.value = resultOut
    }

    function showPenalties() {

        if (btnPenaltyDetail.value == 'Details') {
            btnPenaltyDetail.value = '  Hide  '

            divPayment.style.display = 'none'
            divPayment.style.visibility = 'hidden'

            divNonFiled.style.display = 'none'
            divNonFiled.style.visibility = 'hidden'

            divPenalties.style.display = 'block'
            divPenalties.style.visibility = 'visible'
        } else {
            btnPenaltyDetail.value = 'Details'
            btnNonFiledDetail.value = 'Details'

            divPayment.style.display = 'block'
            divPayment.style.visibility = 'visible'
            divPenalties.style.display = 'none'
            divPenalties.style.visibility = 'hidden'
            divNonFiled.style.display = 'none'
            divNonFiled.style.visibility = 'hidden'
        }

    }

    function showNonFiled() {

        if (btnNonFiledDetail.value == 'Details') {
            btnNonFiledDetail.value = '  Hide  '

            divPayment.style.display = 'none'
            divPayment.style.visibility = 'hidden'

            divPenalties.style.display = 'none'
            divPenalties.style.visibility = 'hidden'

            divNonFiled.style.display = 'block'
            divNonFiled.style.visibility = 'visible'
        } else {
            btnNonFiledDetail.value = 'Details'
            btnPenaltyDetail.value = 'Details'

            divNonFiled.style.display = 'none'
            divNonFiled.style.visibility = 'hidden'

            divPenalties.style.display = 'none'
            divPenalties.style.visibility = 'hidden'

            divPayment.style.display = 'block'
            divPayment.style.visibility = 'visible'

        }

    }

    function setInitFocus() {

        parent.NavWin.ClearImages()
        AppHeader.innerHTML = txtHeader + '<Font class=hdrMedium>|e-Check payment</Font>'
        AppError.innerText = ''
        if (DelinqAmt.innerText == '$.00') {
            btnPenaltyDetail.disabled = true
            btnPenaltyDetail.className = 'inpDisabled'
        }		//if
        if (nonFilingCnt.innerText == '0 periods') {
            btnNonFiledDetail.disabled = true
            btnNonFiledDetail.className = 'inpDisabled'
        }		//if
    }		//setInitFocus


    function SubmitPay() {
        parent.DocWin.location.href = '../Acct/ApplyMain'
    }		//SubmitPay


    function isLoaded() {
        if (parent.MenuWin.document.readyState != 'complete' &&
                parent.HeaderWin.document.readyState != 'complete' &&
                parent.NavWin.document.readyState != 'complete') {
            setTimeout('isLoaded()', 100)
        }		//if
    }		//isLoaded

</script>
</HEAD>


<BODY onload='setInitFocus()'>
<% Html.RenderAction("AppHeader", "INC"); %>

<TABLE cellSpacing=0 cellPadding=0 width="95%" border=0 
		style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%">
  <TR>
    <TD width=75%><P class=lblTextBlack>
      Enter the period and amount for each account to pay. After submitting the transaction,
					you are prompted for confirmation.</P></TD>
    <td width=25%></td>
  </TR>
</TABLE>

<TABLE width=95% style="MARGIN-TOP: 10px; MARGIN-LEFT: 4%; BACKGROUND-COLOR: white" 
		cellSpacing=0 cellPadding=0 bgColor=lightgrey border=0>
  <TR>
    <TD style="BORDER-RIGHT: medium none" width ="45%">
      <P class=lblTextBold align=left>Deliquent 
      Periods </P></TD>
    <TD style="BORDER-RIGHT: medium none" width ="10%">
      <P id=DelinqAmt class=lblTextBlack align=right><%= dDelinqAmt %></P></TD>
    <TD style="BORDER-RIGHT: medium none" width="3%">
      <P style="BORDER-RIGHT: medium none" align =center>&nbsp;</P></TD>
    <TD width="7%" >
      <P align=center>
				<INPUT id=btnPenaltyDetail type=button value=Details onclick="showPenalties()"></P></TD>
    <TD width="35%"><P>&nbsp;&nbsp;</P></TD>
      
  </TR>
  
  <TR>
    <TD style="BORDER-RIGHT: medium none" width ="45%">
      <P class=lblTextBold align=left>Non-Filed 
      Periods </P></TD>
    <TD style="BORDER-RIGHT: medium none" width ="10%">
      <P id=nonFilingCnt class=lblTextBlack align=right><%= NonFilingCntStr %></P></TD>
    <TD style="BORDER-RIGHT: medium none" width="3%">
      <P style="BORDER-RIGHT: medium none" align =center>&nbsp;</P></TD>
    <TD width="7%">
      <P align=center>
				<INPUT id=btnNonFiledDetail type=button value=Details name=button3 onclick='showNonFiled()'></P></TD>
  </TR>

</TABLE>

<div id=divPayment style="DISPLAY: block; VISIBILITY: visible">

<TABLE 
style="MARGIN-TOP: 10px; MARGIN-LEFT: 4%" cellSpacing =0 cellPadding=0 width="95%" border=0>
	<tr style="HEIGHT: 0px">
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
  <TR style="MARGIN-BOTTOM: 5px">
    <TD colspan=14 align=left >
      <P class=lblTextBold>&nbsp;Current Periods</P></TD>
  </TR>	
     
  <TR height=25px>
	<TD colspan=5 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-LEFT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center> Account</P></TD>
    <TD colspan=3 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center> Account ID</P></TD>
    
    <TD colspan=3 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: Lightcyan" 
   >
      <P class=lblTextBold colspan="3" align=center 
     >Period</P></TD>
    <TD colspan=3 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center>Amount</P></TD>    
    <TD class=lblTextBold colspan=5><P>&nbsp;</P></TD>
  </TR>

<%
int row = 0, rowCounter = 1;
string rowName="", HoldName= "", AcctName="", AcctID="", TempName="";

for(i = 62; i<81; i++)
{
	if(VB.len(acctdata[i]) > 0)
    {
        switch(VB.mid(acctdata[i],1,3))
        {
			case "WAG":
				AcctName = "Wage";
                break;
			case "NPT":
				AcctName = "Net Profits";
                break;
			case "BPT":
				AcctName = "Business Privilege";
                break;
			case "UOL":
				AcctName = "Use/Occupancy";
                break;
			case "AMU":
				AcctName = "Amusement";
                break;
			case "PRK":
				AcctName = "Parking";
                break;
			case "ERN":
				AcctName = "Earnings";
                break;
			case "SIT":
				AcctName = "School Income";
                break;
			case "HOT":
				AcctName = "Hotel";
                break;
			default:
				AcctName = VB.mid(acctdata[i],1,3);
                break;
		}
        
		AcctID = VB.mid(acctdata[i],4,12);
		
		if(HoldName != AcctName)
        {
			HoldName = AcctName;
			//'HoldID = AcctID
			TempName=AcctName;
			//'TempID=AcctID
		}
		
		row=row+1;
        
		rowName = "Amount" + row;
		if(rowCounter == 1)
        {
			rowCounter = 2;


%>  
  <TR height=20px>
	<TD colspan=5 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-LEFT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: Whitesmoke" >
      <P class=lblTextBlack align=left style="MARGIN-LEFT: 10px"><%= TempName%></P></TD>
    <TD colspan=3 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=center><%= AcctID%></P></TD>
    
    <TD colspan=3 align=center style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: Whitesmoke" width="6%">
      <P class=lblTextBlack ><SELECT id=select1 name=select1 tabindex=0> 
        <OPTION tabindex=0 value=<%= VB.mid(acctdata[i],16,10)%> selected><%= VB.mid(acctdata[i],16,10)%></OPTION></SELECT></P></TD>
    <TD colspan=3 align=center style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=left><INPUT id='<%=rowName%>'  value="" tabindex=<%=row%> maxlength=9 onblur="return Format()"
      style="MARGIN-LEFT: 5px; width: 100%; align=right; TEXT-ALIGN: right"></P></TD>
  </TR>
<%
        }
		else
        {
			rowCounter = 1;
%>
  
  <TR height=20px>
	<TD colspan=5 style="BORDER-RIGHT: black thin solid; BORDER-LEFT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=left style="MARGIN-LEFT: 10px"><%= TempName%></P></TD>
    <TD colspan=3 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=center><%= AcctID%></P></TD>
    
    <TD colspan=3 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=center><SELECT id=select2 name=select2 tabindex=0> 
        <OPTION tabindex=0 value=<%= VB.mid(acctdata[i],16,10)%> selected><%= VB.mid(acctdata[i],16,10)%></OPTION></SELECT></P></TD>
    <TD colspan=3 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=left><INPUT id='Text1' value="" tabindex=<%=row%> maxlength=9 onblur="return Format()"
      style="MARGIN-LEFT: 5px; width: 100%; TEXT-ALIGN: right"></P></TD>
  </TR>
<%
}
}

	TempName="";
}
    %>
  <TR height=40>
  <td colspan=11></td>
	<TD colspan=3 align=middle>
			<%if(row == 0 ) { %>
				<INPUT id=SubmitPay type=button value="Back" name=SubmitPay onclick=SubmitPay()>
			<% } else { %>
				<INPUT id=Button1 type=button value="Submit" name=SubmitPay onclick=SubmitPay()>
			<%}%>
			</TD>
  </TR>
</TABLE>		
<label id=lblCurrPeriods style="DISPLAY: none"><%=row%></label> 
</div>
	
<div id=divPenalties style="DISPLAY: none; VISIBILITY: hidden">

<TABLE 
style="MARGIN-TOP: 10px; MARGIN-LEFT: 4%" cellSpacing =0 cellPadding=0 width="95%" border=0>
	<tr style="HEIGHT: 0px">
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
		
	<TR style="MARGIN-BOTTOM: 5px" height=25px>
    <TD colspan=15 align=left >
      <P class=lblTextBold>&nbsp;Delinquent Periods</P></TD>
  </TR>	
	<TR height=25px>
	<TD nowrap colspan=4 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-LEFT: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan" width="11%">
      <P class=lblTextBold align=center> Account</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center> Account ID</P></TD>
    
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan" 
   >
      <P class=lblTextBold align=center 
     >Period</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center> Principal</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center> Interest</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center> Penalty</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center> Other</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center>Balance</P></TD>    
    <TD colspan=2 class=lblTextBold ><P>&nbsp;</P></TD>
  </TR>
	
	
<%
HoldName = "";
TempName = "";
rowCounter = 1;
for(i = 22; i < 41; i++)
{
//'Response.Write "AcctCurrent[" & i - 62 & "] = '" & acctdata(i) & "'" & vbcrlf
	if(VB.len(acctdata[i]) > 0)
    {
		switch(VB.mid(acctdata[i],1,3))
        {
			case "WAG":
				AcctName = "Wage";
                break;
			case "NPT":
				AcctName = "Net Profits";
                break;
			case "BPT":
				AcctName = "Business Privilege";
                break;
			case "UOL":
				AcctName = "Use/Occupancy";
                break;
			case "AMU":
				AcctName = "Amusement";
                break;
			case "PRK":
				AcctName = "Parking";
                break;
			case "ERN":
				AcctName = "Earnings";
                break;
			case "SIT":
				AcctName = "School Income";
                break;
			case "HOT":
				AcctName = "Hotel";
                break;
			default:
				AcctName = VB.mid(acctdata[i],1,3);
                break;
		}
		
		if(HoldName != AcctName )
        {
			HoldName = AcctName;
			//'HoldID = AcctID
			
			TempName=AcctName;
			//'TempID=AcctID
		}
		
		
		PeriodPrin=0;
        
		if(VB.mid(acctdata[i],26,15) != "")
        {
			PeriodPrin = CopMvcUtil.GetDouble(VB.mid(acctdata[i],26,15));
		}
		
		PeriodInt=0;
		if(VB.mid(acctdata[i],41,15) != "")
        {
			PeriodInt = CopMvcUtil.GetDouble(VB.mid(acctdata[i],41,15));
		}        

		
		PeriodPen=0;
		if(VB.mid(acctdata[i],56,15) != "")
        {
			PeriodPen = CopMvcUtil.GetDouble(VB.mid(acctdata[i],56,15));
		} 
                

		PeriodOther=0;
		if(VB.mid(acctdata[i],71,15) != "")
        {
			PeriodOther = CopMvcUtil.GetDouble(VB.mid(acctdata[i],71,15));
		} 
                

		PeriodBalance = PeriodPrin+PeriodInt+PeriodPen+PeriodOther;
		
		PeriodPrin =CopMvcUtil.GetDouble( VB.FormatCurrency(PeriodPrin,2));
		PeriodInt =  CopMvcUtil.GetDouble(VB.FormatCurrency(PeriodInt,2));
		PeriodPen = CopMvcUtil.GetDouble(VB.FormatCurrency(PeriodPen,2));
		PeriodOther = CopMvcUtil.GetDouble(VB.FormatCurrency(PeriodOther,2));
		PeriodBalance =CopMvcUtil.GetDouble( VB.FormatCurrency(PeriodBalance,2));
		
		if(rowCounter == 1)
        {
			rowCounter = 2;
%>
  
   <TR height=20px>
	<TD nowrap colspan=4 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BORDER-LEFT: black thin solid; BACKGROUND-COLOR: Whitesmoke" width="11%">
      <P class=lblTextBlack align=left><%= TempName%>&nbsp; </P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid;BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=center><%= VB.mid(acctdata[i],4,12)%>&nbsp; </P></TD>
    
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: Whitesmoke" 
   >
      <P class=lblTextBlack align=center 
     >&nbsp;<%= VB.mid(acctdata[i],16,10)%>&nbsp;</P></TD>
    <TD colspan=2  style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=right><%= PeriodPrin%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid;  BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=right><%= PeriodInt%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid;  BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=right><%= PeriodPen%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid;  BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=right><%= PeriodOther%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid;  BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=right><%= PeriodBalance%>&nbsp;</P></TD>    
    <TD colspan=2 class=lblTextBold ><P>&nbsp;</P></TD>
  </TR>
 
<% 
}
		else
        {
			rowCounter = 1;
%> 

	<TR height=20px>
	<TD nowrap colspan=4 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BORDER-LEFT: black thin solid; BACKGROUND-COLOR: #e0e0e0" width="11%">
      <P class=lblTextBlack align=left><%= TempName%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=center><%= VB.mid(acctdata[i],4,12)%>&nbsp;</P></TD>
    
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0" 
   >
      <P class=lblTextBlack align=center 
     >&nbsp;<%= VB.mid(acctdata[i],16,10)%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=right><%= PeriodPrin%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=right><%= PeriodInt%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=right> <%= PeriodPen%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=right><%= PeriodOther%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=right><%= PeriodBalance%>&nbsp;</P></TD>    
    <TD colspan=2 class=lblTextBlack ><P> &nbsp;</P></TD>
  </TR>  
  
<%  }
	}
	TempName="";
    }
	
%>  

</TABLE>
	
</div>

<div id=divNonFiled style="DISPLAY: none; VISIBILITY: hidden">

<TABLE 
style="MARGIN-TOP: 10px; MARGIN-LEFT: 4%" cellSpacing =0 cellPadding=0 width="95%" border=0>
	<tr style="HEIGHT: 0px">
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
		
	<TR height=25px>
    <TD colspan=15 align=left >
      <P class=lblTextBold>&nbsp;Non-Filing Periods</P></TD>
  </TR>	
	<TR height=25px>
	<TD nowrap colspan=4 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-LEFT: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan" width="11%">
      <P class=lblTextBold align=center> Account</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center> Account ID</P></TD>
    
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan" 
   >
      <P class=lblTextBold align=center 
     >Period</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center> Principal</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center> Interest</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center> Penalty</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center> Other</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; BORDER-BOTTOM: black medium solid; BACKGROUND-COLOR: Lightcyan">
      <P class=lblTextBold align=center>Balance</P></TD>    
    <TD colspan=2 class=lblTextBold ><P>&nbsp;</P></TD>
  </TR>
	
	
<%
    
HoldName = "";
TempName = "";
rowCounter = 1;
for(i = 42; i < 61; i++)
{
	if(VB.len(acctdata[i]) > 0)
    {
		switch(VB.mid(acctdata[i],1,3))
        {
			case "WAG":
				AcctName = "Wage";
                break;
			case "NPT":
				AcctName = "Net Profits";
                break;
			case "BPT":
				AcctName = "Business Privilege";
                break;
			case "UOL":
				AcctName = "Use/Occupancy";
                break;
			case "AMU":
				AcctName = "Amusement";
                break;
			case "PRK":
				AcctName = "Parking";
                break;
			case "ERN":
				AcctName = "Earnings";
                break;
			case "SIT":
				AcctName = "School Income";
                break;
			case "HOT":
				AcctName = "Hotel";
                break;
			default:
				AcctName = VB.mid(acctdata[i],1,3);
                break;
		}
		
		if(HoldName != AcctName )
        {
			HoldName = AcctName;
			TempName=AcctName;
		}
		
		
		PeriodPrin=0;
		if(VB.mid(acctdata[i],26,15) != "")
        {
			PeriodPrin = CopMvcUtil.GetDouble(VB.mid(acctdata[i],26,15));
		}
		
		PeriodInt=0;
		if(VB.mid(acctdata[i],41,15) != "")
        {
			PeriodInt = CopMvcUtil.GetDouble(VB.mid(acctdata[i],41,15));
		}        

		
		PeriodPen=0;
		if(VB.mid(acctdata[i],56,15) != "")
        {
			PeriodPen = CopMvcUtil.GetDouble(VB.mid(acctdata[i],56,15));
		} 
                

		PeriodOther=0;
		if(VB.mid(acctdata[i],71,15) != "")
        {
			PeriodOther = CopMvcUtil.GetDouble(VB.mid(acctdata[i],71,15));
		} 
                

		PeriodBalance = PeriodPrin+PeriodInt+PeriodPen+PeriodOther;
		
		PeriodPrin =CopMvcUtil.GetDouble( VB.FormatCurrency(PeriodPrin,2));
		PeriodInt =  CopMvcUtil.GetDouble(VB.FormatCurrency(PeriodInt,2));
		PeriodPen = CopMvcUtil.GetDouble(VB.FormatCurrency(PeriodPen,2));
		PeriodOther = CopMvcUtil.GetDouble(VB.FormatCurrency(PeriodOther,2));
		PeriodBalance =CopMvcUtil.GetDouble( VB.FormatCurrency(PeriodBalance,2));
		
		if(rowCounter == 1)
        {
			rowCounter = 2;
            


		PeriodBalance = PeriodPrin+PeriodInt+PeriodPen+PeriodOther;
		
		PeriodPrin =CopMvcUtil.GetDouble( VB.FormatCurrency(PeriodPrin,2));
		PeriodInt =  CopMvcUtil.GetDouble(VB.FormatCurrency(PeriodInt,2));
		PeriodPen = CopMvcUtil.GetDouble(VB.FormatCurrency(PeriodPen,2));
		PeriodOther = CopMvcUtil.GetDouble(VB.FormatCurrency(PeriodOther,2));
		PeriodBalance =CopMvcUtil.GetDouble( VB.FormatCurrency(PeriodBalance,2));
		
		if(rowCounter == 1 )
        {
			rowCounter = 2;
%>
  
   <TR height=20px>
	<TD nowrap colspan=4 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BORDER-LEFT: black thin solid; BACKGROUND-COLOR: Whitesmoke" width="11%">
      <P class=lblTextBlack align=left><%= TempName%>&nbsp; </P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid;BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=center><%= VB.mid(acctdata[i],4,12)%>&nbsp; </P></TD>
    
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: Whitesmoke" 
   >
      <P class=lblTextBlack align=center 
     >&nbsp;<%= VB.mid(acctdata[i],16,10)%>&nbsp;</P></TD>
    <TD colspan=2  style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=right><%= PeriodPrin%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid;  BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=right><%= PeriodInt%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid;  BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=right><%= PeriodPen%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid;  BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=right><%= PeriodOther%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid;  BACKGROUND-COLOR: Whitesmoke">
      <P class=lblTextBlack align=right><%= PeriodBalance%>&nbsp;</P></TD>    
    <TD colspan=2 class=lblTextBold ><P>&nbsp;</P></TD>
  </TR>
 
<% 
}
		else
        {
			rowCounter = 1;
%> 

	<TR height=20px>
	<TD nowrap colspan=4 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BORDER-LEFT: black thin solid; BACKGROUND-COLOR: #e0e0e0" width="11%">
      <P class=lblTextBlack align=left><%= TempName%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=center><%= VB.mid(acctdata[i],4,12)%>&nbsp;</P></TD>
    
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0" 
   >
      <P class=lblTextBlack align=center 
     >&nbsp;<%= VB.mid(acctdata[i],16,10)%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=right><%= PeriodPrin%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=right><%= PeriodInt%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=right> <%= PeriodPen%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=right><%= PeriodOther%>&nbsp;</P></TD>
    <TD colspan=2 style="BORDER-RIGHT: black thin solid; BORDER-BOTTOM: black thin solid; BACKGROUND-COLOR: #e0e0e0">
      <P class=lblTextBlack align=right><%= PeriodBalance%>&nbsp;</P></TD>    
    <TD colspan=2 class=lblTextBlack ><P> &nbsp;</P></TD>
  </TR>  
  
<%}
  }
	TempName="";
    }
	
    }
%>  
</TABLE>
</div>
</BODY>
</HTML>

