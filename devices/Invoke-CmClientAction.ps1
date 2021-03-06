#requires -Version 3.0
<#
.SYNOPSIS
    The "Start-CMClientAction" function allows 49 different SCCM client actions to be initiated on one, or more computers.   

.DESCRIPTION
    The "Start-CMClientAction" PowerShell function allows for the initiaion of 49 SCCM client actions that can be ran on the local computer, or remote computers. Only one client action can be ran at a time, so using an array to include several client actions is not allowed. The Configuration Manager applet in Control Panel on the Actions tab lists 10 actions and these are identified in the Notes section with a "ConfigMgr Control Panel Applet" in parenthesis. SCCM Administrators typically find themselves running the following 3 actions during their monthly software update deployments (patching): Machine Policy Retrieval & Evaluation Cycle, Software Updates Scan Cycle, and Software Updates Deployment Evaluation Cycle. Because these 3 actions are so common, I decided to offer a way to bundle them with a 5 minute wait time (300 seconds) between each action. The parameter to use to run these 3 bundled actions is the '-SCCMActionsBundle' parameter. The 'SCCMClientAction' and the 'SCCMActionsBundle' parameters are members of different parameter sets, so they cannot be used together.  

.PARAMETER ComputerName
    Enter the name of one or more computers that you wish to initiate an SCCM client action on. 

.PARAMETER SCCMClientAction
    Enter a numerical value from 1-49 that represents each SCCM client action listed in the Notes section under ther "SCCM Client Action Trigger Codes" heading. 

.PARAMETER SCCMActionsBundle
    A switch parameter that does not accept any values, but rather tells the function to run the following 3 actions listed in the Notes section under ther "SCCM Client Action Trigger Codes" heading: 

    * Option 7 - Request Machine Assignments - (ConfigMgr Control Panel Applet - Machine Policy Retrieval & Evaluation Cycle) 
    * Option 38 - Scan by Update Source - (ConfigMgr Control Panel Applet - Software Updates Scan Cycle) 
    * Option 33 - Software Updates Assignments Evaluation Cycle - (ConfigMgr Control Panel Applet - Software Updates Deployment Evaluation Cycle)  

.EXAMPLE 
    Initiate an SCCM Client Action on the Local Computer  
    Start-CMClientAction -SCCMClientAction 1 

.EXAMPLE 
    Initiate an SCCM Client Action on a Remote Computer 
    Start-CMClientAction -ComputerName 'RemoteComputer1' -SCCMClientAction 1 

.EXAMPLE 
    Initiate an SCCM Client Action on Multiple Remote Computers 
    Start-CMClientAction -ComputerName 'RemoteComputer1', 'RemoteComputer2', 'RemoteComputer3' -SCCMClientAction 1 

.EXAMPLE 
    Initiate an SCCM Client Action on Multiple Remote Computers Using a List of Computers in a Text File 
    Start-CMClientAction -ComputerName (Get-Content -Path "$env:userprofile\desktop\RemoteComputerList.txt") -SCCMClientAction 1 

.EXAMPLE 
    Initiate an SCCM Client Action Bundle on the Local Computer that Runs Options 7, 38, and 33 (Machine Policy Retrievale & Evaluation Cycle, Software Updates Scan Cycle, and Software Updates Deployment Evaluation Cycle) 
    Start-CMClientAction -SCCMActionsBundle 

.EXAMPLE 
    Initiate an SCCM Client Action Bundle on a Remote Computer that Runs Options 7, 38, and 33 (Machine Policy Retrievale & Evaluation Cycle, Software Updates Scan Cycle, and Software Updates Deployment Evaluation Cycle) 
    Start-CMClientAction -ComputerName 'RemoteComputer1' -SCCMActionsBundle 

