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

(* if none is satisfied, tell the user to write it down *)
if (repoName) = {"Another folder..."} then
	set repoName to the text returned of (display dialog "Where are you going to work today?" default answer "")
end if


(* open iTerm, move to directory and open atom there *)
tell application "iTerm" to activate
delay 0.5
tell application "System Events"
	keystroke "cd " & (repoName) & "; atom . --clear-window-state"
	delay 0.1
	tell application "System Events" to key code 36 #return
end tell

delay 2.3

tell application "System Events"
	set userName to name of current user
end tell


(* Next line must be edited with username and computer name *)
set selectedWindow1 to (userName) & "@" & (computerName) & ": ~/" & (repoName)
set selectedWindow2 to "untitled — ~/" & (repoName)


tell application "Mission Control"
	launch
end tell

(*
The dock has a set of nested UI elements for Mission Control, with the following structure:
    "Mission Control"'s group 1 (the base container)
        group 1, group 2, .... (groups for each desktop)
            buttons for open windows on each desktop
        group "Spaces Bar"
            a single button (the '+' buttan to add a new space)
            a list
                buttons for the desktops and any already-made spaces
*)

tell application "System Events"
	tell process "Dock"'s group "Mission Control"'s group 1
		tell group "Spaces Bar"'s list 1
			set {p, s} to {position, size} of last UI element
			set XTarget to (item 1 of p) + (item 1 of s) + 100
			set YTarget to (item 2 of p) + (item 2 of s) + 100
		end tell
		tell group 1
			set viewButton1 to button selectedWindow1
			set {x, y} to get viewButton1's position
			my mouseDrag(x, y, XTarget, YTarget, 0.5)
		end tell
		tell group "Spaces Bar"'s list 1
			set {p, s} to {position, size} of last UI element
			set XTarget to (item 1 of p) + (item 1 of s) + 10
			set YTarget to (item 2 of p) + (item 2 of s) + 10
		end tell
		try
			tell group 1
				set viewButton2 to button selectedWindow2
				set {x, y} to get viewButton2's position
				my mouseDrag(x, y, XTarget, YTarget, 0.5)
			end tell
		end try
		tell group "Spaces Bar"'s list 1
			delay 0.5
			set lastUI to last UI element
			click lastUI
		end tell
	end tell
end tell
on mouseDrag(xDown, yDown, xUp, yUp, delayTime)
	do shell script "

/usr/bin/python <<END

from Quartz.CoreGraphics import CGEventCreateMouseEvent
from Quartz.CoreGraphics import CGEventCreate
from Quartz.CoreGraphics import CGEventPost
from Quartz.CoreGraphics import kCGEventLeftMouseDown
from Quartz.CoreGraphics import kCGEventLeftMouseUp
from Quartz.CoreGraphics import kCGMouseButtonLeft
from Quartz.CoreGraphics import kCGHIDEventTap
from Quartz.CoreGraphics import kCGEventLeftMouseDragged
from Quartz.CoreGraphics import kCGEventMouseMoved
import time

def mouseEvent(type, posx, posy):
          theEvent = CGEventCreateMouseEvent(None, type, (posx,posy), kCGMouseButtonLeft)
          CGEventPost(kCGHIDEventTap, theEvent)

def mousemove(posx,posy):
          mouseEvent(kCGEventMouseMoved, posx,posy);

def mousedrag(posx,posy):
          mouseEvent(kCGEventLeftMouseDragged, posx, posy);

def mousedown(posxdown,posydown):
          mouseEvent(kCGEventLeftMouseDown, posxdown,posydown);

def mouseup(posxup,posyup):
      mouseEvent(kCGEventLeftMouseUp, posxup,posyup);

ourEvent = CGEventCreate(None);

mousemove(" & xDown & "," & yDown & ");
mousedown(" & xDown & "," & yDown & ");
time.sleep(" & (delayTime as text) & ");
mousedrag(" & xUp & "," & yUp & ");
time.sleep(" & (delayTime as text) & ");
mouseup(" & xUp & "," & yUp & ");

END"
end mouseDrag
