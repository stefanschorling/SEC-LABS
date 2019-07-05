Function Get-PwnedUsers{
<#
    .SYNOPSIS
        Get information about email compromise from https://haveibeenpwned.com
    
    .DESCRIPTION
        Get information for a specific email account breach from https://haveibeenpwned.com
        
    
    .EXAMPLE
                PS C:\>Get-PwnedUsers -EmailAddress <emailaddress> 
                PS C:\>get-aduser -Filter * -properties EmailAddress | where {$_.EmailAddress}| get-pwnedusers | Out-GridView 
                PS C:\>Get-Pwnedusers -EmailAddress <emailaddress> | Select Title, BreachDate, Description
    
    .NOTES
Mattias Borg 
        
#>
[CmdletBinding()]
[OutputType([object])]
param (
    [Parameter(Mandatory,ValueFromPipelineByPropertyName=$true,
                   Position=0)]
    [ValidatePattern("(\w+@[]a-zA-Z_]+?\.[a-zA-Z]{2,6})")]
    [string]$EmailAddress
)


Begin
{
    #Set tls version 1.2
    [Net.ServicePointManager]::SecurityProtocol = "tls12"
    $URI = "https://haveibeenpwned.com/api/v2/breachedaccount/"
    
}
Process
{
    try
    {
        
      
        $Request = Invoke-WebRequest -Uri "$($URI)$($EmailAddress)"
        $Response = ConvertFrom-Json $Request 
        New-Object -Type PSObject -Property @{
            Emailaddress = $EmailAddress
			Breached = $true
            Title = $Response.Title
            Name = $Response.Name
            Domain = $Response.Domain
            BreachDate = $Response.BreachDate
            AddedDate  = $Response.AddedDate
            PwnCount = $Response.PwnCount
            DataClasses = $Response.DataClasses
            IsVerified = $Response.IsVerified
            IsSensitive = $Response.IsSensitive
            IsActive = $Response.IsActive
            IsRetired = $Response.IsRetired
            LogoType = $Response.LogoType
      


            }

    

       
        
    }
    catch [exception]
    {
        New-Object -Type PSObject -Property @{
            Emailaddress = $EmailAddress
            Breached = $false
            Title = "N/A"
            Name = "N/A"
            Domain = "N/A"
            BreachDate = "N/A"
            AddedDate  = "N/A"
            PwnCount = "N/A"
            DataClasses = "N/A"
            IsVerified = "N/A"
            IsSensitive = "N/A"
            IsActive = "N/A"
            IsRetired = "N/A"
            LogoType = "N/A"
        }

        
    }
}
End
{
    
}}

