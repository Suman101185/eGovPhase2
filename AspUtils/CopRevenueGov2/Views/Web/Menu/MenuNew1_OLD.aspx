<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>



<style>
    changeOrgTyp span {
        color: #fff;
        font: 12px/20px opensans-regular;
    }

    .UOSTYLE {
        font: 12px/33px opensans-regular !important;
        background-color: #375B94 !important;
    }
</style>

<link href="Content/Styles/nanoscroller.css" rel="stylesheet" />




<script id="clientEventHandlersJS" language="javascript" type="text/javascript">
    //EHD v0.4
    //EGOVWEB-74 20110413 Restarted U&O

    function getEvent(source) {
        var evt = null;
    }

    function getEventSource(event) {
        if (event == undefined || event == null) {
            return null;
        }
        var source = event.target || event.srcElement;
        return source;
    }




    function GetSingleNodeCount(oXML, sElement, val)//Chayan
    {
        var count = 0;
        $(oXML.xml).find(sElement).each(function () {

            count = count + 1;

        });
        return count;
    }
    function GetNodeCount(oXML, sElement, val)//Chayan
    {
        var count = 0;
        $(oXML.xml).find(sElement).each(function () {
            if ($(this).text() != null && $(this).text() != '' && $(this).text() == val) {
                count = count + 1;
            }
        });
        return count;
    }
    function GetInnerNodeText(oXML, sElement1, sElement2, val)//Chayan
    {
        var result;
        $(oXML.xml).find(sElement1).each(function () {
            if ($(this).text() != null && $(this).text() != '' && $(this).text() == val) {
                result = $(this).parent().find(sElement2).text();
            }
        });
        return result;
    }
    function UpdateElementText(oXML, setval, sElement1, searchval, sElement2) {

        var result = 0;
        var count = 0;
        $(oXML.xml).find(sElement1).each(function () {
            count = count + 1;
            if ($(this).text() != null && $(this).text() != '' && $(this).text() == searchval) {
                $(this).parent().find(sElement2).text(setval);
            }
        });
        return oXML;
    }


    var gsInstructionItem = '';
    var gsInstructionMessage = ' for Instructions on filing this return';
    var gsInstructionText = '<LI> Click <font class=lblLink onclick="parent.InstructionLinks()">' +
    'here</font>&nbsp;<label id="InstructionText"></label>';

    var MenuLoaded = '';
    var NavLoaded = '';
    var sNew = "";
    var bChangePin = false;
    var bLoadCoupon = false;
    var sCurrReturnYear = "";





    /*SUMAN --------------------------------
    This function may not work properly if called from another page 
    because this function call another function using function pointer through parameter <ResponseFunction> 
    which is not allwed if both stays on diff. js scripts or diff. page
    Thus it is recomended that any xml must be loaded here in menu page and then access xml from another page using
    parent.MenuWin.<xmlobjectName>
    -----------------------------------------
    */



    $(document).ready(function () {
        try {
            parent.$g.loadXmls();
        }
        catch (expression) {
            alert(' $(document).ready : ' + expression);
        }
        //$('.toggle-menu').jPushMenu();
        //$('.mnuNormal').click(function () {

        //    $('#spnMenu').find('.mnuNormal').css('background-color', '#4F5A7C');
        //    $('#mnuAcctProfile_s').css('background-color', '#FEFEFE');
        //    $(this).css('background-color', '#9FC75D');
        //});
        $('.toggle-menu').jPushMenu();
    });


    //function ispHighlightMenu(obj) {
    //    //spnMenu
    //    $('#mnuServices').css("color", "black");
    //    var id = $(obj).attr("id");

    //    $('#spnMenu .mnuNormal').each(function (i, e) {
    //        if ($(e).hasClass('mnuSelected')) {
    //            $(e).removeClass('mnuSelected');
    //            $(e).addClass('mnuNormal');
    //        }
    //    })
    //    $(obj).addClass("mnuSelected");

    //    //if
    //} 	//ispHighlightMenu

    function window_onload() {


        $('divMain').css("display", "block");
        // $('#divLogin').css("display", "none");
        $('#divLogout').css("display", "none");
        $('#divAccount').css("display", "none");
        $('#divPayments').css("display", "none");
        $('#divPayments1').css("display", "none");//Sanghamitra
        $('#divReturns').css("display", "none");
        $('#divWageYear').css("display", "none");
        $('#divSchoolYear').css("display", "none");
        $('#divBPTlf').css("display", "none");
        $('#divBPTezYear11').css("display", "none");
        $('#divBPTezYear10').css("display", "none");
        $('#divBPTezYear09').css("display", "none");
        $('#divBPTezYear08').css("display", "none");
        $('#divBPTezYear07').css("display", "none");
        $('#divBPTezYear06').css("display", "none");
        $('#divBPTezPage11').css("display", "none");
        $('#divBPTezPage10').css("display", "none");
        $('#divBPTezPage09').css("display", "none");
        $('#divBPTezPage08').css("display", "none");
        $('#divBPTezPage07').css("display", "none");
        $('#divBPTezPage06').css("display", "none");
        $('#divNPTYear').css("display", "none");
        $('#divTOBYear').css("display", "none");
        $('#divReERN').css("display", "none");

        $('#divAcctInfo').css("display", "none");
        $('#divAccount').css("display", "none");
        ShowReturns();
    } 	//window_onload

    function isMenuLoaded() {
        if (parent.MenuWin.document.readyState != 'complete'
        ) {
            setTimeout('isMenuLoaded()', 1000);
        } 	//if
    } 	//isLoaded
    function ispMenu_onclick(mnuElement) {
       
        var lbSrcElement = false
        
        if ($('#spnMenu').disabled == true) {
            return
        } 	//if
        if (mnuElement) {
        }
        else {
            //mnuElement = event.srcElement
            var evt = window.event || arguments.callee.caller.arguments[0] || arguments.callee.caller.caller.arguments[0];
            mnuElement = evt.srcElement || evt.target;



            lbSrcElement = true;
        } 	//if

        var caller_menu_id = mnuElement.id;
        //alert(caller_menu_id);

        if (caller_menu_id == '' || caller_menu_id == 'mnuOnline' || caller_menu_id.search('div') > -1) {

            return;
        } 	//if
        //Sanghamitra
        //if (!parent.DocWin.AppError || mnuElement.id == '' || mnuElement.className == 'mnuLabel') {
        //    if (mnuElement.id == 'mnuServices') {
        //        //				parent.DocWin.location.href = '../Login/Main.asp'
        //    } else {
        //        //			return
        //    } 	//if
        //} 	//if
        ////EHD 01152008 Task: Enable/Disable 'Go to Page 1' Button per Tom Wisner
        //Sanghamitra


        if (mnuElement.disabled == true) {
            return;
        } 	//if
        //alert(mnuElement.id);
        var a
        switch (mnuElement.id) {
            case 'mnuHome':
                var a = window.open('http://www.phila.gov/revenue', 'copdor');
                a.focus();
                break;
            case 'mnuNew':
                var a = window.open('http://www.phila.gov/revenue/aboutus/pages/News.aspx', 'copdor');
                a.focus();
                break;
                //EGOVWEB-50 Changed Link
            case 'mnuTaxGuide':
                //prev url --- http://www.phila.gov/revenue/Philadelphia_Tax_Guide.html'
                var a = window.open('http://www.phila.gov/Revenue/taxpro/Pages/rates.aspx', 'copdor');
                a.focus();
                break;
                //EGOVWEB-50 Changed Link
            case 'mnuTaxForms':
                //http://www.phila.gov/revenue/Form2011.html'
                var a = window.open('http://www.phila.gov/Revenue/taxpro/Pages/TaxReturns.aspx', 'copdor');
                a.focus();
                break;
            case 'mnuFilings':
                var a = window.open('http://www.phila.gov/Revenue/payments/Pages/efile.aspx', 'copdor')
                a.focus();
                break;
            case 'mnuRulings':
                var a = window.open('http://www.phila.gov/Revenue/taxpro/Pages/Regulations.aspx', 'copdor');
                a.focus();
                break;
            case 'mnuFAQs':
                var a = window.open('http://www.phila.gov/Revenue/aboutus/Pages/faq.aspx', 'copdor')
                a.focus();
                break;
            case 'mnuTips':
                var a = window.open('http://www.phila.gov/Revenue/businesses/Pages/FilingTips.aspx', 'copdor')
                a.focus();
                break;
        } 	//switch

        if (typeof (a) !== 'undefined') {
            return;
        } 	//if

        if (/*mnuElement.id == 'mnuReBPTez' ||*/mnuElement.id == 'mnuReNPT') {
            //	return
        } 	//if

        // parent.RightFrame.rows = '*,34'
        $(parent.RightFrame).attr("rows", '*,34');

        // MenuProcessCurrent(mnuElement);//Sangha
        window_onload();
        // ispHighlightMenu(mnuElement);//Sangha
        var tempTaxYr;
        var tempid;

        switch (mnuElement.id) {
            //Login Section		 
            case 'mnuLogLogon':
            case 'mnuLogNewAcct':
            case 'mnuLogPinApply':
            //case 'mnuLogPayCoupon':
            case 'mnuServices':
            case 'mnuServices_a':

                if ($('#divLogin').css('display') == 'none') {
                    $('#divLogout').css("display", "block");
                    //alert('menuelment');
                    ShowReturns();

                    return;
                }

                $('#divLogin').css("display", "block");
                $('#mnuServices').css("color", "black");

                if (document.getElementById('ifrmDocwin').contentWindow.location.href.search('Login/MainAsp') != -1) {

                    if (mnuElement.id == 'mnuLogLogon') {
                        document.getElementById('ifrmDocwin').contentWindow.ShowForm('LogLogin');

                    } else if (mnuElement.id == 'mnuLogNewAcct') {
                        //parent.DocWin.ShowForm('LogApplyFirst');
                        document.getElementById('ifrmDocwin').contentWindow.ShowForm('LogApplyFirst');

                    } else if (mnuElement.id == 'mnuLogPinApply') {
                        // parent.DocWin.ShowForm('LogPinApply');
                        document.getElementById('ifrmDocwin').contentWindow.ShowForm('LogPinApply');
                    } else if (mnuElement.id == 'mnuLogPayCoupon') {

                        //  parent.DocWin.ShowForm('LogCoupon');
                        document.getElementById('ifrmDocwin').contentWindow.ShowForm('LogCoupon');
                    } else if (mnuElement.id == 'mnuServices') {
                        $('#mnuServices').css("color", "blue");
                        // parent.DocWin.ShowForm('LogMain')
                        document.getElementById('ifrmDocwin').contentWindow.ShowForm('LogMain');
                    }
                }
                else {
                    //if (mnuElement.id == 'mnuLogPayCoupon') {
                    //    bLoadCoupon = true;
                    //}

                    //// parent.DocWin.location.href = '../Login/MainAsp'//Sanghamitra
                    //parent.setFrameUrl('Login/MainAsp');

                }
                break;
            case 'mnuLogPayCoupon':
                if (document.getElementById('ifrmDocwin').contentWindow.location.href.search('Login/MainAsp') != -1) {
                    // parent.DocWin.ShowForm('LogChangePin');
                    document.getElementById('ifrmDocwin').contentWindow.ShowForm('LogCoupon');
                } else {
                    bLoadCoupon = true;
                    //  parent.DocWin.location.href = '../Login/MainAsp';//sanghamitra
                    parent.setFrameUrl('Login/MainAsp');
                    $('#divLogout').css("display", "block");
                    $('#divAcctInfo').css("display", "block");
                    ShowReturns();

                }
                break;
            case 'mnuLogPinChange':
                if (document.getElementById('ifrmDocwin').contentWindow.location.href.search('Login/MainAsp') != -1) {
                    // parent.DocWin.ShowForm('LogChangePin');
                    document.getElementById('ifrmDocwin').contentWindow.ShowForm('LogChangePin');
                } else {
                    bChangePin = true;
                    //  parent.DocWin.location.href = '../Login/MainAsp';//sanghamitra
                    parent.setFrameUrl('Login/MainAsp');
                    $('#divLogout').css("display", "block");
                    $('#divAcctInfo').css("display", "block");
                    ShowReturns();

                }
                break;
            case 'mnuLogLogout':

                parent.$g.xmlAccount = parent.$g.xmlTemplate;
                parent.$g.xmlWage = parent.$g.xmlWageTemplate;
                parent.$g.xmlSchool = parent.$g.xmlSchoolTemplate;
                parent.$g.xmlBPTlf = parent.$g.xmlBPTlfTemplate;
                parent.$g.xmlBPTez = parent.$g.xmlBPTezTemplate;
                parent.$g.xmlNPT = parent.$g.xmlNPTTemplate;
                parent.$g.xmlBPTez_2015 = parent.$g.xmlBPTezTemplate_2015;
                parent.$g.xmlNPT_2015 = parent.$g.xmlNPTTemplate_2015;
                parent.$g.xmlTobacco = parent.$g.xmlTobaccoTemplate;
                parent.$g.xmlERN = parent.$g.xmlERNTemplate;

                //  if (parent.DocWin.location.href.search('Login/MainAsp') != -1) {

                if (document.getElementById('ifrmDocwin').contentWindow.location.href.search('Login/MainAsp') != -1) {
                    fillUserAfterLogin(false, '');

                    // $('#treeMenu ul li:has("div")').find('span:first').removeClass('opened');
                    $('#treeMenu ul li:has("div")').find('span:first').removeClass('opened');
                    $('#treeMenu ul li:has("div")').find('div').hide();

                    $('#spnMenu').find('.mnuNormal').css('background-color', '');
                    document.getElementById('ifrmDocwin').contentWindow.ShowForm('LogMain');


                }
                else {

                    $('#treeMenu ul li:has("div")').find('span:first').removeClass('opened');
                    $('#treeMenu ul li:has("div")').find('div').hide();

                    fillUserAfterLogin(false, '');

                    $('#spnMenu').find('.mnuNormal').css('background-color', '');
                    parent.setFrameUrl('Login/MainAsp');

                }

                $('#mnuOnline').css("display", "none");
                $('#divLogin').css("display", "block");
                $('#divReturns').css("display", "none");
                break;
            case 'mnuAcctInfo':
                if (parent.DocWin.location.href.search('ApplyMain') == -1) {
                    // parent.DocWin.location.href = '../Acct/ApplyMain';
                    parent.setFrameUrl('Acct/ApplyMain');
                }
            case 'mnuAcctProfile_s':
            case 'mnuAcctProfile':
            case 'mnuAcctTaxes':
            case 'mnuAcctAddresses':
            case 'mnuAcctPartners':
            case 'mnuAcctECheck':
                $('#divLogin').css("display", "none");
                if (mnuElement.id == 'mnuAcctProfile' || mnuElement.id == 'mnuAcctProfile_s') {
                    $('#spnMenu').find('.mnuNormal').css('background-color', '');
                    $('#mnuAcctProfile_s').css('background-color', '#9FC75D');


                }
                if (document.getElementById('ifrmDocwin').contentWindow.location.href.search('Acct/ApplyMain') != -1) {

                    // if (parent.DocWin.location.href.search('ApplyMain') != -1) {//Sangha
                    $('#divLogout').css("display", "block");
                    $('#mnuOnline').css("display", "block");
                    $('#divAccount').css("display", "block");
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO NAIC_CODE', '', 0) != '0') {

                        ShowReturns();
                    }
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ECHECK ACCOUNT_NUMBER', '', 0) == '') {
                        // $('#mnuAcctECheck').html('&nbsp;&nbsp;* e-Check enroll');//Sanghamitra
                        $('#mnuAcctECheck').html('<a  class="parent" > &nbsp;&nbsp;* e-Check enroll</a>');//Sanghamitra
                    }
                    else {
                        // $('#mnuAcctECheck').html('&nbsp;&nbsp;* e-Check');//sanghamitra
                        $('#mnuAcctECheck').html('<a  class="parent" > &nbsp;&nbsp;* e-Check</a>');//Sanghamitra
                    }
                    //  document.getElementById('ifrmDocwin').contentWindow.ShowForm('AcctProfile');//Sangha

                }//sangha
                else {
                    parent.setFrameUrl('Acct/ApplyMain');
                }




                break;



            case 'mnuTaxfilling_s':
            case 'mnuTaxfilling_a':
            case 'mnuTaxpayments_s':
            case 'mnuTaxpayments_a':
            case 'mnuFileReturns_s':
            case 'mnuFileReturn_a':
                $('#divLogout').css("display", "block");
                ShowReturns();
                break;

            case 'mnuPayCurrent':
                // parent.NavWin.ClearImages();
                $('#divAccount').css("display", "block");
                $('#divPayments').css("display", "block");
                $('#divPayments1').css("display", "block");//Sanghamitra
                $('#divReturns').css("display", "block");
                // MenuProcessClear(divAccount);
                break;
            case 'mnuPayBalances':
                //  parent.NavWin.ClearImages();
                // parent.DocWin.location.href = '../Balances/AccountBalances';//SAnghamitra
                parent.setFrameUrl('Balances/AccountBalances');
                $('#divLogout').css("display", "block");
                $('#divPayments').css("display", "block");
                $('#divPayments1').css("display", "block");//Sanghamitra
                $('#divReturns').css("display", "block");
                $('#divAcctInfo').css("display", "block");
                // MenuProcessClear(divAccount);
                break;
            case 'mnuPayHistory':
                // parent.NavWin.ClearImages()
                // parent.DocWin.location.href = '../E-check/Balances'//Sanghamitra
                parent.setFrameUrl('E-check/Balances');
                $('#divAccount').css("display", "block");
                $('#divPayments').css("display", "block");
                $('#divPayments1').css("display", "block");//Sanghamitra
                $('#divReturns').css("display", "block");
                // MenuProcessClear(divAccount);
                break;
            case 'mnuPayPayment':
                // parent.NavWin.ClearImages();
                // parent.DocWin.location.href = '../E-check/Payment';
                parent.setFrameUrl('E-check/Payment');
                $('#divAccount').css("display", "block");
                $('#divPayments').css("display", "block");
                $('#divPayments1').css("display", "block");//Sanghamitra
                $('#divReturns').css("display", "block");
                // MenuProcessClear(divAccount);
                break;
                //case 'mnuTaxfilling_s':
                //case 'mnuTaxfilling_a':
                //case 'mnuTaxpayments_s':
                //case 'mnuTaxpayments_a':
                //case 'mnuFileReturns_s':
                //case 'mnuFileReturns_a':
            case 'mnuReWage':
            case 'mnuWageYear02':
            case 'mnuWageYear03':
            case 'mnuWageYear04':
            case 'mnuWageYear05':
            case 'mnuWageYear06':
            case 'mnuWageYear07':
            case 'mnuWageYear08':
            case 'mnuWageYear09':
            case 'mnuWageYear10':
            case 'mnuWageYear11':
            case 'mnuWageYear12':
            case 'mnuWageYear13':
            case 'mnuWageYear14': //binoy
            case 'mnuWageYear15': 
            case 'mnuReSchool':
            case 'mnuSchoolYear02':
            case 'mnuSchoolYear03':
            case 'mnuSchoolYear04':
            case 'mnuSchoolYear05':
            case 'mnuSchoolYear06':
            case 'mnuSchoolYear07':
            case 'mnuSchoolYear08':
            case 'mnuSchoolYear09':
            case 'mnuSchoolYear10':
            case 'mnuSchoolYear11':
            case 'mnuSchoolYear12':
            case 'mnuSchoolYear13':
            case 'mnuSchoolYear14':
            case 'mnuSchoolYear15':
            case 'mnuLCF':
            case 'mnuBPTlf':
            case 'mnuBPTlfYear09':
            case 'mnuBPTlfYear10':
            case 'mnuBPTlfYear11':
            case 'mnuBPTlfYear12':
            case 'mnuBPTlfYear13':
            case 'mnuBPTlfYear14':
            case 'mnuBPTlfYear15':
            case 'mnuReBPTez':
            case 'mnuBPTezYear06':
            case 'mnuBPTezYear06Page1':
            case 'mnuBPTezYear06Page2':
            case 'mnuBPTezYear07':
            case 'mnuBPTezYear07Page1':
            case 'mnuBPTezYear07Page2':
            case 'mnuBPTezYear08':
            case 'mnuBPTezYear08Page1':
            case 'mnuBPTezYear08Page2':
            case 'mnuBPTezYear09':
            case 'mnuBPTezYear09Page1':
            case 'mnuBPTezYear09Page2':
            case 'mnuBPTezYear10':
            case 'mnuBPTezYear10Page1':
            case 'mnuBPTezYear10Page2':
            case 'mnuBPTezYear11':
            case 'mnuBPTezYear11Page1':
            case 'mnuBPTezYear11Page2':
            case 'mnuBPTezYear12':
            case 'mnuBPTezYear12Page1':
            case 'mnuBPTezYear12Page2':
            case 'mnuBPTezYear13':
            case 'mnuBPTezYear13Page1':
            case 'mnuBPTezYear13Page2':
            case 'mnuBPTezYear14':  //binoy
            case 'mnuBPTezYear15':
            case 'mnuReNPT':
            case 'mnuNPTYear06':
            case 'mnuNPTYear07':
            case 'mnuNPTYear08':
            case 'mnuNPTYear09':
            case 'mnuNPTYear10':
            case 'mnuNPTYear11':
            case 'mnuNPTYear12':
            case 'mnuNPTYear13':
            case 'mnuNPTYear14':
            case 'mnuNPTYear15':
            case 'mnuTOB':
            case 'mnuTOBYear10':
            case 'mnuTOBYear11':
            case 'mnuTOBYear12':
            case 'mnuTOBYear13':
            case 'mnuTOBYear14':
            case 'mnuReERN':
            case 'mnuReERNYear05':
            case 'mnuUO':
                $('#divLogout').css("display", "block");
                var bFound = false;
                sCurrReturnYear = "";

                if ((mnuElement.id == 'mnuReSchool' || mnuElement.id.substr(0, 13) == 'mnuSchoolYear') &&
                    GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '29') == 1) {

                    parent.$g.xmlSchool = parent.$g.xmlSchoolTemplate;
                    $('#divSchoolYear').css("display", "block");
                    bFound = true;
                    // parent.NavWin.ClearImages();
                    //  MenuProcessClear(divAccount);
                    if (mnuElement.id == 'mnuSchoolYear02') {
                        sCurrReturnYear = '2003';		//Tax Year 2002
                    } else if (mnuElement.id == 'mnuSchoolYear03') {
                        sCurrReturnYear = '2004';		//Tax Year 2003
                    } else if (mnuElement.id == 'mnuSchoolYear04') {
                        sCurrReturnYear = '2005';		//Tax Year 2004
                    } else if (mnuElement.id == 'mnuSchoolYear05') {
                        sCurrReturnYear = '2006';		//Tax Year 2005
                    } else if (mnuElement.id == 'mnuSchoolYear06') {
                        sCurrReturnYear = '2007';		//Tax Year 2006
                    } else if (mnuElement.id == 'mnuSchoolYear07') {
                        sCurrReturnYear = '2008';		//Tax Year 2007
                    } else if (mnuElement.id == 'mnuSchoolYear08') {
                        sCurrReturnYear = '2009';		//Tax Year 2008
                    } else if (mnuElement.id == 'mnuSchoolYear09') {
                        sCurrReturnYear = '2010';		//Tax Year 2009
                    } else if (mnuElement.id == 'mnuSchoolYear10') {
                        sCurrReturnYear = '2011';		//Tax Year 2010
                    } else if (mnuElement.id == 'mnuSchoolYear11') {
                        sCurrReturnYear = '2012';		//Tax Year 2011
                    } else if (mnuElement.id == 'mnuSchoolYear12') {
                        sCurrReturnYear = '2013';		//Tax Year 2012
                    } else if (mnuElement.id == 'mnuSchoolYear13') {
                        sCurrReturnYear = '2014';		//Tax Year 2013
                    } else if (mnuElement.id == 'mnuSchoolYear14') {
                        sCurrReturnYear = '2015';		//Tax Year 2014
                    }
                    else if (mnuElement.id == 'mnuSchoolYear15') {

                        sCurrReturnYear = '2016';		//Tax Year 2016
                    }
                    else if (mnuElement.id == 'mnuReSchool') {
                        sCurrReturnYear = GetTaxesEndYear('29', false);
                    } 	//if
                    // parent.DocWin.location.href = '../Returns/School?y=' + sCurrReturnYear
                    parent.setFrameUrl('Returns/School?y=' + sCurrReturnYear);//Sanghamitra
                }
                else if ((mnuElement.id == 'mnuReWage' || mnuElement.id.substr(0, 11) == 'mnuWageYear') &&
                    GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '1') == 1) {
                    xmlWage = parent.$g.xmlWageTemplate;
                    $('#divWageYear').css("display", "block");
                    bFound = true;
                    // parent.NavWin.ClearImages();
                    // MenuProcessClear(divAccount);
                    if (mnuElement.id == 'mnuWageYear02') {
                        sCurrReturnYear = '2003';		//Tax Year 2002
                    } else if (mnuElement.id == 'mnuWageYear03') {
                        sCurrReturnYear = '2004';		//Tax Year 2003/
                    } else if (mnuElement.id == 'mnuWageYear04') {
                        sCurrReturnYear = '2005';		//Tax Year 2004
                    } else if (mnuElement.id == 'mnuWageYear05') {
                        sCurrReturnYear = '2006';		//Tax Year 2005
                    } else if (mnuElement.id == 'mnuWageYear06') {
                        sCurrReturnYear = '2007';		//Tax Year 2006
                    } else if (mnuElement.id == 'mnuWageYear07') {
                        sCurrReturnYear = '2008';		//Tax Year 2007
                    } else if (mnuElement.id == 'mnuWageYear08') {
                        sCurrReturnYear = '2009'		//Tax Year 2008
                    } else if (mnuElement.id == 'mnuWageYear09') {
                        sCurrReturnYear = '2010';		//Tax Year 2009
                    } else if (mnuElement.id == 'mnuWageYear10') {
                        sCurrReturnYear = '2011';		//Tax Year 2010
                    } else if (mnuElement.id == 'mnuWageYear11') {
                        sCurrReturnYear = '2012';		//Tax Year 2011
                    } else if (mnuElement.id == 'mnuWageYear12') {
                        sCurrReturnYear = '2013';		//Tax Year 2012
                    } else if (mnuElement.id == 'mnuWageYear13') {
                        sCurrReturnYear = '2014';		//Tax Year 2013
                    } else if (mnuElement.id == 'mnuWageYear14') {     //binoy
                        sCurrReturnYear = '2015';		//Tax Year 2014  
                    } else if (mnuElement.id == 'mnuWageYear15') {     //binoy
                        sCurrReturnYear = '2016';		//Tax Year 2014  
                    } else if (mnuElement.id == 'mnuReWage') {
                        // Click header year will be end date
                        sCurrReturnYear = GetTaxesEndYear('1', false);

                    } 	//if

                    // parent.DocWin.location.href = '../Returns/Wage?y=' + sCurrReturnYear;//Sanghamitra
                    parent.setFrameUrl('Returns/Wage?y=' + sCurrReturnYear);//Sanghamitra
                    //NPT Form
                } else if ((mnuElement.id == 'mnuReNPT' || mnuElement.id.substr(0, 10) == 'mnuNPTYear') &&
                    //parent.DocWin.parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'TAX_ACCT[ACCOUNT = "3"]', '') == 1) {
                    GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '3') == 1) {
                    parent.$g.xmlNPT = parent.$g.xmlNPTTemplate;
                    parent.$g.xmlNPT_2015 = parent.$g.xmlNPTTemplate_2015;
                    $('#divNPTYear').css("display", "block");
                    //divNPTYear.style.display = 'block'
                    bFound = true;
                    // parent.NavWin.ClearImages();
                    //  MenuProcessClear(divAccount);
                    if (mnuElement.id == 'mnuNPTYear15') {
                        sCurrReturnYear = '2016';		//Tax Year 2015	
                    }
                    if (mnuElement.id == 'mnuNPTYear14') {
                        sCurrReturnYear = '2015';		//Tax Year 2013		
                    }
                    else if (mnuElement.id == 'mnuNPTYear13') {
                        sCurrReturnYear = '2014';		//Tax Year 2013		
                    }
                    else if (mnuElement.id == 'mnuNPTYear12') {
                        sCurrReturnYear = '2013';		//Tax Year 2012
                    } else if (mnuElement.id == 'mnuNPTYear11') {
                        sCurrReturnYear = '2012';		//Tax Year 2011
                    } else if (mnuElement.id == 'mnuNPTYear10') {
                        sCurrReturnYear = '2011';		//Tax Year 2010
                    } else if (mnuElement.id == 'mnuNPTYear09') {
                        sCurrReturnYear = '2010';		//Tax Year 2009
                    } else if (mnuElement.id == 'mnuNPTYear08') {
                        sCurrReturnYear = '2009'		//Tax Year 2008
                    } else if (mnuElement.id == 'mnuNPTYear07') {
                        sCurrReturnYear = '2008';		//Tax Year 2007
                    } else if (mnuElement.id == 'mnuNPTYear06') {
                        sCurrReturnYear = '2007';		//Tax Year 2006
                    } else if (mnuElement.id == 'mnuReNPT') {
                        sCurrReturnYear = GetTaxesEndYear('3', false);
                    } 	//if

                    if (lbSrcElement == true) {
                        // parent.DocWin.location.href = '../Returns/NPT/NPT?y=' + sCurrReturnYear;//sanghamitra
                        parent.setFrameUrl('Returns/NPT/NPT?y=' + sCurrReturnYear);
                    } else {
                        // parent.DocWin.location.href = '../../Returns/NPT/NPT?y=' + sCurrReturnYear;//sanghamitra
                        parent.setFrameUrl('Returns/NPT/NPT?y=' + sCurrReturnYear);
                    } 	//if

                    //Loss Carry Forward
                } else if (mnuElement.id == 'mnuLCF') {
                    //   parent.NavWin.ClearImages()
                    // MenuProcessClear(divAccount)
                    bFound = true
                    if (lbSrcElement == true) {
                        // parent.DocWin.location.href = '../Returns/LossCarryForwardAsp'//Sanghamitra
                        parent.setFrameUrl('Returns/LossCarryForwardAsp');
                    } else {
                        // parent.DocWin.location.href = '../../Returns/LossCarryForwardAsp'//Sanghamitra
                        parent.setFrameUrl('Returns/LossCarryForwardAsp');
                    } 	//if
                    //					divAccount.style.display = 'block'
                    //					divPayments.style.display = 'block'
                    //					divReturns.style.display = 'block'

                    //BPT Long Form
                } else if (mnuElement.id == 'mnuBPTlf' || mnuElement.id.substr(0, 12) == 'mnuBPTlfYear' &&
                    //parent.DocWin.parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'TAX_ACCT[ACCOUNT = "24"]', '') == 1) {
                    GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '24') == 1) {

                    parent.$g.xmlBPTlf = parent.$g.xmlBPTlfTemplate;
                    $('#divBPTlf').css("display", "block");
                    //divBPTlf.style.display = 'block'
                    if (mnuElement.id == 'mnuBPTlfYear09') {
                        sCurrReturnYear = '2010';		//Tax Year 2009
                    } else if (mnuElement.id == 'mnuBPTlfYear10') {
                        sCurrReturnYear = '2011';		//Tax Year 2010
                    } else if (mnuElement.id == 'mnuBPTlfYear11') {
                        sCurrReturnYear = '2012';		//Tax Year 2011
                    } else if (mnuElement.id == 'mnuBPTlfYear12') {
                        sCurrReturnYear = '2013';		//Tax Year 2012
                    } else if (mnuElement.id == 'mnuBPTlfYear13') {
                        sCurrReturnYear = '2014';		//Tax Year 2013
                    } else if (mnuElement.id == 'mnuBPTlfYear14') {
                        sCurrReturnYear = '2015';		//Tax Year 2014
                    } else if (mnuElement.id == 'mnuBPTlfYear15') {
                        sCurrReturnYear = '2016';		//Tax Year 2015
                    } else if (mnuElement.id == 'mnuBPTlf') {
                        // Click header year will be end date
                        sCurrReturnYear = GetTaxesEndYear('24', false);
                    } //if			
                    bFound = true;
                    // parent.NavWin.ClearImages();//Sanghamitra
                    //  MenuProcessClear(divAccount);
                    if (lbSrcElement == true) {
                        // parent.DocWin.location.href = '../Returns/BPT_LF/BPTlf?y=' + sCurrReturnYear;
                        parent.setFrameUrl('Returns/BPT_LF/BPTlf?y=' + sCurrReturnYear);

                    } else {
                        //  parent.DocWin.location.href = '../../Returns/BPT_LF/BPTlf?y=' + sCurrReturnYear;
                        parent.setFrameUrl('Returns/BPT_LF/BPTlf?y=' + sCurrReturnYear);
                    } 	//if
                    //BPT EZ
                }
                else if ((mnuElement.id == 'mnuReBPTez' || mnuElement.id.substr(0, 12) == 'mnuBPTezYear') && mnuElement.id.substr(14, 4) != 'Page' && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '24') == 1) {


                    parent.$g.xmlBPTez = parent.$g.xmlBPTezTemplate;
                    parent.$g.xmlBPTez_2015 = parent.$g.xmlBPTezTemplate_2015;

                    $('#divBPTezYear06').css("display", "block");
                    $('#divBPTezPage06').css("display", "none");
                    $('#divBPTezYear07').css("display", "block");
                    $('#divBPTezPage07').css("display", "none");
                    $('#divBPTezYear08').css("display", "block");
                    $('#divBPTezPage08').css("display", "none");
                    $('#divBPTezYear09').css("display", "block");
                    $('#divBPTezPage09').css("display", "none");
                    $('#divBPTezYear10').css("display", "block");
                    $('#divBPTezPage10').css("display", "none");
                    $('#divBPTezYear11').css("display", "block");
                    $('#divBPTezPage11').css("display", "none");
                    $('#divBPTezYear12').css("display", "block");
                    $('#divBPTezPage12').css("display", "none");

                    $('#divBPTezYear13').css("display", "block");
                    $('#divBPTezPage13').css("display", "none");
                    //$('#divBPTezYear14').css("display", "block");  //binoy
                    //$('#divBPTezPage14').css("display", "none");

                    if (mnuElement.id == 'mnuBPTezYear06') {
                        sCurrReturnYear = '2007';         // Tax Year 2006
                        $('#divBPTezPage06').css("display", "block");
                    } else if (mnuElement.id == 'mnuBPTezYear07') {
                        sCurrReturnYear = '2008';         // Tax Year 2007
                        $('#divBPTezPage07').css("display", "block");
                    } else if (mnuElement.id == 'mnuBPTezYear08') {
                        sCurrReturnYear = '2009';         // Tax Year 2008
                        $('#divBPTezPage08').css("display", "block");
                    } else if (mnuElement.id == 'mnuBPTezYear09') {
                        sCurrReturnYear = '2010';        // Tax Year 2009
                        $('#divBPTezPage09').css("display", "block");
                    } else if (mnuElement.id == 'mnuBPTezYear10') {
                        sCurrReturnYear = '2011';         // Tax Year 2010
                        $('#divBPTezPage10').css("display", "block");
                    } else if (mnuElement.id == 'mnuBPTezYear11') {
                        sCurrReturnYear = '2012';         // Tax Year 2011
                        $('#divBPTezPage11').css("display", "block");

                    } else if (mnuElement.id == 'mnuBPTezYear12') {
                        sCurrReturnYear = '2013';         // Tax Year 2012
                        $('#divBPTezPage12').css("display", "block");
                    } else if (mnuElement.id == 'mnuBPTezYear13') {
                        sCurrReturnYear = '2014';         // Tax Year 2013
                        $('#divBPTezPage13').css("display", "block");
                    } else if (mnuElement.id == 'mnuBPTezYear14') {    //binoy
                        sCurrReturnYear = '2015';         // Tax Year 2014
                        $('#divBPTezPage14').css("display", "block");
                    }
                    else if (mnuElement.id == 'mnuBPTezYear15') {    //binoy
                        sCurrReturnYear = '2016';         // Tax Year 2014
                        //$('#divBPTezPage14').css("display", "block");
                    }
                    else if (mnuElement.id == 'mnuReBPTez') {
                        // Click header year will be end date
                        sCurrReturnYear = GetTaxesEndYear('24', false);
                        // eval('divBPTezPage' + GetTaxesEndYear('24', true)).style.display = 'block';

                    }       //if 
                    bFound = true;
                    //  parent.NavWin.ClearImages();
                    //  MenuProcessClear(divAccount);
                    if (lbSrcElement == true) {
                        // parent.DocWin.location.href = '../Returns/BPTez?y=' + sCurrReturnYear;//Sanghamitra
                        parent.setFrameUrl('Returns/BPTez?y=' + sCurrReturnYear);
                    } else {
                        // parent.DocWin.location.href = '../../Returns/BPTez?y=' + sCurrReturnYear;//sanghamitra
                        parent.setFrameUrl('Returns/BPTez?y=' + sCurrReturnYear);
                    } 	//if

                    // parent.DocWin.ShowPage(2);//Sanghamitra

                    //EGOVWEB-42 Tobacco(TOB) Form
                } else if ((mnuElement.id == 'mnuTOB' || mnuElement.id.substr(0, 10) == 'mnuTOBYear') && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '27') == 1) {
                    //parent.DocWin.parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'TAX_ACCT[ACCOUNT = 27]', '') == 1{
                    //&& $(parent.$g.xmlAccount).find("TAX_ACCT").find("ACCOUNT:contains('27')")) {
                    //loadXmlAsync('../XML/AcctTemplate.xml', parseXml_xmlAccount);
                    //loadXmlAsync('../XML/AcctTemplate.xml', parseXml_xmlTemplate);
                    parent.$g.xmlTobacco = parent.$g.xmlTobaccoTemplate; //


                    //  divTOBYear.style.display =	'block';
                    $('#divTOBYear').css("display", "block");
                    bFound = true;
                    // parent.NavWin.ClearImages();
                    // MenuProcessClear(divAccount);
                    if (mnuElement.id == 'mnuTOBYear10') {
                        sCurrReturnYear = '2011';		//Tax Year 2010
                    } else if (mnuElement.id == 'mnuTOBYear11') {
                        sCurrReturnYear = '2012';	//Tax Year 2011
                    } else if (mnuElement.id == 'mnuTOBYear12') {
                        sCurrReturnYear = '2013';		//Tax Year 2012
                    } else if (mnuElement.id == 'mnuTOBYear13') {
                        sCurrReturnYear = '2014';		//Tax Year 2013
                    } else if (mnuElement.id == 'mnuTOBYear14') {
                        sCurrReturnYear = '2015';		//Tax Year 2014
                    } else if (mnuElement.id == 'mnuTOB') {
                        sCurrReturnYear = GetTaxesEndYear('27', false);
                    } 	//if
                    if (lbSrcElement == true) {

                        //parent.DocWin.location.href = '../Returns/Tobacco?y=' + sCurrReturnYear;///sanghamitra
                        parent.setFrameUrl('Returns/Tobacco?y=' + sCurrReturnYear);//Sanghamitra
                    } else {
                        // parent.DocWin.location.href = '../../Returns/Tobacco?y=' + sCurrReturnYear;//Sanghamitra
                        parent.setFrameUrl('Returns/Tobacco?y=' + sCurrReturnYear);
                    } 	//if
                    //EHD - 01152008 - Task ERN Return Added
                } else if ((mnuElement.id == 'mnuReERN' || mnuElement.id == 'mnuReERNYear05') &&
                    //parent.DocWin.parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'TAX_ACCT[ACCOUNT = "2"]', '') == 1) {
                        GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '2') == 1) {
                    xmlERN = xmlERNTemplate;

                    // divReERN.style.display = 'block'
                    $('#divReERN').css("display", "block");
                    bFound = true;
                    //   parent.NavWin.ClearImages();
                    // MenuProcessClear(divAccount);
                    if (mnuElement.id == 'mnuReERNYear06') {
                        sCurrReturnYear = '2006';
                    } else if (mnuElement.id == 'mnuReERNYear07') {
                        sCurrReturnYear = '2007';
                    } 	//if
                    //  parent.DocWin.location.href = '../Returns/ERN/ERNAsp?y=' + sCurrReturnYear;//sanghamitra
                    parent.setFrameUrl('Returns/ERN/ERNAsp?y=' + sCurrReturnYear);
                    //EHD - 01152008 - Task UO Return Added
                    //EGOVWEB-74 Restarted U&O -->
                } else if (mnuElement.id == 'mnuUO') {

                    //			}else if ((mnuElement.id == 'mnuUO' || 
                    //					mnuElement.id == 'mnuUOYear11' || mnuElement.id == 'mnuReUOYearB') && 
                    //					parent.DocWin.parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'TAX_ACCT[ACCOUNT = 84]', '') == 1) {			
                    //				divUO.style.display = 'block'
                    bFound = true
                    // parent.NavWin.ClearImages();
                    // MenuProcessClear(divAccount);
                    //				if (mnuElement.id == 'mnuUO' ||
                    //						mnuElement.id == 'mnuUOYear11') {
                    //					sCurrReturnYear = '2009'		//Tax Year 2008
                    //				} else if (mnuElement.id == 'mnuReUOYearB') {
                    //					sCurrReturnYear = '2010'		//Tax Year 2009
                    //				}		//if
                    //				parent.DocWin.location.href = '../Returns/UO.asp?y=' + sCurrReturnYear
                    //clipboardData.setData ('Text', oUOForm.xml.xml);

                    // parent.DocWin.location.href = '../UO/UOList';//Sanghamitra
                    parent.setFrameUrl('UO/UOList');
                } 	//if
                if (bFound) {

                    //divAcctInfo.style.display = 'block'
                    $('#divAcctInfo').css("display", "block");
                } else {
                    //divAccount.style.display = 'none';
                    $('#divAccount').css("display", "none");
                    //  parent.DocWin.location.href = '../Acct/ApplyMain';//sanghamitra
                    parent.setFrameUrl('Acct/ApplyMain');
                    switch (mnuElement.id) {
                        case 'mnuReWage':
                            alert('You are not Registered for Wage Taxes...\n' +
                            'Click the Tax Type Tab at the bottom of the Profile Screen\n' +
                            'Click the Wage Checkbox and Enter Monthly Taxable Wages\n' +
                            'Click the Submit Tab to register for Wage Tax.');
                            break;
                        case 'mnuReSchool':
                            alert('You are not Registered for School Taxes...\n' +
                            'Click the Tax Type Tab at the bottom of the Profile Screen\n' +
                            'Click the School Income Checkbox\n' +
                            'Click the Submit Tab to register for School Income Tax.');
                            break;
                        case 'mnuReBPTez':
                            alert('You are not Registered for Business Income and Receipts Taxes...\n' +
                            'Click the Tax Type Tab at the bottom of the Profile Screen\n' +
                            'Click the Business Income and Receipts Checkbox\n' +
                            'Click the Submit Tab to register for Business Income and Receipts Tax.');
                        case 'mnuReNPT':
                            alert('You are not Registered for Net Profit Taxes...\n' +
                            'Click the Tax Type Tab at the bottom of the Profile Screen\n' +
                            'Click the Net Profit Checkbox\n' +
                            'Click the Submit Tab to register for Net Profit Tax.');
                            break;
                        case 'mnuTOB':
                            alert('You are not Registered for Tobacco Taxes...\n' +
                            'Click the Tax Type Tab at the bottom of the Profile Screen\n' +
                            'Click the Tobacco Checkbox\n' +
                            'Click the Submit Tab to register for Tobacco Tax.');
                            break;
                            //EHD - 01152008 - Task UO Return Added
                        case 'mnuUO':
                            alert('You are not Registered for Use & Occupancy Taxes...\n' +
                            'Click the Tax Type Tab at the bottom of the Profile Screen\n' +
                            'Click the Use & Occupancy Checkbox\n' +
                            'Click the Submit Tab to register for Use & Occupancy Tax.');
                            break;
                    } 	//switch
                } 	//if
                // divLogout.style.display = 'block'
                $('#divLogout').css("display", "block");
                ShowReturns();
               // loadpage();// binoy
                break
        } 	//switch
    } 	//ispMenu_onclick


    function isLoaded() {
        if (parent.DocWin.document.readyState != 'complete') {
            setTimeout('isLoaded()', 100);
        } 	//if
    } 	//isLoaded


    function InstructionLinks() {

        var a
        switch (gsInstructionItem) {
            case '#Profile':
                gsInstructionItem = '#2';
                break;
            case '#TaxType':
                gsInstructionItem = '#3';
                break;
            case '#Address':
                gsInstructionItem = '#4';
                break;
            case '#Officer':
                gsInstructionItem = '#5';
                break;
            case '#WageReturn':
                gsInstructionItem = '#6';
                break;
            case '#SchoolReturn':
                gsInstructionItem = '#7';
                break;
            case '#BIR':
                $('#mnuLCF').click();
                return;

                //		case '#BptLf':
                //			a = window.open('../PDF/Online Long Form - BPT Filing Instructions.pdf')
                //			a.focus()
                //			return
                //		case '#BptEz':
                //			a = window.open('../PDF/Online EZ - BPT Filing Instructions.pdf')
                //			a.focus()
                //			return
            case '#NPTReturn':
                a = window.open('../../PDF/Online EZ - NPT Filing Instructions.pdf');
                a.focus();
                return
                //		case '#TobaccoReturn':
                //			a = window.open('../PDF/Online Tobacco Filing Instructions.pdf')
                //			a.focus()
                //			return
        } 	//switch

        a = window.open('../PDF/Online Services Instructions.pdf', 'copdor');
        a.focus();
    } 	//InstructionLinks
    function ShowReturns() {
        var lDisplay = false;

        //divReturns.style.display = 'none';
        $('#divReturns').css("display", "none");
        // mnuReWage.style.display = 'none';
        $('#mnuReWage').css("display", "none");
        //mnuReSchool.style.display = 'none';
        $('#mnuReSchool').css("display", "none");
        //  mnuBPTlf.style.display = 'none';
        $('#mnuLCF').css("display", "none");
        $('#mnuBPTlf').css("display", "none");
        //mnuReBPTez.style.display = 'none';
        $('#mnuReBPTez').css("display", "none");
        //mnuReNPT.style.display = 'none';
        $('#mnuReNPT').css("display", "none");
        // mnuTOB.style.display = 'none';
        $('#mnuTOB').css("display", "none");
        // mnuUO.style.display = 'none';
        $('#mnuUO').css("display", "none");
        // mnuReERN.style.display = 'none';
        $('#mnuReERN').css("display", "none");

        var taxcount = 0;
        TotalAccounts = 0
        //	iCount = parent.$x.ispXmlGetRecCount(parent.$g.parent.$g.xmlAccount, 'TAX_ACCT', '') 
        //	EntityStartDate = parent.$x.ispXmlGetFieldVal(parent.$g.parent.$g.xmlAccount, 'ENTITY_INFO/START_DATE', '', 0) 
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
                if (lDisplay == true && divLogout.style.display == 'block') {

                    $('#divReturns').css("display", "block");
                    //EGOVWEB-107 Added

                    $('#divPayments').css("display", "block");
                    $('#divPayments1').css("display", "block");//Sanghamitra

                }

                //if
            }		//if
        }		//for


        HideMenuTaxYears(); //chayan
    } 	//ShowReturns

    function GetTaxesEndYear(taxAcctCode, YearMinus1) { //chayan
        //alert(parent.DocWin.parent.$x.ispXmlGetFieldVal(parent.$g.parent.$g.xmlAccount, 'TAX_ACCT[ACCOUNT ="' + taxAcctCode + '"] PRK_ID', ''));
        //GetNodeCount
        //GetInnerNodeText

        var a;
        var TwoBtyeDate;
        if (YearMinus1 == true) {
            // a = parent.DocWin.parent.$x.ispXmlGetFieldVal(parent.$g.parent.$g.xmlAccount, 'TAX_ACCT[ACCOUNT ="' + taxAcctCode + '"] PRK_ID', '').slice(-2)

            a = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', taxAcctCode).slice(-2);
            TwoBtyeDate = String(parseInt(a, 10) - 1);
            if (TwoBtyeDate == 'NaN') { TwoBtyeDate = ''; }
            if (TwoBtyeDate.length == 1) {
                TwoBtyeDate = '0' + TwoBtyeDate;
            } 	//if
            return TwoBtyeDate;
        } else {
            //a = parent.DocWin.parent.$x.ispXmlGetFieldVal(parent.$g.parent.$g.xmlAccount, 'TAX_ACCT[ACCOUNT ="' + taxAcctCode + '"] PRK_ID', '').slice(-4)
            //clipboardData.setData ('Text', parent.$g.parent.$g.xmlAccount.xml.xml);
            a = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', taxAcctCode).slice(-4);

            var century = a.substr(0, 2);

            TwoBtyeDate = String(parseInt(a.slice(-2), 10))	// + 1)

            if (TwoBtyeDate == 'NaN') { TwoBtyeDate = ''; }
            if (TwoBtyeDate.length == 1) {
                TwoBtyeDate = '0' + TwoBtyeDate;
            } 	//if
            return century + TwoBtyeDate;
        } 	//if
    } 	//GetTaxesEndYear

    function getFormatedDate() {
        var tmpDate, lDate, mToday;
        mToday = new Date();
        return mToday.getMonth() + 1 + "/" + mToday.getDate() + "/" + mToday.getFullYear();

    }
    function ReformatTaxesEndDate() {
        //1 = Wage  29 = School  24 = BPT  3 = NPT  27 = Tobacco
        var aAccounts = new Array();
        aAccounts[0] = 1; aAccounts[1] = 29; aAccounts[2] = 24; aAccounts[3] = 3; aAccounts[4] = 27;
        var tmpDate, lDate, mToday;
        var i;
        // mToday = new Date();
        mToday = getFormatedDate();
        //clipboardData.setData ('Text', parent.$g.parent.$g.xmlAccount.xml.xml);
        for (i = 0; i < aAccounts.length; i++) {
            lDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', aAccounts[i]);
            //alert(lDate);


            if (lDate == null || lDate == '') {
                //alert(mToday.toString());
                //	parent.$g.xmlAccount = UpdateElementText(parent.$g.xmlAccount,'12/31/' + String(parseInt(mToday.toString().slice(-4)) + 1),'TAX_ACCT ACCOUNT',aAccounts[i],'PRK_ID');
                parent.$g.xmlAccount = UpdateElementText(parent.$g.xmlAccount, '12/31/' + String(parseInt(mToday.toString().slice(-4))), 'TAX_ACCT ACCOUNT', aAccounts[i], 'PRK_ID');
                //alert('out');
                // parent.DocWin.parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '12/31/' + String(parseInt(mToday.toString().slice(-4)) + 1), 'TAX_ACCT[ACCOUNT = "' + aAccounts[i] + '"] PRK_ID', '', 0);
            }
            else if (lDate != null && lDate.search('/') == -1) {

                tmpDate = lDate.substr(4, 2) + '/' + lDate.substr(6, 2) + '/' + lDate.substr(0, 4);
                parent.$g.xmlAccount = UpdateElementText(parent.$g.xmlAccount, tmpDate, 'TAX_ACCT ACCOUNT', aAccounts[i], 'PRK_ID');
                //$(parent.$g.xmlAccount).find("TAX_ACCT").find("ACCOUNT:contains('" + aAccounts[i] + "')").parent().find("PRK_ID").text(tmpDate));
                // parent.DocWin.parent.$x.ispXmlSetFieldVal(parent.$g.parent.$g.xmlAccount, tmpDate, 'TAX_ACCT[ACCOUNT =" ' + aAccounts[i] + '"] PRK_ID', '', 0);

            } 	//if
            //if
        } 	//for
        //XMLToString(parent.$g.xmlAccount);
    } 	//ReformatTaxesEndDate

    function HideMenuTaxYears() {

        //1 = Wage  29 = School  24 = BPT  3 = NPT  27 = Tobacco
        var iWageItems = 0, iSchoolItems = 0, iBPTezItems = 0, iBPTlfItems = 0, iNPTItems = 0, iTobaccoItems = 0;
        ReformatTaxesEndDate();
        var startDate;
        var prkId;


        a = parent.document.getElementsByTagName('li'); //removed menuwin Sangha

        for (i = 0; i < a.length; i++) {

            if (a[i].id.indexOf('mnuWageYear') != -1 && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '1') == 1) {
                startDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '1').slice(-4);
                prkId = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '1').slice(-4);

                if (startDate != '' && '20' + a[i].id.slice(-2) < startDate) {
                    $(a[i]).css("display", "none");
                } else if (prkId != '' && '20' + a[i].id.slice(-2) > prkId) {


                    $(a[i]).css("display", "none");
                } else {
                    $(a[i]).css("display", "block");
                    iWageItems = iWageItems + 1;
                    //alert("iWageItems: " + iWageItems);

                }		//if
                //School Menu Items
            } else if (a[i].id.indexOf('mnuSchoolYear') != -1 && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '29') == 1) {

                startDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '29').slice(-4);
                prkId = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '29').slice(-4);

                if (startDate != '' && '20' + a[i].id.slice(-2) < startDate) {

                    $(a[i]).css("display", "none");
                } else if (prkId != '' && '20' + a[i].id.slice(-2) > prkId) {

                    $(a[i]).css("display", "none");
                } else {
                    $(a[i]).css("display", "block");
                    iSchoolItems = iSchoolItems + 1;
                    //alert("iSchoolItems: " + iSchoolItems);
                }		//if
                //NPT Menu Items
            } else if (a[i].id.indexOf('mnuNPTYear') != -1 && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '3') == 1) {

                startDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '3').slice(-4);
                prkId = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '3').slice(-4);


                if (startDate != '' && '20' + a[i].id.slice(-2) < startDate) {
                    $(a[i]).css("display", "none");
                } else if (prkId != '' && '20' + a[i].id.slice(-2) > prkId) {

                    $(a[i]).css("display", "none");
                } else {
                    $(a[i]).css("display", "block");
                    iNPTItems = iNPTItems + 1;
                }		//if
                //BPTez Menu Items
            } else if (a[i].id.indexOf('mnuBPTezYear') != -1 && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '24') == 1) {


                startDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '24').slice(-4);
                prkId = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '24').slice(-4);


                if (startDate != '' && '20' + a[i].id.slice(-2) < startDate) {

                    $(a[i]).css("display", "none");
                } else if (prkId != '' && '20' + a[i].id.slice(-2) > prkId) {

                    $(a[i]).css("display", "none");
                } else {
                    $(a[i]).css("display", "block");
                    //alert(a[i].id);
                    iBPTezItems = iBPTezItems + 1;
                }		//if
                //BPTlf Menu Items
            } else if (a[i].id.indexOf('mnuBPTlfYear') != -1 && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '24') == 1) {

                startDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '24').slice(-4);
                prkId = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '24').slice(-4);


                if (startDate != '' && '20' + a[i].id.slice(-2) < startDate) {

                    $(a[i]).css("display", "none");
                } else if (prkId != '' && '20' + a[i].id.slice(-2) > prkId) {

                    $(a[i]).css("display", "none")
                } else {
                    $(a[i]).css("display", "block");
                    iBPTlfItems = iBPTlfItems + 1;
                }		//if
                //Tobacco Menu Items
            } else if (a[i].id.indexOf('mnuTOBYear') != -1 && GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '27') == 1) {

                startDate = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'START_DATE', '27').slice(-4);
                prkId = GetInnerNodeText(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', 'PRK_ID', '27').slice(-4);


                if (startDate != '' && '20' + a[i].id.slice(-2) < startDate) {

                    $(a[i]).css("display", "none");
                } else if (prkId != '' && '20' + a[i].id.slice(-2) > prkId) {

                    $(a[i]).css("display", "none")
                } else {
                    $(a[i]).css("display", "block");
                    iTobaccoItems = iTobaccoItems + 1;
                }		//if
            }		//if
        }		//for

        /*
        alert("iWageItems: " + iWageItems);
        alert("iSchoolItems: " + iSchoolItems);
        alert("iNPTItems: " + iNPTItems);
        alert("iBPTezItems: " + iBPTezItems);
        alert("iBPTlfItems: " + iBPTlfItems);
        */

        if (iWageItems == 0) {
            $('#mnuReWage').css("display", "none");
            //mnuReWage.style.display = 'none'
        }		//if
        if (iSchoolItems == 0) {
            $('#mnuReSchool').css("display", "none");
            //mnuReSchool.style.display = 'none'
        }		//if
        if (iNPTItems == 0) {
            $('#mnuReNPT').css("display", "none");
            //mnuReNPT.style.display = 'none'
        }		//if
        if (iBPTezItems == 0) {
            $('#mnuReBPTez').css("display", "none");//Sangha
            //mnuReBPTez.style.display = 'none'
        }		//if
        if (iBPTlfItems == 0) {
            $('#mnuBPTlf').css("display", "none");
            //mnuBPTlf.style.display = 'none'
        }		//if
        if (iTobaccoItems == 0) {
            $('#mnuTOB').css("display", "none");
            //mnuTOB.style.display = 'none'

        }

        //alert(iWageItems + '  ' + iSchoolItems + '  ' + iNPTItems + '  ' + iBPTezItems + '  ' +  iBPTlfItems)
    }		//HideMenuTaxYears
    function loadpage() {

        //if ($.browser.mozilla || $.browser.firefox || $.browser.opera || $.browser.safari || $.browser.chrome) {

        //    //if (mnuElement.id == 'mnuAcctProfile' || mnuElement.id == 'mnuAcctProfile_s' || mnuElement.id == 'mnuOnline' ) {
        //    try {
        //        var iFrameID = parent.window.frames['ifrmDocwin'];

        //        //$(iFrameID).height($(iFrameID).contents().find("html").height() + 70);
        //    }
        //    catch (ee) {
        //        var iFrameID1 = parent.document.getElementById('ifrmDocwin');

        //        //iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";

        //    }

        //    /* }
        //     else {
        //         $(iFrameID).height($(iFrameID).contents().find("html").height() + 70);
        //     }*/
        //}
        //else {
        //    var iFrameID1 = parent.document.getElementById('ifrmDocwin');
            // if (mnuElement.id == 'mnuAcctProfile' || mnuElement.id == 'mnuAcctProfile_s' || mnuElement.id == 'mnuOnline') {
            //iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";

            /*  }
              else {
                  
                  iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";
              }*/

       

    } //binoy
