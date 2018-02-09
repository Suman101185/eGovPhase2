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

string strAddressesStr;
string [] strAddresses;

string var_NET_INCOME, var_GROSS_RECEIPTS, var_TAX_DUE, var_ESTIMATED_TAX, var_TOTAL_TAX, var_NPT_TAX_CREDIT;
string var_BPT_TAX_CREDIT, var_TOTAL_PAY_CREDITS, var_NET_TAX, var_INTEREST_PENALTY, var_AMOUNT_OWED, var_REFUND, var_NPT_OVERPAY, var_BPT_OVERPAY;

string var_name, var_ein_ssn_label, var_ein_ssn_value, var_address, var_year, var_rate, var_acc_id;
string var_PREPARER_NAME, var_PREPARER_PHONE, var_PREPARER_PHONE_EXT, var_PREPARER_EMAIL_ADDRESS, var_PREPARER_WHO;
//Schedule A
string var_A_NI_LOSS, var_A_NI_PORT_ACTIVITIES, var_A_NI_PUC_ICC, var_A_NI_PUBLIC_LAW, var_A_ADJUSTED_NET_INCOME, var_A_TOTAL_NONBUS_INCOMES, var_A_I_APPORTIONED,
       var_A_I_APPORTIONED_PERCENT, var_A_I_APPORTIONED_PHILA, var_A_I_NONBUS_PHILA, var_A_I_CURRENT_YEAR, var_A_NET_DEDUCTION_A, var_A_LOSS_CARRY_FORWARD,
       var_A_I_TAXABLE, var_TAX_DUE_A; 
//schedule B
string var_NI_LOSS, var_ADJ_NI_INTEREST, var_ADJ_NI_PORT_ACTIVITIES, var_ADJ_NI_PUC_ICC, var_ADJ_NI_PUBLIC_LAW, var_ADJ_RECEIPTS_DIR, var_ADJ_INCOME, var_ADJ_RECEIPTS_OTHER, var_ADJ_GROSS_RECEIPTS,
var_ADJ_GROSS_PERCENT, var_ADJ_TOTAL, var_NI_ADJUSTED, var_I_NONBUS, var_I_APPORTIONED, var_I_APPORTIONED_PHILA, var_I_NONBUS_PHILA, var_I_CURRENT_YEAR, var_STAT_NET_DEDUCTION_B_X,
var_LOSS_CARRY_FORWARD, var_I_TAXABLE, var_schB_TAX_DUE;
//Schedule C
String var_c1, var_c2, var_c3;
//Schedule D
String GR_SALES, GR_SERVICES, GR_RENTALS, GR_TOTALS, LE_SALES_OUT, LE_SERVICES_OUT, LE_RENTALS_OUT, LE_OTHER, NET_TAXABLE_RECEIPTS_BEFORE, STAT_EXCLUSION_D_X,
NET_TAXABLE_RECEIPTS_AFTER, RECEIPTS_ALTERNATIVE_METHOD, RECEIPTS_REGULAR_RATE, TAX_DUE, TAX_DUE_ALT, d_TOTAL_TAX_DUE;
//Schedule E
string M_ALT_RECEIPTS, M_GOODS_COST, M_TAX_BASE, M_TAX_DUE, W_ALT_RECEIPTS, W_GOODS_MATERIALS, W_GOODS_LABOR, W_GOODS_COST, W_TAX_BASE, W_TAX_DUE, R_ALT_RECEIPTS, R_GOODS_MATERIALS,
 R_GOODS_LABOR, R_GOODS_COST, R_TAX_BASE, R_TAX_DUE, e_TOTAL_TAX_DUE;
 //check schA or SchB
string var_sch_ind;
StringBuilder sb = new StringBuilder();
    
