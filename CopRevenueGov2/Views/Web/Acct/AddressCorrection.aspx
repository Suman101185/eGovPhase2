<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>   
    <title></title>
    <!-- Bootstrap Core CSS -->
<link href="../Content/Styles/bootstrap.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="../Content/Styles/copegov.css" rel="stylesheet">
<link href="../Content/Styles/style.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css">
    <script ID="clientEventHandlersJS" LANGUAGE="javascript" type="text/javascript">
        var AC_Form;
        var xmlCode1 = parent.$g.getXmlDocObj();
        var xmlCode1Return = parent.$g.getXmlDocObj();

        $(document).ready(function () {
            loadXmlFiles();
        });

        function loadXmlFiles() {

            parent.$g.loadXmlSync("XML/Code1AddressCheck", parseXml_xmlCode1);
            parent.$g.loadXmlSync("XML/Code1AddressCheck", parseXml_xmlCode1Return);
        }

        function parseXml_xmlCode1(xml) {
            
            xmlCode1.loadXML(xml);
        }

        function parseXml_xmlCode1Return(xml) {
           
            xmlCode1Return.loadXML(xml);
        }

        function acCeaAccept() {
            $('#divAC').css('display', 'none');//style.display = 'none'
            
            if (AC_Form == 'PROFILE') {
                AC_ProfileDisabled(false);		//Located on Profile Page
                bAcctAddressChanged = false;
               
            } else if (AC_Form == 'PARTNERS') {
                AC_OfficersDisabled(false);		//Located on Officers Page
                bOfficersAddressChanged = 'accepted';
                updatePart();		//Located on Officers Page
                bOfficersAddressChanged = false;
            } else if (AC_Form == 'ADDRESSES') {
                AC_AddressDisabled(false);		//Located on Addresses Page

                bAddrAddressChanged = 'accepted';
                UpdateAddr();		//Located on Addresses Page

                bAddrAddressChanged = false;
            }		//if
        }

        function acCvaAccept() {          
           
            $('#divAC').css('display', 'none');
            
            if (AC_Form == 'PROFILE') {
                AC_ProfileDisabled(false);		//Located on Profile Page
                AC_ProfileChangePopulate();			//Located on Profile Page
                bAcctAddressChanged = false;
               
            } else if (AC_Form == 'PARTNERS') {
                AC_OfficersDisabled(false);		//Located on Officers Page
                AC_OfficersChangePopulate();			//Located on Officers Page
                bOfficersAddressChanged = 'accepted';
                
                bOfficersAddressChanged = false;
            } else if (AC_Form == 'ADDRESSES') {
                AC_AddressDisabled(false);		//Located on Addresses Page
                AC_AddressChangePopulate();	//Located on Addresses Page
                bAddrAddressChanged = 'accepted';
                
                bAddrAddressChanged = false;
            }		//if
        }		//acAccept

        function acCancel() {
           

            $('#divAC').css('display', 'none');
           
            if (AC_Form == 'PROFILE') {
                AC_ProfileDisabled(false);		//Located on Profile Page
                $('#txtBusAddress1').focus();
            } else if (AC_Form == 'PARTNERS') {
                AC_OfficersDisabled(false);		//Located on Officers Page
                $('#txtPartAddr1').focus();
            } else if (AC_Form == 'ADDRESSES') {
                AC_AddressDisabled(false);		//Located on Addresses Page
                $('#txtAddr1').focus();
            } else {
            }		//if
            //	parent.focus()	
        }		//acCancel

        function ac_CheckAddress() {           
            //EHD 2009.05.13 Code1 check on Profile, Address and Partners screens
            var sAddress1, sAddress2, sZipCode;
            
            $('#btnCVA').removeAttr('disabled');
            if (AC_Form == 'PROFILE') {
                sAddress1 = $('#txtBusAddress1').val();
                //EGOVWEB-82
                sAddress2 = " ";	//txtBusAddress2.value
                sZipCode = $('#txtBusZip').val();
            }
            else if (AC_Form == 'PARTNERS') {
                sAddress1 = $('#txtPartAddr1').val();
                sAddress2 = $('#txtPartAddr2').val();
                //sAddress2 = txtBusCity.value;

                sZipCode = $('#txtPartBusZip').val();

            }
            else if (AC_Form == 'ADDRESSES') {
                sAddress1 = $('#txtAddr1').val();
                sAddress2 = $('#txtAddr2').val();
                sZipCode = $('#txtAddrBusZip').val();
            }
            else {
                return false;
            }		//if

            parent.$x.ispXmlSetFieldVal(xmlCode1, sAddress1, 'Address1', '', 0);
            parent.$x.ispXmlSetFieldVal(xmlCode1, sAddress2, 'Address2', '', 0);
            parent.$x.ispXmlSetFieldVal(xmlCode1, sZipCode, 'Zip', '', 0);

            //SUMAN CODE1 service down , skip check process
            ispCallXMLForm(xmlCode1, xmlCode1Return, 'AddressCheck', '');


            var xmlstring;

            var tmpReturn = parent.$g.XMLToString(xmlCode1Return);

            tmpReturn = tmpReturn.replace('&lt;?xml version="1.0" encoding="UTF-8"?&gt;', '');
            tmpReturn = tmpReturn.replace(/(&lt;)/g, '<');
            tmpReturn = tmpReturn.replace(/(&gt;)/g, '>');

            xmlCode1Return.loadXML(tmpReturn);

            xmlCode1Return.xml = parent.$x.ispXmlGetRecordXml(xmlCode1Return, 'c1match', 0);

            if (parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Message', '', 0).toUpperCase() == 'SUCCESS' &&
                    parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Closeness', '', 0) == '0') {
                // alert("abc");
                acCvaAccept();
                return true;
            }
            else {
                // alert("abcd");
                FormatAddress();
                ShowAddressCorrection();//manoranjan
                return false;
            }		//if
        }		//ac_CheckAddress


        function ispReplace(sInput, sFind, sReplace) {
           

            //suman ---------
            var r;
            r = sInput.replace(sFind, sReplace);
            return r;
            //---------------

        }

        function ShowAddressCorrection() {
          
            var ddAddrBusState = document.getElementById("ddAddrBusState");
            var ddBusState = document.getElementById("ddBusState");
            
            var text = '';
            var left = 0;
            var top = 0;
            //divAC.style.display = 'block'
            $('#divAC').css('display', 'block');
            //divAC.style.position = 'absolute'
            $('#divAC').css('position', 'absolute');
            

            var l1_ctrl;
            var l2_ctrl;
            var l1_ctrl_offset;
            var l2_ctrl_offset;

            if (AC_Form == 'PROFILE') {
                text = $('#txtBusAddress1').val() + ' ' + $('#txtBusCity').val() + ' ' +
                        $(ddBusState.options[ddBusState.selectedIndex]).attr('CODE') + ' ' + $('#txtBusZip').val();
                $('#lblCEA').text(text);
                DisplayProfile();
               
                l1_ctrl = $('#AcctProfile');
                l2_ctrl = $('#divAC');
                l1_ctrl_offset = l1_ctrl.offset();
                l2_ctrl_offset = l2_ctrl.offset();

                left = ((l1_ctrl.width() / 2) - (l2_ctrl.width() / 2)) + l1_ctrl_offset.left;
                top = ((l1_ctrl.height() / 2) - (l2_ctrl.height() / 2)) + l1_ctrl_offset.top;



                $('#divAC').css('left', left);
                $('#divAC').css('top', top);


                AC_ProfileDisabled(true);		//Located on Profile Page
            } else if (AC_Form == 'PARTNERS') {
                text = $('#txtPartAddr1').val() + ' ' + $('#txtPartAddr2').val() + ' ' + $('#txtPartBusCity').val() + ', ' +
                        $(ddPartBusState.options[ddPartBusState.selectedIndex]).attr('CODE') + ' ' + $('#txtPartBusZip').val();
                $('#lblCEA').text(text);
               

                l1_ctrl = $('#AcctPartners');
                l2_ctrl = $('#divAC');
                l1_ctrl_offset = l1_ctrl.offset();
                l2_ctrl_offset = l2_ctrl.offset();

                left = ((l1_ctrl.width() / 2) - (l2_ctrl.width() / 2)) + l1_ctrl_offset.left;
                top = ((l1_ctrl.height() / 2) - (l2_ctrl.height() / 2)) + l1_ctrl_offset.top;


              $('#divAC').css('left', left);
               $('#divAC').css('top', top);

                AC_OfficersDisabled(true);		//Located on Officers Page
            } else if (AC_Form == 'ADDRESSES') {
                text = $('#txtAddr1').val() + ' ' + $('#txtAddr2').val() + ' ' + $('#txtAddrBusCity').val() + ' ' +
                        $(ddAddrBusState.options[$('#ddBusState').selectedIndex]).attr('CODE') + ' ' + $('#txtAddrBusZip').val();
                $('#lblCEA').text(text);
               

                l1_ctrl = $('#AcctAddresses');
                l2_ctrl = $('#divAC');
                l1_ctrl_offset = l1_ctrl.offset();
                l2_ctrl_offset = l2_ctrl.offset();

               left = ((l1_ctrl.width() / 2) - (l2_ctrl.width() / 2)) + l1_ctrl_offset.left;
                top = ((l1_ctrl.height() / 2) - (l2_ctrl.height() / 2)) + l1_ctrl_offset.top;

                $('#divAC').css('left', left);
                $('#divAC').css('top', top);

                AC_AddressDisabled(true);		//Located on Addresses Page
            } else {
            }		//if

            if (parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address1', '', 0) == '') {
                //btnCVA.disabled = true
                $('#btnCVA').attr('disabled', 'true');
            }		//if
            $('#divAC').focus()
        }		//ShowAddressCorrection

        function FormatAddress() {
            var sAddress;
            if (parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Message', '', 0).toUpperCase() != 'SUCCESS') {
                sAddress = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Message', '', 0) + ': ';
            } else {
                sAddress = '';
            }		//if


            if (parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address1', '', 0) != '') {
                //		sAddress += '\n'
                sAddress += parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address1', '', 0);
                if (parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address2', '', 0) != '' &&
                        AC_Form != 'PROFILE') {
                    sAddress += ', ' + parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address2', '', 0);
                }		//if
                sAddress += ', ' + parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'City', '', 0);
                sAddress += ', ' + parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'State', '', 0);
                sAddress += ', ' + parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Zip', '', 0);
                if (parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Zip4', '', 0) != '') {
                    sAddress += '-' + parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Zip4', '', 0);
                }		//if
            }		//if
            $('#lblCVA').text(sAddress);
        }	//FormatAddress



