JsOsaDAS1.001.00bplist00�Vscript_�app = Application.currentApplication();
app.includeStandardAdditions = true;

//app.doShellScript('ls')

app.displayNotification("TestText", {subtitle:"Test", withTitle: "Title"});

console.log(app);

app.onOpenLocation = function (thisUrl) {
	app.displayNotification(thisUrl);
	//app.doShellScript('/usr/sbin/lpadmin -p "HPDesignJet1055CM_PS3" -o printer-is-shared=false -E -v lpd://10.4.10.56 -P /Library/Printers/PPDs/Contents/Resources/HP\ DesignJet\ 1055CM\ PS3.gz');
}

//on decodeText(theText)// 	set flagA to false// 	set flagB to false// 	set theTempCharacter to ""// 	set theCharacterList to {}// 	repeat with theCurrentCharacter in theText// 		set theCurrentCharacter to contents of theCurrentCharacter// 		if theCurrentCharacter is "%" then// 			set flagA to true// 		else if flagA is true then// 			set theTempCharacter to theCurrentCharacter// 			set flagA to false// 			set flagB to true// 		else if flagB is true then// 			set end of theCharacterList to decodeCharacterHexString(("%" & theTempCharacter & theCurrentCharacter) as string)// 			set theTempCharacter to ""// 			set flagA to false// 			set flagB to false// 		else// 			set end of theCharacterList to theCurrentCharacter// 		end if// 	end repeat// 	return theCharacterList as string// end decodeText// on splitText(theText, theDelimiter)// 	set AppleScript's text item delimiters to theDelimiter// 	set theTextItems to every text item of theText// 	set AppleScript's text item delimiters to ""// 	return theTextItems// end splitText// on open location this_URL// 	// do shell script "/usr/sbin/lpadmin -p \"HPDesignJet1055CM_PS3\" -o printer-is-shared=false -E -v lpd://10.4.10.56 -P /Library/Printers/PPDs/Contents/Resources/HP\\ DesignJet\\ 1055CM\\ PS3.gz"// 	// 	set uriSplit to splitText(this_URL, "?")// 	set queryString to the offset of "?" in this_URL// 	display notification this_URL with title "Printer List" subtitle "Processing is complete."// end open location                              �jscr  ��ޭ