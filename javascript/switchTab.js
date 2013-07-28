var switchTab = function(options) {
	this.tabClass = options.tabClass || '';
	this.contentId = options.contentId || '';
	this.activeClass = options.activeClass || '';
	this.showFirst = options.showFirst || '';
	this.tabIdArr = options.tabId || [];
	this.showFirstFn(this);
	function tabClick (options) {
		var tabIdArr = options.tabIdArr,
			tabClass = options.tabClass,
			activeClass = options.activeClass,
			contentId = options.contentId
		for (var i = 0, len = tabIdArr.length; i < len; i++) {
			document.getElementById(tabIdArr[i]).onclick = function(data) {
				var tabId = data.srcElement.id;
				options.activeColor(tabClass, activeClass, tabId);
				options.fetchContent(options.getUrl(tabId), contentId)
			}
		}
	}
	tabClick(this);
}


switchTab.prototype.getUrl = function(tabId) {
	return document.getElementById(tabId).getAttribute('tab-url');
};

switchTab.prototype.fetchContent = function(tabUrl, contentId) {
	var xmlhttp;
	if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
	  	xmlhttp=new XMLHttpRequest();
	}else {// code for IE6, IE5
	  	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200) {
		    document.getElementById(contentId).innerHTML=xmlhttp.responseText;
		}
	}
	xmlhttp.open("GET",tabUrl,true);
	xmlhttp.send();
};

switchTab.prototype.activeColor = function(tabClass, activeClass, tabId) {
	var elems = document.getElementsByClassName(tabClass);
	for(var i = 0; i < elems.length; i++) {
	    elems[i].className = elems[i].className.replace(activeClass , '' );
	}
	document.getElementById(tabId).className += ' ' + activeClass;
};

switchTab.prototype.showFirstFn = function(options) {
	var tabId = options.showFirst,
		tabClass = options.tabClass,
		activeClass = options.activeClass,
		contentId = options.contentId;
	options.activeColor(tabClass, activeClass, tabId);
	options.fetchContent(options.getUrl(tabId), contentId)
};
