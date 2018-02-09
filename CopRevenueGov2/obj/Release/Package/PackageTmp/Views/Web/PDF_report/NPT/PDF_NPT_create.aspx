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


string var_name, var_ein_ssn_label, var_ein_ssn_value, var_address, var_year, var_acc_id;
string var_PREPARER_NAME, var_PREPARER_PHONE, var_PREPARER_PHONE_EXT, var_PREPARER_EMAIL_ADDRESS, var_PREPARER_WHO;
//
string dNPTResidentRate, dNPTNonResidentRate, var_RESIDENT_INCOME, var_RESIDENT_INCOME_TAX, var_RESIDENT_BASE_INCOME_TAXABLE, var_RESIDENT_BASE_INCOME_TAX,
        var_RESIDENT_TOTAL_TAX, var_NON_RES_INCOME, var_NON_RES_INCOME_TAX, var_NON_RES_BASE_INCOME_TAXABLE, var_NON_RES_BASE_INCOME_TAX, var_NON_RES_TOTAL_TAX, var_TOTAL_TAX,
        var_BPT_TAX_CREDIT, var_OTHER_TAX_CREDIT, var_TAX_DUE, var_TOTAL_PAY_CREDIT, var_INTEREST_PENALTY, var_TOTAL_DUE, var_OVERPAY, var_LINE17, BALANCE,
        REFUND, BPT_OVERPAY, NPT_OVERPAY; 


void  OpenNPTTemplate()
{

    sPath = Server.MapPath("~");

    //Set fso = Server.CreateObject("Scripting.FileSystemObject")
    using (StreamReader st = File.OpenText(sPath + @"\Views\web\PDF_report\NPT\NPT.htm"))
    {
        sPayCouponTemplate = st.ReadToEnd();
    }

    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{name}", var_name); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ssn_label}", var_ein_ssn_label);

    sPayCouponTemplate = sPayCouponTemplate.Replace("{ssn_value}", var_ein_ssn_value); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{address}", var_address);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{acc_id}", var_acc_id);
    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{year}", var_year);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{dNPTResidentRate}", dNPTResidentRate);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{dNPTNonResidentRate}", dNPTNonResidentRate);
    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{RESIDENT_INCOME}", var_RESIDENT_INCOME);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{RESIDENT_INCOME_TAX}", var_RESIDENT_INCOME_TAX);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{RESIDENT_BASE_INCOME_TAXABLE}", var_RESIDENT_BASE_INCOME_TAXABLE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{RESIDENT_BASE_INCOME_TAX}", var_RESIDENT_BASE_INCOME_TAX);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{RESIDENT_TOTAL_TAX}", var_RESIDENT_TOTAL_TAX);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NON_RES_INCOME}", var_NON_RES_INCOME);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NON_RES_INCOME_TAX}", var_NON_RES_INCOME_TAX);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NON_RES_BASE_INCOME_TAXABLE}", var_NON_RES_BASE_INCOME_TAXABLE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NON_RES_BASE_INCOME_TAX}", var_NON_RES_BASE_INCOME_TAX);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NON_RES_TOTAL_TAX}", var_NON_RES_TOTAL_TAX);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_TAX}", var_TOTAL_TAX);
    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{BPT_TAX_CREDIT}", var_BPT_TAX_CREDIT);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{OTHER_TAX_CREDIT}", var_OTHER_TAX_CREDIT);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TAX_DUE}", var_TAX_DUE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_PAY_CREDIT}", var_TOTAL_PAY_CREDIT);
    //Schedule B
    sPayCouponTemplate = sPayCouponTemplate.Replace("{INTEREST_PENALTY}", var_INTEREST_PENALTY);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_DUE}", var_TOTAL_DUE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{OVERPAY}", var_OVERPAY);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{LINE17}", var_LINE17);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{BALANCE}", BALANCE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{REFUND}", REFUND);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{BPT_OVERPAY}", BPT_OVERPAY);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NPT_OVERPAY}", NPT_OVERPAY);
    //    
    sPayCouponTemplate = sPayCouponTemplate.Replace("{year}", var_year);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{dNPTResidentRate}", dNPTResidentRate);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{dNPTNonResidentRate}", dNPTNonResidentRate);
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

</script>


<%

	Response.CacheControl = "no-cache";
	Response.AddHeader("Pragma", "no-cache");
	Response.Expires = 0;
	Response.ContentType = "text/html";

    msApp = "CC";
    msCouponPath = COPPaths.COUPON_PATH;

    var_name = CopQueryString.GetString("q");
    var_ein_ssn_label = CopQueryString.GetString("r");
    var_ein_ssn_value = CopQueryString.GetString("s");
    var_address = CopQueryString.GetString("t");
    var_year = CopQueryString.GetString("u");
    dNPTResidentRate = CopQueryString.GetString("dNPTResidentRate");
    dNPTNonResidentRate = CopQueryString.GetString("dNPTNonResidentRate");
    var_acc_id = CopQueryString.GetString("acc_no");
    //NPT PG1
    var_RESIDENT_INCOME = CopQueryString.GetString("a");
    var_RESIDENT_INCOME_TAX = CopQueryString.GetString("b");
    var_RESIDENT_BASE_INCOME_TAXABLE = CopQueryString.GetString("c");
    var_RESIDENT_BASE_INCOME_TAX = CopQueryString.GetString("d");
    var_RESIDENT_TOTAL_TAX = CopQueryString.GetString("e");
    var_NON_RES_INCOME = CopQueryString.GetString("f");
    var_NON_RES_INCOME_TAX = CopQueryString.GetString("g");
    var_NON_RES_BASE_INCOME_TAXABLE = CopQueryString.GetString("h");
    var_NON_RES_BASE_INCOME_TAX = CopQueryString.GetString("i");
    var_NON_RES_TOTAL_TAX = CopQueryString.GetString("j");
    var_TOTAL_TAX = CopQueryString.GetString("TOTAL_TAX");
    var_BPT_TAX_CREDIT = CopQueryString.GetString("k");
    var_OTHER_TAX_CREDIT = CopQueryString.GetString("l");
    var_TOTAL_PAY_CREDIT = CopQueryString.GetString("m");
    var_TAX_DUE = CopQueryString.GetString("TAX_DUE");

    var_INTEREST_PENALTY = CopQueryString.GetString("INTEREST_PENALTY");
    var_TOTAL_DUE = CopQueryString.GetString("NPT_TOTAL_DUE");
    var_OVERPAY = CopQueryString.GetString("OVERPAY");
    var_LINE17 = CopQueryString.GetString("LINE17");
    BALANCE = CopQueryString.GetString("BALANCE");
    REFUND = CopQueryString.GetString("REFUND");
    BPT_OVERPAY = CopQueryString.GetString("BPT_OVERPAY");
    NPT_OVERPAY = CopQueryString.GetString("NPT_OVERPAY");
    //
    var_PREPARER_NAME = CopQueryString.GetString("v");
    var_PREPARER_PHONE = CopQueryString.GetString("x");
    var_PREPARER_PHONE_EXT = CopQueryString.GetString("yy");
    var_PREPARER_EMAIL_ADDRESS = CopQueryString.GetString("z");
    var_PREPARER_WHO = CopQueryString.GetString("zz");

    OpenNPTTemplate();

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
