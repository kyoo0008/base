<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html>  
<head>     
	<script type="text/javascript" src="${pageContext.request.contextPath}/template/common/js/jquery/jquery-1.9.1.min.js"></script> 
</head>  
<body>     
	<script type="text/javascript">          
	(function() {             
		var api_key = 'R_5826142b5eb382dc7e6fac36695a48f2',                 
			api_login = 'agshon',                 
			api_url = 'api.bitly.com';   
		function shorten(url, callback) {                             
			if(!api_key || !api_login || !api_url) { console.log("returning... not yet initialized"); return; }  
			if(!url || !callback) { throw "Attempt to call shorten without a url or a callback function"; }  
			$.getJSON("http://"+api_url+"/v3/shorten?longUrl="+encodeURIComponent(url)+"&login="+api_login+"&apiKey="+api_key+"&callback=?", callback);              
		}               
		$.ajax({                 
			url: "api_key_include.js", // << this should return the data                 
			success: function(data) {                     
				api_key     = data.api_key;                     
				api_login   = data.api_login;                     
				api_url     = data.api_url;                 
			},                 
			data: {},                 
			type: "POST",                 
			dataType:"json"             
		});
		
		shorten("<c:url value="${param.currentUrl}"/>", function(response) {
			var url = response.data.url;
			var goUrl = "";
			<c:choose>
				<c:when test="${snsTitle eq '페이스북'}">
					goUrl = "http://www.facebook.com/sharer.php?u=" + url + "&t=" + encodeURIComponent("${param.contents}");
				</c:when>
				<c:when test="${snsTitle eq '트위터'}">
					goUrl = "http://twitter.com/?status=" + encodeURIComponent("${param.contents}") + "+" + url;
				</c:when>
				<c:when test="${snsTitle eq '미투데이'}">
					goUrl = "http://me2day.net/posts/new?new_post[body]=" + encodeURIComponent("${param.contents}") + "+" + url;
				</c:when>
			</c:choose>
			
			document.location.href = goUrl;
		}); 
	})();     
	</script>      
</body>  
</html>