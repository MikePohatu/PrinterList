SET FILECALLPATH=%~dp0

mkdir "%ProgramFiles%\20Road\PrintTools"
copy /y "%FILECALLPATH%SetupPrinter.ps1" "%ProgramFiles%\20Road\PrintTools\SetupPrinter.ps1"
regedit /s "%FILECALLPATH%protocol.reg"