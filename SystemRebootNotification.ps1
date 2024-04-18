<######################################
Author: Alex McAnnally
Created: 9/16/2022
Modified: 4/18/2024
Purpose: Alerts Sys Admins of server reboot, this script is scheduled to run in Windows Task Scheduler.
#######################################>

$Computer = $env:COMPUTERNAME
$Date = Get-Date -Format "dd-MM-yyyy HH:mm:ss"
$os = Get-WmiObject -Class win32_operatingsystem
$Boottime = $os.ConvertToDateTime($os.LastBootUpTime)
$uptime = (get-date) - $os.ConvertToDateTime($os.LastBootUpTime)
$UptimeMin = [math]::Round($Uptime.TotalMinutes)

$FromAddress = "FROM_EMAIL@EMAIL.COM"
$eMailSubject = "***System Reboot Alert*** System:$Computer restarted $UptimeMin minute(s) ago"
$eMailBody = "Computer $Computer has been rebooted recently"
$recipients = ("TO_EMAIL1@EMAIL.COM, TO_EMAIL2@EMAIL.COM, ETC.")
$eMailServer = "YOUR SMPTP SERVER HERE"


if ($uptime.TotalMinutes -lt 30) {


 Send-MailMessage -From $FromAddress `
                        -To $recipients `
                        -Subject $eMailSubject `
                        -Body $eMailBody `
                        -SmtpServer $eMailServer

}