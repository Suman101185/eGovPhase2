<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<!DOCTYPE html>
<html>
<head >
<!-- Bootstrap Core CSS -->
<link href="../Content/Styles/bootstrap.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="../Content/Styles/copegov.css" rel="stylesheet">
<link href="../Content/Styles/style.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css">

<script id="clientEventHandlersJS" language="javascript" type="text/javascript">
    var arrAcc = new Array();
    var arrControls = new Array('chkBPT', 'chkNPT', 'chkWage', 'chkTobacco','chkSchool', 'chkEarn', 'chkLiquor', 'chkUO',
             'chkParking', 'chkHotel', 'chkAmusement', 'chkCoin', 'chkRental');
    var errTaxes = '', initTaxes = false;

    var TotalAccounts = 0;

    function ClearTaxes() {

        for (i = 0; i < arrControls.length; i++) {
            chkName = arrControls[i];
            chkObj = document.getElementById(chkName);
            txtObj = document.getElementById('txt' + chkObj.id.slice(3));
            if (chkObj.parentElement.parentElement.parentElement.parentElement.parentElement.style.display == 'none') {
                chkObj.checked = false;
                txtObj.value = '';
                $('#txtObj').css('display', 'none');// = 'hidden';
            }		//if
        }		//for
    }		//ClearTaxes

    function DisplayTaxes() {       
       
        var ddOrgType = document.getElementById('ddOrgType');
        var ddNAIC1 = document.getElementById('ddNAIC1');
        var chkNPT = document.getElementById('chkNPT');
        var txtNPT = document.getElementById('txtNPT');
        var txtBusStartDate = document.getElementById('txtBusStartDate');      
        $(AppError_tax).text('');
        $('#divAcctTaxes').css('display', 'block');       
       
        //Turn off Individual Taxes for all but below
        //60-Individual, 70-Estate, 161-LLC Individual
        $('#divBusinessTaxes').css('display', 'none');
        $('#divBusinessMsgs').css('display', 'none');
        $('#divIndividualTaxes').css('display', 'none');
        $('#divIndividualMsgs').css('display', 'none');
        $('#divWarningMsgs').css('display', 'none');
        $('#divGeneralMsgs').css('display', 'block');
        $('#divBPTQuestion').css('display', 'none');
        $('#divBPTForm').css('display', 'none');
        $('#chkNPT').removeAttr('disabled');
        $('#txtNPT').removeAttr('disabled');      

        if ($("#ddOrgType option:selected").attr('CODE') == '999') {		//No org type selected
            $('#divWarningMsgs').css('display', 'block');
            $('#divGeneralMsgs').css('display', 'none');
        }
        else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == '2') {		//SSN
            if ($("#ddOrgType option:selected").attr('CODE') == '60' ||
                $("#ddOrgType option:selected").attr('CODE') == '70' ||
                $("#ddOrgType option:selected").attr('CODE') == '161') {		//60-Individual, 70-Estate, 161-LLC Individual
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlNAIC, 'L1', 'DESC', ddNAIC1.selectedIndex) == 'NonBusiness') {		//Non-Business
                    $('#divBusinessTaxes').css('display', 'none');
                    $('#divBusinessMsgs').css('display', 'none');
                    $('#divIndividualTaxes').css('display', 'block');
                    $('#divIndividualMsgs').css('display', 'block');
                    if (parent.sNew == true) {		//New Registration
                        $('#chkNPT').removeAttr('disabled');
                        chkNPT.checked = false;
                        txtNPT.value = '';
                        $('#txtNPT').css('visibility', 'hidden');
                    }		//if
                }
                else {		//Not Non-Business
                    $('#divBusinessTaxes').css('display', 'block');
                   
                    $('#divBusinessMsgs').css('display', 'block');
                    
                    $('#divIndividualTaxes').css('display', 'block');
                   
                    $('#divIndividualMsgs').css('display', 'none');
                    if (parent.sNew == true) {		//New Registration
                        if ($("#ddOrgType option:selected").attr('CODE') == '60' ||
                                $("#ddOrgType option:selected").attr('CODE') == '161') {		//60-Individual, 161-LLC Individual
                            chkNPT.checked = true;
                            $('#chkNPT').attr('disabled', 'true');
                            $('#txtNPT').css('visibility', 'visible');
                            $('#txtNPT').val($('#txtBusStartDate').val());
                            // txtNPT.focus()
                        }		//if
                    }		//if
                }		//if
            }		//if
        }
        else {		//EIN
            
            $('#divBusinessTaxes').css('display', 'block');
           
            $('#divBusinessMsgs').css('display', 'block');
            
            $('#divIndividualTaxes').css('display', 'none');
           
            $('#divIndividualMsgs').css('display', 'none');
            //EGOVWEB-113 - disable NPT for Corporations (New and Existing) Moved code out new section below
            $('#chkNPT').removeAttr('disabled');
            //if ($("#ddOrgType option:selected").attr('CODE') == '140' ||
            //        $("#ddOrgType option:selected").attr('CODE') == '163') {		//140-Corporation or 163-LLC Corporation
            //    chkNPT.checked = false;
            //    $('#chkNPT').attr('disabled', 'true');
            //    txtNPT.value = '';
            //    $('#txtNPT').css('visibility', 'hidden');
            //}	//if
            if (parent.sNew == true) {		//New Registration
                if ($("#ddOrgType option:selected").attr('CODE') == '161') {		//161-LLC Individual
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlNAIC, 'L1', 'DESC', ddNAIC1.selectedIndex) != 'NonBusiness') {		//Not Non-Business
                        chkNPT.checked = true;
                        $('#chkNPT').attr('disabled', 'true');
                        $('#txtNPT').css('visibility', 'visible');
                        $('#txtNPT').val($('#txtBusStartDate').val());
                        
                    }		//if
                }		//if
            }		//if
        }		//if

        if (initTaxes == false) {
            LoadAccError();

            PopulateAccounts();

        }		//if

       
        parent.gsInstructionItem = '#TaxType';
       

        CurrentLayer = 'AcctTaxes';
        if (errTaxes != '') {

            $(AppError_tax).text(errTaxes);
            parent.ScrollTop(errTaxes);
        }		//if
        initTaxes = true;
        if (parent.sNew == false) {
            BPTExemptDisplay();
            // this.focus()
        } else {
            ClearTaxes();
            BPTExemptDisplay();
        }		//if


       

        if ($('#txtBusStartDate').val() == '') {
            $('#divAcctTaxes').css('display', 'none');
            alert('Please Enter a Philadelphia Start Date on the Profile Tab.');
            DisplayProfile();
        }	//if

        //Temporary Delete
        $('#divBusinessMsgs').css('display', 'none');
       
        $('#divGeneralMsgs').css('display', 'none');
    }		//DisplayTaxes


    function BPTClick() {
        var ddOrgType = document.getElementById('ddOrgType');
        var chkBPT = document.getElementById('chkBPT');
        var chkNPT = document.getElementById('chkNPT');
        var txtNPT = document.getElementById('txtNPT');
        var txtBPT = document.getElementById('txtBPT');

        ValidateAcc()
        BPTExemptDisplay()
        if ($("#ddOrgType option:selected").attr('CODE') == '140' ||
                $("#ddOrgType option:selected").attr('CODE') == '163') {			//140-Corp or 163-LLC Corporation
            return
        }		//if

        if ($("#ddOrgType option:selected").attr('CODE') == '11' ||
               $("#ddOrgType option:selected").attr('CODE') == '60' ||
               $("#ddOrgType option:selected").attr('CODE') == '161' ||
                $("#ddOrgType option:selected").attr('CODE') == '162') {		//11-Partnership, 60-Individual, 161-LLC Individual or 162-LLC Partnership
            if (chkBPT.checked) {		//BPT Checked
                chkNPT.checked = true;
                $('#chkNPT').attr('disabled', 'true');
                if (txtNPT.value == '') {
                    txtNPT.value = txtBPT.value;
                }		//if
                $('#txtNPT').attr('disabled', 'true');
                $('#txtNPT').css('visibility', 'visible');
               
            } else if (!chkBPT.checked) {
                if ($("#ddOrgType option:selected").attr('CODE') == '60' ||
                      $("#ddOrgType option:selected").attr('CODE') == '161') {		//60-Individual, 161-LLC Individual
                    $('#txtNPT').removeAttr('disabled');
                    if ($('#txtNPT').val() == '') {
                        $('#txtNPT').val($('#txtBusStartDate').val());
                    }	//if
                } else {
                    chkNPT.checked = false;
                    $('#chkNPT').removeAttr('disabled');
                    $('#txtNPT').removeAttr('disabled');;
                    txtNPT.value = '';
                    $('#txtNPT').css('visibility', 'hidden');
                    ValidateAcc();
                }		//if
            }//if
        } //if
    }//BPTClick

    function BPTChange() {
        var ddOrgType = document.getElementById('ddOrgType');

        BPTExemptDisplay();
        if ($("#ddOrgType option:selected").attr('CODE') == '11' ||
                $("#ddOrgType option:selected").attr('CODE') == '60' ||
                $("#ddOrgType option:selected").attr('CODE') == '161' ||
               $("#ddOrgType option:selected").attr('CODE') == '162') {//11-Partnership, 60-Individual, 161-LLC Individual or 162-LLC Partnership
            $('#txtNPT').val($('#txtBPT').val());
            $('#txtNPT').attr('disabled', 'true');
           
        }		//if
    }		//BPTChange

    function LoadAccError() {
        var i = 0, txt1
        var txtBPT = document.getElementById('txtBPT');
        var txtNPT = document.getElementById('txtNPT');
        var txtWage = document.getElementById('txtWage');
        var txtLiquor = document.getElementById('txtLiquor');
        var txtHotel = document.getElementById('txtHotel');
        var txtLiquor = document.getElementById('txtLiquor');
        var txtAmusement = document.getElementById('txtAmusement');
        var txtRental = document.getElementById('txtRental');
        var txtTobacco = document.getElementById('txtTobacco');
        var txtUO = document.getElementById('txtUO');
        var txtEarn = document.getElementById('txtEarn');
        var txtSchool = document.getElementById('txtSchool');
        var radBptQ1Yes = document.getElementById('radBptQ1Yes');
        var radBptQ1No = document.getElementById('radBptQ1No');
        var radBptQ2Yes = document.getElementById('radBptQ2Yes');
        var radBptQ2No = document.getElementById('radBptQ2No');
        var radBptQ3Yes = document.getElementById('radBptQ3Yes');
        var radBptQ3No = document.getElementById('radBptQ3No');
        var radBptQ4Yes = document.getElementById('radBptQ4Yes');
        var radBptQ4No = document.getElementById('radBptQ4No');
        var radBptQ5Yes = document.getElementById('radBptQ5Yes');
        var radBptQ5No = document.getElementById('radBptQ5No');
        var radBptQ6Yes = document.getElementById('radBptQ6Yes');
        var radBptQ6No = document.getElementById('radBptQ6No');
        var radBptQ7Yes = document.getElementById('radBptQ7Yes');
        var radBptQ7No = document.getElementById('radBptQ7No');
        var chkBptAcknowledge = document.getElementById('chkBptAcknowledge');


        txt1 = "Tax start date can not be less than the business start date";
        txt2 = "Tax start date can not be greater than 1 month from today's date";
      
        arrAcc[i++] = [txtBPT, 'chkBPT.checked==true &&  $(\'#txtBPT\').val()==""', 'BPT start date required']
        arrAcc[i++] = [txtBPT, 'chkBPT.checked==true && ' +
                'new Date( $(\'#txtBPT\').val()) < new Date($(\'#txtBusStartDate\').val())', txt1]
        arrAcc[i++] = [txtBPT, '(chkBPT.checked==true) && ' +
                '(new Date($(\'#txtBPT\').val()).valueOf()) > ' +
                '(new Date((new Date().getMonth() + 2).toString() + "/" + new Date().getDate().toString() ' +
                ' + "/" + (new Date().getFullYear()).toString()).valueOf()) ', txt2]
     
        arrAcc[i++] = [txtNPT, 'chkNPT.checked==true && $(\'#txtNPT\').val()==""', 'NPT start date required']
        arrAcc[i++] = [txtNPT, 'chkNPT.checked==true && ' +
                'new Date($(\'#txtNPT\').val()) < new Date($(\'#txtBusStartDate\').val())', txt1]
        arrAcc[i++] = [txtNPT, '(chkNPT.checked==true) && ' +
                '(new Date($(\'#txtNPT\').val()).valueOf()) > ' +
                '(new Date((new Date().getMonth() + 2).toString() + "/" + new Date().getDate().toString() ' +
                ' + "/" + (new Date().getFullYear()).toString()).valueOf()) ', txt2]
       
        arrAcc[i++] = [txtWage, 'chkWage.checked==true && $(\'#txtWage\').val()==""', 'Wage start date required']
        arrAcc[i++] = [txtWage, 'chkWage.checked==true && ' +
                'new Date($(\'#txtWage\').val()) < new Date($(\'#txtBusStartDate\').val())', txt1]
        arrAcc[i++] = [txtWage, '(chkWage.checked==true) && ' +
                '(new Date($(\'#txtWage\').val()).valueOf()) > ' +
                '(new Date((new Date().getMonth() + 2).toString() + "/" + new Date().getDate().toString() ' +
                ' + "/" + (new Date().getFullYear()).toString()).valueOf()) ', txt2]
        
        arrAcc[i++] = [atrWage, 'chkWage.checked==true && $(\'#atrWage\').val()==""', 'Monthly gross required']       
        arrAcc[i++] = [atrWage, 'chkWage.checked==true && RemoveCurrency($(\'#atrWage\').val())==true', 'Monthly gross not numeric or > parent.$999,999']       
        arrAcc[i++] = [txtLiquor, 'chkLiquor.checked==true && $(\'#txtLiquor\').val()==""', 'Liquor start date required']
        arrAcc[i++] = [txtLiquor, 'chkLiquor.checked==true && ' +
                'new Date($(\'#txtLiquor\').val()) < new Date($(\'#txtBusStartDate\').val())', txt1]
        arrAcc[i++] = [txtLiquor, '(chkLiquor.checked==true) && ' +
                '(new Date($(\'#txtLiquor\').val()).valueOf()) > ' +
                '(new Date((new Date().getMonth() + 2).toString() + "/" + new Date().getDate().toString() ' +
                ' + "/" + (new Date().getFullYear()).toString()).valueOf()) ', txt2]
       
        arrAcc[i++] = [txtHotel, 'chkHotel.checked==true && $(\'#txtHotel\').val()==""', 'Hotel start date required']
        arrAcc[i++] = [txtHotel, 'chkHotel.checked==true && ' +
                'new Date($(\'#txtHotel\').val()) < new Date($(\'#txtBusStartDate\').val())', txt1]
        arrAcc[i++] = [txtHotel, '(chkHotel.checked==true) && ' +
                '(new Date($(\'#txtHotel\').val()).valueOf()) > ' +
                '(new Date((new Date().getMonth() + 2).toString() + "/" + new Date().getDate().toString() ' +
                ' + "/" + (new Date().getFullYear()).toString()).valueOf()) ', txt2]
       
        arrAcc[i++] = [txtAmusement, 'chkAmusement.checked==true && $(\'#txtAmusement\').val()==""', 'Amusement start date required']
        arrAcc[i++] = [txtAmusement, 'chkAmusement.checked==true && ' +
                'new Date($(\'#txtAmusement\').val()) < new Date($(\'#txtBusStartDate\').val())', txt1]
        arrAcc[i++] = [txtAmusement, '(chkAmusement.checked==true) && ' +
                '(new Date($(\'#txtAmusement\').val()).valueOf()) > ' +
                '(new Date((new Date().getMonth() + 2).toString() + "/" + new Date().getDate().toString() ' +
                ' + "/" + (new Date().getFullYear()).toString()).valueOf()) ', txt2]
      
        arrAcc[i++] = [txtRental, 'chkRental.checked==true && $(\'#txtRental\').val()==""', 'Vehicle Rental start date required']
        arrAcc[i++] = [txtRental, 'chkRental.checked==true && ' +
                'new Date($(\'#txtRental\').val()) < new Date($(\'#txtBusStartDate\').val())', txt1]
        arrAcc[i++] = [txtRental, '(chkRental.checked==true) && ' +
                '(new Date($(\'#txtRental\').val()).valueOf()) > ' +
                '(new Date((new Date().getMonth() + 2).toString() + "/" + new Date().getDate().toString() ' +
                ' + "/" + (new Date().getFullYear()).toString()).valueOf()) ', txt2]
      
        arrAcc[i++] = [txtTobacco, 'chkTobacco.checked==true && $(\'#txtTobacco\').val()==""', 'Tobacco start date required']
        arrAcc[i++] = [txtTobacco, 'chkTobacco.checked==true && ' +
                'new Date($(\'#txtTobacco\').val()) < new Date($(\'#txtBusStartDate\').val())', txt1]
        arrAcc[i++] = [txtTobacco, '(chkRental.checked==true) && ' +
                '(new Date($(\'#txtTobacco\').val()).valueOf()) > ' +
                '(new Date((new Date().getMonth() + 2).toString() + "/" + new Date().getDate().toString() ' +
                ' + "/" + (new Date().getFullYear()).toString()).valueOf()) ', txt2]
       
        arrAcc[i++] = [txtUO, 'chkUO.checked==true && $(\'#txtUO\').val()==""', 'Use/Occupancy start date required']
        arrAcc[i++] = [txtUO, 'chkUO.checked==true && ' +
                'new Date($(\'#txtUO\').val()) < new Date($(\'#txtBusStartDate\').val())', txt1]
        arrAcc[i++] = [txtUO, '(chkUO.checked==true) && ' +
                '(new Date($(\'#txtUO\').val()).valueOf()) > ' +
                '(new Date((new Date().getMonth() + 2).toString() + "/" + new Date().getDate().toString() ' +
                ' + "/" + (new Date().getFullYear()).toString()).valueOf()) ', txt2]
        
        arrAcc[i++] = [atrUO, 'chkUO.checked==true && $(\'#atrUO\').val()==""', 'BRT number required']
        arrAcc[i++] = [atrUO, 'chkUO.checked==true && isNaN(parseInt($(\'#atrUO\').val()))', 'BRT number not numeric']
       
        arrAcc[i++] = [txtEarn, 'chkEarn.checked==true && $(\'#txtEarn\').val()==""', 'Earnings start date required']
        arrAcc[i++] = [txtEarn, 'chkEarn.checked==true && ' +
                'new Date($(\'#txtEarn\').val()) < new Date($(\'#txtBusStartDate\').val())', txt1]
        arrAcc[i++] = [txtEarn, '(chkEarn.checked==true) && ' +
                '(new Date($(\'#txtEarn\').val()).valueOf()) > ' +
                '(new Date((new Date().getMonth() + 2).toString() + "/" + new Date().getDate().toString() ' +
                ' + "/" + (new Date().getFullYear()).toString()).valueOf()) ', txt2]
       
        arrAcc[i++] = [txtSchool, 'chkSchool.checked==true && $(\'#txtSchool\').val()==""', 'School start date required']
        arrAcc[i++] = [txtSchool, 'chkSchool.checked==true && ' +
                'new Date($(\'#txtSchool\').val()) < new Date($(\'#txtBusStartDate\').val())', txt1]
        arrAcc[i++] = [txtSchool, '(chkSchool.checked==true) && ' +
                '(new Date($(\'#txtSchool\').val()).valueOf()) > ' +
                '(new Date((new Date().getMonth() + 2).toString() + "/" + new Date().getDate().toString() ' +
                ' + "/" + (new Date().getFullYear()).toString()).valueOf()) ', txt2]

     
        //BPT Exempt Forms
        var sCheckThis = 'chkBPT.checked == true && new Date($(\'#txtBPT\').val()) >= new Date("1/1/2012") && new Date($(\'#txtBPT\').val()) <= new Date("12/31/2012")'
        arrAcc[i++] = [radBptQ1Yes, sCheckThis + ' && radBptQ1Yes.checked==false && radBptQ1No.checked==false', 'Applying for BPT exemption question 1 must be answered']
        arrAcc[i++] = [radBptQ1No, sCheckThis + ' && radBptQ1Yes.checked==false && radBptQ1No.checked==false', 'Applying for BPT exemption question 1 must be answered']
        arrAcc[i++] = [radBptQ2Yes, 'chkBPT.checked == true && radBptQ1Yes.checked==true && radBptQ2Yes.checked==false && radBptQ2No.checked==false', 'Applying for BPT exemption question 2 must be answered']
        arrAcc[i++] = [radBptQ2No, 'chkBPT.checked == true && radBptQ1Yes.checked==true && radBptQ2Yes.checked==false && radBptQ2No.checked==false', 'Applying for BPT exemption question 2 must be answered']
        arrAcc[i++] = [radBptQ3Yes, 'chkBPT.checked == true && radBptQ1Yes.checked==true && radBptQ3Yes.checked==false && radBptQ3No.checked==false', 'Applying for BPT exemption question 3 must be answered']
        arrAcc[i++] = [radBptQ3No, 'chkBPT.checked == true && radBptQ1Yes.checked==true && radBptQ3Yes.checked==false && radBptQ3No.checked==false', 'Applying for BPT exemption question 3 must be answered']
        arrAcc[i++] = [radBptQ4Yes, 'chkBPT.checked == true && radBptQ1Yes.checked==true && radBptQ4Yes.checked==false && radBptQ4No.checked==false', 'Applying for BPT exemption question 4 must be answered']
        arrAcc[i++] = [radBptQ4No, 'chkBPT.checked == true && radBptQ1Yes.checked==true && radBptQ4Yes.checked==false && radBptQ4No.checked==false', 'Applying for BPT exemption question 4 must be answered']
        arrAcc[i++] = [radBptQ5Yes, 'chkBPT.checked == true && radBptQ1Yes.checked==true && radBptQ5Yes.checked==false && radBptQ5No.checked==false', 'Applying for BPT exemption question 5 must be answered']
        arrAcc[i++] = [radBptQ5No, 'chkBPT.checked == true && radBptQ1Yes.checked==true && radBptQ5Yes.checked==false && radBptQ5No.checked==false', 'Applying for BPT exemption question 5 must be answered']
        arrAcc[i++] = [radBptQ6Yes, 'chkBPT.checked == true && radBptQ1Yes.checked==true && radBptQ6Yes.checked==false && radBptQ6No.checked==false', 'Applying for BPT exemption question 6 must be answered']
        arrAcc[i++] = [radBptQ6No, 'chkBPT.checked == true && radBptQ1Yes.checked==true && radBptQ6Yes.checked==false && radBptQ6No.checked==false', 'Applying for BPT exemption question 6 must be answered']
        arrAcc[i++] = [radBptQ7Yes, 'chkBPT.checked == true && radBptQ1Yes.checked==true && radBptQ7Yes.checked==false && radBptQ7No.checked==false', 'Applying for BPT exemption question 7 must be answered']
        arrAcc[i++] = [radBptQ7No, 'chkBPT.checked == true && radBptQ1Yes.checked==true && radBptQ7Yes.checked==false && radBptQ7No.checked==false', 'Applying for BPT exemption question 7 must be answered']
        arrAcc[i++] = [chkBptAcknowledge, 'chkBPT.checked == true && radBptQ1Yes.checked==true && chkBptAcknowledge.checked==false', 'Applying for BPT exemption acknowledgment must be checked']
    }		//LoadAccError


    function RemoveCurrency(lValue) {       
        var lTemp = lValue
     
        lTemp = lTemp.replace('$', '')
        lTemp = lTemp.replace(',', '')
        lTemp = lTemp.replace(')', '')
        lTemp = lTemp.replace('(', '')
        lTemp = lTemp.replace('%', '')
        lTemp = lTemp.replace('-', '')

        if (lValue == '') {
            return false;
        }		//if

        var lTemp2 = parseFloat(lTemp);
        if (lTemp2 == lTemp) {
            return false;
        } else {
            return true;
        }		//if
    }		//RemoveCurrency


    function PopulateAccounts() {
       
        var chkLiquor = document.getElementById('chkLiquor');
        var lblLiquor = document.getElementById('lblLiquor');
        var atrWage = document.getElementById('atrWage');
        var atrUO = document.getElementById('atrUO');
        var atrParking = document.getElementById('atrParking');        

        var txtObj, chkObj, chkName, EntityStartDate;
        
        TotalAccounts = 0
        debugger;
        iCount = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'TAX_ACCT', '')
        
        for (i = 0; i < iCount; i++) {
            sCode = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ACCOUNT', '', i)
            if (sCode != '0') {
                TotalAccounts = TotalAccounts + 1
                for (j = 0; j < arrControls.length; j++) {
                    chkName = arrControls[j]
                    chkObj = document.getElementById(chkName)
                    txtObj = document.getElementById('txt' + chkObj.id.slice(3))
                    if ($(chkObj).attr('CODE') == sCode) {
                        if (chkObj.checked == false) {
                            chkObj.click();
                        }		//if
                        txtObj.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'TAX_ACCT START_DATE', '', i);

                        lockField(chkObj, true);
                        lockField(txtObj, true);
                        switch (sCode) {
                            case '1':
                                $('#atrWage').val(ispFormatMoney(
                                        parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'WAGE_MONTHLY_GROSS', '', i), 0));
                                //chkObj.idx = j
                                lockField(atrWage, true);
                                break
                            case '24': 	//BPT
                                BPTExemptPopulateForm(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'UOL_BRT', '', 0));
                               
                                break;
                            case '84':
                                atrUO.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'UOL_BRT', '', i);
                                lockField(atrUO, true);
                                break;
                            case '8':
                                atrParking.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'PRK_ID', '', i);
                                lockField(atrParking, true);
                                break;
                        } 	//switch
                    }		//if
                }		//for
            }		//if
        }		//for
        if ($("#chkUO").prop('checked') == false) {

            $('#chkUO').attr('disabled', 'true');// = true;

        }	//if
        if (chkLiquor.checked == false) {
            $('#chkLiquor').attr('disabled', 'true');// = true;
            lblLiquor.value = 'To add this tax type, you must contact the Law Department.';
            $('#lblLiquor').css('border', 'none');//='none';
            $('#lblLiquor').css('visibility', 'visible');
        }	//if


    }		//PopulateAccounts

    function GetSingleNodeCount(oXML, sElement, val)//Chayan
    {
        var count = 0;
        $(oXML.xml).find(sElement).each(function () {

            count = count + 1;

        });
        return count;
    }
    function ClearAccounts() {

        
        //suman ------
        
        var xmlTemp = parent.$g.getXmlDocObj();
        xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "TAX_ACCT", 0);
        //-----------
        var nodecount = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'TAX_ACCT');

        //for (j = 0; j < nodecount; j++) {
        //    parent.$x.ispXmlReplaceNode(parent.$g.xmlAccount, "TAX_ACCT", j, xmlTemp, "TAX_ACCT", 0)
        //}
        
        //for
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
            }		//if
        }
    }		//ClearAccounts


    function UpdateAccounts() {
        debugger;
        var txtObj, chkObj, lastIdx, sFunction;
        var ddOrgType = document.getElementById('ddOrgType');
        var chkNPT = document.getElementById('chkNPT');
        var chkBPT = document.getElementById('chkBPT');
        var txtNPT = document.getElementById('txtNPT');
        var atrSchool = document.getElementById('txtSchool');
        var atrTobacco = document.getElementById('txtTobacco');
        var atrWage = document.getElementById('atrWage');
        var atrUO = document.getElementById('atrUO');
        var atrParking = document.getElementById('atrParking');

       
        var xmlTemp = parent.$g.getXmlDocObj();

        ClearAccounts();

        if ($("#ddOrgType option:selected").attr('CODE') == '60') {
            if (chkBPT.checked == true && chkNPT.checked == false) {
                chkNPT.checked = true;
                $('#txtNPT').val($('#txtBPT').val());
                $('#txtNPT').css('visibility', 'visible');
            }		//if
        }		//if

        ValidateAcc();
        if (errTaxes != '') {
            return false;
        }		//if
        //--------Changes the code by SumanG--------
        xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "TAX_ACCT", 0);
        parent.$x.ispAppendNodeXml(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp,
                'TAX_ACCT', 0);
        debugger;
        for (j = 0; j < arrControls.length; j++) {
            chkObj = document.getElementById(arrControls[j]);
            txtObj = document.getElementById('txt' + chkObj.id.slice(3)); 
             
            if (chkObj.checked == true) {		
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'A', 'TAX_ACCT FUNCTION_CODE', '', TotalAccounts);

               
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(chkObj).attr('CODE'), 'TAX_ACCT ACCOUNT', '', TotalAccounts);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtObj.value, 'TAX_ACCT START_DATE', '', TotalAccounts);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '12/31/' + new Date().getFullYear(), 'TAX_ACCT PRK_ID', '', TotalAccounts);
              
                if (txtObj.id == "txtWage") {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, atrWage.value, 'TAX_ACCT WAGE_MONTHLY_GROSS', '', TotalAccounts);
                } else if (txtObj.id == "txtBPT") {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, BPTExemptPopulateXml(), 'TAX_ACCT UOL_BRT', '', TotalAccounts);
                } else if (txtObj.id == "txtUO") {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, atrUO.value, 'TAX_ACCT UOL_BRT', '', TotalAccounts);
                }
                else if (txtObj.id == "txtParking") {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, atrParking.value, 'TAX_ACCT PRK_ID', '', TotalAccounts);
                }		//if
               
               // alert(parent.$g.xmlAccount);
                //parent.$x.ispXmlReplaceNode(parent.$g.xmlAccount, "TAX_ACCT", TotalAccounts, xmlTemp, "TAX_ACCT", 0);
                //-------END---------------
                TotalAccounts = TotalAccounts + 1;
            }		//if
        }		//for

        xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "TAX_ACCT", 0);
        parent.$x.ispAppendNodeXml(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp,
                'TAX_ACCT', 0);
        for (j = 0; j < arrControls.length; j++) {
            chkObj = document.getElementById(arrControls[j]);
            txtObj = document.getElementById('txt' + chkObj.id.slice(3));

            if (chkObj.checked == true) {                

                if (txtObj.id == "txtTobacco") {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'A', 'TAX_ACCT FUNCTION_CODE', '', TotalAccounts-1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(chkObj).attr('CODE'), 'TAX_ACCT ACCOUNT', '', TotalAccounts-1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtObj.value, 'TAX_ACCT START_DATE', '', TotalAccounts-1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '12/31/' + new Date().getFullYear(), 'TAX_ACCT PRK_ID', '', TotalAccounts-1);
                } 
                //-------END---------------
                
            }		//if
        }

        xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "TAX_ACCT", 0);
        parent.$x.ispAppendNodeXml(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp,
                'TAX_ACCT', 0);
        for (j = 0; j < arrControls.length; j++) {
            chkObj = document.getElementById(arrControls[j]);
            txtObj = document.getElementById('txt' + chkObj.id.slice(3));

            if (chkObj.checked == true) {

                if (txtObj.id == "txtEarn") {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'A', 'TAX_ACCT FUNCTION_CODE', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(chkObj).attr('CODE'), 'TAX_ACCT ACCOUNT', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtObj.value, 'TAX_ACCT START_DATE', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '12/31/' + new Date().getFullYear(), 'TAX_ACCT PRK_ID', '', TotalAccounts - 1);
                }
                //-------END---------------

            }		//if
        }

        xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "TAX_ACCT", 0);
        parent.$x.ispAppendNodeXml(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp,
                'TAX_ACCT', 0);
        for (j = 0; j < arrControls.length; j++) {
            chkObj = document.getElementById(arrControls[j]);
            txtObj = document.getElementById('txt' + chkObj.id.slice(3));

            if (chkObj.checked == true) {

                if (txtObj.id == "txtSchool") {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'A', 'TAX_ACCT FUNCTION_CODE', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(chkObj).attr('CODE'), 'TAX_ACCT ACCOUNT', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtObj.value, 'TAX_ACCT START_DATE', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '12/31/' + new Date().getFullYear(), 'TAX_ACCT PRK_ID', '', TotalAccounts - 1);
                }
                //-------END---------------

            }		//if
        }


        xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "TAX_ACCT", 0);
        parent.$x.ispAppendNodeXml(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp,
                'TAX_ACCT', 0);
        for (j = 0; j < arrControls.length; j++) {
            chkObj = document.getElementById(arrControls[j]);
            txtObj = document.getElementById('txt' + chkObj.id.slice(3));

            if (chkObj.checked == true) {

                if (txtObj.id == "txtHotel") {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'A', 'TAX_ACCT FUNCTION_CODE', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(chkObj).attr('CODE'), 'TAX_ACCT ACCOUNT', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtObj.value, 'TAX_ACCT START_DATE', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '12/31/' + new Date().getFullYear(), 'TAX_ACCT PRK_ID', '', TotalAccounts - 1);
                }
                //-------END---------------

            }		//if
        }

        xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "TAX_ACCT", 0);
        parent.$x.ispAppendNodeXml(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp,
                'TAX_ACCT', 0);
        for (j = 0; j < arrControls.length; j++) {
            chkObj = document.getElementById(arrControls[j]);
            txtObj = document.getElementById('txt' + chkObj.id.slice(3));

            if (chkObj.checked == true) {

                if (txtObj.id == "txtAmusement") {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'A', 'TAX_ACCT FUNCTION_CODE', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(chkObj).attr('CODE'), 'TAX_ACCT ACCOUNT', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtObj.value, 'TAX_ACCT START_DATE', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '12/31/' + new Date().getFullYear(), 'TAX_ACCT PRK_ID', '', TotalAccounts - 1);
                }
                //-------END---------------

            }		//if
        }
        xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "TAX_ACCT", 0);
        parent.$x.ispAppendNodeXml(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp,
                'TAX_ACCT', 0);
        for (j = 0; j < arrControls.length; j++) {
            chkObj = document.getElementById(arrControls[j]);
            txtObj = document.getElementById('txt' + chkObj.id.slice(3));

            if (chkObj.checked == true) {

                if (txtObj.id == "txtRental") {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'A', 'TAX_ACCT FUNCTION_CODE', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(chkObj).attr('CODE'), 'TAX_ACCT ACCOUNT', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtObj.value, 'TAX_ACCT START_DATE', '', TotalAccounts - 1);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '12/31/' + new Date().getFullYear(), 'TAX_ACCT PRK_ID', '', TotalAccounts - 1);
                }
                //-------END---------------

            }		//if
        }

        var acc = parent.$g.xmlAccount;
        //alert(acc);
        lbAcctChanged = true;
       
        
        return true;
    }		//UpdateAccounts



    function ValidateDate() {
      
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);
        var value = ispValidateDate(source.value);

        if (value == false) {
            value = '';
        }		//if
        source.value = value;
    }		//ValidateDate


    function ShowAttr() {
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);
        var id, name;

        id = source.id;
        name = id.slice(3);
        debugger;
       


        if (source.checked == true) {            
            errTaxes = '';
          
            $(AppError_tax).text(errTaxes);
            if (errTaxes != '') {
                parent.ScrollTop(errTaxes);
            }
            lbAcctChanged = true;
          
            $(document.getElementById('txt' + name)).css('visibility', 'visible');
           
            $(document.getElementById('txt' + name)).val($('#txtBusStartDate').val());

            if (initTaxes == true) {
               
                $(document.getElementById('txt' + name)).removeAttr('disabled');
                document.getElementById('txt' + name).focus();
            }		//if
           
            ShowAttr2(name, true);
        } else {
            if (name == 'BPT') {
                $('#divBPTQuestion').css('display', 'block');
                $('#divBPTForm').css('display', 'block');
            } 	//if
            $(document.getElementById('txt' + name)).css('visibility', 'hidden');//.style.visibility = 'hidden';
            $(document.getElementById('txt' + name)).attr('disabled', 'true');
            $(document.getElementById('txt' + name)).attr('class', 'inpNormal form-control');
            document.getElementById('txt' + name).value = '';
            if ($('#divAcctTaxes').css('display') == 'block') {
                ValidateAcc();
            }		//if
            ShowAttr2(name, false);
        }		//if

    }		//ShowAttr

    function ShowAttr2(name, state) {       
        if (name == 'Wage' || name == 'UO' || name == 'Parking') {
            if (state == true) {
                
                $(document.getElementById('att' + name)).css('visibility', 'visible');
                
                $(document.getElementById('atr' + name)).attr('class', 'inpNormal');
               
                $(document.getElementById('atr' + name)).removeAttr('disabled');
                if ($(AppError_tax).text() != '') {
                }		//if
            }
            else {
               
                $(document.getElementById('att' + name)).css('visibility', 'hidden');
               
                $(document.getElementById('atr' + name)).attr('class', 'inpNormal');
               
                $(document.getElementById('atr' + name)).removeAttr('disabled');
            }		//if
        }		//if
        
    }		//ShowAttr2


    function ValidateAcc() {
        
        var chkAmusement = document.getElementById('chkAmusement');
        var chkBPT = document.getElementById('chkBPT');
        var chkCoin = document.getElementById('chkCoin');
        var chkEarn = document.getElementById('chkEarn');
        var chkHotel = document.getElementById('chkHotel');
        var chkLiquor = document.getElementById('chkLiquor');
        var chkNPT = document.getElementById('chkNPT');
        var chkParking = document.getElementById('chkParking');
        var chkRental = document.getElementById('chkRental');
        var chkSchool = document.getElementById('chkSchool');
        var chkUO = document.getElementById('chkUO');
        var chkWage = document.getElementById('chkWage');
        var chkTobacco = document.getElementById('chkTobacco');
     
        var a = '';
        errTaxes = '';
        if (parent.sNew == false && initTaxes == false) {
        } else {
            switch (true) {
                case chkAmusement.checked:
                    break
                case chkBPT.checked:
                    break
                case chkCoin.checked:
                    break
                case chkEarn.checked:
                    break
                case chkHotel.checked:
                    break
                case chkLiquor.checked:
                    break
                case chkNPT.checked:
                    break
                case chkParking.checked:
                    break
                case chkRental.checked:
                    break
                case chkSchool.checked:
                    break
                case chkUO.checked:
                    break
                case chkWage.checked:
                    break
                case chkTobacco.checked:
                    break
                default:
                    a = '0';		//No accounts selected
            }		//select
        }		//if

        if (a == '') {
            errTaxes = ispSetInputErr(arrAcc);
        } else {
            errTaxes = 'At least 1 account must be selected';
        }

        if ($('#divAcctTaxes').css('display', 'block')) {
          
            $(AppError_tax).text(errTaxes);
            if (errTaxes != '') {
                parent.ScrollTop(errTaxes);
            }
        }		//if

        if (errTaxes != '') {
            lbAcctChanged = false;
        } else {
            lbAcctChanged = true;
        }		//if
       
        ResolveIframeLoadHeight();
        
    }		//ValidateAcc


    function ClickHelp(sLink) {
        window.open(sLink)
    }

    function BPTExemptDisplay() {       
        var txtBPT = document.getElementById('txtBPT');
        var chkBPT = document.getElementById('chkBPT');
        var radBptQ1Yes = document.getElementById('radBptQ1Yes');
        var dtStartDate = new Date(txtBPT.value);
        var dtLowDate = new Date('01/01/2009');
        var dtHighDate = new Date('12/31/2099'); // ? SUMAN IT WAS 2012 BEFORE LOSS & CARRY UPSATE
        debugger;

        if (chkBPT.checked == true) {
            if (dtStartDate >= dtLowDate && dtStartDate <= dtHighDate) {
                $('#divBPTQuestion').css('display', 'block');//style.display = 'block';
                if (radBptQ1Yes.checked == true) {
                    $('#divBPTForm').css('display', 'block');//.style.display = 'block';
                } 	//if
            } else {
                $('#divBPTQuestion').css('display', 'none');//.style.display = 'none'
                $('#divBPTForm').css('display', 'none');//.style.display = 'none'
                BPTExemptClear();
            } 	//if
            if (errTaxes == '') {
            } else {
                ResolveIframeLoadHeight();
                alert('Taxes Error: ' + errTaxes);
            } 	//if
        } else {
            $('#divBPTQuestion').css('display', 'none');//style.display = 'none';;
            $('#divBPTForm').css('display', 'none');//.style.display = 'none';
            BPTExemptClear();
        } 	//if
        //	} 	//if
    } 	//BPTExemptDisplay

    function BPTExemptClick() {
        var conYES = 0;
        var conNO = 1;

       
        var evt = window.event || arguments.callee.caller.arguments[0];
        var src = parent.getEventSource(evt);
        //-------------
        var radBptQ1No = document.getElementById('radBptQ1No');

        if (src.name == radBptQ1No.name && document.getElementsByName(src.name).item(conYES).checked == true) {
            $('#divBPTForm').css('display', 'block');

            
        } else {
            $('#divBPTForm').css('display', 'none');
            BPTExemptClear();
            document.getElementsByName(src.name).item(conNO).checked = true;


        }
        ResolveIframeLoadHeight();//Manoranjan
        
    } 	//BPTClick
    function ResolveIframeLoadHeight() {
        //----------Manoranjan------------------------------
        var iframe = window.parent.document.getElementById('ifrmDocwin');
        var container = $('#tab1').css("height");
        iframe.style.height = container;
        //----------------------------------------
    }   

    function BPTExemptClear() {
        var radBptQ1Yes = document.getElementById('radBptQ1Yes');
        var radBptQ1No = document.getElementById('radBptQ1No');
        var radBptQ2Yes = document.getElementById('radBptQ2Yes');
        var radBptQ2No = document.getElementById('radBptQ2No');
        var radBptQ3Yes = document.getElementById('radBptQ3Yes');
        var radBptQ4Yes = document.getElementById('radBptQ4Yes');
        var radBptQ4No = document.getElementById('radBptQ4No');
        var radBptQ5Yes = document.getElementById('radBptQ5Yes');
        var radBptQ5No = document.getElementById('radBptQ5No');
        var radBptQ6Yes = document.getElementById('radBptQ6Yes');
        var radBptQ6No = document.getElementById('radBptQ6No');
        var radBptQ7Yes = document.getElementById('radBptQ7Yes');
        var radBptQ7No = document.getElementById('radBptQ7No');
        var chkBptAcknowledge = document.getElementById('chkBptAcknowledge');

        radBptQ1Yes.checked = false;
        radBptQ1No.checked = true; //changes
        radBptQ2Yes.checked = false;
        radBptQ2No.checked = false;
        radBptQ3Yes.checked = false;
        radBptQ3No.checked = false;
        radBptQ4Yes.checked = false;
        radBptQ4No.checked = false;
        radBptQ5Yes.checked = false;
        radBptQ5No.checked = false;
        radBptQ6Yes.checked = false;
        radBptQ6No.checked = false;
        radBptQ7Yes.checked = false;;
        radBptQ7No.checked = false
        chkBptAcknowledge.checked = false;
    } 	//BPTExemptClear

    function BPTExemptPopulateXml() {
        var radBptQ1Yes = document.getElementById('radBptQ1Yes');
        var radBptQ1No = document.getElementById('radBptQ1No');
        var radBptQ2Yes = document.getElementById('radBptQ2Yes');
        var radBptQ2No = document.getElementById('radBptQ2No');
        var radBptQ3Yes = document.getElementById('radBptQ3Yes');
        var radBptQ4Yes = document.getElementById('radBptQ4Yes');
        var radBptQ4No = document.getElementById('radBptQ4No');
        var radBptQ5Yes = document.getElementById('radBptQ5Yes');
        var radBptQ5No = document.getElementById('radBptQ5No');
        var radBptQ6Yes = document.getElementById('radBptQ6Yes');
        var radBptQ6No = document.getElementById('radBptQ6No');
        var radBptQ7Yes = document.getElementById('radBptQ7Yes');
        var radBptQ7No = document.getElementById('radBptQ7No');

        var lsReturnVal = '';
       
        if (radBptQ1Yes.checked == true) {
            lsReturnVal = lsReturnVal + 'Y';
            //EGOVWEB-93 Questions for Section A
            lsReturnVal = radBptQ2Yes.checked == true ? lsReturnVal + 'Y' : lsReturnVal + '';
            lsReturnVal = radBptQ2No.checked == true ? lsReturnVal + 'N' : lsReturnVal + '';
            lsReturnVal = radBptQ3Yes.checked == true ? lsReturnVal + 'Y' : lsReturnVal + '';
            lsReturnVal = radBptQ3No.checked == true ? lsReturnVal + 'N' : lsReturnVal + '';
            lsReturnVal = radBptQ4Yes.checked == true ? lsReturnVal + 'Y' : lsReturnVal + '';
            lsReturnVal = radBptQ4No.checked == true ? lsReturnVal + 'N' : lsReturnVal + '';
            lsReturnVal = radBptQ5Yes.checked == true ? lsReturnVal + 'Y' : lsReturnVal + '';
            lsReturnVal = radBptQ5No.checked == true ? lsReturnVal + 'N' : lsReturnVal + '';
            //EGOVWEB-93 Mainframe has Acknoledgment in postion 6 after Section A
            lsReturnVal = chkBptAcknowledge.checked == true ? lsReturnVal + 'Y' : lsReturnVal + '';
            //EGOVWEB-93 Questions for Section B
            lsReturnVal = radBptQ6Yes.checked == true ? lsReturnVal + 'Y' : lsReturnVal + '';
            lsReturnVal = radBptQ6No.checked == true ? lsReturnVal + 'N' : lsReturnVal + '';
            lsReturnVal = radBptQ7Yes.checked == true ? lsReturnVal + 'Y' : lsReturnVal + '';
            lsReturnVal = radBptQ7No.checked == true ? lsReturnVal + 'N' : lsReturnVal + '';
        } else if (radBptQ1No.checked == true) {
            lsReturnVal = lsReturnVal + 'N';
        } else {
        }		//if
        //	}		//if
        return lsReturnVal
    }		//BPTExemptPopulateXml

    function BPTExemptPopulateForm(lsQuestionAnswers) {
        debugger;
        $('#divBPTQuestion').css('display', 'none');
        $('#divBPTForm').css('display', 'none');
        var chkBptAcknowledge = document.getElementById('chkBptAcknowledge');
        var radBptQ1Yes = document.getElementById('radBptQ1Yes');
        var radBptQ1No = document.getElementById('radBptQ1No');
        var radBptQ2Yes = document.getElementById('radBptQ2Yes');
        var radBptQ2No = document.getElementById('radBptQ2No');
        var radBptQ3Yes = document.getElementById('radBptQ3Yes');
        var radBptQ4Yes = document.getElementById('radBptQ4Yes');
        var radBptQ4No = document.getElementById('radBptQ4No');
        var radBptQ5Yes = document.getElementById('radBptQ5Yes');
        var radBptQ5No = document.getElementById('radBptQ5No');
        var radBptQ6Yes = document.getElementById('radBptQ6Yes');
        var radBptQ6No = document.getElementById('radBptQ6No');
        var radBptQ7Yes = document.getElementById('radBptQ7Yes');
        var radBptQ7No = document.getElementById('radBptQ7No');

        if (lsQuestionAnswers != '') {
            for (i = 0; i < lsQuestionAnswers.length; i++) {
                var idx = i + 1;
                if (idx == 6) {
                    if (lsQuestionAnswers.substr(i, 1) == 'N') {
                        chkBptAcknowledge.checked = false;
                    } else if (lsQuestionAnswers.substr(i, 1) == 'Y') {
                        chkBptAcknowledge.checked = true;
                    } else {
                        chkBptAcknowledge.checked = false;
                    }		//if
                } else if (idx < 9) {
                    if (idx > 6) {
                        //EGOVWEB-93 Controls for section B use IDX as 6 and 7
                        idx = idx - 1;
                    } 	//if
                    if (lsQuestionAnswers.substr(i, 1) == 'N') {
                        eval('radBptQ' + idx + 'No.checked = true');
                    } else if (lsQuestionAnswers.substr(i, 1) == 'Y') {
                        eval('radBptQ' + idx + 'Yes.checked = true');
                    } else {
                        eval('radBptQ' + idx + 'No.checked = false');
                        eval('radBptQ' + idx + 'Yes.checked = false');
                    } 	//if
                } else {
                }		//if
            } 	//for
            if (radBptQ1Yes.checked == true) {
                $('#divBPTQuestion').css('display', 'block');
                $('#divBPTForm').css('display', 'block');
            } else {
                $('#divBPTQuestion').css('display', 'block');
            }		//if
            if (lsQuestionAnswers.length > 0) {
                BPTExemptLockDisplay(true);
            }		//if
        }		//if
    } 	//BPTExemptPopulateForm

    function BPTExemptLockDisplay(bLock) {
       

        if (bLock == true) {
            $('#radBptQ1No').attr('disabled', bLock);
           
            $('#radBptQ1Yes').attr('disabled', bLock);
            
            $('#radBptQ2No').attr('disabled', bLock);
            
            $('#radBptQ2Yes').attr('disabled', bLock);
          
            $('#radBptQ3No').attr('disabled', bLock);
            
            $('#radBptQ3Yes').attr('disabled', bLock);
            
            $('#radBptQ4No').attr('disabled', bLock);
            
            $('#radBptQ4Yes').attr('disabled', bLock);
            
            $('#radBptQ5No').attr('disabled', bLock);
           
            $('#radBptQ5Yes').attr('disabled', bLock);
            
            $('#radBptQ6No').attr('disabled', bLock);
           
            $('#radBptQ6Yes').attr('disabled', bLock);
           
            $('#radBptQ7No').attr('disabled', bLock);
           
            $('#radBptQ7Yes').attr('disabled', bLock);
            
            $('#chkBptAcknowledge').attr('disabled', bLock);
        }
        else {
            $('#radBptQ1No').removeAttr('disabled');
           
            $('#radBptQ1Yes').removeAttr('disabled');
           
            $('#radBptQ2No').removeAttr('disabled');
           
            $('#radBptQ2Yes').removeAttr('disabled');
            
            $('#radBptQ3No').removeAttr('disabled');
            
            $('#radBptQ3Yes').removeAttr('disabled');
           
            $('#radBptQ4No').removeAttr('disabled');
           
            $('#radBptQ4Yes').removeAttr('disabled');
           
            $('#radBptQ5No').removeAttr('disabled');
           
            $('#radBptQ5Yes').removeAttr('disabled');
           
            $('#radBptQ6No').removeAttr('disabled');
            
            $('#radBptQ6Yes').removeAttr('disabled');
           
            $('#radBptQ7No').removeAttr('disabled');
           
            $('#radBptQ7Yes').removeAttr('disabled');
           
            $('#chkBptAcknowledge').removeAttr('disabled');
        }
    }		//BPTExemptLockDisplay

    function Taxes_Print(bPrint) {
        if (bPrint == true) {

           
            $('#divAcctTaxes').css('display', 'block');
           
            $('#PrintTaxesHdr').css('display', 'block');
            
            $('#divBusinessTaxes').css('display', 'block');
            
            $('#divIndividualTaxes').css('display', 'block');
           
            $('#divWarningMsgs').css('display', 'none');
           
            $('#divGeneralMsgs').css('display', 'none');
            PopulateAccounts();
        } else {
                     
           
            $('#PrintTaxesHdr').css('display', 'none');
          
        }		//if
    }		//Taxes_Print

