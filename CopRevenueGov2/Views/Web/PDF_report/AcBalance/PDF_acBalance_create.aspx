<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.IO" %>

<script runat="server">

CopMvcUtil util = new CopMvcUtil();
RevFuncSrv rev_func_srv = new RevFuncSrv();
FuncSrv func_srv = new FuncSrv();
XMLUtil xmlProc = new XMLUtil();
string sPath= string.Empty; 
string sPayCouponTemplate = string.Empty;
string msCouponPath = string.Empty;
string msApp= string.Empty;
XmlDocument xmlReqDoc = new XmlDocument();
XmlDocument xmlOut = new XmlDocument();
XmlDocument xmlTmplDoc = new XmlDocument();
CString gsDebug = string.Empty;

string strAddressesStr;
string [] strAddresses;
string[] var_tax_type; 
string all_tax_type;

ArrayList arrSample = new ArrayList();




#region AcBalance
string tax_typeValue = "";
StringBuilder sb = new StringBuilder();

string sTaxValue = string.Empty;
string sTaxTypeValue = string.Empty;
int iTaxColumn = 8;
string[,] arr2D_Tax = null;

string[,] arr2D_BusinessTax = null;
string[,] arr2D_WageTax = null;
string[,] arr2D_EarningsTax = null;
string[,] arr2D_NetProfitTax = null;

// New 2D Arrays
string[,] arr2D_SchoolIncomeTax = null;
string[,] arr2D_TobaccoTax = null;
string[,] arr2D_UandO_LandlordTax = null;
string[,] arr2D_UandO_TenantTax = null;

string sBusinessTaxHTML = string.Empty;
string sWageTaxHTML = string.Empty;
string sEarningsTaxHTML = string.Empty;
string sNetProfitTaxHTML = string.Empty;

// New TaxHTMLs
string sSchoolIncomeTaxHTML = string.Empty;
string sTobaccoTaxHTML = string.Empty;
string sUandO_LandlordTaxHTML = string.Empty;
string sUandO_TenantTaxHTML = string.Empty;
#endregion

string var_ACC_ID, var_EntityAccountID, var_EntityId, var_EntityType, var_ent_name, var_ent_add;       
    
void OpenPayCouponTemplate()
{
    sPath = Server.MapPath("~");

    //Set fso = Server.CreateObject("Scripting.FileSystemObject")
    using (StreamReader st = File.OpenText(sPath + @"\Views\web\PDF_report\AcBalance\2015.htm"))
    {
        sPayCouponTemplate = st.ReadToEnd();
    }
    //

    sPayCouponTemplate = sPayCouponTemplate.Replace("{name}", var_ent_name); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ssn_label}",var_EntityType);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{account_id}", var_EntityAccountID);


    sPayCouponTemplate = sPayCouponTemplate.Replace("{ssn_value}", var_EntityId); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{address}", var_ent_add); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))

   //
    //var_tax_type = all_tax_type.Split(',');


    sPayCouponTemplate = sPayCouponTemplate.Replace("{sch_div_strt}", sb.ToString());
    ////sPayCouponTemplate = sPayCouponTemplate.Replace("{PREPARER_EMAIL_ADDRESS}", var_PREPARER_EMAIL_ADDRESS);



    //TempDate = datepart("yyyy", Now) & datepart("m", Now) & datepart("d", Now) & datepart("h", Now) & datepart("m", Now) & datepart("s", Now)

    CString TempDate = DateTime.Now.Year.ToString();
    TempDate += DateTime.Now.Month.ToString();
    TempDate += DateTime.Now.Day.ToString();
    TempDate += DateTime.Now.Hour.ToString();
    TempDate += DateTime.Now.Minute.ToString();
    TempDate += DateTime.Now.Second.ToString();


    string sTmpPayCoup = Session.SessionID + "_" + TempDate;

    using (StreamWriter st = File.CreateText(msCouponPath + sTmpPayCoup + ".htm"))
    {
        st.WriteLine(sPayCouponTemplate);
        st.Close();
    }


    string sFileHTM = msCouponPath + sTmpPayCoup + ".htm";
    string sFilePDF = string.Empty;
    sFilePDF = msCouponPath + sTmpPayCoup + ".pdf";
    try
    {
        CopMvcPDFUtil HTMConverter = new CopMvcPDFUtil();
        HTMConverter.PdfFilePath = msCouponPath + sTmpPayCoup + ".pdf";
        HTMConverter.HtmlFilePath = sFileHTM;
        HTMConverter.OptionsString = "-nocenter -width 612 -height 792 -margin 0x0x0x0";
        HTMConverter.CallVeryPDF();
    }
    catch (Exception ex)
    {
        using (StreamWriter st = File.CreateText("CreateImage Error 2 - "))
        {
            st.WriteLine(ex.Message + ex.StackTrace + VB.vbcrlf);
            st.Close();
        }
    }

    File.Delete(sFileHTM);
    string sPayCouponDisplay = string.Empty;

    ClientScript.RegisterStartupScript(GetType(), "id", "schA_temp()", true);

    ////System.Diagnostics.Process.Start(sFilePDF);

    //string s = "window.open('2015.htm', 'popup_window', 'width=300,height=100,left=100,top=100,resizable=yes');";
    //ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);

    //using (StreamReader st = File.OpenText(sPath + @"\Views\web\paycoupon\PDFCouponDisplay.htm"))
    using (StreamReader st = File.OpenText(sPath + @" \Views\web\PDF_report\PDFDisplay.htm"))
    {

        sPayCouponDisplay = st.ReadToEnd();
        st.Close();
    }

    sPayCouponDisplay = sPayCouponDisplay.Replace("{PDFFILE}", @"..\CouponImages\" + sTmpPayCoup + ".pdf");
    Response.Write(VB.mid(sPayCouponDisplay, 4));
   
}

