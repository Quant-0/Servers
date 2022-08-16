rem ___________________
rem BEGIN CONFIGURATION
rem ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
set SteamCMD_Dir=D:\Server\steamcmd
rem ^ Location to dirctory containing steamcmd.exe ^
set Server_Dir=D:\Server\LEAP Server
rem ^ Location to directory that the Leap Server will be installed in ^
set Executable_Dir=D:\Server\LEAP Server\LEAP\Binaries\Win64
rem ^ Location to directory containing the following executable ^
set Server_Executable=LEAPServer.exe
rem ________________
rem BEGIN BATCH CODE
rem ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
cls
@echo off
title LEAP Server Watchdog                                                                                                                                                  Aroad Leap Server
echo DO NOT CLOSE THIS WINDOW!
echo.
:start
tasklist /nh /fi "Imagename eq %Server_Executable%" | find "LEAPServer"
if ERRORLEVEL=1 goto update
if ERRORLEVEL=0 goto close
:update
echo Checking For Update
start "" /b /w /high "%SteamCMD_Dir%\steamcmd.exe" +force_install_dir "%Server_Dir%" +login anonymous +app_update 906940 validate +quit
echo.
echo If No Errors Exist, The Server Has Been Started! Check Task Manager
echo.
echo Waiting For Crash...
cd "%Executable_Dir%"
start "" /w /high "%Server_Executable%" -nosteamclient PORT=7777 -server -log &:: Using "-log" Will Prevent Automatic Crash Detection
echo Crash Detected!
echo.
echo CTRL+C To Freeze Before Restarting
timeout /t 15
goto start
:close
echo.
echo !ERROR! SERVER ALREADY RUNNING! SHUTDOWN WILL COMMENCE
taskkill /im "%Server_Executable%" /f /t
timeout /t 3
goto start