.EXAMPLE 
    Initiate an SCCM Client Action Bundle on Multiple Remote Computers that Runs Options 7, 38, and 33 (Machine Policy Retrievale & Evaluation Cycle, Software Updates Scan Cycle, and Software Updates Deployment Evaluation Cycle) 
    Start-CMClientAction -ComputerName 'RemoteComputer1', 'RemoteComputer2', 'RemoteComputer3' -SCCMActionsBundle 

.EXAMPLE 
    Initiate an SCCM Client Action Bundle on Multiple Remote Computers Using a List of Computers in a Text File that Runs Options 7, 38, and 33 (Machine Policy Retrievale & Evaluation Cycle, Software Updates Scan Cycle, and Software Updates Deployment Evaluation Cycle) 
    Start-CMClientAction -ComputerName (Get-Content -Path "$env:userprofile\desktop\RemoteComputerList.txt") -SCCMActionsBundle 

.NOTES 
    Based on The SavvyTech scirpt from 4/19/2016, updated 5/23/2017
    Please refer to the TechNet Gallery at: https://gallery.technet.microsoft.com/Start-SCCM-Client-Actions-d3d84c3c 
    
    SCCM Client Action Trigger Codes 
      -------------------------------- 

       1 - {000000000001} Hardware Inventory - (ConfigMgr Control Panel Applet - Hardware Inventory Cycle) 
       2 - {000000000002} Software Inventory - (ConfigMgr Control Panel Applet - Software Inventory Cycle) 
       3 - {000000000003} Discovery Inventory - (ConfigMgr Control Panel Applet - Discovery Data Collection Cycle) 
       4 - {000000000010} File Collection - (ConfigMgr Control Panel Applet - File Collection Cycle) 
       5 - {0000-0000-0000-000000000011} IDMIF Collection  
       6 - {0000-0000-0000-000000000012} Client Machine Authentication  
       7 - {0000-0000-0000-000000000021} Request Machine Assignments - (ConfigMgr Control Panel Applet - Machine Policy Retrieval & Evaluation Cycle)  
       8 - {0000-0000-0000-000000000022} Evaluate Machine Policies  
       9 - {0000-0000-0000-000000000023} Refresh Default MP Task  
      10 - {0000-0000-0000-000000000024} LS (Location Service) Refresh Locations Task  
      11 - {0000-0000-0000-000000000025} LS (Location Service) Timeout Refresh Task  
      12 - {0000-0000-0000-000000000026} Policy Agent Request Assignment (User)  
      13 - {0000-0000-0000-000000000027} Policy Agent Evaluate Assignment (User) - (ConfigMgr Control Panel Applet - User Policy Retrieval & Evaluation Cycle) 
      14 - {0000-0000-0000-000000000031} Software Metering Generating Usage Report  
      15 - {0000-0000-0000-000000000032} Source Update Message - (ConfigMgr Control Panel Applet - Windows Installer Source List Update Cycle) 
      16 - {0000-0000-0000-000000000037} Clearing Proxy Settings Cache  
      17 - {0000-0000-0000-000000000040} Machine Policy Agent Cleanup  
      18 - {0000-0000-0000-000000000041} User Policy Agent Cleanup 
      19 - {0000-0000-0000-000000000042} Policy Agent Validate Machine Policy/Assignment  
      20 - {0000-0000-0000-000000000043} Policy Agent Validate User Policy/Assignment  
      21 - {0000-0000-0000-000000000051} Retrying/Refreshing Certificates in AD on MP  
      22 - {0000-0000-0000-000000000061} Peer DP Status Reporting  
      23 - {0000-0000-0000-000000000062} Peer DP Pending Package Check Schedule  
      24 - {0000-0000-0000-000000000063} SUM Updates Install Schedule  
      25 - {0000-0000-0000-000000000071} NAP action  
      26 - {0000-0000-0000-000000000101} Hardware Inventory Collection Cycle  
      27-  {0000-0000-0000-000000000102} Software Inventory Collection Cycle  
      28 - {0000-0000-0000-000000000103} Discovery Data Collection Cycle  
      29 - {0000-0000-0000-000000000104} File Collection Cycle  
      30 - {0000-0000-0000-000000000105} IDMIF Collection Cycle  
      31 - {0000-0000-0000-000000000106} Software Metering Usage Report Cycle  
      32 - {0000-0000-0000-000000000107} Windows Installer Source List Update Cycle  
      33 - {0000-0000-0000-000000000108} Software Updates Assignments Evaluation Cycle - (ConfigMgr Control Panel Applet - Software Updates Deployment Evaluation Cycle)  
      34 - {0000-0000-0000-000000000109} Branch Distribution Point Maintenance Task  
      35 - {0000-0000-0000-000000000110} DCM Policy  
      36 - {0000-0000-0000-000000000111} Send Unsent State Message  
      37 - {0000-0000-0000-000000000112} State System Policy Cache Cleanout  
      38 - {0000-0000-0000-000000000113} Scan by Update Source - (ConfigMgr Control Panel Applet - Software Updates Scan Cycle) 
      39 - {0000-0000-0000-000000000114} Update Store Policy  
      40 - {0000-0000-0000-000000000115} State System Policy Bulk Send High 
      41 - {0000-0000-0000-000000000116} State System Policy Bulk Send Low  
      42 - {0000-0000-0000-000000000120} AMT Status Check Policy  
      43 - {0000-0000-0000-000000000121} Application Manager Policy Action - (ConfigMgr Control Panel Applet - Application Deployment Evaluation Cycle) 
      44 - {0000-0000-0000-000000000122} Application Manager User Policy Action 
      45 - {0000-0000-0000-000000000123} Application Manager Global Evaluation Action  
      46 - {0000-0000-0000-000000000131} Power Management Start Summarizer 
      47 - {0000-0000-0000-000000000221} Endpoint Deployment Reevaluate  
      48 - {0000-0000-0000-000000000222} Endpoint AM Policy Reevaluate  
      49 - {0000-0000-0000-000000000223} External Event Detection 
