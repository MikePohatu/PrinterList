function SetupPrinter {
    Param (
        [Parameter(Mandatory=$true)][string] $IP,
        [Parameter(Mandatory=$true)][string] $Name,
        [Parameter(Mandatory=$true)][string] $Driver,
        [string] $Location = "",
        [string] $Comment = ""
    )
    
    Write-Host "Adding printer: $Name, Port: $IP, Driver: $Driver, Comment: $Comment, Location: $Location"

    $Port = Get-PrinterPort $IP -ErrorAction Ignore
    if ($Port) {
        Write-Information "Printer port already exists: $port"
    } else {
        Add-PrinterPort -name "$IP"
    }

    $Printer = Get-Printer -Name $Name -ErrorAction Ignore
    if ($Printer) {
        Write-Warning "Printer already exists: $Name. Updating..."
        Set-Printer -Name "$Name" -DriverName "$Driver" -PortName "$IP" -Location $Location -Comment $Comment
    } else {
        Add-Printer -Name "$Name" -DriverName "$Driver" -PortName "$IP" -Location $Location -Comment $Comment
    }
    write-host "Done"
}

Write-Host "Adding your printer. Please wait..."

Add-Type -AssemblyName System.Web
$url=[System.Web.HttpUtility]::UrlDecode($args[0])
$urlArr = $url.split(":")
$urlParams = $urlArr[1].split(";")

#$urlParams | out-file -FilePath "$($env:TEMP)\printermapper.log" -Append


SetupPrinter -Name $urlParams[0] -IP $urlParams[1] -Driver $urlParams[2] -Comment $urlParams[3] -Location $urlParams[4]

start-sleep -seconds 3
