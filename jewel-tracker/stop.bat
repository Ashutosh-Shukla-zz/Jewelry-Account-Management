@echo off

wscript.exe invis.vbs libraries\bin\stopNetworkServer.bat
SET WEBAPP_LOCATION=%cd%\libraries\start\webapp.bat
SET WEBAPP_LOCATION=%WEBAPP_LOCATION:\=\\%
:: Gets the PID of the required process
for /f "delims=" %%a in ('" wmic process where (CommandLine like '%%%WEBAPP_LOCATION%%%') get processid | findstr [0-9]"') do call set "Process_ID=/pid %%a %%Process_ID%%"
:: Kills the task using obtained PID
taskkill %Process_ID%
