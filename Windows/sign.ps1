Function Get-ListedCert {
    $certsArr = Get-ChildItem -Path cert:currentuser\my\ -CodeSigningCert

    Write-Host "Please select your certificate from the list below"

    for ($i=0; $i -lt $certsArr.Count; $i++) {
        Write-Host "$($i): $($certsArr[$i].Subject)"
    }

    [int]$selected = Read-Host "Press the number of the certificate"
    return $certsArr[$selected]
}

Function SignScript {
    Param(
        [Parameter(Mandatory=$true)][string]$Path,
        [string]$SignPath='C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64',
        [string]$Description
    )

    $signer = "$SignPath\signtool.exe"
    [Array]$signparams = "sign","/v","/n","20Road Limited","/d",$Description,"/du","https://20road.com","/tr","http://ts.ssl.com","/td","SHA256","/fd","SHA256",$Path

    Write-Host "Sign tool: $signer"
    Write-Host "Params: $signparams"

    & $signer $signparams
}


SignScript -Path "$($PSScriptRoot)\SetupPrinter.ps1" -Description "20Road PrinterList Setup Script"