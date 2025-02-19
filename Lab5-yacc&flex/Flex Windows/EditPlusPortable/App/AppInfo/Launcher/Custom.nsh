!define REG     `${SET}\EditPlus.reg`
!define DEFREG  `${DEFDATA}\settings\EditPlus.reg`
!define BRANCH  `HKEY_CURRENT_USER\Software\ES-Computing\EditPlus 3\Install`
!define INI     `${SET}\editplus_u.ini`
!define DEFINI  `${DEFDATA}\settings\editplus_u.ini`
!define KEY     `${SET}\reg_u.ini`
!define DEFKEY  `${DEFDATA}\settings\reg_u.ini`
!define SYN     `${DATA}\Syntax`
!define DEFSYN  `${DEFDATA}\Syntax`
!define FONTS   `${DATA}\Fonts`
!define WRITE:1 `• Add personal fonts in here.$\r$\n`
!define WRITE:2 `Compatible: .fon, .fnt, .ttf, .ttc, .fot, .otf, .mmm, .pfb, .pfm.`
!define 86      `EditPlus 3\EditPlus.exe`
!define 64      `EditPlus 3\EditPlus_x64.exe`
!define DOC     `${DATA}\Documents`
!define US      `${APPDIR}\ssceam.tlx`
!define UK      `${APPDIR}\sscebr.tlx`
!define SPELL   `Software\ES-Computing\EditPlus 3\Spell Checker`

Function GetLCID
	!macro _GetLCID _LNG _LCID
		Push ${_LNG}
		Call GetLCID
		Pop ${_LCID}
	!macroend
	!define GetLCID "!insertmacro _GetLCID"
	Exch $0
	StrCmp $0 dword:000003b5 0 +3
	StrCpy $0 1042
		Goto +2
	StrCpy $0 1033
	Exch $0
FunctionEnd
Function GetLNG
	!macro _GetLNG _LCID _LNG
		Push ${_LCID}
		Call GetLNG
		Pop ${_LNG}
	!macroend
	!define GetLNG "!insertmacro _GetLNG"
	Exch $0
	StrCmp $0 1042 0 +3
	StrCpy $0 dword:000003b5
		Goto +2
	StrCpy $0 dword:00000000
	Exch $0
FunctionEnd

${SegmentFile}
${Segment.OnInit}
	Push $0
	${IsWOW64} $0
	StrCmp $0 0 0 IsWOW64
		${WriteSettings} 32 Architecture
		Goto END
	IsWOW64:
	${ReadUserConfig} $0 RunX86Mode
	StrCmp $0 true 0 false
		${WriteSettings} 86 Architecture
		${WriteLauncherConfig} Launch ProgramExecutable64 `${86}`
			Goto END
	false:
		SetRegView 64
		System::Call `${DISABLEREDIR}`
		${WriteSettings} 64 Architecture
		${WriteLauncherConfig} Launch ProgramExecutable64 `${64}`
	END:
	Pop $0
!macroend

!macro OS
	Push $0
	${If} ${IsNT}
		${If} ${IsWinXP}
			${IfNot} ${AtLeastServicePack} 2
				StrCpy $0 `Service Pack 2`
				MessageBox MB_ICONSTOP|MB_TOPMOST `$(MINREQ)`
				Call Unload
				Quit
			${EndIf}
		${ElseIfNot} ${AtLeastWinXP}
			StrCpy $0 `Windows XP`
			MessageBox MB_ICONSTOP|MB_TOPMOST `$(MINREQ)`
			Call Unload
			Quit
		${EndIf}
	${Else}
		StrCpy $0 `Windows XP`
		MessageBox MB_ICONSTOP|MB_TOPMOST `$(MINREQ)`
		Call Unload
		Quit
	${EndIf}
	Pop $0
!macroend

!macro Init
	Push $0
	IfFileExists `${REG}` +2
	CopyFiles /SILENT `${DEFREG}` `${REG}`
	IfFileExists `${INI}` +2
	CopyFiles /SILENT `${DEFINI}` `${INI}`
	IfFileExists `${KEY}` +2
	CopyFiles /SILENT `${DEFKEY}` `${KEY}`
	IfFileExists `${DOC}` +2
	CreateDirectory `${DOC}`
	IfFileExists `${SYN}` +3
	CreateDirectory `${SYN}`
	CopyFiles /SILENT `${DEFSYN}\*.*` `${SYN}`
	IfFileExists `${FONTS}\_.txt` +6
	CreateDirectory `${FONTS}`
	FileOpen $0 `${FONTS}\_.txt` w
	FileWrite $0 `${WRITE:1}`
	FileWrite $0 `${WRITE:2}`
	FileClose $0
	Pop $0
!macroend

!macro Lang
	Push $0
	IfFileExists `${REG}` 0 +3
	ReadINIStr $0 `${REG}` `${BRANCH}` `"Language"`
	Goto +2
	ReadINIStr $0 `${DEFREG}` `${BRANCH}` `"Language"`
	${GetLCID} $0 $0
	${SetEnvironmentVariable} PortableApps.comLocaleID $0
	Pop $0
!macroend

!macro LangInit
	Push $0
	ReadEnvStr $0 PortableApps.comLocaleID
	${GetLNG} $0 $0
	${SetEnvironmentVariable} PAL:LanguageCustom $0
	Pop $0
!macroend

!macro UnRegWrite
	IfFileExists `${US}` 0 +4
	WriteRegDWORD HKCU `${SPELL}` 0 1
	WriteRegDWORD HKCU `${SPELL}` 1 0
	Goto +4
	IfFileExists `${UK}` 0 +3
	WriteRegDWORD HKCU `${SPELL}` 0 0
	WriteRegDWORD HKCU `${SPELL}` 1 1
!macroend

${SegmentPrePrimary}
	Push $0
	${ConfigRead} `${INI}` `Workspace Path=` $0
	StrCmp $0 "" 0 Clear
	${ConfigWrite} `${INI}` `Workspace Path=` `${DATA}` $0
	Clear:
	${Fonts::Import} `${FONTS}`
	Pop $0
!macroend

${SegmentPostPrimary}
	${Fonts::Restore} `${FONTS}`
!macroend