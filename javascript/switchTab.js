
var switchTab = function(options) {

	// pass options of set to default.
	this.tabClass = options.tabClass || '';
	this.contentId = options.contentId || '';
	this.activeClass = options.activeClass || '';
	this.showFirst = options.showFirst || '';
	this.tabIdArr = options.tabId || [];

	// showup the first tab
	this.showFirstFn(this);

	// switch to correct state from url
	this.state(this);

	// tab click function
	function tabClick (options) {
		var tabIdArr = options.tabIdArr,
			tabClass = options.tabClass,
			activeClass = options.activeClass,
			contentId = options.contentId
		

		// register onclick function for all the tabs
		for (var i = 0, len = tabIdArr.length; i < len; i++) {
			document.getElementById(tabIdArr[i]).onclick = function(data) {
				var tabId = data.target.id;

				// history pushState
				var state_obj = { 'tab_state': tabId}
				history.pushState(state_obj, tabId, '#' + tabId);
				console.log(history);
				console.log(history.state)
				options.activeColor(tabClass, activeClass, tabId);
				options.fetchContent(options.getUrl(tabId), contentId)
			}
		}

    window.addEventListener("popstate", function(event) {
      var tabId = options.showFirst;
      if (window.location.hash !== "") {
        tabId = window.location.hash.substring(1);
      }
      options.activeColor(tabClass, activeClass, tabId);
      options.fetchContent(options.getUrl(tabId), contentId);
    }, false);
	}
	tabClick(this);
}

switchTab.prototype.state = function(options) {
	var contentId = options.contentId,			
		tabClass = options.tabClass,
		activeClass = options.activeClass,
		contentId = options.contentId
	var hash = window.location.hash;
	var sub_hash = hash.substring(1);

	if(hash) {
		this.activeColor(tabClass, activeClass, sub_hash);
		this.fetchContent(this.getUrl(sub_hash), contentId)
	}
};


switchTab.prototype.getUrl = function(tabId) {
	return document.getElementById(tabId).getAttribute('tab-url');
};


// fetch content from URL
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

// tab active color switch
switchTab.prototype.activeColor = function(tabClass, activeClass, tabId) {
	var elems = document.getElementsByClassName(tabClass);
	for(var i = 0; i < elems.length; i++) {
	    elems[i].className = elems[i].className.replace(activeClass , '' );
	}
	document.getElementById(tabId).className += ' ' + activeClass;
};

// the first tab
switchTab.prototype.showFirstFn = function(options) {
	var tabId = options.showFirst,
		tabClass = options.tabClass,
		activeClass = options.activeClass,
		contentId = options.contentId;
	options.activeColor(tabClass, activeClass, tabId);
	options.fetchContent(options.getUrl(tabId), contentId)
};
