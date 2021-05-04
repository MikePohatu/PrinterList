SET FILECALLPATH=%~dp0

mkdir "%ProgramFiles%\20Road\PrinterList"
copy /y "%FILECALLPATH%SetupPrinter.ps1" "%ProgramFiles%\20Road\PrinterList\SetupPrinter.ps1"
regedit /s "%FILECALLPATH%protocol.reg"