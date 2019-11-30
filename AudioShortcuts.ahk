
#Include, %A_ScriptDir%
#Include, va.ahk


#Persistent	;this keeps the script running if no hotkeys are set (though one is)

SetWorkingDir %A_ScriptDir%
;Set the IsHeadset to the correct value the first time the script starts
;This can be put before IsHeadset is IsHeadsetd, if you change the device yourself regularly
; curDeviceName := VA_GetDeviceName(VA_GetDevice("playback"))
; IsHeadset := curDeviceName != "Speakers"
; VA_SetDefaultEndpoint("playback:" 1, 0)
VA_SetDefaultEndpoint("Headset", 0)
IsHeadset := 1
;SETS THE TRAY ICON, ADDS AN OPTION TO RUN THE SCRIPT FROM THE TRAY
Menu, Tray, Icon, %A_ScriptDir%/headphones.png,,1								;default is speaker icon
Menu, Tray, NoStandard										;?
Menu, Tray, Add, &Switch Playback Device, !Pause				;add tray option
Menu, Tray, Add, Audio Devices, OpenAudioDevices
; Menu, Tray, Add, &Volume Up (Ctrl+Alt+Page Up), ^!PgUp		;add tray option
; Menu, Tray, Add, &Volume Down (Ctrl+Alt+Page Down), ^!PgDn	;add tray option
Menu, Tray, Add, 											;add blank line
Menu, Tray, Standard										;?
Menu, Tray, Default, Audio Devices				;default option is new option
Return

OpenAudioDevices:
  Run, mmsys.cpl
return


;IsHeadset HEADPHONES AND SPEAKERS
;see http://www.autohotkey.net/~Lexikos/docs/VA.html#VA_GetDevice for playback names
;see sound menu -> playback tab for names
;or use VA_SetDefaultEndpoint("playback:" (IsHeadset ? 4 : 2), 0) (number 4 and 2 are speakers and headset on my pc)
;or give devices a pretty name

!Pause::   ;IsHeadsets headphones / speakers 

if (IsHeadset) {
  VA_SetDefaultEndpoint("Speakers", 0)
  Menu, Tray, Icon, %A_ScriptDir%/speaker.png,,1
}
else {
  VA_SetDefaultEndpoint("Headset", 0)
  Menu, Tray, Icon, %A_ScriptDir%/headphones.png,,1
}
IsHeadset := !IsHeadset
return
