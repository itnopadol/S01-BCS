:start
	del C:\BCS\BCSrobot\result.txt

	tasklist /fi "imagename eq BCSROBOT.exe" >C:\BCS\BCSrobot\result.txt
	find "BCSROBOT.exe" C:\BCS\BCSrobot\result.txt  
	
	if  %errorlevel% neq 0  goto RunApp
	taskkill /F /IM BCSROBOT.exe
	goto RunApp

:RunApp
	start /min C:\BCS\BCSRobot\MultiRobot_Run.bat
	goto endBat

:endBat
	exit
	