//////void  PopulateAccountInfo(string sPOBox, string SAccountName, string sPhone)
//////{
//////    sPayCouponTemplate = sPayCouponTemplate.Replace("{BOX}", sPOBox);               //Replace(sPayCouponTemplate, "{BOX}", sPOBox)
//////    sPayCouponTemplate = sPayCouponTemplate.Replace("{AcctID}",SAccountName);       //Replace(sPayCouponTemplate, "{AcctID}", SAccountName)
//////    sPayCouponTemplate = sPayCouponTemplate.Replace("{PHONE}", " (215) " + sPhone); //Replace(sPayCouponTemplate, "{PHONE}", " (215) " & SPhone)
//////}

string ispProperCase(string val)
{
    string sTng;
    string [] vTmp;
    
    int i=0;
	
	if(val == "" )
    {
		sTng = val;
    }
	else
    {
		vTmp = val.Split(' ');
		sTng =  VB.Left(vTmp[0], 1).ToUpper();//  Ucase(left(Vtmp(0),1))
        
		if(vTmp[0].Length > 1 )
        {
			sTng = sTng + VB.mid(vTmp[0],2).ToLower();  //LCase(mid(vTmp(0),2))
		}
		
		for(i = 0; i < vTmp.Length; i++)
        {
			sTng = sTng + " " +  VB.mid(vTmp[i],1).ToUpper();  //    Ucase(left(vTmp(i),1))
			if(vTmp[i].Length > 1 )
            {
				sTng = sTng + VB.mid(vTmp[i],2).ToLower(); //LCase(Mid(vTmp(i),2))
			}
        }	
			
    }

    return sTng;
	
}

#region function_acBalance

private List<int> CollectAllIndexes(string sMainString, string sPipeString)
{
    List<int> iArrIndexes = new List<int>();

    int iPipeIndex = 0;
    while ((iPipeIndex < sMainString.Length) && (iPipeIndex = sMainString.IndexOf(sPipeString, iPipeIndex)) != -1)
    {
        iArrIndexes.Add(iPipeIndex);
        iPipeIndex += sPipeString.Length;
    }

    return iArrIndexes;
}

