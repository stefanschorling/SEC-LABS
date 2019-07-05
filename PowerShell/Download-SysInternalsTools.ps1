Function Download-SysInternalsTools{
<# 
 .Synopsis Download-SysInternalsTools will simply download the sysinternals tools
 .DESCRIPTION Download all tools to a specified destination directory
 .EXAMPLE Download-SysInternalsTools -DestinationFolder E:\Troubleshooting\SysInternals
 .EXAMPLE Download-SysInternalsTools -DestinationFolder E:\Troubleshooting\SysInternals -DownloadAsZIP
 .NOTES Created by Mattias Borg 2016 
#>
Param($DestinationFolder = "$env:temp\Sysinternals",[Switch]$DownloadAsZIP)
 
if (-not (Test-Path $DestinationFolder))
{
 
    New-Item $DestinationFolder -ItemType Directory
 
}
$Tools = (Invoke-WebRequest -Uri "http://live.sysinternals.com").links.innerHTML
if ($DownloadAsZIP){
$Tools = (Invoke-WebRequest -Uri "http://live.sysinternals.com/Files/").links.innerHTML
}
 
[int]$i = 0
 
Foreach ($Tool in $Tools)
    {
         
        $Source = "http://live.sysinternals.com/$Tool"
        if ($DownloadAsZIP){
        $Source = "http://live.sysinternals.com/Files/$Tool"
        }
 
 
        $Destination = "$DestinationFolder\$Tool"
 
        $i++
        Write-Progress -activity "Downloading: $i/$($Tools.count)" -status "$Tool " -PercentComplete (($i / $Tools.count)  * 100)
  
        try{
                Invoke-WebRequest $Source -OutFile $Destination
            }
            catch
            {
                Write-Host "Could not download $Tool"
            }
    }
}
