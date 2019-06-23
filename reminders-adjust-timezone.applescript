#!/usr/bin/osascript

# I use this when I change the time-zones.

tell application "Reminders"
    repeat with eachReminder in reminders in list "Planned"
        tell eachReminder
            set due date to (due date as date + 10 * hours)
        end tell
    end repeat
end tell
