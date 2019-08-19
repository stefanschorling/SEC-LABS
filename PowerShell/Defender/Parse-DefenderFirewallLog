
Function Parse-DefenderFirewallLog
{
<#
.Synopsis
   Parse Defender Firewall log
.DESCRIPTION
   Parse the log file of windows defender firewall output as object to use filter
.EXAMPLE
   Parse-DefenderFirewallLog
.EXAMPLE
   Parse-DefenderFirewallLog -Path <path to log>
.NOTES
   Mattias Borg
   SEC-LABS R&D
#>   
[CmdletBinding()]
[Alias()]
[OutputType([object])]
Param
(
    # Param1 help description
    [Parameter(Mandatory=$false,
               ValueFromPipelineByPropertyName=$false,
               Position=0)]
    [string]$Path = "$env:systemroot\system32\LogFiles\Firewall\pfirewall.log"

)

if (test-path $path)
{
    try
    {
        $Rows = Get-Content $Path
        foreach($Row in $Rows) 
            {
                if(($Row -like "*Allow*") -or ($Row -like "*Drop*"))
                    {
                        $OutObject = $Row.split(" ")
                        new-object psobject -Property @{
                                    Date = $OutObject[0]
                                    Time = $OutObject[1]
                                    Action = $OutObject[2]
                                    Protocol = $OutObject[3]
                                    SrcIP = $OutObject[4]
                                    DstIP = $OutObject[5]
                                    SrcPort = $OutObject[6]
                                    DstPort = $OutObject[7]
                                    Size = $OutObject[8]
                                    TCPFlags = $OutObject[9]
                                    TCPSyn = $OutObject[10]
                                    TCPack = $OutObject[11]
                                    TCPWin = $OutObject[12]
                                    ICMPType = $OutObject[13]
                                    ICMPCode = $OutObject[14]
                                    Info = $OutObject[15]
                                    Path = $OutObject[16]
                                    }            
                    }
            }
    }
    catch
        {
            Write-Error "Can't read $path.`nDid you elevate?"
        }
}
else
    {
        Write-Error "No such path:`n$path"
    }
}