<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head>


<script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/Accounting.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>

<script id="clientEventHandlersJS" language="javascript" type="text/javascript">

    function ClearButtons() {

        $('#btn1').html('');
        $('#btn1').removeAttr('disabled');
        $('#btn2').html('');
        $('#btn2').removeAttr('disabled');
        $('#btn3').html('');
        $('#btn3').removeAttr('disabled');
        $('#btn4').html('');
        $('#btn4').removeAttr('disabled');
        $('#btn5').html('');
        $('#btn5').removeAttr('disabled');
        $('#btn6').html('');
        $('#btn6').removeAttr('disabled');
    } 	//ClearButtons

    function ClearImages() {
        $('#btn7').html('');
        $('#btn7').removeAttr('disabled');
    } 	//ClearButtons

</script>

<link rel="stylesheet" type="text/css" href="../Content/Styles/Font.css" />
<link rel="stylesheet" type="text/css" href="../Content/Styles/Object.css" />

<title></title>
</head>
    <body>
<!-- suman : I dont know why this tag has 2 id and which ione is final, i removed "tblButtons"
<table id="tblNavMenu" class="tblNormal" cellspacing="0" cellpadding="0" border="0" id="tblButtons"
-->

<table id="tblNavMenu" class="tblNormal" cellspacing="0" cellpadding="0" border="0" width="95%" height="40">

    <tr id="rowButtons" style="DISPLAY: none">  
		<td width="15%" align="right">
			<p id="btn1"></p>
		</td>
		<td width="15%" align="center">
			<p id="btn2"></p>
		</td>
		<td width="15%" align="center">
			<p id="btn3"></p>
		</td>
		<td width="15%" align="left">
			<p id="btn4"></p>
		</td>
		<td width="15%" align="left">
			<p id="btn5"></p>
		</td>
		<td width="15%" align="left">
			<p id="btn6"></p>
		</td>

	</tr>

    <tr id="mnuImages" style="display: none;">
		<td align="left" valign="top">
			<p id="btn7" style="margin-left: 4%; margin-top:0%; width:100%;">
            
                <!--  here is no image as expected in Acct/ApplyMain.asp , line 98 -->
				<!--So I create one, but don't know its outcome -->
				<img id="imgProfile" height="34" src="../Content/Images/taxtype_tbd.gif" width="72" alt="" />


                <!--  This img id should be 'imgAddresses' as coded in Acct/ApplyMain.asp, line 116 -->
				<!--<img id="img2" height="34" src="../Images/taxtype_tbd.gif" width="72" /> -->
				<img id="imgAccount" height="34" src="../Content/Images/taxtype_tbd.gif" width="72" alt="" />

                <!--  This img id should be 'imgAddresses' as coded in Acct/ApplyMain.asp, line 122 -->
				<!--<img id="img3" height="34" src="../Images/address_tbd.gif" width="70" /> 
  				<img id="imgAddresses" height="34" src="../Images/address_tbd.gif" width="70" alt="" />

                <!--  This img id should be 'imgPartners' as coded in Acct/Profile.htm -->
				<!--<img id="img4" height="34" src="../Images/officer_tbd.gif" width="66" /> -->
                <img id="imgPartners" height="34" src="../Content/Images/officer_tbd.gif" width="66" alt="" />

                <!--  This img id should be 'imgECheck' as coded in Acct/Profile.htm line 165 -->
				<!--<img id="img5" style="display: none;" height="34" src="../Images/e-check_tbd.gif" width="65" /> -->
				<img id="imgECheck" style="display: none;" height="34" src="../Content/Images/e-check_tbd.gif" width="65" alt="" />


                <!-- This img id should be 'imgSubmit' as coded in Acct/Profile.htm line 177-->
				<!--<img id="img6" height="34" src="../Images/submit_tbd.gif" width="71" /> -->
				<img id="imgSubmit" height="34" src="../Content/Images/submit_tbd.gif" width="71" alt="" />
			</p>
				<!--
                Suman ----------------------------------------------------------------------------
                This print button is forming dynamically. no need it to be hard coded here.
                This might have written for testing purpose only.
                 
                &nbsp;&nbsp;&nbsp;&nbsp;
                <input id="btnPrint1" style="height:64px; width:100; margin-bottom:2px" value="Print Application" type="button"></input>
                ------------------------------------------------------------------------------------
                -->
			
		</td>
  </tr>
  
  <tr id="rowLabel" style="display: none">
		<td align="left" valign="top">
			<p id="lbl1" style="font-weight: bold;  margin-left: 4%; color: red"></p></td>
  </tr>  
</table>
    </body>
</html>
