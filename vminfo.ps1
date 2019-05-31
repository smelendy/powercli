#!/usr/bin/pwsh

Connect-viserver umw-vcenter

Get-VM | Add-Member -Name "IPv4Address" -Value {$this.ExtensionData.Guest.IPAddress} -MemberType ScriptProperty -Passthru -Force | Add-Member -Name "GuestOS" -Value {$this.ExtensionData.Guest.GuestFullName} -MemberType ScriptProperty -Passthru -Force | Add-Member -Name "HostName" -Value {$this.ExtensionData.Guest.HostName} -MemberType ScriptProperty -Passthru -Force |Add-Member -Name "Datastore" -Value {Get-Datastore -VM $this} -MemberType ScriptProperty -Passthru -Force | Add-Member -Name "VMToolsVer" -Value {$this.extensiondata.config.tools.toolsversion} -MemberType ScriptProperty -Passthru -Force | Select IPv4Address,HostName,Name,VMHost,PowerState,VMToolsVer,GuestOS,Vendor,Model,Cpu,numCPU,MemoryGB,UsedSpaceGB,ProvisionedSpaceGB,Datastore,Notes | Export-excel -worksheetname Virutal-Guests  vmware.xlsx  

Get-VMHost |Select-Object Name,Manufacturer,Model,ProcessorType| Export-excel -worksheetname VM-Hosts vmware.xlsx 

Get-Datastore| Select-object Name,Datacenter,CapacityGB,FreeSpaceGB,State,DatastoreBrowserPath,Type,FileSystemVersion |Export-excel -worksheetname Datastores  vmware.xlsx  

Get-Snapshot * | Select Name, VM, SizeGB, Created | Export-excel -worksheetname Snapshots vmware.xlsx 
