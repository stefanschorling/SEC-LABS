Function Test-WDURLS
{
$urls = ((iwr "https://raw.githubusercontent.com/stefanschorling/SEC-LABS/master/PowerShell/Defender/Connectitivy/urls.txt").content).split("`n")

foreach ($url in $urls)
{

	if ($url -like "http*")
		{	
			if ($url -like "*pki*")
			{
				$resp = iwr "https://www.microsoft.com/pkiops/docs/repository.htm"
				$pkiUrls =  $resp.links.href
				foreach ($pkiUrl in $pkiUrls)
					{
						if ($pkiUrl -like "*$url*")
						{
							$pkiresponse = iwr $pkiUrl
							if ($pkiresponse.statuscode -eq "200")
							{
								$testresult = "Success"
								break
							}
							else{$testresult = "false"}
						}   
					}
			
			}
			else{
			$response = iwr $url
			if ($response.statuscode -eq "200")
				{
					
					$testresult = "Success"

				}
				else{$testresult = "false"}
				}
		}
		else
			{
			
				
				$result = test-netconnection -computername $url -port 443
			
				if ($result.TcpTestSucceeded)
					{
					
						$testresult = "Success"
					
					}
					else{$testresult = "false"}
			}
		
	New-Object PSObject -Property @{
						 URL = $url
						 Success = $testresult
						 
						 }	
	
	

}
}