void OpenPayCouponTemplate()
{
   
	sPath = Server.MapPath("~");
    
	//Set fso = Server.CreateObject("Scripting.FileSystemObject")
    using (StreamReader st = File.OpenText(sPath + @"\Views\web\PDF_report\BPTLF\BPTLF.htm"))
    {
	    sPayCouponTemplate =  st.ReadToEnd();
    }
    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{name}", var_name); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ssn_label}", var_ein_ssn_label);

    sPayCouponTemplate = sPayCouponTemplate.Replace("{ssn_value}", var_ein_ssn_value); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{address}", var_address);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{acc_id}", var_acc_id);
    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NET_INCOME}", var_NET_INCOME);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{GROSS_RECEIPTS}", var_GROSS_RECEIPTS);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TAX_DUE}", var_TAX_DUE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ESTIMATED_TAX}", var_ESTIMATED_TAX);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_TAX}", var_TOTAL_TAX);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NPT_TAX_CREDIT}", var_NPT_TAX_CREDIT);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{BPT_TAX_CREDIT}", var_BPT_TAX_CREDIT);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_PAY_CREDITS}", var_TOTAL_PAY_CREDITS);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NET_TAX}", var_NET_TAX);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{INTEREST_PENALTY}", var_INTEREST_PENALTY);

    sPayCouponTemplate = sPayCouponTemplate.Replace("{AMOUNT_OWED}", var_AMOUNT_OWED);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{REFUND}", var_REFUND);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NPT_OVERPAY}", var_NPT_OVERPAY);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{BPT_OVERPAY}", var_BPT_OVERPAY);
    //Check and print //Schedule B or Schedule A
    sPayCouponTemplate = sPayCouponTemplate.Replace("{sch_div_strt}", sb.ToString()); 
    ////Schedule B
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{NI_LOSS}", var_NI_LOSS);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{ADJ_NI_INTEREST}", var_ADJ_NI_INTEREST);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{ADJ_NI_PORT_ACTIVITIES}", var_ADJ_NI_PORT_ACTIVITIES);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{ADJ_NI_PUC_ICC}", var_ADJ_NI_PUC_ICC);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{ADJ_NI_PUBLIC_LAW}", var_ADJ_NI_PUBLIC_LAW);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{ADJ_RECEIPTS_DIR}", var_ADJ_RECEIPTS_DIR);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{ADJ_INCOME}", var_ADJ_INCOME);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{ADJ_RECEIPTS_OTHER}", var_ADJ_RECEIPTS_OTHER);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{ADJ_GROSS_RECEIPTS}", var_ADJ_GROSS_RECEIPTS);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{ADJ_GROSS_PERCENT}", var_ADJ_GROSS_PERCENT);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{ADJ_TOTAL}", var_ADJ_TOTAL);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{NI_ADJUSTED}", var_NI_ADJUSTED);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{I_NONBUS}", var_I_NONBUS);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{I_APPORTIONED}", var_I_APPORTIONED);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{I_APPORTIONED_PERCENT}", var_I_APPORTIONED_PHILA);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{I_APPORTIONED_PHILA}", var_I_NONBUS_PHILA);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{I_NONBUS_PHILA}", var_I_NONBUS_PHILA);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{I_CURRENT_YEAR}", var_I_CURRENT_YEAR);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{STAT_NET_DEDUCTION_B_X}", var_STAT_NET_DEDUCTION_B_X);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{LOSS_CARRY_FORWARD}", var_LOSS_CARRY_FORWARD);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{I_TAXABLE}", var_I_TAXABLE);
    //sPayCouponTemplate = sPayCouponTemplate.Replace("{TAX_DUE}", var_schB_TAX_DUE);
    //Schedule C
    sPayCouponTemplate = sPayCouponTemplate.Replace("{c1}", var_c1);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{c2}", var_c2);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{c3}", var_c3);
    //Schedule D
    sPayCouponTemplate = sPayCouponTemplate.Replace("{GR_SALES}", GR_SALES);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{GR_SERVICES}", GR_SERVICES);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{GR_RENTALS}", GR_RENTALS);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{GR_TOTALS}", GR_TOTALS);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{LE_SALES_OUT}", LE_SALES_OUT);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{LE_SERVICES_OUT}", LE_SERVICES_OUT);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{LE_RENTALS_OUT}", LE_RENTALS_OUT);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{LE_OTHER}", LE_OTHER);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NET_TAXABLE_RECEIPTS_BEFORE}", NET_TAXABLE_RECEIPTS_BEFORE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{STAT_EXCLUSION_D_X}", STAT_EXCLUSION_D_X);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NET_TAXABLE_RECEIPTS_AFTER}", NET_TAXABLE_RECEIPTS_AFTER);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{RECEIPTS_ALTERNATIVE_METHOD}", RECEIPTS_ALTERNATIVE_METHOD);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{RECEIPTS_REGULAR_RATE}", RECEIPTS_REGULAR_RATE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TAX_DUE}", TAX_DUE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TAX_DUE_ALT}", TAX_DUE_ALT);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_TAX_DUE}", d_TOTAL_TAX_DUE);
    //Schedule E
    sPayCouponTemplate = sPayCouponTemplate.Replace("{M_ALT_RECEIPTS}", M_ALT_RECEIPTS);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{M_GOODS_COST}", M_GOODS_COST);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{M_TAX_BASE}", M_TAX_BASE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{M_TAX_DUE}", M_TAX_DUE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{W_ALT_RECEIPTS}", W_ALT_RECEIPTS);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{W_GOODS_MATERIALS}", W_GOODS_MATERIALS);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{W_GOODS_LABOR}", W_GOODS_LABOR);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{W_GOODS_COST}", W_GOODS_COST);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{W_TAX_BASE}", W_TAX_BASE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{W_TAX_DUE}", W_TAX_DUE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{R_ALT_RECEIPTS}", R_ALT_RECEIPTS);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{R_GOODS_MATERIALS}", R_GOODS_MATERIALS);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{R_GOODS_LABOR}", R_GOODS_LABOR);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{R_GOODS_COST}", R_GOODS_COST);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{R_TAX_BASE}", R_TAX_BASE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{R_TAX_DUE}", R_TAX_DUE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_TAX_DUE}", e_TOTAL_TAX_DUE);
    //    
    sPayCouponTemplate = sPayCouponTemplate.Replace("{year}", var_year);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{rate}", var_rate);
    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PREPARER_WHO}", var_PREPARER_WHO);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PREPARER_NAME}", var_PREPARER_NAME);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PREPARER_PHONE}", var_PREPARER_PHONE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PREPARER_PHONE_EXT}", var_PREPARER_PHONE_EXT);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PREPARER_EMAIL_ADDRESS}", var_PREPARER_EMAIL_ADDRESS);
	

	//TempDate = datepart("yyyy", Now) & datepart("m", Now) & datepart("d", Now) & datepart("h", Now) & datepart("m", Now) & datepart("s", Now)
        
    CString TempDate = DateTime.Now.Year.ToString();
    TempDate += DateTime.Now.Month.ToString();
    TempDate += DateTime.Now.Day.ToString();
    TempDate += DateTime.Now.Hour.ToString();
    TempDate += DateTime.Now.Minute.ToString();
    TempDate += DateTime.Now.Second.ToString();
    
        
	string sTmpPayCoup =  Session.SessionID + "_" + TempDate;
	
    using(StreamWriter st = File.CreateText(msCouponPath + sTmpPayCoup + ".htm"))
    {
	    st.WriteLine(sPayCouponTemplate );
        st.Close();
    }
     
   
    string sFileHTM = msCouponPath + sTmpPayCoup + ".htm";
    string sFilePDF = string.Empty;
    sFilePDF = msCouponPath + sTmpPayCoup + ".pdf";
    try
    {
        CopMvcPDFUtil HTMConverter = new CopMvcPDFUtil();
        HTMConverter.PdfFilePath = msCouponPath + sTmpPayCoup + ".pdf";
        HTMConverter.HtmlFilePath= sFileHTM;
        HTMConverter.OptionsString = "-nocenter -width 612 -height 792 -margin 0x0x0x0";
        HTMConverter.CallVeryPDF();
    }
    catch(Exception ex)
    {
        using(StreamWriter st = File.CreateText("CreateImage Error 2 - "))
        {
	        st.WriteLine( ex.Message + ex.StackTrace + VB.vbcrlf );
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

string schA_temp()
{
    if (Convert.ToInt16(var_sch_ind) > 0)
    {
        sb.Append("<div id =\"schB\">");
        sb.Append("<table cellpadding=\"0\" cellspacing=\"0\" style=\"width:100%;\" border=\"0\">");
        //        
        sb.Append("<tr style=\"height: .25in\">");
        sb.Append("<td width=\"5%\">&nbsp;</td>");
        sb.Append("<td width=\"85%\">&nbsp;</td>");
        sb.Append("<td width=\"10%\">&nbsp;</td>");
        sb.Append("</tr>");
        //        
        sb.Append("<tr>");
        sb.Append("<th colspan=\"3\" align=\"left\"><u><b>2015 BIRT Schedule B: Computation of Tax On Net Income(Method II)</b></u></th>");
        sb.Append("</th>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>1.</td>");
        sb.Append("<td>Net Income (Loss) as properly reported to the Federal Government     ");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_NI_LOSS);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        //        
        sb.Append("<tr>");
        sb.Append("<th colspan=\"3\" align=\"left\"><u><b>ADJUSTMENTS (Per BIRT Reg. 404 and Public Law 86-272)</b></u></th>");
        sb.Append("</th>");
        sb.Append("</tr>");
        //
        sb.Append("<tr>");
        sb.Append("<td>2a.</td>");
        sb.Append("<td>Income net of interest expense attributable to direct obligations of the Federal Government,");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_ADJ_NI_INTEREST);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>2b.</td>");
        sb.Append("<td>Tax Due for the {year} Business Income & Receipts Tax (If loss, enter \"0\")");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_ADJ_NI_PORT_ACTIVITIES);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>2c.</td>");
        sb.Append("<td>Net Income (Loss) from specific PUC and ICC business activities. (Reg. 101 (D) (3))");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_ADJ_NI_PUC_ICC);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>2d.</td>");
        sb.Append("<td>Net Income (Loss) from Public Law 86-272 activities");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_ADJ_NI_PUBLIC_LAW);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>2e.</td>");
        sb.Append("<td>Receipts by corporations of dividends, interest and royalties received from...");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_ADJ_RECEIPTS_DIR);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>2f.</td>");
        sb.Append("<td>Line 1 minus Lines 2a through 2e ");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_ADJ_INCOME);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>2g.</td>");
        sb.Append("<td>All other receipts from other corporations of the same affiliated group. (Reg. 302 (N))");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_ADJ_RECEIPTS_OTHER);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>2h.</td>");
        sb.Append("<td>Gross Receipts per BIRT Regulation §404(B) (5) (e) ");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_ADJ_GROSS_RECEIPTS);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>2i.</td>");
        sb.Append("<td>Divide Line 2g by Line 2h");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_ADJ_GROSS_PERCENT);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>2j.</td>");
        sb.Append("<td>Multiply Line 2f by Line 2i");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_ADJ_TOTAL);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>3.</td>");
        sb.Append("<td>ADJUSTED NET INCOME(Loss)[Calculated - Line 2f minus Line 2j]");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_NI_ADJUSTED);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>4.</td>");
        sb.Append("<td>Total Nonbusiness Income (Loss)");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_I_NONBUS);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>5.</td>");
        sb.Append("<td>Income(Loss) to be apportioned[Calculated - Line 3 minus Line 4]");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_I_APPORTIONED);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>6.</td>");
        sb.Append("<td>Income(Loss) to be apportioned[Calculated - Line 3 minus Line 4]");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_I_APPORTIONED_PHILA);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>7.</td>");
        sb.Append("<td>Income (Loss) apportioned to Philadelphia[Calculated - Multiply Line 5 by Line 6]");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_I_APPORTIONED_PHILA);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>8.</td>");
        sb.Append("<td>Nonbusiness Income (Loss) allocated to Philadelphia");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_I_NONBUS_PHILA);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>9.</td>");
        sb.Append("<td>Current Year Income (Loss)[Calculated - Line 7 plus Line 8]");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_I_CURRENT_YEAR);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>10.</td>");
        sb.Append("<td>Statutory Net Income Deduction (from Worksheet S, Line S5 )");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_STAT_NET_DEDUCTION_B_X);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>11.</td>");
        sb.Append("<td>Loss Carry Forward, if any");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_LOSS_CARRY_FORWARD);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>12.</td>");
        sb.Append("<td>Taxable Income (Loss)[Calculated - Line 9 minus Line 10 minus Line 11]");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_I_TAXABLE);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>13.</td>");
        sb.Append("<td>TAX DUE (Multiply Line 12 by 0.0643)");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_schB_TAX_DUE);
        sb.Append("</td>");
        sb.Append("</tr>");
        //

        sb.Append("</table>");
        sb.Append("</div>");
    }
    else
    {
        sb.Append("<div id =\"schA\">");
        sb.Append("<table cellpadding=\"0\" cellspacing=\"0\" style=\"width:100%;\" border=\"0\">");
        //        
        sb.Append("<tr style=\"height: .25in\">");
        sb.Append("<td width=\"5%\">&nbsp;</td>");
        sb.Append("<td width=\"85%\">&nbsp;</td>");
        sb.Append("<td width=\"10%\">&nbsp;</td>");
        sb.Append("</tr>");
        //        
        sb.Append("<tr>");
        sb.Append("<th colspan=\"3\" align=\"left\"><u><b>2015 BIRT Schedule A: Computation of Tax On Net Income(Method I)</b></u></th>");
        sb.Append("</th>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>1.</td>");
        sb.Append("<td>Net Income (Loss) per accounting system used plus income </br> taxes deducted in arriving at Net Income");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_NI_LOSS);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>2.</td>");
        sb.Append("<td>Net Income (Loss) from certain port related activities.");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_NI_PORT_ACTIVITIES);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>3.</td>");
        sb.Append("<td>Net Income (Loss) from specific PUC and ICC business activities. ");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_NI_PUC_ICC);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>4.</td>");
        sb.Append("<td>Net Income (Loss) from Public Law 86-272 activities");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_NI_PUBLIC_LAW);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>5.</td>");
        sb.Append("<td>Adjusted Net Income (Loss)[Calculated - Line 1 minus 2, 3, and 4]");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_ADJUSTED_NET_INCOME);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>6.</td>");
        sb.Append("<td>Total Nonbusiness Income (Loss)");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_TOTAL_NONBUS_INCOMES);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>7.</td>");
        sb.Append("<td>Income (Loss) to be apportioned (Line 5 minus Line 6)");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_I_APPORTIONED);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>8.</td>");
        sb.Append("<td>Average of Apportionment Factors");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_I_APPORTIONED_PERCENT);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>9.</td>");
        sb.Append("<td>Income (Loss) apportioned to Philadelphia[Calculated - Multiply Line 7 by Line 8] ");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_NI_LOSS);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>10.</td>");
        sb.Append("<td>Nonbusiness Income (Loss) allocated to Philadelphia");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_I_NONBUS_PHILA);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>11.</td>");
        sb.Append("<td>Current year Income (Loss)[Calculated - Line 9 plus Line 10]");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_I_CURRENT_YEAR);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>12.</td>");
        sb.Append("<td>Statutory Net Income Deduction  ");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_NET_DEDUCTION_A);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>13.</td>");
        sb.Append("<td>Loss Carry Forward, if any. ");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_LOSS_CARRY_FORWARD);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>14.</td>");
        sb.Append("<td>Taxable Income (Loss)[Calculated - Line 11 minus Line 12 minus Line 13].");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_A_I_TAXABLE);
        sb.Append("</td>");
        sb.Append("</tr>");
        // <tr>
        sb.Append("<tr>");
        sb.Append("<td>15.</td>");
        sb.Append("<td>TAX DUE");
        //sb.Append("Net Income (Loss) per accounting system used plus income taxes deducted in arriving at Net Income");
        sb.Append("</td>");
        sb.Append("<td align=\"right\">");
        sb.Append(var_TAX_DUE_A);
        sb.Append("</td>");
        sb.Append("</tr>");
        // 
        sb.Append("</table>");
        sb.Append("</div>");
    }
    return sb.ToString();
}

