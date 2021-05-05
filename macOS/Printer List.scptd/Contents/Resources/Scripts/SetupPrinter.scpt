#!/usr/bin/osascript -l JavaScript

var app = Application.currentApplication();
app.includeStandardAdditions = true;

//https://stackoverflow.com/a/21553982
function getLocation(href) {
    var match = href.match(/^(SetupPrinter\:)\/\/(([^:\/?#]*)(?:\:([0-9]+))?)([\/]{0,1}[^?#]*)(\?[^#]*|)(#.*|)$/i);
    return match && {
        href: href,
        protocol: match[1],
        host: match[2],
        hostname: match[3],
        port: match[4],
        pathname: match[5],
        search: match[6],
        hash: match[7]
    }
}

function getParams(search) {
	if (search && search.length !== 0) {
		const params = {};
		var searchString = search;
		if (search.startsWith("?")) { searchString = searchString.slice(1); }

		const paramPairs = searchString.split("&");

		paramPairs.forEach(pair => {
			var keyval = pair.split("=");
			if (keyval.length > 1) {
				params[keyval[0]]= decodeURIComponent(keyval[1]);
			}
		});

		//make sure the expected params are there in the returned object
		const expectedParams = ["name","ip","location","comment","driver"];
		expectedParams.forEach(propName => {
			if (Object.prototype.hasOwnProperty.call(params, propName)===false) {
				params[propName]= "";
			}
		})
		return params;
	}
	return null;
}

function run(this_URL) {
	//var test = "SetupPrinter://setup?name=test1&ip=192.168.4.5#hasher";
	const url = this_URL;

	if (url && url.length !== 0) {
		const uri = getLocation(url);
		const params = getParams(uri.search);

		app.displayNotification(params.name + " : " + params.ip, {withTitle: "Adding printer"});	
	}
	else {
		app.displayNotification("Empty Printer List setup", {withTitle: "Error:"});	
	}
}