SET FILECALLPATH=%~dp0

mkdir "%ProgramFiles%\20Road\PrinterList"
copy /y "%FILECALLPATH%SetupPrinter.ps1" "%ProgramFiles%\20Road\PrinterList\SetupPrinter.ps1"
if not exist "%ProgramFiles%\20Road\PrinterList\conf.json" copy /y "%FILECALLPATH%conf.json" "%ProgramFiles%\20Road\PrinterList\conf.json"
regedit /s "%FILECALLPATH%protocol.reg"