</script>

     <title></title>
</head>
<body>

<%--<div class="tab-content customtabs">--%>
    <div style="display: none;" role="tabpanel" class="tab-pane active" id="divAcctTaxes">

        <h2>Taxpayer Information  |   <span>Tax Types </span></h2>
        <div class="inner_white-panel">
            <div class="contentsection">
                 <div class="row">
                                 <div class="col-lg-12 col-lg-offset-0 no-padding-left">
                    <div id="AppError_tax" class="errormsg no-padding" style="display:block;"> </div>
                        </div>                
              

                     </div> 
                 <h4><%--<a href="#" onclick="parent.InstructionLinks();">Click here</a> for more information on completing this screen.<br /> --%>               
                    <span style="color:red">*</span> Required fields  
                        <br />
                    Select all appropriate Tax Types</h4>
                <div class="row">
                    <div id="divBusinessTaxes" class="col-lg-12" style="display: none">
                        <div class="well custom_well table-responsive">

                            <table id="TABLE1" class="table table-condensed table-striped custom_table01 table-bordered" summary="Employee Pay Sheet">

                                <tbody>
                                    <tr>
                                        <td class="border_top taxes-top-border" align="center"><strong>Business Taxes</strong></td>
                                        <td class="border_top taxes-top-border" align="center"><strong>Start Date</strong></td>
                                        <td class="border_top no_border_right" align="center"><strong>Additional  Attributes</strong></td>

                                    </tr>
                                    <tr class="odd">
                                        <td align="" class="small_texts">


                                            <div class="form-group top_10margin no-margin-bottom">
                                                <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input id="chkBPT" type="checkbox" class="fordisablecheckbox" style="height:12px; width:15px;" code="24" name="chkBPT" onclick="ShowAttr(); BPTClick()" />
                                                            <span><a onclick="ClickHelp('https://beta.phila.gov/services/payments-assistance-taxes/business-taxes/business-income-receipts-tax-birt/')">Business Income and Receipts</a></span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>

                                        </td>



                                        <td align="center">

                                            <div class="form-group top_10margin no-margin-bottom">

                                                <div class="col-sm-12">
                                                    <input type="text" class="form-control" id="txtBPT" name="txtBPT" maxlength="10" size="12" style="visibility: hidden" onchange="ValidateDate();ValidateAcc();BPTChange()">
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>



                                        </td>
                                        <td>
                                            <p>&nbsp;</p>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td align="" class="small_texts">
                                            <div class="form-group top_10margin no-margin-bottom">
                                                <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input id="chkNPT" type="checkbox" class="fordisablecheckbox" style="height:12px; width:15px;" code="3" name="chkNPT" onclick="ShowAttr()" />
                                                            <span><a style="cursor: hand" onclick="ClickHelp('https://beta.phila.gov/services/payments-assistance-taxes/business-taxes/net-profits-tax/')">Net Profits</a></span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>

                                        </td>
                                        <td align="center">

                                            <div class="form-group top_10margin no-margin-bottom">

                                                <div class="col-sm-12">
                                                    <input type="text" class="form-control" id="txtNPT" name="txtNPT" maxlength="10" size="12" style="visibility: hidden" onchange="ValidateDate();ValidateAcc()" />
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>

                                        </td>
                                        <td>
                                            <p>&nbsp;</p>
                                        </td>

                                    </tr>

                                    <tr class="odd">
                                        <td align="" class="small_texts">
                                            <div class="form-group top_10margin no-margin-bottom">
                                                <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input id="chkWage" type="checkbox" class="fordisablecheckbox" style="height:12px; width:15px;" code="1" name="chkWage" onclick="ShowAttr()" />
                                                            <span><a style="cursor: hand" onclick="ClickHelp('https://beta.phila.gov/services/payments-assistance-taxes/business-taxes/wage-tax-employers/')">Wage</a></span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </td>
                                        <td align="center">
                                            <div class="form-group top_10margin no-margin-bottom">

                                                <div class="col-sm-12">
                                                    <input type="text" class="form-control" id="txtWage" name="txtWage" maxlength="10" size="12" style="visibility: hidden" onchange="ValidateDate();ValidateAcc()" />
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </td>
                                        <td class="no_border_right" align="">

                                            <div class="form-group">
                                                <label for="inputEmail3" class="col-sm-6 control-label top_10margin">
                                                    <a style="cursor: hand"
                                                        onclick="ClickHelp('https://beta.phila.gov/services/business-self-employment/business-taxes/wage-tax-employers/')">Monthly Philadelphia Withholdings</a></label>
                                                <div class="col-sm-6">
                                                    <input  class="form-control" id="atrWage" maxlength="15" size="18" style="text-align: right"
                                                        onchange="atrWage.value=ispFormatMoney(atrWage.value, 0);ValidateAcc()" value='0'>
                                                </div>
                                            </div>

                                        </td>

                                    </tr>


                                    <tr>
                                        <td align="" class="small_texts">


                                            <div class="form-group top_10margin no-margin-bottom">
                                                <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input id="chkLiquor" type="checkbox" class="fordisablecheckbox" code="28" name="chkLiquor" onclick="ShowAttr()" />
                                                            <span><a style="cursor: hand" onclick="ClickHelp('https://beta.phila.gov/services/payments-assistance-taxes/business-taxes/liquor-tax/')">Liquor</a></span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>

                                        </td>
                                        <td align="center">
                                            <div class="form-group top_10margin no-margin-bottom">

                                                <div class="col-sm-12">
                                                    <input class="form-control" id="txtLiquor" name="lblLiquor" maxlength="10" size="12"
                                                        style="visibility: hidden" onchange="ValidateDate();ValidateAcc()" />
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <label id="lblLiquor" style="visibility: hidden; width: 100%; text-align: center">
                                            </label>
                                        </td>

                                    </tr>

                                    <tr class="odd">
                                        <td align="" class="small_texts">
                                            <div class="form-group top_10margin no-margin-bottom">
                                                <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input id="chkHotel" type="checkbox" class="fordisablecheckbox" code="23" name="chkHotel" onclick="ShowAttr()" />
                                                            <span><a style="cursor: hand" onclick="ClickHelp('https://beta.phila.gov/services/payments-assistance-taxes/business-taxes/hotel-tax/')">Hotel</a></span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>

                                        </td>
                                        <td align="center">

                                            <div class="form-group top_10margin no-margin-bottom">

                                                <div class="col-sm-12">
                                                    <input class="form-control" id="txtHotel" name="txtHotel" maxlength="10" size="12"
                                                        style="visibility: hidden" onchange="ValidateDate();ValidateAcc()" />
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <p>&nbsp;</p>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td align="" class="small_texts">
                                            <div class="form-group top_10margin no-margin-bottom">
                                                <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input id="chkAmusement" class="fordisablecheckbox" type="checkbox" code="6" name="chkAmusement" onclick="ShowAttr()" />
                                                            <span><a style="cursor: hand" onclick="ClickHelp('https://beta.phila.gov/services/payments-assistance-taxes/business-taxes/amusement-tax/')">Amusement</a></span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </td>
                                        <td align="center">

                                            <div class="form-group top_10margin no-margin-bottom">

                                                <div class="col-sm-12">
                                                    <input class="form-control" id="txtAmusement" name="txtRental" maxlength="10" size="12"
                                                        style="visibility: hidden" onchange="ValidateDate();ValidateAcc()" />
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <p>&nbsp;</p>
                                        </td>
                                    </tr>

                                    <tr class="odd">
                                        <td align="" class="small_texts">

                                            <div class="form-group top_10margin no-margin-bottom">
                                                <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input id="chkRental" type="checkbox" class="fordisablecheckbox" code="14" name="chkRental" onclick="ShowAttr()" />
                                                            <span><a style="cursor: hand" onclick="ClickHelp('https://beta.phila.gov/services/payments-assistance-taxes/business-taxes/vehicle-rental-tax/')">Vehicle Rental</a></span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </td>
                                        <td align="center">

                                            <div class="form-group top_10margin no-margin-bottom">

                                                <div class="col-sm-12">
                                                    <input class="form-control" id="txtRental" name="txtAmusement" maxlength="10" size="12"
                                                        style="visibility: hidden" onchange="ValidateDate();ValidateAcc()" />
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>

                                        </td>
                                        <td>
                                            <p>&nbsp;</p>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td align="" class="small_texts">
                                            <div class="form-group top_10margin no-margin-bottom">
                                                <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input id="chkTobacco" type="checkbox" class="fordisablecheckbox" code="27" name="chkTobacco" onclick="ShowAttr()" />
                                                            <span><a style="cursor: hand" onclick="ClickHelp('https://beta.phila.gov/services/payments-assistance-taxes/business-taxes/tobacco-and-tobacco-related-products-tax/')">Tobacco</a></span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </td>
                                        <td align="center">
                                            <div class="form-group top_10margin no-margin-bottom">

                                                <div class="col-sm-12">
                                                    <input class="form-control" id="txtTobacco" name="txtTobacco" maxlength="10" size="12"
                                                        style="visibility: hidden" onchange="ValidateDate();ValidateAcc()" />
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </td>
                                        <td>
                                            <p>&nbsp;</p>
                                        </td>
                                    </tr>
                                    <tr class="odd">
                                        <td align="" class="small_texts">
                                            <div class="form-group top_10margin no-margin-bottom">
                                                <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                    <div class="checkbox">
                                                        <label>
                                                            <input id="chkUO" type="checkbox" class="fordisablecheckbox" code="84" name="chkUO" onclick="ShowAttr()" />
                                                            <span><a style="cursor: hand" onclick="ClickHelp('https://beta.phila.gov/services/payments-assistance-taxes/business-taxes/use-occupancy-tax/')">Use/Occupancy</a></span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </td>
                                        <td align="center">
                                            <div class="form-group top_10margin no-margin-bottom">

                                                <div class="col-sm-12">
                                                    <input class="form-control" id="txtUO" name="txtUO" maxlength="10" size="12"
                                                        style="visibility: hidden" onchange="ValidateDate();ValidateAcc()" />
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>

                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <label for="inputEmail3" class="col-sm-6 control-label top_10margin">
                                                    <p id="attUO" name="attUO" align=left style="VISIBILITY: hidden">&nbsp;
                                                    <a style="cursor: pointer" onclick="ClickHelp('../Help/HelpBRT.htm')">BRT#</a>
                                                    &nbsp;<input class="inpNormal" id="atrUO" name="atrUO" maxlength="11" size="12"
                                                        onchange="ValidateAcc()"></p>
                                                  
                                                </label>
                                            </div>

                                        </td>
                                    </tr>



                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="clear"></div>

                    <div id="divIndividualTaxes" class="col-lg-12 table-responsive" style="display: none; background:#fff !important;">
                        <table id="TABLE2" class="table table-condensed table-striped custom_table01 table-bordered" summary="Employee Pay Sheet">

                            <tbody>
                                <tr>
                                    <td class="border_top taxes-top-border" align="center"><strong>Business Taxes</strong></td>
                                    <td class="border_top taxes-top-border" align="center"><strong>Start Date</strong></td>
                                    <td class="border_top no_border_right" align="center"><strong>Additional  Attributes</strong></td>

                                </tr>
                                <tr class="odd">
                                    <td align="" class="small_texts">
                                        <div class="form-group top_10margin no-margin-bottom">
                                            <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                <div class="checkbox">
                                                    <label>
                                                        <input id="chkEarn" type="checkbox" class="fordisablecheckbox" style="height:12px; width:15px;" code="2" name="chkEarn" onclick="ShowAttr();" />
                                                        <span><a style="cursor: hand" onclick="ClickHelp('https://beta.phila.gov/services/payments-assistance-taxes/income-taxes/earnings-tax-employees/')">Earnings</a></span>
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="form-group top_10margin no-margin-bottom">

                                            <div class="col-sm-12">
                                                <input class="form-control" id="txtEarn" name="txtBPT" maxlength="10" size="12"
                                                    style="visibility: hidden" onchange="ValidateDate();ValidateAcc();BPTChange()" />
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </td>
                                    <td>
                                        <p>&nbsp;</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="" class="small_texts">
                                        <div class="form-group top_10margin no-margin-bottom">
                                            <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                <div class="checkbox">
                                                    <label>
                                                        <input id="chkSchool" class="fordisablecheckbox" style="height:12px; width:15px;" type="checkbox" code="29" name="chkSchool" onclick="ShowAttr();" />
                                                        <span><a style="cursor: hand" onclick="ClickHelp('https://beta.phila.gov/services/payments-assistance-taxes/income-taxes/school-income-tax/')">School Income</a></span>
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </td>
                                    <td align="center">
                                        <div class="form-group top_10margin no-margin-bottom">

                                            <div class="col-sm-12">
                                                <input class="form-control" id="txtSchool" name="txtSchool" maxlength="10" size="12"
                                                    style="visibility: hidden" onchange="ValidateDate();ValidateAcc();BPTChange()" />
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </td>
                                    <td>
                                        <p>&nbsp;</p>
                                    </td>
                                </tr>

                                <tr style="display: none; visibilty: visible">
                                    <td>
                                        <div class="form-group top_10margin no-margin-bottom">
                                            <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                <div class="checkbox">
                                                    <label>
                                                        <input id="chkParking" class="fordisablecheckbox" type="checkbox" code="8" name="chkParking" onclick="ShowAttr()">
                                                        <span><a style="cursor: hand" onclick="ClickHelp('../Help/HelpParkingTax.htm')">Parking</a></span>
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group top_10margin no-margin-bottom">

                                            <div class="col-sm-12">
                                                <input class="form-control" id="txtParking" name="txtParking" maxlength="10" size="12"
                                                    style="visibility: hidden" onchange="ValidateDate();ValidateAcc()">
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>

                                    </td>
                                    <td>
                                        <p id="attParking" name="attParking" align="left" style="visibility: hidden">
                                            &nbsp;
							<a class="lblLink" style="cursor: hand" onclick="ClickHelp('../Help/HelpLotID.htm')">Lot ID</a>
                                            &nbsp;<input id="atrParking" name="atrParking" maxlength="11" size="12"
                                                onchange="ValidateAcc()">
                                        </p>
                                    </td>

                                </tr>

                                <tr style="display: none; visibilty: visible" class="odd">
                                    <td>
                                        <div class="form-group top_10margin no-margin-bottom">
                                            <div class="col-sm-offset-0 col-sm-11 checkbox_here">
                                                <div class="checkbox">
                                                    <label>
                                                        <input id="chkCoin" class="fordisablecheckbox" type="checkbox" code="9" name="chkCoin" onclick="ShowAttr()">
                                                        <span><a style="cursor: hand"
                                                            onclick="ClickHelp('../Help/HelpCoinTax.htm')">Coin</a></span>
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group top_10margin no-margin-bottom">

                                            <div class="col-sm-12">
                                                <input id="txtCoin" class="form-control" name="txtCoin" maxlength="10" size="12"
                                                    style="visibility: hidden" onchange="ValidateDate();ValidateAcc()">
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </td>
                                    <td>
                                        <p>&nbsp;</p>
                                    </td>

                                </tr>
                            </tbody>
                        </table>

                        

                    </div>
                    <div class="clearfix"></div>
                    <div id="divBPTQuestion" style="visibility: visible">
                        <table id="tblBPTQuestion" cellspacing="0" cellpadding="0" width="85%" border="0" style="margin-top: 5px; margin-left: 4%">
                            <!--Template Row-->
                            <tr>
                                <td style="width: 140px"></td>
                                <td style="width: 20px"></td>
                                <td></td>
                            </tr>
                            <tr style="vertical-align: text-top">
                                <td class="lblTextBlack" colspan="3"><b>Business Income and Receipts Tax Options</b>
                                    <br />
                                    &nbsp;</td>
                            </tr>
                            <tr style="vertical-align: text-top">
                                <td style="width: 100px" class="lblTextBlack">1.
                                        <input id="radBptQ1Yes" name="radBptQ1" type="radio" onclick="BPTExemptClick(); ValidateAcc()" />Yes &nbsp<input id="radBptQ1No" name="radBptQ1" type="radio" checked="checked" onclick="    BPTExemptClick(); ValidateAcc()" />No</td> <%--changes--%>
                                <td style="width: 20px"></td>
                                <td class="lblTextBlack">Are you claiming "New Business" tax status under Philadephia Code 19-3800?<br />
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </div>
                    

                    <div id="divBPTForm" class="col-lg-12 table-responsive" style="display: none; visibility: visible">
                        <table id="tblBPTForm" class="table table-condensed table-striped custom_table01 table-bordered">
                            <!--Template Row-->
                            <tr>
                                <td style="width: 140px"></td>
                                <td style="width: 20px"></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="lblTextBlack" colspan="3">Please complete this section if you are seeking status as a new business under Code 19-3800 which exempts the business from paying Business Income and Receipts Tax for the first two years of operation and also exempts the new business from having to pay the parent.$300 Commercial Activity License Fee.
						<br />
                                    <br />
                                    <b>Section A</b> - Eligibility<br />
                                    &nbsp;</td>
                            </tr>
                            <tr style="vertical-align: text-top">
                                <td style="width: 100px">2.
                                        <input id="radBptQ2Yes" name="radBptQ2" type="radio" onclick="ValidateAcc()" />Yes<input id="radBptQ2No" name="radBptQ2" type="radio" onclick="    ValidateAcc()" />No</td>
                                <td style="width: 20px"></td>
                                <td class="lblTextBlack">Is this reactivation of an existing Business Income and Receipts Tax account that has been active within the last five years?<br />
                                    &nbsp;</td>
                            </tr>
                            <tr style="vertical-align: text-top">
                                <td style="width: 100px" class="lblTextBlack">3.
                                        <input id="radBptQ3Yes" name="radBptQ3" type="radio" onclick="ValidateAcc()" />Yes<input id="radBptQ3No" name="radBptQ3" type="radio" onclick="    ValidateAcc()" />No</td>
                                <td style="width: 20px"></td>
                                <td class="lblTextBlack">Is this a business affiliated with or sharing common ownership or control with a business that has filed a Business Income and Receipts Tax return?<br />
                                    &nbsp;</td>
                            </tr>
                            <tr style="vertical-align: text-top">
                                <td style="width: 100px" class="lblTextBlack">4.
                                        <input id="radBptQ4Yes" name="radBptQ4" type="radio" onclick="ValidateAcc()" />Yes<input id="radBptQ4No" name="radBptQ4" type="radio" onclick="    ValidateAcc()" />No</td>
                                <td style="width: 20px"></td>
                                <td class="lblTextBlack">Is this a business created through an ownership change of a business that has filed a Business Income and Receipts Tax return including but not limited to:
						<br />
                                    &nbsp;&nbsp;&nbsp;a) A merger, acquisition, or reorganization.
						<br />
                                    &nbsp;&nbsp;&nbsp;b) The transfer of an existing business to a person who maintains the same or substantially similar business.
						<br />
                                    &nbsp;&nbsp;&nbsp;c) The closing of a business and its subsequent reopening as the same or similar business.<br />
                                    &nbsp;</td>
                            </tr>
                            <tr style="vertical-align: text-top">
                                <td style="width: 100px" class="lblTextBlack">5.
                                        <input id="radBptQ5Yes" name="radBptQ5" type="radio" onclick="ValidateAcc()" />Yes<input id="radBptQ5No" name="radBptQ5" type="radio" onclick="    ValidateAcc()" />No</td>
                                <td style="width: 20px"></td>
                                <td class="lblTextBlack">Is this business primarily engaged to holding, selling, leasing, transferring, managing or developing real estate?</td>
                            </tr>
                            <tr style="vertical-align: text-top">
                                <td class="lblTextBlack" colspan="3">If you answer yes to any of the above questions you do not qualify for new business tax status under Code 19-3800.
						<br />
                                    <br />
                                    <b>Section B</b> - Employment Requirements<br />
                                    &nbsp;</td>
                            </tr>
                            <tr style="height: 40px; vertical-align: text-top">
                                <td style="width: 100px" class="lblTextBlack">6.
                                        <input id="radBptQ6Yes" name="radBptQ6" type="radio" onclick="ValidateAcc()" />Yes<input id="radBptQ6No" name="radBptQ6" type="radio" onclick="    ValidateAcc()" />No</td>
                                <td style="width: 20px"></td>
                                <td class="lblTextBlack">Do you agree to employ at least three full-time employees who are not family members and who work at least sixty percent of their time in the City of Philadelphia within the first 12 months of your business start date and continuously thereafter throught the 18th month of your business start date?<br />
                                    &nbsp;</td>
                            </tr>
                            <tr style="height: 40px; vertical-align: text-top">
                                <td style="width: 100px" class="lblTextBlack">7.
                                        <input id="radBptQ7Yes" name="radBptQ7" type="radio" onclick="ValidateAcc()" />Yes<input id="radBptQ7No" name="radBptQ7" type="radio" onclick="    ValidateAcc()" />No</td>
                                <td style="width: 20px"></td>
                                <td class="lblTextBlack">Do you agree to employ at least six full-time employees who are not family members and who work at least sixty percent of their time in the City of Philadelphia from the 18th month of your business start date and continuously thereafter throught the 24th month of your business start date?<br />
                                    &nbsp;</td>
                            </tr>
                            <tr style="vertical-align: text-top">
                                <td class="lblTextBlack" colspan="3">If you answer no to either of the above questions you do not qualify for new business tax status under Code 19-3800. If you answered yes to both questions you will automatically be registered for a wage tax account and be subject to wage tax filing requirements.
						<br />
                                    <br />
                                    <input id="chkBptAcknowledge" type="checkbox" onclick="ValidateAcc()" />&nbsp;&nbsp;&nbsp;I acknowledge that if I qualify for the new business tax status and subsequently fail to meet the employment requirements set forth in this section you will retroactively be subject to the full Business Income and Receipts Tax and Commercial Activity License fee from the start date of your business.<br />
                                    &nbsp;</td>
                            </tr>
                        </table>
                        <br />
                    </div>

                    <div id="divBusinessMsgs" class="col-lg-12" style="display: none; visibility: visible">
                        <p class="bg-primary">
                            <b>Wage Tax</b> - Only EMPLOYERS should register for Wage Tax.&nbsp;
                        </p>
                        <p class="bg-primary">
                            <b>*Wage Tax Filing Frequencies</b>
                        </p>
                        <p class="bg-primary">
                            <b>- Quarterly </b>- For an employer who withholds less than parent.$350 Philadelphia wage tax per month.
                        </p>
                        <p class="bg-primary">
                            <b>- Monthly </b>- For an employer who withholds Philadelphia wage tax in excess of parent.$350 but less than parent.$16,000 per month.
                        </p>
                        <p class="bg-primary">
                            <b>- Weekly </b>- For an employer who withholds Philadelphia wage tax of parent.$16,000 or more per month.
                        </p>
                        <p class="bg-primary">
                            <b>- Semi-Monthly </b>- For an employer who fits the weekly filing criteria with a biweekly payroll.
                        </p>

                        <p class="bg-primary">
                            <b>Earnings Tax</b> - Only EMPLOYEES having taxable wages on which Wage Tax was NOT withheld should register for Earnings Tax.
                        </p>
                    </div>

                    <div id="divIndividualMsgs" style="display: none; background:#fff !important; visibility: visible;">
                        <p class="bg-primary" style=" background:#fff !important;"> 
                            <b>Notice</b> - If you need to apply for business taxes, please return to the 'Profile' screen and change the 'Type of Business' field accordingly.
                        </p>
                    </div>

                    <div id="divWarningMsgs" style="display: none; visibility: visible">
                        <p class="bg-primary">
                            <b>Warning</b> - No organizational type selected on the Profile Screen. Please complete the Profile Screen than add your taxes
                        </p>
                    </div>

                    <div id="divGeneralMsgs" style="display: none; visibility: visible">
                        <p class="bg-primary">
                            If you 
				have additional addresses, other than the address on the profile screen, click 
				on the 'Address' button below. Partners/Corporations must click the 'Officer/Partner' 
				button before submitting for a tax account number.&nbsp;&nbsp;If neither of 
				these items apply to you, click the "Submit" button.
                        </p>
                    </div>
                    <br />
                  
                     <div class="form-group" id="divbtnSubmit" style="display: block">
                        <div class="col-sm-offset-3 col-sm-5  text-right">                                                               
                            <a class="btn btn-default submit_button_light" onclick="DoSubmit()" id="imgSubmit">Continue</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%--</div>--%>
    
  </body>
</html>
