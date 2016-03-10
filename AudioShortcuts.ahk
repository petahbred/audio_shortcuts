#include VA.ahk	;VA.ahk has to be in the same folder as this script
#Persistent	;this keeps the script running if no hotkeys are set (though one is)

;Set the Toggle to the correct value the first time the script starts
;This can be put before Toggle is toggeled, if you change the device yourself regularly
curDeviceName := VA_GetDeviceName(VA_GetDevice("playback"))
firstDeviceName := VA_GetDeviceName(VA_GetDevice("Speakers"))
Toggle := curDeviceName != firstDeviceName

;SETS THE TRAY ICON, ADDS AN OPTION TO RUN THE SCRIPT FROM THE TRAY
Menu, Tray, Icon, speak.ico,,1								;default is speaker icon
Menu, Tray, NoStandard										;?
Menu, Tray, Add, &Switch Playback Device, ^!F11				;add tray option
Menu, Tray, Add, &Volume Up (Ctrl+Alt+Page Up), ^!PgUp		;add tray option
Menu, Tray, Add, &Volume Down (Ctrl+Alt+Page Down), ^!PgDn	;add tray option
Menu, Tray, Add, 											;add blank line
Menu, Tray, Standard										;?
Menu, Tray, Default, &Switch Playback Device				;default option is new option
Return

;TOGGLE HEADPHONES AND SPEAKERS
;see http://www.autohotkey.net/~Lexikos/docs/VA.html#VA_GetDevice for playback names
;see sound menu -> playback tab for names
;or use VA_SetDefaultEndpoint("playback:" (Toggle ? 4 : 2), 0) (number 4 and 2 are speakers and headset on my pc)
;or give devices a pretty name

^!F11::   ;Ctrl+Alt+F11 toggles headphones / speakers
Toggle := !Toggle

if (Toggle) {
VA_SetDefaultEndpoint("Realtek HD Audio 2nd output", 0)
Menu, Tray, Icon, head.ico,,1
}
else {
VA_SetDefaultEndpoint("Speakers", 0)
Menu, Tray, Icon, speak.ico,,1
}
return

;change the volume
^!PgUp::Send {Volume_Up 3}
^!PgDn::Send {Volume_Down 3}