</script>




<div class="cbp-spmenu-push">
    <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left">



        <h3>Inside our Site
                    <button class="toggle-menu menu-left jPushMenuBtn" style="position: relative; left: 110px;"></button>
        </h3>
        <span id="spnMenu" onclick="ispMenu_onclick()">
            <div id="treeMenu">

                <ul class="nano-content">
                    <li class="mnuNormal"><span id="mnuHome" class="closed statics"><a class="parent">Revenue Home Page</a></span></li>
                    <li class="mnuNormal"><span id="mnuNew" class="closed statics"><a class="parent">What's New</a></span></li>
                    <li class="mnuNormal"><span id="mnuTaxGuide" class="closed statics"><a class="parent">Plain Talk Tax Guide</a></span></li>
                    <li class="mnuNormal"><span id="mnuTaxForms" class="closed statics"><a class="parent">Tax Forms & Instructions</a></span></li>

                    <li><span id="mnuServices" class="closed"><a id="mnuServices_a" class="parent">Online Services Home</a></span>
                        <div style="display: block">
                            <ul id="divLogin">
                                <li class="mnuNormal"><span class="closed for_spacing" id="mnuLogLogon">Login</span></li>
                                <li class="mnuNormal"><span class="closed for_spacing" id="mnuLogPinApply">Pin Apply</span></li>
                                <li class="mnuNormal"><span class="closed for_spacing" id="mnuLogNewAcct">Account Apply</span></li>
                            </ul>
                            <ul id="divLogout">
                                <li class="mnuNormal"><span class="closed for_spacing" id="mnuLogLogout">Logout</span></li>
                                <li class="mnuNormal"><span class="closed for_spacing" id="mnuLogPinChange">Pin Change</span></li>
                                <li class="mnuNormal"><span class="closed for_spacing" id="mnuLogPayCoupon">Payment</span></li>

                            </ul>
                        </div>

                        <%-- <div style="display: none" id="divLogout">
                            <ul>
                                <li class="mnuNormal"><span class="closed for_spacing" id="mnuLogLogout">Logout</span></li>
                                <li class="mnuNormal"><span class="closed for_spacing" id="mnuLogPinChange">Pin Change</span></li>
                                <li class="mnuNormal"><span class="closed for_spacing" id="mnuLogPayCoupon">Payment</span></li>

                            </ul>
                        </div>--%>

                    </li>


                    <%-- 1/12/14 Sanghamitra:This portion is not needed--%>
                    <%--  <li id="mnuOnline" style="display: none;"><span class="closed" ><a  class="parent">Taxpayer Information</a></span>
             <div  style="display: none; ">
                         <ul id="divAccount">
                <li ><span class="closed for_spacing" id="mnuAcctProfile" >* Profile</span></li>
                <li ><span class="closed for_spacing" id="mnuAcctTaxes">* Accounts</span></li>
                <li ><span class="closed for_spacing" id="mnuAcctAddresses">&nbsp;&nbsp;* Addresses</span></li> 
                <li ><span class="closed for_spacing" id="mnuAcctPartners"> &nbsp;&nbsp;* Partners/Officers</span></li>
                <li ><span class="closed for_spacing" id="mnuAcctECheck"> &nbsp;&nbsp;* E-Check</span></li> 
                         </ul>
                     </div>
              </li>     --%>
                    <%-- 1/12/14 Sanghamitra:This portion is not needed--%>
                    <li id="mnuOnline" style="display: none;"><span class="closed" id="mnuAcctProfile_s"><a class="parent" id="mnuAcctProfile">Taxpayer Information</a></span>
                    </li>
                    <%-- <li ><span class="closed for_spacing" id="mnuAcctProfile" style="display:none" >* Profile</span></li> --%>

                    <li style="display: none;" id="divPayments"><span class="closed" id="mnuTaxpayments_s"><a id="mnuTaxpayments_a" class="parent">Tax Payments</a></span>
                        <div style="display: none;">
                            <ul>
                                <li class="mnuNormal"><span class="closed" id="mnuPayCurrent" style="display: none">Current Payments</span></li>
                                <li class="mnuNormal"><span class="closed" id="mnuPayBalances">Outstanding Balances</span></li>
                                <li class="mnuNormal"><span class="closed" id="mnuPayHistory" style="display: none">&nbsp;&nbsp;Payment History</span></li>
                                <li class="mnuNormal"><span class="closed" id="mnuPayPayment" style="display: none">&nbsp;&nbsp; eCheck Payment</span></li>
                                <li class="mnuNormal"><span class="closed" id="mnuPayAgreement" style="display: none">&nbsp;&nbsp;Payment Agreement</span></li>
                            </ul>
                        </div>
                    </li>

                    <li id="divPayments1" style="display: none;"><span class="closed" id="mnuTaxfilling_s"><a id="mnuTaxfilling_a" class="parent">Tax Filing Information</a></span>

                        <div style="display: none;">
                            <ul>
                                <%-- <li  class="mnuNormal"><span class="closed for_spacing" id="mnuLCF" >Loss Carry Forward and Estimated Payments</span></li>--%>
                                <li class="mnuNormal year_spacing" id="mnuLCF" style="cursor: pointer">Loss Carry Forward and Estimated Payments</li>

                            </ul>
                        </div>
                    </li>


                    <li style="display: none;" id="divReturns"><span class="closed" id="mnuFileReturns_s"><a class="parent" id="mnuFileReturn_a">File Returns</a></span>
                        <div style="display: none;">
                            <ul>
                                <li id="mnuReWage" class="test"><span class="closed"><a class="parent">Wage</a></span>
                                    <div style="background: #666; display: none;">
                                        <ul>
                                            <li id="mnuWageYear15" class="mnuNormal year_spacing">2015</li>
                                            <li id="mnuWageYear14" class="mnuNormal year_spacing">2014</li>
                                            <li id="mnuWageYear13" class="mnuNormal year_spacing">2013</li>
                                            <li id="mnuWageYear12" class="mnuNormal year_spacing">2012</li>
                                            <li id="mnuWageYear11" class="mnuNormal year_spacing">2011</li>
                                            <li id="mnuWageYear10" class="mnuNormal year_spacing">2010</li>
                                        </ul>
                                    </div>
                                </li>
                                <li id="mnuReSchool"><span class="closed"><a class="parent">School Income</a></span>
                                    <div style="background: #666; display: none;">
                                        <ul>
                                            <li id="mnuSchoolYear15" class="mnuNormal year_spacing">2015</li>
                                            <li id="mnuSchoolYear14" class="mnuNormal year_spacing">2014</li>
                                            <li id="mnuSchoolYear13" class="mnuNormal year_spacing">2013</li>
                                            <li id="mnuSchoolYear12" class="mnuNormal year_spacing">2012</li>
                                            <li id="mnuSchoolYear11" class="mnuNormal year_spacing">2011</li>
                                            <li id="mnuSchoolYear10" class="mnuNormal year_spacing">2010</li>
                                        </ul>
                                    </div>
                                </li>
                                <li id="mnuBPTlf"><span class="closed"><a class="parent">Business Income and Receipts Long Form</a></span>
                                    <div style="display: none; background: #666;">
                                        <ul>
                                            <%--<li id="mnuBPTlfYear14" class="mnuNormal">2014</li>--%>
                                            <li id="mnuBPTlfYear15" class="mnuNormal year_spacing">2015</li>
                                            <li id="mnuBPTlfYear14" class="mnuNormal year_spacing">2014</li>
                                            <li id="mnuBPTlfYear13" class="mnuNormal year_spacing">2013</li>
                                            <li id="mnuBPTlfYear12" class="mnuNormal year_spacing">2012</li>
                                            <li id="mnuBPTlfYear11" class="mnuNormal year_spacing">2011</li>
                                            <li id="mnuBPTlfYear10" class="mnuNormal year_spacing">2010</li>
                                        </ul>
                                    </div>
                                </li>
                                <li id="mnuReBPTez"><span class="closed"><a class="parent">Business Income and Receipts EZ</a></span>
                                    <div style="display: none; background: #666;">
                                        <ul>
                                            <li id="mnuBPTezYear15" class="mnuNormal year_spacing">2015</li>
                                            <li id="mnuBPTezYear14" class="mnuNormal year_spacing">2014</li>
                                            <li id="mnuBPTezYear13" class="mnuNormal year_spacing">2013</li>
                                            <li id="mnuBPTezYear12" class="mnuNormal year_spacing">2012</li>
                                            <li id="mnuBPTezYear11" class="mnuNormal year_spacing">2011</li>
                                            <li id="mnuBPTezYear10" class="mnuNormal year_spacing">2010</li>
                                        </ul>
                                    </div>
                                </li>
                                <li id="mnuReNPT"><span class="closed"><a class="parent">Net Profit</a></span>
                                    <div style="display: none; background: #666;">
                                        <ul>
                                            <li id="mnuNPTYear15" class="mnuNormal year_spacing">2015</li>
                                            <li id="mnuNPTYear14" class="mnuNormal year_spacing">2014</li>
                                            <li id="mnuNPTYear13" class="mnuNormal year_spacing">2013</li>
                                            <li id="mnuNPTYear12" class="mnuNormal year_spacing">2012</li>
                                            <li id="mnuNPTYear11" class="mnuNormal year_spacing">2011</li>
                                            <li id="mnuNPTYear10" class="mnuNormal year_spacing">2010</li>
                                        </ul>
                                    </div>
                                </li>
                                <li id="mnuTOB"><span class="closed"><a class="parent">Tobacco</a></span>
                                    <div style="display: none; background: #666;">
                                        <ul>
                                            <li id="mnuTOBYear14" class="mnuNormal year_spacing">2014</li>
                                            <li id="mnuTOBYear13" class="mnuNormal year_spacing">2013</li>
                                            <li id="mnuTOBYear12" class="mnuNormal year_spacing">2012</li>
                                            <li id="mnuTOBYear11" class="mnuNormal year_spacing">2011</li>
                                            <li id="mnuTOBYear10" class="mnuNormal year_spacing">2010</li>
                                        </ul>
                                    </div>
                                </li>
                                <li id="mnuUO" class="mnuNormal for_spacing UOSTYLE">Use & Occupancy
                
                                </li>

                            </ul>
                        </div>
                    </li>
                    <li class="mnuNormal"><span class="closed statics"><a class="parent">Electronic Filing</a></span></li>
                    <li class="mnuNormal"><span class="closed statics"><a class="parent">Technical Rulings</a></span></li>


                </ul>
            </div>

        </span>
        <div class="clear"></div>



    </nav>
</div>

<%--<script type="text/javascript" src="Content/js/jquery.js"></script>--%>
<script type="text/javascript" src="Content/js/bootstrap.min.js"></script>
<!-- FOR TREE MENU -->
<script type="text/javascript" src="Content/js/treeMenu.js"></script>