private void GenerateTaxHTMLFromIndex(string sMainString, List<int> iAllPipeIndexes)
{
    int iPipeIndex = 0;
    int iStartPipeIndex = 0;
    int iNextPipeIndex = 0;
    int iCutOutLength = 0;

    for (int iIndex = 0; iIndex <= iAllPipeIndexes.Count; iIndex++)
    {
        switch (iIndex)
        {
            case 0:
                iPipeIndex = iAllPipeIndexes[iIndex];

                if (sMainString.StartsWith("||"))
                {
                    iStartPipeIndex = iPipeIndex + 2;
                    iNextPipeIndex = iAllPipeIndexes[iIndex + 1];
                    iCutOutLength = iNextPipeIndex - iStartPipeIndex;
                    sTaxValue = sMainString.Substring(iStartPipeIndex, iCutOutLength);
                }
                else
                    sTaxValue = sMainString.Substring(0, iPipeIndex);
                break;

            default:
                iStartPipeIndex = iAllPipeIndexes[iIndex - 1] + 2;

                if (iIndex == iAllPipeIndexes.Count)
                    sTaxValue = sMainString.Substring(iStartPipeIndex);
                else
                {
                    iNextPipeIndex = iAllPipeIndexes[iIndex];
                    iCutOutLength = iNextPipeIndex - iStartPipeIndex;
                    sTaxValue = sMainString.Substring(iStartPipeIndex, iCutOutLength);
                }
                break;
        }

        PopulateTaxHTML(sTaxValue);
    }
}

private void PopulateTaxHTML(string sDynamicValue)
{
    int iTaxRow = GetTaxRows(sDynamicValue);
    PopulateTax2D(sDynamicValue, iTaxRow);
    sTaxTypeValue = sDynamicValue.Substring(0, 3);

    switch (sTaxTypeValue)
    {
        case "024":
            arr2D_BusinessTax = arr2D_Tax;
            sBusinessTaxHTML += GenerateTaxHTML(arr2D_BusinessTax, iTaxRow);
            break;

        case "001":
            arr2D_WageTax = arr2D_Tax;
            sWageTaxHTML += GenerateTaxHTML(arr2D_WageTax, iTaxRow);
            break;

        case "002":
            arr2D_EarningsTax = arr2D_Tax;
            sEarningsTaxHTML += GenerateTaxHTML(arr2D_EarningsTax, iTaxRow);
            break;

        case "003":
            arr2D_NetProfitTax = arr2D_Tax;
            sNetProfitTaxHTML += GenerateTaxHTML(arr2D_NetProfitTax, iTaxRow);
            break;

        //New Tax Cases
        case "027":
            arr2D_TobaccoTax = arr2D_Tax;
            sTobaccoTaxHTML += GenerateTaxHTML(arr2D_TobaccoTax, iTaxRow);
            break;

        case "029":
            arr2D_SchoolIncomeTax = arr2D_Tax;
            sSchoolIncomeTaxHTML += GenerateTaxHTML(arr2D_SchoolIncomeTax, iTaxRow);
            break;

        case "084":
            arr2D_UandO_LandlordTax = arr2D_Tax;
            sUandO_LandlordTaxHTML += GenerateTaxHTML(arr2D_UandO_LandlordTax, iTaxRow);
            break;

        case "085":
            arr2D_UandO_TenantTax = arr2D_Tax;
            sUandO_TenantTaxHTML += GenerateTaxHTML(arr2D_UandO_TenantTax, iTaxRow);
            break;
    }
}

private int GetTaxRows(string sTax)
{
    int iArrTaxLength = 0;
    int iTaxRow = 0;
    string[] arrTax = null;

    sTax = sTax.Replace("/*/", ",");
    arrTax = sTax.Split(',');

    iArrTaxLength = arrTax.Length;
    iTaxRow = (iArrTaxLength - 1) / iTaxColumn;

    return iTaxRow;
}

private string[,] PopulateTax2D(string sTax, int iTaxRow)
{
    int iTaxIndex = 1;

    string[] arrTax = null;

    sTax = sTax.Replace("/*/", ",");
    arrTax = sTax.Split(',');

    arr2D_Tax = new string[iTaxRow, iTaxColumn];

    for (int iRow = 0; iRow < iTaxRow; iRow++)
    {
        for (int iColumn = 0; iColumn < iTaxColumn; iColumn++)
        {
            arr2D_Tax[iRow, iColumn] = arrTax[iTaxIndex];
            iTaxIndex++;
        }
    }

    return arr2D_Tax;
}

private bool IsAllAlphabetic(string value)
{
    foreach (char c in value)
    {
        if (!char.IsLetter(c))
            return false;
    }

    return true;
}