</script>
</head>
<body>
     <div id="divAC" class="div-border table-width " style="DISPLAY: none; 
			 POSITION: relative; BACKGROUND-COLOR: #e5e4e2; z-index:100">
		<table width="100%" border=0 cellSpacing=0 cellPadding=0 >
			<tr>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
				<td WIDTH="5%"></td>
		  </tr>
			<tr>
				<td colspan=20 align=middle valign=center>
					<label class="hdrLarge" style="color:#2B547E">Address Verification Dialog</label><br>
				</td>
			</tr><!--			<tr>
				<td colspan=20 height=10></td>
			</tr>-->
			<tr>
				<td colspan=14>
					<label class="lblInstrNormal" style="margin-left: 10px; color:#2B547E">You entered address.</label></td>
				<td colspan=4></td>
				<td colspan=2></td>
			</tr>
			<tr>
				<td colspan=16 valign=center height=10 style="VERTICAL-ALIGN: middle">
					<label id="lblCEA" class="inpNormal" style="margin-left: 10px; VERTICAL-ALIGN: middle"></label><br>
				</td>
				<td colspan=2 valign=center align=middle height=10>
					<INPUT id="btnCancel" onclick="acCancel()" class="small_edit" style="margin-left: 5px; WIDTH: 60px" type=button value="Edit">
				</td>

				<td colspan=2 valign=center align=middle height=10>
					<INPUT id="btnCEA" onclick="acCeaAccept()" class="small_edit" style="margin-left: 5px; WIDTH: 60px" type=button value="Accept">
				</td>
			</tr>
			<tr>
				<td colspan=20 height=10></td>
			</tr>
			<tr>
				<td colspan=8>
					<label class="lblInstrNormal" style="margin-left: 10px; color:#2B547E">We suggest.</label>
				<td colspan=4></td>
				<td colspan=8></td>
			</tr>
			<tr>
				<td colspan=18 valign=center height=10 style="VERTICAL-ALIGN: middle" >
					<label id="lblCVA" class="inpNormal" style="margin-left: 10px; VERTICAL-ALIGN: middle"></label><br>
				</td>
				<td colspan=2 valign=center align=middle height=10>
					<INPUT id="btnCVA" onclick="acCvaAccept()" class="small_edit" style="MARGIN-LEFT: 5px; WIDTH: 60px" type=button value="Accept">
				</td>
			</tr>
		</table>

	</div>
</body>
</html>
