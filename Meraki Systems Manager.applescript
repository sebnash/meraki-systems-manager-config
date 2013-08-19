try
	do shell script "ps -A | grep -v grep | grep /usr/sbin/m_agent"
on error
	display dialog "Agent process is not active." buttons {"Quit"} default button 1 with title "Meraki Systems Manager"
	return
end try
try
	do shell script "/bin/ls /etc/meraki/ci.conf" with administrator privileges
	set status to "Disabled"
	set action_button to "Enable"
on error
	set status to "Enabled"
	set action_button to "Disable"
end try
set meraki to display dialog "Remote desktop: " & status buttons {action_button, "Quit"} default button 2 with title "Meraki Systems Manager"
set action to button returned of meraki
if action is equal to "Enable" then
	do shell script "rm -f /etc/meraki/ci.conf" with administrator privileges
end if
if action is equal to "Disable" then
	do shell script "curl --create-dirs -o /etc/meraki/ci.conf  http://dl.meraki.net/sm/ci.conf" with administrator privileges
end if
