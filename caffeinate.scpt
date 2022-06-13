set chosenTime to null
set timeChoices to {"10 Minutes", "30 Minutes", "1 Hour", "2 Hours", "3 Hours", "5 Hours", "10 Hours", "24 Hours"}

try
	set caffeinateId to do shell script "pgrep caffeinate"
on error
	set caffeinateId to null
end try

if (caffeinateId is not equal to null) then
	do shell script "killall caffeinate"
end if

set DIALOG to (display dialog ¬
	"Would you like to start Caffeinate?" & return with title ¬
	"Caffeinate" buttons {"Yes", "Cancel", "Custom Time"} ¬
	default button 1)

set buttonAnswerInitial to button returned of DIALOG

if buttonAnswerInitial is equal to "Custom Time" then ¬
	set chosenTime to (choose from list timeChoices with title ¬
		"Caffeinate" with prompt ¬
		"Select how long to run Caffeinate for:" default items ¬
		"1 Hour" OK button name ¬
		{"Start"})

if (buttonAnswerInitial is equal to "Yes") then
	do shell script "caffeinate -usid > /dev/null 2>&1 &"
else if (chosenTime) then
	set chosenTimeToSeconds to null
	display dialog "fhjdksa:"
	if (chosenTime is equal to {"10 Minutes"}) then
		set chosenTimeToSeconds to "600"
	else if (chosenTime is equal to {"30 Minutes"}) then
		set chosenTimeToSeconds to "1800"
	else if (chosenTime is equal to {"1 Hour"}) then
		set chosenTimeToSeconds to "3600"
	else if (chosenTime is equal to {"2 Hours"}) then
		set chosenTimeToSeconds to "7200"
	else if (chosenTime is equal to {"3 Hours"}) then
		set chosenTimeToSeconds to "10800"
	else if (chosenTime is equal to {"5 Hours"}) then
		set chosenTimeToSeconds to "18000"
	else if (chosenTime is equal to {"10 Hours"}) then
		set chosenTimeToSeconds to "36000"
	else if (chosenTime is equal to {"24 Hours"}) then
		set chosenTimeToSeconds to "86400"
	end if
	if (chosenTimeToSeconds is not equal to null) then
		do shell script "caffeinate -usidt" & chosenTimeToSeconds & " > /dev/null 2>&1 &"
	end if
else
	return
end if

do shell script "pgrep caffeinate"

set stopWorking to (display dialog ¬
	"Stop Caffeinate?" with title ¬
	"Caffeinate" buttons {"Stop"} ¬
	default button 1)

set stopWorkingResponse to button returned of stopWorking

if stopWorkingResponse is equal to "Stop" then do shell script "killall caffeinate"
