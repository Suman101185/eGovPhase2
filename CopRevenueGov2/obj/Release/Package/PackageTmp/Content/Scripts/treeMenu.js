$(document).ready(function (){
		
		// TREE MENU
		
		$('#treeMenu ul li:has("div")').find('span:first').addClass('closed');
		$('#treeMenu ul li:has("div")').find('div').hide();	
		$('#treeMenu li:has("div")').find('span:first').click(function () {

		 

		    var seclected_ul = $(this).parent().parent();

		    var opened_li_mainMenu = $(seclected_ul).find('li:has("div:visible")');
		    var opened_li_mainMenu_div = opened_li_mainMenu.find('div');
		    var s = opened_li_mainMenu.find('span');
		    opened_li_mainMenu_div.hide();

		    s.removeClass('opened');
		    var seclected_li = $(this).parent('li');

		    seclected_li.find('span:first').toggleClass('opened');
		    seclected_li.find('div:first').slideToggle();
		    //-------------

		});
		 
		 /*$('#treeMenu ul li:has("div")').find('span:first').addClass('closed');
		$('#treeMenu ul li:has("div")').find('div').hide();	
		$('#treeMenu li:has("div")').find('span:first').click (function (){ 
			alert('hi');
			$(this).parent('li').find('span:first').toggleClass('opened');
			$(this).parent('li').find('div:first').slideToggle();
		 
		 });*/
		 
		 
	});