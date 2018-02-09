<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<%
    Session["AccNum"] = "";
%>
<script type="text/javascript" language="javascript" src="../Content/Scripts/jquerymin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/global.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/jquery.browser.min.js"></script>

<%--<link rel="Stylesheet" href="../Content/Styles/Font.css" />
<link rel="Stylesheet" href="../Content/Styles/Object.css" />--%>

<script type="text/javascript" language="javascript">
    var txtHeader = 'Taxpayer Information';
    var gsLoginPage = '';
    var regInteger = new RegExp("[0-9]{1,13}");

    function isLoaded() {
        if (parent.document.readyState != 'complete') {
           // setTimeout('isLoaded()', 0);
        }		//if
    }
    //isLoaded
    ///'Sudipta
    function GetSingleNodeCount(oXML, sElement, val)//Chayan
    {
        var count = 0;
        $(oXML.xml).find(sElement).each(function () {

            count = count + 1;

        });
        return count;
    }


    $(document).ready(function () {

        //''''Sudipta'''''
        var currenturl = window.location.search;
        debugger;
        //setTimeout('isLoaded()', 0);

        if (currenturl.indexOf("?status=true") !== -1 || currenturl.indexOf("?status=false") !== -1) {
           
            ShowForm('PaySuccess');
            var dobj = parent.$g.getXmlDocObj();
            parent.$g.loadXmls();

            var acct = localStorage.getItem("AccountNumber");
            debugger;
            var pin = localStorage.getItem("Pin");
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "I", "ENTITY_INFO FUNCTION_CODE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, acct, "ENTITY_INFO ENTITY_ID", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, pin, "ENTITY_INFO PIN", '', 0);
            ispCallXMLForm(parent.$g.xmlAccount, dobj, "AccountInfo");
            if (parent.$x.ispXmlGetFieldVal(dobj, 'ERROR_INFO MESSAGE', "", 0) == "") {

                parent.$g.xmlAccount.loadXML(dobj.xml);
               
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0) != "") {
                   

                    var uName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME', '', 0);
                    debugger;
                    if (uName.indexOf("*") >= 0) {
                        uName = uName.replace(/\*/g, " ");
                        localStorage.setItem("AccountName", uName);
                    }
                    localStorage.setItem("AccountName", uName);
                    $('#divPayments').css("display", "block");
                    parent.fillUserAfterLogin(true, uName);

                    //''''''' Populating menu''''''''


                    TotalAccounts = 0;
                    var taxcount = 0;

                   
                    taxcount = GetSingleNodeCount(parent.$g.xmlAccount, 'TAX_ACCT', '');
                    var acc = '';
                    for (i = 0; i < taxcount; i++) {

                        acc = $(parent.$g.xmlAccount.xml).find('ACCOUNT').eq(i).text();

                        if (acc != '0') {
                            if (acc == '1') {

                                $('#mnuReWage').css("display", "block");
                                lDisplay = true;
                            }
                            if (acc == '29') {
                                $('#mnuReSchool').css("display", "block");
                                lDisplay = true;
                            }
                            if (acc == '24') {
                                $('#mnuLCF').css('display', 'block');
                                $('#mnuBPTlf').css("display", "block");
                                lDisplay = true;

                                $('#mnuReBPTez').css("display", "block");
                                lDisplay = true;
                            }
                            if (acc == '27') {


                                $('#mnuTOB').css("display", "block");
                                lDisplay = true;
                            }
                            if (acc == '3') {
                                $('#mnuReNPT').css("display", "block");
                                lDisplay = true;
                            }
                            if (acc == '84') {
                                $('#mnuUO').css("display", "block");
                                lDisplay = true;
                            }
                            if (acc == '2') {
                                if (parent.gEnvironment == 'U') {
                                    $('#mnuReERN').css("display", "block");
                                    lDisplay = true;

                                }
                            }


                            //if
                        }  //if
                    }

                }
            }



        }



      
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, "ENTITY_INFO ENTITY_ID", '', 0) == '') {
            ShowForm('LogLogin');
        } else if (parent.bChangePin == true) {

            ShowForm('LogChangePin');
            parent.bChangePin = false;
            $('#mnuLogLogout').css("display", "block");
            $('#mnuLogPinChange').css("display", "block");
            $('#mnuLogPayCoupon').css("display", "block");
            $('#divPayments').css("display", "block");
            
        }
        else if (parent.bLCF == true) {
            parent.setFrameUrl('Acct/ApplyMain');
            parent.bLCF = false;
        }
        else if (parent.Cancelform == true) {
            ShowForm('LogLogin');
            parent.Cancelform=false;
        }
        
        //if

        //if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, "ENTITY_INFO ENTITY_ID", '', 0) != '') {
        //    ShowForm('LogLogin');
        //}

        if ('<%= CopMvcUtil.GetString(Session["Redirect"]) %>' == 'COUPON' || parent.bLoadCoupon == true) {
            debugger;
			<% Session["Redirect"] = ""; %>
            parent.bLoadCoupon = false;
            ShowForm('LogCoupon');          

        }		//if
        if (parent.gbElectronicCoupon == true) {
            debugger;
            DisplayCoupLogin('EPayment', 'TRUE');
            parent.gbElectronicCoupon = false;
        }
        if (parent.NTL == true) {
            DisplayCoupLogin('NTL', 'TRUE');
            HidePayCoupon();
            parent.NTL = false;
        }
        //ShowForm('LogLogin');
        parent.document.title = parent.window.gTitle;

    });
    function HidePayCoupon() {
        $('#divLogin').css('display', 'none');
        $('#LogPinApply').css('display', 'none');
        $('#divPinApply').css('display', 'none');
        $('#divApplyFirst').css('display', 'none');
    }
    function HideForm() {
        $('#divLogin').css('display', 'none');
        $('#LogPinApply').css('display', 'none');
        $('#divPinApply').css('display', 'none');
    }

    function HideOtherForm() {
        $('#LogCoupon').css('display', 'none');
        $('#LogLogin').css('display', 'none');
        $('#divLogin').css('display', 'none');
        $('#divApplyFirst').css('display', 'none');
        $('#divPayCoupon').css('display', 'none');    
    }
    function HideForApplyFirst() {
        $('#LogCoupon').css('display', 'none');
        $('#LogLogin').css('display', 'none');
        $('#divLogin').css('display', 'none');        
        $('#divPayCoupon').css('display', 'none');
    }
    
    function displayw2() {
        DisplayModal();
    }

    function display1099() {
        Display1099Modal();
    }

    function ShowForm(id) {
        
       
        $('#LogMain').css('display', 'none');
        $('#LogPinApply').css('display', 'none');
        $('#LogLogin').css('display', 'none');
        $('#LogChangePin').css('display', 'none');
        $('#LogApplyFirst').css('display', 'none');
       
        $('#divForgotPinNew').css('display', 'none');        
        $('#ApplyPinThankYou').css('display', 'none');
        $('#LogCoupon').css('display', 'none');
        $('#divPinApply').css('display', 'none');
        $('#divLogin').css('display', 'none');
        $('#divApplyFirst').css('display', 'none');
        $('#divPayCoupon').css('display', 'none');
        
        debugger;
        try {
            if (id == 'LogMain') {
                debugger;
                DisplayLogin();
            }
            else if (id == 'LogPinApply') {
                DisplayPinApply();
            }
            else if (id == 'LogLogin') {

                DisplayLogin();
            }
            else if (id == 'LogChangePin') {
              
                DisplayChangePin();
            }
            else if (id == 'LogApplyFirst') {

                DisplayApplyFirst();
            }
            else if (id == 'divForgotPin') {
                DisplayForgotPin();
            }
            else if (id == 'ApplyPinThankYou') {
                DisplayThankYou('');
            }
            else if (id == 'LogCoupon') {
                DisplayCoupLogin();
            }


                ///'''Sudipta'''''
            else if (id == 'PaySuccess') {

                DisplaySuccess();
            }
            //'''''''

        }
        catch (exp) {

            alert('ShowForm : ' + exp);
        }       
        resolvedIframeheight();//manoranjan
    }   
    function resolvedIframeheight() {
        //iframe height issue resolved
        var iframe = window.parent.document.getElementById('ifrmDocwin');
        var container = $('#tab1').css("height");
        iframe.style.height = container;
    }

</script>




<div id="tab1">
    <%
        
        Html.RenderAction("Main", "Login");
        Html.RenderAction("Login", "Login");
        Html.RenderAction("PayCoupon", "Login");
        Html.RenderAction("PinApply", "Login");
        Html.RenderAction("ApplyFirst", "Login");
        Html.RenderAction("ChangePin", "Login");
        Html.RenderAction("ForgotPin", "Login");
        Html.RenderAction("ThankYou", "Login");
        Html.RenderAction("Email", "Login"); 
      
        
        
    %>
</div>
