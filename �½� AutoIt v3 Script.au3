#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------


#include <GUIConstantsEx.au3>
#include <Process.au3>

Global $filePath = "./browers.txt"
;浏览器个数
Global $COUNT = 30

main()

Func main()
	Local $GUIWidth = 320, $GUIHeight = 60
	Global $ParentWin, $browers[$COUNT]
	$ParentWin = GUICreate("dyt测试辅助工具", $GUIWidth, $GUIHeight)
	$file = GUICtrlCreateInput("", 10, 5, 300, 20)
	$btn = GUICtrlCreateButton("Ok", 10, 35, 60, 20)
	
	GUISetState()
	While 1
        $msg = GUIGetMsg()
		Select
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
			Case $msg = $btn
				$browers = readBrowersOf($filePath)
				ext($browers, GUICtrlRead($file))
		EndSelect
    WEnd
    GUIDelete()
EndFunc

;运行读取到的程序
Func ext($where, $url)
	WinMinimizeAll ( )
	FOR $item IN $where
		Dim $path = String($item)
		If IsString($path) And StringLen($path) > 0 Then
			If FileExists($path) Then
				Local $pro = ShellExecute($path, $url)
			EndIf
		EndIf
	NEXT
EndFunc


;读取浏览器的地址
Func readBrowersOf($where)
	$file = FileOpen($where)
	Dim $rs_count = 0
	Dim $results[$COUNT]
	While 1
		$line = FileReadLine($file)
		If @error = -1 Then ExitLoop
		If StringLen($line)  Then
			$results[$rs_count] = $line
			$rs_count = $rs_count + 1
			
		EndIf
	Wend
	FileClose($file)
	
	Return $results
EndFunc
	