private string GenerateTaxHTML(string[,] sTax2D, int iTaxRow)
{
    string sTaxHTML = string.Empty;

    for (int iRow = 0; iRow < iTaxRow; iRow++)
    {
        sTaxHTML += "<tr>";

        for (int iColumn = 0; iColumn < iTaxColumn; iColumn++)
        {
            if (IsAllAlphabetic(sTax2D[iRow, iColumn])
                || sTax2D[iRow, iColumn].Contains("/"))
                sTaxHTML += "<td align='center'>";
            else
            {
                sTaxHTML += "<td align='right'>";

                sTax2D[iRow, iColumn] = sTax2D[iRow, iColumn].Replace("$", "");
                sTax2D[iRow, iColumn] = String.Format("{0:n}", Convert.ToDouble(sTax2D[iRow, iColumn]));
                sTax2D[iRow, iColumn] = "$&nbsp;" + sTax2D[iRow, iColumn];
            }

            sTaxHTML += sTax2D[iRow, iColumn];
            sTaxHTML += "&nbsp;&nbsp;</td>";
        }

        sTaxHTML += "</tr>";
    }

    return sTaxHTML;
}

private string CommonHeight()
{
    string sCommonHeight = string.Empty;

    sCommonHeight += "<tr style=\"height: .45in\">";
    sCommonHeight += "<td colspan=\"8\">&nbsp;</td>";
    sCommonHeight += "</tr>";

    return sCommonHeight;
}

private string CommonHeaders()
{
    string sCommonHeaders = string.Empty;

    sCommonHeaders += "<tr>";
    sCommonHeaders += "<td colspan=\"8\" bgcolor='lightgrey'>&nbsp;&nbsp;Payment Type";
    sCommonHeaders += "</td>";
    sCommonHeaders += "</tr>";

    sCommonHeaders += "<tr>";
    sCommonHeaders += "<td align='center'>Payment Type</td>";
    sCommonHeaders += "<td align='center'>Period</td>";
    sCommonHeaders += "<td align='center'>Principal</td>";
    sCommonHeaders += "<td align='center'>Interest</td>";
    sCommonHeaders += "<td align='center'>Penalty</td>";
    sCommonHeaders += "<td align='center'>Other</td>";
    sCommonHeaders += "<td align='center'>Balance</td>";
    sCommonHeaders += "<td align='center'>Payment</td>";
    sCommonHeaders += "</tr>";

    return sCommonHeaders;
}
private string schA_temp()
{
    if (tax_typeValue.Contains("||"))
    {
        List<int> iAllPipeIndices = CollectAllIndexes(tax_typeValue, "||");
        GenerateTaxHTMLFromIndex(tax_typeValue, iAllPipeIndices);
    }
    else
        PopulateTaxHTML(tax_typeValue);
    
    sb.Append("<div id =\"schB\">");
    sb.Append("<table cellpadding=\"0\" cellspacing=\"0\" style=\"width:100%;\" border=\"1\">");

    if (!sBusinessTaxHTML.Equals(string.Empty))
    {
        sb.Append(CommonHeight());

        sb.Append("<tr>");
        sb.Append("<td colspan=\"8\"><strong>&nbsp;&nbsp;Business Income and Receipt Tax </strong>");
        sb.Append("</td>");
        sb.Append("</tr>");

        sb.Append(CommonHeaders());
        sb.Append(sBusinessTaxHTML);
    }

    if (!sWageTaxHTML.Equals(string.Empty))
    {
        sb.Append(CommonHeight());

        sb.Append("<tr>");
        sb.Append("<td colspan=\"8\"><strong>&nbsp;&nbsp;Wage Tax </strong>");
        sb.Append("</td>");
        sb.Append("</tr>");

        sb.Append(CommonHeaders());
        sb.Append(sWageTaxHTML);
    }

    if (!sEarningsTaxHTML.Equals(string.Empty))
    {
        sb.Append(CommonHeight());

        sb.Append("<tr>");
        sb.Append("<td colspan=\"8\"><strong>&nbsp;&nbsp;Earnings Tax </strong>");
        sb.Append("</td>");
        sb.Append("</tr>");

        sb.Append(CommonHeaders());
        sb.Append(sEarningsTaxHTML);
    }

    if (!sNetProfitTaxHTML.Equals(string.Empty))
    {
        sb.Append(CommonHeight());

        sb.Append("<tr>");
        sb.Append("<td colspan=\"8\"><strong>&nbsp;&nbsp;Net Profit Tax </strong>");
        sb.Append("</td>");
        sb.Append("</tr>");

        sb.Append(CommonHeaders());
        sb.Append(sNetProfitTaxHTML);
    }

    //New TaxHTMLs 
    if (!sTobaccoTaxHTML.Equals(string.Empty))
    {
        sb.Append(CommonHeight());

        sb.Append("<tr>");
        sb.Append("<td colspan=\"8\"><strong>&nbsp;&nbsp;Tobacco Tax </strong>");
        sb.Append("</td>");
        sb.Append("</tr>");

        sb.Append(CommonHeaders());
        sb.Append(sTobaccoTaxHTML);
    }

    if (!sSchoolIncomeTaxHTML.Equals(string.Empty))
    {
        sb.Append(CommonHeight());

        sb.Append("<tr>");
        sb.Append("<td colspan=\"8\"><strong>&nbsp;&nbsp;School Income Tax </strong>");
        sb.Append("</td>");
        sb.Append("</tr>");
        sb.Append("<tr>");

        sb.Append(CommonHeaders());
        sb.Append(sSchoolIncomeTaxHTML);
    }

    if (!sUandO_LandlordTaxHTML.Equals(string.Empty))
    {
        sb.Append(CommonHeight());

        sb.Append("<tr>");
        sb.Append("<td colspan=\"8\"><strong>&nbsp;&nbsp;U&O Tax - Landlord </strong>");
        sb.Append("</td>");
        sb.Append("</tr>");

        sb.Append(CommonHeaders());
        sb.Append(sUandO_LandlordTaxHTML);
    }

    if (!sUandO_TenantTaxHTML.Equals(string.Empty))
    {
        sb.Append(CommonHeight());

        sb.Append("<tr>");
        sb.Append("<td colspan=\"8\"><strong>&nbsp;&nbsp;U&O Tax - Tenant </strong>");
        sb.Append("</td>");
        sb.Append("</tr>");

        sb.Append(CommonHeaders());
        sb.Append(sUandO_TenantTaxHTML);
    }

    sb.Append("</table>");
    sb.Append("</div>");

    return sb.ToString();
}
#endregion




