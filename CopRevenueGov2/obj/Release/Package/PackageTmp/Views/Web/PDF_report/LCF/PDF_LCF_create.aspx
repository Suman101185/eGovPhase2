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

string var_ACCOUNT_ID, var_YEAR_X, var_EST_PAID_X, var_YEAR, var_AMOUNT, var_COMMENT;
string var_YEAR_1, var_INCOME_1, var_COMMENT_1, var_YEAR_2, var_INCOME_2, var_COMMENT_2, var_YEAR_3, var_INCOME_3, var_COMMENT_3,var_name;

    
void OpenPayCouponTemplate()
{
   
	sPath = Server.MapPath("~");
    
	//Set fso = Server.CreateObject("Scripting.FileSystemObject")
    
        using (StreamReader st = File.OpenText(sPath + @"\Views\web\PDF_report\LCF\LCFPDF.htm"))
        {
            sPayCouponTemplate = st.ReadToEnd();
        }
    
    
    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{name}", var_name); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)

    sPayCouponTemplate = sPayCouponTemplate.Replace("{ACCOUNT_ID}", var_ACCOUNT_ID); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{YEAR_X}", var_YEAR_X); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{EST_PAID_X}", var_EST_PAID_X); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{YEAR}", var_YEAR); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{AMOUNT}", var_AMOUNT); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{COMMENT}", var_COMMENT); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{YEAR_1}", var_YEAR_1); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{INCOME_1}", var_INCOME_1); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{COMMENT_1}", var_COMMENT_1); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{YEAR_2}", var_YEAR_2); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))

    sPayCouponTemplate = sPayCouponTemplate.Replace("{INCOME_2}", var_INCOME_2);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{COMMENT_2}", var_COMMENT_2);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{YEAR_3}", var_YEAR_3);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{INCOME_3}", var_INCOME_3);

    sPayCouponTemplate = sPayCouponTemplate.Replace("{COMMENT_3}", var_COMMENT_3);
    
   
	

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

    var_ACCOUNT_ID = CopQueryString.GetString("a");
    var_YEAR_X = CopQueryString.GetString("b");
    var_EST_PAID_X = CopQueryString.GetString("c");
    var_YEAR = CopQueryString.GetString("d");
    var_AMOUNT = CopQueryString.GetString("e");
    var_COMMENT = CopQueryString.GetString("f");
    var_YEAR_1 = CopQueryString.GetString("g");
    var_INCOME_1 = CopQueryString.GetString("h");
    var_COMMENT_1 = CopQueryString.GetString("i");
    var_YEAR_2 = CopQueryString.GetString("j");
    var_INCOME_2 = CopQueryString.GetString("k");
    var_COMMENT_2 = CopQueryString.GetString("l");
    var_YEAR_3 = CopQueryString.GetString("m");
    var_INCOME_3 = CopQueryString.GetString("n");
    var_COMMENT_3 = CopQueryString.GetString("o");
    var_name = CopQueryString.GetString("p");
    
    
    
    
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
