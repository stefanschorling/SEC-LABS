function Get-WPAkey
{
<#
.Synopsis Get-WPAKey is a function to extract the WPA key for a specific SSID
.DESCRIPTION Get the WPA key in clear text
.EXAMPLE Get-WPAkey -SSID "MySSID"
.EXAMPLE Get-WPAkey
.NOTES Created by Mattias Borg 2015
 www.sec-labs.com
#>
param([Parameter(Mandatory=$false,
ValueFromPipelineByPropertyName=$false,
Position=0)]
$SSID = (netsh wlan show profiles | Select-String "All User Profile"))
foreach ($profile in $SSID)
    {
            try{
                $SSID = ($profile.ToString().Split(":")[1]).trim()
               }catch{}
        try
        {
            $Data = netsh wlan show profiles name="$SSID" key=clear | select-String Authentication, Cipher, "Key Content"
            $Data = $Data -split ":"
            [string]$Authentication = $Data[1]
            [string]$Cipher = $Data[3]
            [string]$Key = $Data[9]
        }
            catch
            {
            }
        New-Object -Type PSObject -Property @{
        Authentication = $Authentication.trim()
        SSIDName = $SSID
        Cipher = $Cipher.trim()
        Key = $Key.trim()
        }
    }
}