#> 
     
[CmdletBinding()] 
param ( 
    [parameter(ValueFromPipeline=$True, ValueFromPipelineByPropertyName=$True, HelpMessage='Enter the name of either one or more computers')] 
        [Alias('CN')]    
        $ComputerName = $env:COMPUTERNAME,  

    [parameter(ParameterSetName = 'Set 1', HelpMessage='Enter the SCCM client action numerical value')] 
        [ValidateNotNullOrEmpty()] 
        [ValidateRange(1,49)] 
        [Alias('SCA')]    
        [Int] $SCCMClientAction, 

    [parameter(ParameterSetName = 'Set 2', HelpMessage='Use this switch parameter to run the following 3 SCCM client actions: Machine Policy Retrieval & Evaluation Cycle, Software Updates Scan Cycle, and Software Updates Deployment Evaluation Cycle')] 
        [Alias('SAB')]    
        [Switch] $SCCMActionsBundle 
) 

Begin { 
    $NewLine = "`r`n" 

    If ($ComputerName -eq $env:COMPUTERNAME) {    
        $ComputerVar = $ComputerName.ToUpper() 
    }
    Else { 
        Write-Verbose "=======================================================" 
        Write-Verbose "            Check Computer(s) Online Status            " 
        Write-Verbose "=======================================================" 

        $ComputerOnlineStatus = Foreach ($Computer in $ComputerName) { 
            $Online  = @(ForEach-Object -Process { If (Test-Connection -ComputerName $Computer -Count '1' -Quiet) { $Computer } }) 
            $Offline = @(ForEach-Object -Process { If (!(Test-Connection -ComputerName $Computer -Count '1' -Quiet)) { $Computer } }) 
            [pscustomobject] @{ 
                'Online' = $Online; 
                'Offline' = $Offline 
            }
        }
        $ComputerVar = ($ComputerOnlineStatus.Online).ToUpper()
        
        Write-Verbose "---------- Computer(s) Online ----------" 
        If ($ComputerOnlineStatus.Online) { 
            ($ComputerOnlineStatus.Online).ToUpper() 
        } 
        Else { 
            Write-Verbose 'N/A' 
        } 

        Write-Verbose "---------- Computer(s) Offline ----------" 
 
        If ($ComputerOnlineStatus.Offline) {
            ($ComputerOnlineStatus.Offline).ToUpper() 
        }   
        Else { 
            Write-Verbose 'N/A' 
        }   
    } 
} 

