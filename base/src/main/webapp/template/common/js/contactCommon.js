

function fn_egov_contact_login_req() {
	alert('로그인 하신 후 이용해주세요');
	return false;
	
	
}

function fn_egov_contact_req(loginYn) {
	if(typeof(initCfgBackGround) == 'undefined') {
		if(loginYn != 'Y') {
			fn_egov_contact_login_req();
		}
	}
}

/*
function fn_egov_background_req() {	
	if(typeof(jQuery) == 'undefined') {	
		if(confirm('화면이동이 필요합니다. 이동하시겠습니까?')) {
			window.location.href = smartPortalUrl + '/index.do?reqBtnCfgBackGround=Y';
		}
	}
}

function fn_egov_menu_req() {
	if(typeof(jQuery) == 'undefined') {		
		if(confirm('화면이동이 필요합니다. 이동하시겠습니까?')) {
			window.location.href = smartPortalUrl + '/index.do?reqBtnCfgMenu=Y';
		}
	}
}

function fn_egov_site_req() {
	if(typeof(jQuery) == 'undefined') {		
		if(confirm('화면이동이 필요합니다. 이동하시겠습니까?')) {
			window.location.href = smartPortalUrl + '/index.do?reqBtnCfgSite=Y';
		}
	}
}
*/
function smartIconToggle()
{
	var div = document.getElementById("smartIconToggleDiv");
	var topen = document.getElementById("bopen");
	var tclose = document.getElementById("bclose");
	//var menu = document.getElementById("sub_bottom_menu");

	if(div != null) {
		//if(div.style.visibility=="" || div.style.visibility=="visible")
		if(topen.style.display == "none")
		{
			//div.style.visibility = "hidden";
			div.style.display = "none";
			topen.style.display = "block";
			tclose.style.display = "none";
			//menu.style.bottom = -107;
			fnSetCookieValue('tabViewCookie', 'hide');
		}else{
			//div.style.visibility = "visible";
			div.style.display = "block";
			topen.style.display = "none";
			tclose.style.display = "block";
			//menu.style.bottom = 0;
			fnSetCookieValue('tabViewCookie', 'show');
		}
	}
}

function smartIconNextRolling()
{

	var i=1;
	for(i; i<rollingCount;i++)
	{
		var divValue = document.getElementById("smartIconPanel"+i);

		if(divValue.style.display=="block")
		{
			if(i==rollingCount-1)
			{
				document.getElementById("smartIconPanel"+i).style.display="none";
				document.getElementById("smartIconPanel1").style.display="block";
				i=rollingCount;
			}
			else
			{

				document.getElementById("smartIconPanel"+i).style.display="none";

				if(!document.getElementById("smartIconPanel"+(i+1)))
				{
					document.getElementById("smartIconPanel1").style.display="block";
					i=rollingCount;
				}
				else
				{
					document.getElementById("smartIconPanel"+(i+1)).style.display="block";
					i=rollingCount;
				}
			}
		}
	}
}


function smartIconPrevRolling()
{
	var i=1;
	var j=1;

	for(i; i<rollingCount;i++)
	{
		var divValue=document.getElementById("smartIconPanel"+i);

		if(divValue.style.display=="block")
		{
			if(i==1)
			{
				for(j; j<rollingCount;j++)
				{

					if(document.getElementById("smartIconPanel"+(rollingCount-j)))
					{
						document.getElementById("smartIconPanel"+i).style.display="none";
						document.getElementById("smartIconPanel"+(rollingCount-j)).style.display="block";
						i=rollingCount;
						j=rollingCount;
					}

				}
			}
			else
			{
				document.getElementById("smartIconPanel"+i).style.display="none";
				document.getElementById("smartIconPanel"+(i-1)).style.display="block";
				i=rollingCount;

			}
		}
	}
}

  function fnGetCookie(name) {
	  /*
	  var prefix = name + "=";

	  var cookieStartIndex = document.cookie.indexOf(prefix);
	  if (cookieStartIndex == -1) return null;
	  var cookieEndIndex = document.cookie.indexOf(";", cookieStartIndex + prefix.length);
	  if (cookieEndIndex == -1) cookieEndIndex = document.cookie.length;


	  return unescape(document.cookie.substring(cookieStartIndex + prefix.length, cookieEndIndex));
	  */
	  var results = document.cookie.match ( '(^|;) ?' + name + '=([^;]*)(;|$)' );  
	  if ( results )    
		  return ( unescape ( results[2] ) );  
	 else    
		 return null;
  }
  
  function fnSetCookieValue(name, value) {
  	var expireDate = new Date();
  	expireDate.setFullYear(expireDate.getFullYear() + 1);
  	
  	var domain = "";
  	/*
  	var domain = "domain=.edus.or.kr;";
  	if(document.domain == "smart.edus.or.kr") {
  		domain = "";
  	}
  	*/
  	var cook = name + "=" + escape(value) + "; path=/; expires=" + expireDate.toGMTString() + ";" + domain;
  	document.cookie = cook;
  }
  
  if(fnGetCookie('tabViewCookie') == 'hide') {
		smartIconToggle();
  }
