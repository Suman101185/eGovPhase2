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


string var_ITEM_NOT_PHILA, var_ITEM_TOTAL, var_ITEM_PHILA, var_ITEM_TAX_DUE, var_PACK_TOTAL, var_PACK_NOT_PHILA;
string var_PACK_PHILA, var_PACK_TAX_DUE, var_PAPER_TOTAL, var_PAPER_NOT_PHILA, var_PAPER_PHILA, var_PAPER_TAX_DUE, var_TOTAL_TAX_DUE, var_CREDITS, var_NET_TAX_DUE, var_INTEREST_PENALTY, var_TOTAL_AMOUNT_DUE;
string var_TAX_REFUND, var_TAX_OVERPAID;
string var_name, var_ein_ssn_label, var_ein_ssn_value, var_address, var_year, var_rate, var_acNo;
string var_PREPARER_NAME, var_PREPARER_PHONE, var_PREPARER_PHONE_EXT, var_PREPARER_EMAIL_ADDRESS, var_PREPARER_WHO;
string var_dTobaccoItemTaxRate, var_dTobaccoPackTaxRate, var_dTobaccoPaperTaxRate;


void tobaccoPdfTemplate()
{

    sPath = Server.MapPath("~");

    //Set fso = Server.CreateObject("Scripting.FileSystemObject")
    using (StreamReader st = File.OpenText(sPath + @"\Views\web\PDF_report\TOBACCO\Tobacco.htm"))
    {
        sPayCouponTemplate = st.ReadToEnd();
    }

    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{name}", var_name); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ssn_label}", var_ein_ssn_label);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ssn_value}", var_ein_ssn_value); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{address}", var_address);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{acc_id}", var_acNo);
    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ITEM_NOT_PHILA}", var_ITEM_NOT_PHILA); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ITEM_TOTAL}", var_ITEM_TOTAL); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ITEM_PHILA}", var_ITEM_PHILA); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ITEM_TAX_DUE}", var_ITEM_TAX_DUE); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PACK_TOTAL}", var_PACK_TOTAL); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PACK_NOT_PHILA}", var_PACK_NOT_PHILA); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PACK_PHILA}", var_PACK_PHILA); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PACK_TAX_DUE}", var_PACK_TAX_DUE); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PAPER_TOTAL}", var_PAPER_TOTAL); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PAPER_NOT_PHILA}", var_PAPER_NOT_PHILA); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))

    sPayCouponTemplate = sPayCouponTemplate.Replace("{PAPER_PHILA}", var_PAPER_PHILA);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PAPER_TAX_DUE}", var_PAPER_TAX_DUE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_TAX_DUE}", var_TOTAL_TAX_DUE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{CREDITS}", var_CREDITS);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NET_TAX_DUE}", var_NET_TAX_DUE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{INTEREST_PENALTY}", var_INTEREST_PENALTY);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_AMOUNT_DUE}", var_TOTAL_AMOUNT_DUE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TAX_REFUND}", var_TAX_REFUND);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TAX_OVERPAID}", var_TAX_OVERPAID);
    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{dTobaccoItemTaxRate}", var_dTobaccoItemTaxRate);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{dTobaccoPackTaxRate}", var_dTobaccoPackTaxRate);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{dTobaccoPaperTaxRate}", var_dTobaccoPaperTaxRate);
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

    var_ITEM_NOT_PHILA = CopQueryString.GetString("aaa");
    var_ITEM_TOTAL = CopQueryString.GetString("ITEM_TOTAL");
    var_ITEM_PHILA = CopQueryString.GetString("ITEM_PHILA");
    var_ITEM_TAX_DUE = CopQueryString.GetString("a");
    var_PACK_TOTAL = CopQueryString.GetString("b");
    var_PACK_NOT_PHILA = CopQueryString.GetString("c");
    var_PACK_PHILA = CopQueryString.GetString("d");
    var_PACK_TAX_DUE = CopQueryString.GetString("e");
    var_PAPER_TOTAL = CopQueryString.GetString("f");
    var_PAPER_NOT_PHILA = CopQueryString.GetString("g");
    var_PAPER_PHILA = CopQueryString.GetString("h");
    var_PAPER_TAX_DUE = CopQueryString.GetString("i");
    var_TOTAL_TAX_DUE = CopQueryString.GetString("j");
    var_CREDITS = CopQueryString.GetString("k");
    var_NET_TAX_DUE = CopQueryString.GetString("l");
    var_INTEREST_PENALTY = CopQueryString.GetString("m");
    var_TOTAL_AMOUNT_DUE = CopQueryString.GetString("n");

    var_TAX_REFUND = CopQueryString.GetString("o");
    var_TAX_OVERPAID = CopQueryString.GetString("p");
    //, ;
    var_dTobaccoItemTaxRate = CopQueryString.GetString("dTobaccoItemTaxRate");
    var_dTobaccoPackTaxRate = CopQueryString.GetString("dTobaccoPackTaxRate");
    var_dTobaccoPaperTaxRate = CopQueryString.GetString("dTobaccoPaperTaxRate");

    //
    var_name = CopQueryString.GetString("q");
    var_ein_ssn_label = CopQueryString.GetString("r");
    var_ein_ssn_value = CopQueryString.GetString("s");
    var_address = CopQueryString.GetString("t");
    var_year = CopQueryString.GetString("u");
    var_acNo = CopQueryString.GetString("acNo");

    //
    var_PREPARER_NAME = CopQueryString.GetString("v");
    var_PREPARER_PHONE = CopQueryString.GetString("x");
    var_PREPARER_PHONE_EXT = CopQueryString.GetString("yy");
    var_PREPARER_EMAIL_ADDRESS = CopQueryString.GetString("z");
    var_PREPARER_WHO = CopQueryString.GetString("zz");

    tobaccoPdfTemplate();

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
