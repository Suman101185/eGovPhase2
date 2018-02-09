<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<HTML><HEAD>

<%
    /*
    this.ClientScript.RegisterClientScriptBlock(
    this.GetType(),
    "JQUERY_MIN",
    CopMvcUtil.GetStringFromFile(Server.MapPath("~/Content/Scripts/JqueryMin.js")), true); 

    this.ClientScript.RegisterClientScriptBlock(
    this.GetType(),
    "ispFunctions",
    CopMvcUtil.GetStringFromFile(Server.MapPath("~/Content/Scripts/ispFunctions.js")), true);

    this.ClientScript.RegisterClientScriptBlock(
    this.GetType(),
    "ispXmlProc",
    CopMvcUtil.GetStringFromFile(Server.MapPath("~/Content/Scripts/ispXmlProc.js")), true);     
     * */
%>

<script language="javascript" type="text/javascript">
var gProcessSubmitElement = ''
var gCurrentLayer = new Array()
var gTimeOutID = ''
var gIntervalID = ''

function ispDisplayProgress(lFunction, lLabel) {
	gCurrentLayer = new Array();

//EHD - 2008.11.24 - Added for the Code1 Addition
//$(parent.NavWin.document).find('#tblNavMenu').first().attr("disabled")
	if ($(parent.NavWin.document).find('#tblNavMenu').first().is(":disabled") == true) {
		return;
	}
	//if
	//alert(window.event);
	//alert(arguments.callee.caller);

	var event=null;
	if(window.event !=null && window.event != 'undefined')
	{
		event = window.event;
	
	}
	else
	{
		if(arguments.callee != null && arguments.callee !='undefined')
		{
			if(arguments.callee.caller != null && arguments.callee.caller != 'undefined')
			{
				event =arguments.callee.caller.arguments[0] ;
			}
		}	
	}
	
	if (event != null) {
		var eElement =  parent.MenuWin.getEventSource(event);
		if (eElement != null) {
			gProcessSubmitElement = eElement;
			$(gProcessSubmitElement).css("visibility","hidden");
		}		
	} 
	else {
		$(parent.NavWin.document).find('#btn7').first().css("visibility", "hidden");
	}		

	j=0;
	$(document).find('div').each(function (){
		if($(this).css('display')=='block'){
			$(this).css('display', 'none');
			gCurrentLayer[j] = $(this);
			j = j+1;
		}
	});
//--------------------------------------------------


	if (lLabel == null) {
		lLabel = '';
	}		//if
	$('#lblProgressDoing').text(lLabel);
	$('#ispProgressScreen').css('display','block');
//	gIntervalID = window.setInterval('ispProgressMove()',50)
	gTimeOutID = window.setTimeout(lFunction,1);
}		//ispDisplayProgress
		
function ispHideProgress(lLayer) {
	if (gProcessSubmitElement != null) {
		if (gProcessSubmitElement != '') {
			$(gProcessSubmitElement).css('visibility','visible');
			gProcessSubmitElement = '';
		} else {
			$(parent.NavWin.document).find('#btn7').first().css("visibility", "visible");
		}		
	}		
	
	for (i=0; i<gCurrentLayer.length; i++) {
		$(gCurrentLayer[i]).css('display', 'block');//style.display = 'block';
	}		//for

//	gCurrentLayer = new Array()

	window.clearInterval(gIntervalID);
	window.clearTimeout(gTimeOutID);
	//ispProgressScreen.style.display="none";
	$('#ispProgressScreen').css('display','none');
}		//ispHideProgress

function ispProgressMove() {
	$('#lblProgressMoving').html($('#lblProgressMoving').html() + '>  ');
//	Table1.refresh
//	window.setInterval('ispProgressMove',50)
}		//ispProgressMove

</script>
</HEAD>
<BODY>
<Div Id="Ispprogressscreen" Style="display: None; visibility: Visible">
	<Table Border="0" Cellpadding="0" Cellspacing="0" Width="80%" Height="70%"
			 Id="Table1" Align="Center" Style="Position: Absolute; Valign: Middle">
		<tr height=45%><td></td></tr>
		<tr width="100%" height=40>
			<td ALIGN="middle" VALIGN="center">
				<font FACE="Courier New" COLOR="blue" style="FONT-WEIGHT: bold; FONT-SIZE: 12pt">
						<label id=lblProgressDoing></label>
						<label> - Please Wait</label></font></td></tr>


		<tr height=45%><td></td></tr>
</table>
</div>
</BODY>
</HTML>