</script>


<%

	Response.CacheControl = "no-cache";
	Response.AddHeader("Pragma", "no-cache");
	Response.Expires = 0;
	Response.ContentType = "text/html";

    msApp = "CC";
    msCouponPath = COPPaths.COUPON_PATH;
    
   


    all_tax_type            = CopQueryString.GetString("tax_type");
    var_ACC_ID              = CopQueryString.GetString("var_ACC_ID");
    var_EntityAccountID     = CopQueryString.GetString("var_EntityAccountID");
    var_EntityId            = CopQueryString.GetString("var_EntityId");
    var_EntityType          = CopQueryString.GetString("var_EntityType");
    var_ent_name            = CopQueryString.GetString("var_ent_name");
    var_ent_add             = CopQueryString.GetString("var_ent_add");
    //tax_type                = CopQueryString.GetString("tax_type");
    tax_typeValue           = CopQueryString.GetString("tax_typeValue");
    
    schA_temp();
    OpenPayCouponTemplate();
    
    //Delete all coupon files associate with this session
    //Set fso = Server.CreateObject("Scripting.FileSystemObject")


    DirectoryInfo Folder = new DirectoryInfo(COPPaths.COUPON_PATH); 
    DateTime qDate = DateTime.Now.AddHours(-1);
    int iCounter=0;
    if(Folder.Exists == false)
    {
        Folder.Create();
    }
    
    foreach(FileInfo i in Folder.GetFiles())
    {
	    iCounter = iCounter + 1;
    
	    if(i.LastWriteTime <= qDate)
        {
            File.Delete(COPPaths.COUPON_PATH + i.Name);
	    }
	    if(iCounter == 21 )
        {
		    break;
        }
    }


%>
