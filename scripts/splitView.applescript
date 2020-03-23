(* get current user and computer name that will be displayed in the title of iTerm *)
tell application "System Events"
	set userName to name of current user
end tell
set computerName to computer name of (system info)


(* get list of possible repos to work on *)
set locals to {"GitHub", "GitLab", "ownCloud/Coding"}

set myList to {}
repeat with mylocal in locals
	tell application "Finder"
		set localFolders to name of folders of folder ("/Users/" & (userName) & "/" & (mylocal) as POSIX file)
		repeat with i from 1 to count of localFolders
			set repo to (mylocal) & "/" & item (i) of localFolders
			copy repo to end of myList
		end repeat
	end tell
end repeat

copy "Another folder..." to end of myList

set repoName to choose from list myList with prompt "Where are you going to work today?"

if (repoName) is not false then
	(* if none is satisfied, tell the user to write it down *)
	if (repoName) = {"Another folder..."} then
		set repoName to the text returned of (display dialog "Where are you going to work today?" default answer "")
	end if
	
	
	(* open VScode in specific `repoName` *)
	do shell script "/usr/local/bin/code " & "/Users/wvieira/" & (repoName)
	delay 0.6
	(* set CScode to full screen mode by `command +F` *)
	tell application "Visual Studio Code" to activate
	tell application "System Events"
		keystroke "f" using {command down, control down}
	end tell
end if