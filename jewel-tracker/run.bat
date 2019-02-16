@echo off
:: Call to vbscript for starting batch in background
wscript.exe invis.vbs libraries\bin\startNetworkServer.bat
wscript.exe invis.vbs libraries\start\webapp.bat
:: Wait till the embedded server starts
:: Default is 5000ms = 5seconds
echo.
echo [execute] Initializing Container Services
ping 192.0.2.2 -n 1 -w 1000 > nul
echo|set /p=[execute] .
FOR %%A IN (. .) DO echo|set /p=%%A
echo .
ping 192.0.2.2 -n 1 -w 1000 > nul
echo [execute] Starting application... 8s
ping 192.0.2.2 -n 1 -w 1000 > nul
echo|set /p=[execute] .
FOR %%A IN (. . . . . . . . . . . . . .) DO echo|set /p=%%A
echo .
ping 192.0.2.2 -n 1 -w 1000 > nul
echo [execute] Starting Backend Processes
ping 192.0.2.2 -n 1 -w 1000 > nul
echo|set /p=[execute] .
FOR %%A IN (. . . . . . . . .) DO echo|set /p=%%A
echo .
ping 192.0.2.2 -n 1 -w 1000 > nul
echo [execute] Initializing Browser Engine... 4s
ping 192.0.2.2 -n 1 -w 1000 > nul
echo|set /p=[execute] .
FOR %%A IN (. . .) DO echo|set /p=%%A
echo .
ping 192.0.2.2 -n 1 -w 1000 > nul
echo [execute] Application Started
ping 192.0.2.2 -n 1 -w 1000 > nul
echo|set /p=[execute] .
FOR %%A IN (. . . . . . . .) DO echo|set /p=%%A
echo .
ping 192.0.2.2 -n 1 -w 1000 > nul
:: Open URL in default web browser
START "" "http://localhost:8080"
:: Exit the batch and let the process run in background
