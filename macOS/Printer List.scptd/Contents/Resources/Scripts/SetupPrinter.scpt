JsOsaDAS1.001.00bplist00?Vscript_?#!/usr/bin/env osascript -l JavaScript
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
		var params = {};
		var searchString = search;
		if (search.startsWith("?")) { searchString = searchString.slice(1); }

		var paramPairs = searchString.split("&");

		paramPairs.forEach(pair => {
			var keyval = pair.split("=");
			if (keyval.length > 1) {
				params[keyval[0]] = decodeURIComponent(keyval[1]);
			}
		});
		
		//make sure the expected params are there in the returned object
		var expectedParams = ["name","win_address","win_driver","win_options","mac_address","mac_app","mac_driver", "mac_options","ios_app","android_app","location","comment"];
		expectedParams.forEach(propName => {
			if (Object.prototype.hasOwnProperty.call(params, propName)===false) {
				params[propName] = "";
			}
		})
		return params;
	}
	return null;
}

function run(this_URL) {
	//var url = "SetupPrinter://setup?name=test1&mac_address=lpd%3A%2F%2F192.168.147.230&mac_app=https://apps.apple.com/us/app/brother-iprint-scan/id1193539993?mt=12#hasher";
	var url = this_URL.toString();	

	//debugger;
	if (url && url.length > 0) {
		var uri = getLocation(url);
		
		if (uri) {
			debugger;
			var params = getParams(uri.search);
			
			//there is an app, not old school printer. Launch the URL
			if (params.mac_app) { 
				app.openLocation(params.mac_app);
				return;
			}
			
			var printUri = 'lpd://' + params.ip;
			if (params.mac_driver.toLowerCase() === "" || params.mac_driver.toLowerCase() === "airprint" ) { 
				params.mac_driver = "everywhere";
			}
		
			var cmd = ""
			if (params.mac_options !== "") {
				cmd = 'lpadmin -P "' + params.name + '" -D "' + params.comment + '" -L "' + params.location + '" -E -v ' + params.mac_address + ' -m ' + params.mac_driver + ' ' + params.mac_options + ' -o printer-is-shared=False';
			} else {
				cmd = 'lpadmin -P "' + params.name + '" -D "' + params.comment + '" -L "' + params.location + '" -E -v ' + params.mac_address + ' -m ' + params.mac_driver + ' -o printer-is-shared=False';
			}
		
			app.displayNotification(cmd, {withTitle: "Debug"});	
			
			try {
				app.doShellScript(cmd);
			}
			catch (err)  {
				app.displayNotification("There was an error adding the printer:\n" + err.message, {withTitle: "Error adding printer"});	
			}
		} else {
			app.displayNotification("Invalid URI", {withTitle: "Error adding printer"});
		}
	}
	else {
		app.displayNotification("Empty Printer List setup", {withTitle: "Error adding printer"});	
	}
}                              ?jscr  ??ޭ