</script>


<%

	Response.CacheControl = "no-cache";
	Response.AddHeader("Pragma", "no-cache");
	Response.Expires = 0;
	Response.ContentType = "text/html";

    msApp = "CC";
    msCouponPath = COPPaths.COUPON_PATH;

    //BPT_PG1
    var_NET_INCOME = CopQueryString.GetString("a");
    var_GROSS_RECEIPTS = CopQueryString.GetString("b");
    var_TAX_DUE = CopQueryString.GetString("c");
    var_ESTIMATED_TAX = CopQueryString.GetString("d");
    var_TOTAL_TAX = CopQueryString.GetString("e");
    var_NPT_TAX_CREDIT = CopQueryString.GetString("f");
    var_BPT_TAX_CREDIT = CopQueryString.GetString("g");
    var_TOTAL_PAY_CREDITS = CopQueryString.GetString("h");
    var_NET_TAX = CopQueryString.GetString("i");
    var_INTEREST_PENALTY = CopQueryString.GetString("j");
    var_AMOUNT_OWED = CopQueryString.GetString("k");
    var_REFUND = CopQueryString.GetString("l");
    var_NPT_OVERPAY = CopQueryString.GetString("m");
    var_BPT_OVERPAY = CopQueryString.GetString("n");
    //
    var_name = CopQueryString.GetString("q");
    var_ein_ssn_label = CopQueryString.GetString("r");
    var_ein_ssn_value = CopQueryString.GetString("s");
    var_address = CopQueryString.GetString("t");
    var_year = CopQueryString.GetString("u");
    var_rate = CopQueryString.GetString("w");
    var_acc_id = CopQueryString.GetString("p");
    //Schedule A
    var_A_NI_LOSS = CopQueryString.GetString("NI_LOSS_A");
    var_A_NI_PORT_ACTIVITIES = CopQueryString.GetString("NI_PORT_ACTIVITIES_A");
    var_A_NI_PUC_ICC = CopQueryString.GetString("NI_PUC_ICC_A");
    var_A_NI_PUBLIC_LAW = CopQueryString.GetString("var_NI_PUBLIC_LAW_A");
    var_A_ADJUSTED_NET_INCOME = CopQueryString.GetString("ADJUSTED_NET_INCOMES_A");
    var_A_TOTAL_NONBUS_INCOMES = CopQueryString.GetString("TOTAL_NONBUS_INCOMES_A");
    var_A_I_APPORTIONED = CopQueryString.GetString("I_APPORTIONED_A");
    var_A_I_APPORTIONED_PERCENT = CopQueryString.GetString("I_APPORTIONED_PERCENT_A");
    var_A_I_NONBUS_PHILA = CopQueryString.GetString("I_NONBUS_PHILA_A");
    var_A_I_CURRENT_YEAR = CopQueryString.GetString("I_CURRENT_YEAR_A");
    var_A_NET_DEDUCTION_A = CopQueryString.GetString("NET_DEDUCTION_A");
    var_A_LOSS_CARRY_FORWARD = CopQueryString.GetString("LOSS_CARRY_FORWARD_A");
    var_A_I_TAXABLE = CopQueryString.GetString("I_TAXABLE_A");
    var_TAX_DUE_A = CopQueryString.GetString("TAX_DUE_A");
    //schedule B
    var_NI_LOSS = CopQueryString.GetString("NI_LOSS");
    var_ADJ_NI_INTEREST = CopQueryString.GetString("ADJ_NI_INTEREST");
    var_ADJ_NI_PORT_ACTIVITIES = CopQueryString.GetString("ADJ_NI_PORT_ACTIVITIES");
    var_ADJ_NI_PUC_ICC = CopQueryString.GetString("ADJ_NI_PUC_ICC");
    var_ADJ_NI_PUBLIC_LAW = CopQueryString.GetString("ADJ_NI_PUBLIC_LAW");
    var_ADJ_RECEIPTS_DIR = CopQueryString.GetString("ADJ_RECEIPTS_DIR");
    var_ADJ_INCOME = CopQueryString.GetString("ADJ_INCOME");
    var_ADJ_RECEIPTS_OTHER = CopQueryString.GetString("ADJ_RECEIPTS_OTHER");
    var_ADJ_GROSS_RECEIPTS = CopQueryString.GetString("ADJ_GROSS_RECEIPTS");
    var_ADJ_GROSS_PERCENT = CopQueryString.GetString("ADJ_GROSS_PERCENT");
    var_ADJ_TOTAL = CopQueryString.GetString("ADJ_TOTAL");
    var_NI_ADJUSTED = CopQueryString.GetString("NI_ADJUSTED");
    var_I_NONBUS = CopQueryString.GetString("I_NONBUS");
    var_I_APPORTIONED = CopQueryString.GetString("I_APPORTIONED");
    var_I_APPORTIONED_PHILA = CopQueryString.GetString("I_APPORTIONED_PHILA");
    var_I_NONBUS_PHILA = CopQueryString.GetString("I_NONBUS_PHILA");
    var_I_CURRENT_YEAR = CopQueryString.GetString("I_CURRENT_YEAR");
    var_STAT_NET_DEDUCTION_B_X = CopQueryString.GetString("STAT_NET_DEDUCTION_B_X");
    var_LOSS_CARRY_FORWARD = CopQueryString.GetString("LOSS_CARRY_FORWARD");
    var_I_TAXABLE = CopQueryString.GetString("I_TAXABLE");
    var_TAX_DUE = CopQueryString.GetString("TAX_DUE");
    //Schedule C1
    var_c1 = CopQueryString.GetString("c1");
    var_c2 = CopQueryString.GetString("c2");
    var_c3 = CopQueryString.GetString("c3");
    //Schedule D 
    GR_SALES = CopQueryString.GetString("GR_SALES");
    GR_SERVICES = CopQueryString.GetString("GR_SERVICES");
    GR_RENTALS = CopQueryString.GetString("GR_RENTALS");
    GR_TOTALS = CopQueryString.GetString("GR_TOTALS");
    LE_SALES_OUT = CopQueryString.GetString("LE_SALES_OUT");
    LE_SERVICES_OUT = CopQueryString.GetString("LE_SERVICES_OUT");
    LE_RENTALS_OUT = CopQueryString.GetString("LE_RENTALS_OUT");
    LE_OTHER = CopQueryString.GetString("LE_OTHER");
    NET_TAXABLE_RECEIPTS_BEFORE = CopQueryString.GetString("NET_TRB");
    STAT_EXCLUSION_D_X = CopQueryString.GetString("STAT_EXCLUSION_D_X");
    NET_TAXABLE_RECEIPTS_AFTER = CopQueryString.GetString("NET_TR_AF");
    RECEIPTS_ALTERNATIVE_METHOD = CopQueryString.GetString("R_ALT_MTHD");
    RECEIPTS_REGULAR_RATE = CopQueryString.GetString("R_R_RATE");
    TAX_DUE = CopQueryString.GetString("d_TAX_DUE");
    TAX_DUE_ALT = CopQueryString.GetString("d_TAX_DUE_ALT");
    d_TOTAL_TAX_DUE = CopQueryString.GetString("d_TOTAL_TAX_DUE");
    //Schedule E
    M_ALT_RECEIPTS = CopQueryString.GetString("M_ALT_RECEIPTS");
    M_GOODS_COST = CopQueryString.GetString("M_GOODS_COST");
    M_TAX_BASE = CopQueryString.GetString("M_TAX_BASE");
    M_TAX_DUE = CopQueryString.GetString("M_TAX_DUE");
    W_ALT_RECEIPTS = CopQueryString.GetString("W_ALT_RECEIPTS");
    W_GOODS_MATERIALS = CopQueryString.GetString("W_GOODS_MATERIALS");
    W_GOODS_LABOR = CopQueryString.GetString("W_GOODS_LABOR");
    W_GOODS_COST = CopQueryString.GetString("W_GOODS_COST");
    W_TAX_BASE = CopQueryString.GetString("W_TAX_BASE");
    W_TAX_DUE = CopQueryString.GetString("W_TAX_DUE");
    R_ALT_RECEIPTS = CopQueryString.GetString("R_ALT_RECEIPTS");
    R_GOODS_MATERIALS = CopQueryString.GetString("R_GOODS_MATERIALS");
    R_GOODS_LABOR = CopQueryString.GetString("R_GOODS_LABOR");
    R_GOODS_COST = CopQueryString.GetString("e_R_GOODS_COST");
    R_TAX_BASE = CopQueryString.GetString("e_R_TAX_BASE");
    R_TAX_DUE = CopQueryString.GetString("e_R_TAX_DUE");
    e_TOTAL_TAX_DUE = CopQueryString.GetString("e_TOTAL_TAX_DUE");
    //
    var_PREPARER_NAME = CopQueryString.GetString("v");
    var_PREPARER_PHONE = CopQueryString.GetString("x");
    var_PREPARER_PHONE_EXT = CopQueryString.GetString("yy");
    var_PREPARER_EMAIL_ADDRESS = CopQueryString.GetString("z");
    var_PREPARER_WHO = CopQueryString.GetString("zz");

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