Process { 
    Switch ($SCCMClientAction) { 
         '1' { $ClientAction = '{00000000-0000-0000-0000-000000000001}' } 
         '2' { $ClientAction = '{00000000-0000-0000-0000-000000000002}' } 
         '3' { $ClientAction = '{00000000-0000-0000-0000-000000000003}' } 
         '4' { $ClientAction = '{00000000-0000-0000-0000-000000000010}' } 
         '5' { $ClientAction = '{00000000-0000-0000-0000-000000000011}' } 
         '6' { $ClientAction = '{00000000-0000-0000-0000-000000000012}' } 
         '7' { $ClientAction = '{00000000-0000-0000-0000-000000000021}' } 
         '8' { $ClientAction = '{00000000-0000-0000-0000-000000000022}' } 
         '9' { $ClientAction = '{00000000-0000-0000-0000-000000000023}' } 
        '10' { $ClientAction = '{00000000-0000-0000-0000-000000000024}' } 
        '11' { $ClientAction = '{00000000-0000-0000-0000-000000000025}' } 
        '12' { $ClientAction = '{00000000-0000-0000-0000-000000000026}' } 
        '13' { $ClientAction = '{00000000-0000-0000-0000-000000000027}' } 
        '14' { $ClientAction = '{00000000-0000-0000-0000-000000000031}' } 
        '15' { $ClientAction = '{00000000-0000-0000-0000-000000000032}' } 
        '16' { $ClientAction = '{00000000-0000-0000-0000-000000000037}' } 
        '17' { $ClientAction = '{00000000-0000-0000-0000-000000000040}' } 
        '18' { $ClientAction = '{00000000-0000-0000-0000-000000000041}' } 
        '19' { $ClientAction = '{00000000-0000-0000-0000-000000000042}' } 
        '20' { $ClientAction = '{00000000-0000-0000-0000-000000000043}' } 
        '21' { $ClientAction = '{00000000-0000-0000-0000-000000000051}' } 
        '22' { $ClientAction = '{00000000-0000-0000-0000-000000000061}' } 
        '23' { $ClientAction = '{00000000-0000-0000-0000-000000000062}' } 
        '24' { $ClientAction = '{00000000-0000-0000-0000-000000000063}' } 
        '25' { $ClientAction = '{00000000-0000-0000-0000-000000000071}' } 
        '26' { $ClientAction = '{00000000-0000-0000-0000-000000000101}' } 
        '27' { $ClientAction = '{00000000-0000-0000-0000-000000000102}' } 
        '28' { $ClientAction = '{00000000-0000-0000-0000-000000000103}' } 
        '29' { $ClientAction = '{00000000-0000-0000-0000-000000000104}' } 
        '30' { $ClientAction = '{00000000-0000-0000-0000-000000000105}' } 
        '31' { $ClientAction = '{00000000-0000-0000-0000-000000000106}' } 
        '32' { $ClientAction = '{00000000-0000-0000-0000-000000000107}' } 
        '33' { $ClientAction = '{00000000-0000-0000-0000-000000000108}' } 
        '34' { $ClientAction = '{00000000-0000-0000-0000-000000000109}' } 
        '35' { $ClientAction = '{00000000-0000-0000-0000-000000000110}' } 
        '36' { $ClientAction = '{00000000-0000-0000-0000-000000000111}' } 
        '37' { $ClientAction = '{00000000-0000-0000-0000-000000000112}' } 
        '38' { $ClientAction = '{00000000-0000-0000-0000-000000000113}' } 
        '39' { $ClientAction = '{00000000-0000-0000-0000-000000000114}' } 
        '40' { $ClientAction = '{00000000-0000-0000-0000-000000000115}' } 
        '41' { $ClientAction = '{00000000-0000-0000-0000-000000000116}' } 
        '42' { $ClientAction = '{00000000-0000-0000-0000-000000000120}' } 
        '43' { $ClientAction = '{00000000-0000-0000-0000-000000000121}' } 
        '44' { $ClientAction = '{00000000-0000-0000-0000-000000000122}' } 
        '45' { $ClientAction = '{00000000-0000-0000-0000-000000000123}' } 
        '46' { $ClientAction = '{00000000-0000-0000-0000-000000000131}' } 
        '47' { $ClientAction = '{00000000-0000-0000-0000-000000000221}' } 
        '48' { $ClientAction = '{00000000-0000-0000-0000-000000000222}' } 
        '49' { $ClientAction = '{00000000-0000-0000-0000-000000000223}' }  
    } 

    If (!($PSBoundParameters.Keys.Contains('SCCMActionsBundle'))) { 
        Foreach ($Computer in $ComputerVar) { 
           Try {          
                Invoke-WmiMethod -ComputerName $Computer -Namespace root\ccm -Class sms_client -Name TriggerSchedule -ArgumentList $ClientAction -ErrorAction Stop 
                Write-Verbose "The specified SCCM client action was successfully initiated on computer $Computer" 
            } 
            Catch { 
                Write-Warning -Message "The following error occurred when trying to run the specified SCCM client action on computer ${Computer}: $_" 
            }    
        } 
    } 

    Else { 
        Foreach ($Computer in $ComputerVar) { 
            Write-Verbose '---------- Running SCCM Client Actions Bundle ----------' 
            Try {          
                Write-Verbose 'Machine Policy Retrieval & Evaluation Cycle' 
                Invoke-WmiMethod -ComputerName $Computer -Namespace root\ccm -Class sms_client -Name TriggerSchedule -ArgumentList '{00000000-0000-0000-0000-000000000021}' -ErrorAction Stop 
                Write-Verbose 'Machine Policy Retrieval and Evaluation Cycle action successfully initiated' 
                Write-Verbose 'Waiting 5 minutes before running next SCCM client action...' 
                Start-Sleep -Seconds 300 
            } 
            Catch { 
                Write-Warning -Message "The following error occurred when trying to run the specified SCCM client action on computer ${Computer}: $_" 
                Break 
            }  
            Try {          
                Write-Verbose 'Software Updates Scan Cycle' 
                Invoke-WmiMethod -ComputerName $Computer -Namespace root\ccm -Class sms_client -Name TriggerSchedule -ArgumentList '{00000000-0000-0000-0000-000000000113}' -ErrorAction Stop 
                Write-Verbose 'Software Updates Scan Cycle action successfully initiated' 
                Write-Verbose 'Waiting 5 minutes before running next SCCM client action...' 
                Start-Sleep -Seconds 300 
            } 
            Catch { 
                Write-Warning -Message "The following error occurred when trying to run the specified SCCM client action on computer ${Computer}: $_" 
                Break 
            }  

            Try {
                Write-Verbose 'Software Updates Deployment Evaluation Cycle' 
                Invoke-WmiMethod -ComputerName $Computer -Namespace root\ccm -Class sms_client -Name TriggerSchedule -ArgumentList '{00000000-0000-0000-0000-000000000108}' -ErrorAction Stop 
                Write-Verbose 'Software Updates Deployment Evaluation Cycle action successfully initiated' 
                Write-Verbose 'Waiting 5 minutes before running next SCCM client action...' 
                Start-Sleep -Seconds 300 
            } 
            Catch { 
                Write-Warning -Message "The following error occurred when trying to run the specified SCCM client action on computer ${Computer}: $_" 
                Break 
            }  
        } 
    } 
} 
End {}
