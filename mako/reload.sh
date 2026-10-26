#!/usr/bin/env sh

/usr/bin/makoctl reload

/usr/bin/notify-send --app-name="Test notif app" --icon=firefox -t 5000 "Here is some summary" "Needed to create a script because makoctl reload wasn't working"
