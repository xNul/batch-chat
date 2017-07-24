@echo off
set col1=0
set col2=7
if "%1" == "msgingrmsg" goto msgingrmsg
if "%1" == "msgingsmsg" goto msgingsmsg
if "%1" == "msgingr" goto msgingr
if "%1" == "msgings" goto msgings
if "%1" == "plist" goto plistsep
if "%1" == "messages" goto rankident
if not exist "%appdata%\Batch_Chat" goto net
goto nonad
:nonad
title Batch Chat
color %col1%%col2%
if not exist "%appdata%\Batch_Chat" mkdir "%appdata%\Batch_Chat"
set cddefault=%cd%
set fileversion=Alpha_1.9.2
set version=Alpha 1.9.2
goto okaygo
:net
if not exist "C:\chat" mkdir "C:\chat"
title Network ERROR
cls
echo.
echo  Your network drive has
echo  not yet been setup,
echo  press 1 for the first
echo  step.  After pressing 1
echo  and following the
echo  instructions, press enter
echo  and press 2.  Note: pressing
echo  3 will reset this process.
echo     Then your done!
echo.
echo   1.) Step 1
echo   2.) Step 2
echo   3.) Reset
echo   4.) Exit
echo.
choice /c 1234 >NUL
if %ERRORLEVEL% == 1 goto step1
if %ERRORLEVEL% == 2 goto step2
if %ERRORLEVEL% == 3 goto stepreset
if %ERRORLEVEL% == 4 exit
goto net

:step1
cls
echo.
echo  This part you have to do
echo       manually:
echo.
echo   1.) Goto your "C" drive
echo   2.) Right-click on the
echo               "chat" folder
echo   3.) Click "Properties"
echo   4.) Click "Sharing" at the
echo         top of the new window.
echo   5.) Click "Share"
echo   6.) Click the down arrow and
echo               select "Everyone"
echo   7.) Click "Add"
echo   8.) A new line should appear,
echo       with "Everyone" to the left.
echo   9.) On the right of that line
echo          click the down arrow.
echo   10.) Select "Read/Write"
echo   11.) Click "Share" at te bottom
echo          of the window.
echo   12.) if prompted accept administrator
echo                      access.
echo   13.) Exit out of everything.
echo.
echo     Press Enter to Continue.
pause >NUL
goto step12

:step12
cls
echo.
echo  Step 1 completed!
echo.
echo  Press Enter to Return to the Menu.
echo.
pause >NUL
goto net

:step2
net use Z: \\%computername%\chat
mkdir "%appdata%\Batch_Chat"
cls
echo.
echo  Step 2 completed!
echo.
echo  Press Enter to Exit.
echo.
pause >NUL
exit

:stepreset
rmdir "%appdata%\Batch_Chat"
cls
echo.
echo  Reset complete!
echo.
echo Press Enter to Return.
echo.
pause >NUL
goto net
:okaygo
if not defined pcname set pcname=%computername%
PUSHD \\Nabakin-PC\chat
popd
cd %appdata%\Batch_Chat
if not exist "colous.exe" xcopy "%cddefault%\colous.exe" "%appdata%\Batch_Chat"
if exist "settings.bat" call "settings.bat"
PUSHD \\Nabakin-PC\chat
set /p nextversion=<"Z:\usernames\%rusername%\version.bc"
popd
if exist "%appdata%\Batch_Chat\settings.bat" (
if not "%nextversion%" == "%fileversion%" goto update
)
set cols=40 
set lines=8 
mode con cols=%cols%lines=%lines%
if exist "%appdata%\Batch_Chat\temp.bat" del "%appdata%\Batch_Chat\temp.bat"
PUSHD \\Nabakin-PC\chat
if not exist "Z:\ranks" mkdir "Z:\ranks"
if not exist "Z:\ranks\Guest" mkdir "Z:\ranks\Guest"
if not exist "Z:\ranks\Dispicable" mkdir "Z:\ranks\Dispicable"
if not exist "Z:\ranks\Operator" mkdir "Z:\ranks\Operator"
if not exist "Z:\ranks\Moderator" mkdir "Z:\ranks\Moderator"
if not exist "Z:\ranks\Director" mkdir "Z:\ranks\Director"
if not exist "Z:\ranks\Admin" mkdir "Z:\ranks\Admin"
if not exist "Z:\usernames" mkdir "Z:\usernames"
if not exist "Z:\update" mkdir "Z:\update"
if not exist "Z:\players" mkdir "Z:\players"
popd
goto run
:adstart
cls
title Batch Chat - Admin, not
echo.
echo  You need to exit out and run this as Administrator,
echo  you only have to do this one time.
echo.
echo  If you do not know how, search google.com
echo.
echo  Press Enter to Exit.
echo.
pause >NUL
exit
:run
cd %appdata%\Batch_Chat
if exist "settings.bat" goto start
color f0
cls
echo.
echo              Welcome to Batch Chat.
echo.
set /p rusername=What is your name? 
PUSHD \\Nabakin-PC\chat
if exist "Z:\usernames\%rusername%" goto userexist
popd
cd "%appdata%\Batch_Chat"
set col1=%col1% 
set col2=%col2% 
set permsg=7 
set percol=7 
set colousc=7 
echo set rusername=%rusername%> "settings.bat"
echo set room=Lobby>> "settings.bat"
echo set rank=Guest>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set pmsgn=%pmsgn%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
PUSHD \\Nabakin-PC\chat
mkdir "Z:\usernames\%rusername%"
echo %fileversion%> "Z:\usernames\%rusername%\version.bc"
echo Guest> "Z:\usernames\%rusername%\rankGuest.bc"
if not exist "Z:\Lobby" mkdir "Z:\Lobby"
popd
cd "%appdata%\Batch_Chat"
call "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
PUSHD \\Nabakin-PC\chat
if not exist "Z:\Lobby\Lobby.crm" echo Welcome to the new room, %room%! > "Z:\Lobby\Lobby.crm"
goto start
:userexist
popd
cls
title Batch Chat - User Error
echo.
echo  This user already exists!
echo.
pause >NUL
goto run
:start
cls
if not exist "Z:\players\%rusername% [%rank%]" mkdir "Z:\players\%rusername% [%rank%]"
popd
cd "%appdata%\Batch_Chat"
call "settings.bat"
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set pmsgn=%pmsgn%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
cd "%cddefault%"
start Chat-%fileversion%.bat messages
goto CHATLOOP
:CHATLOOP
mode con cols=%cols%lines=%lines%
color %col1%%col2%
cls
cd "%appdata%\Batch_Chat"
call "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
set cols=%cols:~0,-1%
set lines=%lines:~0,-1%
title Batch Chat - %room%
echo %room%
echo.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
for /f "tokens=1,2,3 delims=" %%a IN ('type Z:\%room%\%room%.crm') DO (colous Writesec "%%a"&set check=%%a)
set old=%check%
set oldc=%cols%
set oldl=%lines%
goto loop
:loop
cd "%appdata%\Batch_Chat"
set old1=%col1%
set old2=%col2%
if not "%old1%" == "%col1%" (
color %col1%%col2%
cls
echo %room%
echo.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
for /f "tokens=1,2,3 delims=" %%a IN ('type Z:\%room%\%room%.crm') DO (colous Writesec "%%a"&set check=%%a)
)
if not "%cols%" == "%oldc%" (
set oldc=%cols%
set oldl=%lines%
mode con cols=%cols%lines=%lines%
echo %room%
echo.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
for /f "tokens=1,2,3 delims=" %%a IN ('type Z:\%room%\%room%.crm') DO (colous Writesec "%%a"&set check=%%a)
)
cd "%appdata%\Batch_Chat"
call "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
set cols=%cols:~0,-1%
set lines=%lines:~0,-1%
if not exist "Z:\usernames\%rusername%\newmsg.bc" goto skipt
set /p nomnom=<"Z:\usernames\%rusername%\newmsg.bc"
cd "%appdata%\Batch_Chat"
call "settings.bat"
set pmsgn=%nomnom%
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set pmsgn=%pmsgn%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
cd "%cddefault%"
start Chat-%fileversion%.bat msgingr
del "Z:\usernames\%rusername%\newmsg.bc"
:skipt
if exist "Z:\usernames\%rusername%\%room%\cls.bc" (
set /p tuser=<"Z:\usernames\%rusername%\%room%\cls.bc"
cls
echo %room%
echo.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo %tuser% has cleared the chat log.
del "Z:\usernames\%rusername%\%room%\cls.bc"
)
if exist "Z:\usernames\%rusername%\cls.bc" (
cls
echo %room%
echo.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
del "Z:\usernames\%rusername%\cls.bc"
)
if exist "Z:\usernames\%rusername%\rank.bc" goto rankset
for /f "tokens=1,2,3* delims=" %%a IN ('type Z:\%room%\%room%.crm') DO (set check=%%a)
if NOT "%check%" == "%old%" (colous Writesec "%check%"&set old=%check%)
goto loop
:rankset
set /p rankt=<"Z:\usernames\%rusername%\rank.bc"
cd "%appdata%\Batch_Chat"
call "settings.bat"
if "%rankt%" == "Admin" set colousc=5 
if "%rankt%" == "Director" set colousc=4 
if "%rankt%" == "Moderator" set colousc=1 
if "%rankt%" == "Operator" set colousc=2 
if "%rankt%" == "Guest" set colousc=7 
if "%rankt%" == "Dispicable" set colousc=0 
del "Z:\usernames\%rusername%\rank%rank%.bc"
echo %rankt%> "Z:\usernames\%rusername%\rank%rankt%.bc"
cd "%appdata%\Batch_Chat"
set rank=%rankt%
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set pmsgn=%pmsgn%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
del "Z:\usernames\%rusername%\rank.bc"
goto CHATLOOP
:updone
popd
cd "%appdata%\Batch_Chat"
echo @echo off> "temp.bat"
echo cd "%appdata%\Batch_Chat">> "temp.bat"
echo call "settings.bat">> "temp.bat"
echo cls>> "temp.bat"
echo title Batch Chat - Update Successful>> "temp.bat"
echo echo.>> "temp.bat"
echo echo  You have been updated successfully! >> "temp.bat"
echo echo.>> "temp.bat"
echo if exist "Z:\update\Chat-winvista-%nextversion%.bat" del "%cddefault%\Chat-winvista-%fileversion%.bat">> "temp.bat"
echo pause>> "temp.bat"
echo exit>> "temp.bat"
start "temp.bat"
exit
:update
popd
title Batch Chat - Update
cls
echo.
echo  There is a update for Batch Chat!
echo    Would you like to update? [Y/N]
echo  If it asks you to overwrite type "Yes"
echo.
set /p update=">"
if "%update%" == "y" goto next
if "%update%" == "Y" goto next
if "%update%" == "n" goto run
if "%update%" == "N" goto run
:next
cls
if exist "Z:\update\Chat-winvista-%nextversion%.bat" XCOPY "Chat-winvista-%nextversion%.bat" "%cddefault%"
goto updone
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
rem STOPS HERE GOES TO MESSAGES
:msgingr
start %cddefault%\Chat-%fileversion%.bat msgingrmsg
color f0
cls
cd "%appdata%\Batch_Chat"
call "settings.bat"
title Batch Chat - Private %pmsgn%
echo %pmsgn%
echo.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
for /f "tokens=1,2,3 delims=" %%a IN ('type Z:\usernames\%rusername%\msging\%pmsgn%\chat.crm') DO (colous Writesec "%%a"&set check=%%a)
set old=%check%
goto msgingrloop
:msgingrloop
for /f "tokens=1,2,3* delims=" %%a IN ('type Z:\usernames\%rusername%\msging\%pmsgn%\chat.crm') DO (set check=%%a)
if NOT "%check%" == "%old%" (colous Writesec "%check%"&set old=%check%)
goto msgingrloop
:msgingrmsg
mode con cols=30 lines=2
color f0
cls
cd %appdata%\Batch_Chat
call "settings.bat"
set permsg=%permsg:~0,-1%
set percol=%percol:~0,-1%
set colousc=%colousc:~0,-1%
title Private Message
color f0
set /p messagep=Say: 
echo [8]%TIME:~0,2%:%TIME:~3,2% [%colousc%]%rank% [%percol%]%rusername%: [%permsg%]%messagep% >> "Z:\usernames\%rusername%\msging\%pmsgn%\chat.crm"
goto msgingrmsg
:msgings
start %cddefault%\Chat-%fileversion%.bat msgingsmsg
color f0
cls
cd "%appdata%\Batch_Chat"
call "settings.bat"
title Batch Chat - Private %pmsgn%
echo %pmsgn%
echo.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
for /f "tokens=1,2,3 delims=" %%a IN ('type Z:\usernames\%pmsgn%\msging\%rusername%\chat.crm') DO (colous Writesec "%%a"&set check=%%a)
set old=%check%
goto msgingsloop
:msgingsloop
for /f "tokens=1,2,3* delims=" %%a IN ('type Z:\usernames\%pmsgn%\msging\%rusername%\chat.crm') DO (set check=%%a)
if NOT "%check%" == "%old%" (colous Writesec "%check%"&set old=%check%)
goto msgingsloop
:msgingsmsg
mode con cols=30 lines=2
color f0
cls
cd %appdata%\Batch_Chat
call "settings.bat"
set permsg=%permsg:~0,-1%
set percol=%percol:~0,-1%
set colousc=%colousc:~0,-1%
title Private Message
color f0
set /p messagep=Say: 
echo [8]%TIME:~0,2%:%TIME:~3,2% [%colousc%]%rank% [%percol%]%rusername%: [%permsg%]%messagep% >> "Z:\usernames\%pmsgn%\msging\%rusername%\chat.crm"
goto msgingsmsg
:rankident
cd "%appdata%\Batch_Chat"
call "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
PUSHD \\%pcname%\chat
popd
if not exist "Z:\usernames\%rusername%" mkdir "Z:\usernames\%rusername%"
echo Welcome, %rusername%! >> "Z:\%room%\%room%.crm"
goto msg%rank%
goto error
:error
title MAJOR ERROR
cls
echo.
echo There has been an error!
echo.
echo  1.) exit
echo  2.) delete game data
echo.
set /p errorc=">"
if %errorc%==1 goto exit
if %errorc%==2 goto errordel
goto error
:errordel
cls
del "%appdata%\Batch_Chat\settings.bat"
echo.
echo   Data has been deleted!
echo.
pause >NUL
goto exit
:exit
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
exit
:msgAdmin
mode con cols=30 lines=2
cd "%appdata%\Batch_Chat"
call "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
set permsg=%permsg:~0,-1%
set percol=%percol:~0,-1%
set colousc=%colousc:~0,-1%
title Message
color %col1%%col2%
if not "%rank%" == "Admin" goto msg%rank%
cls
set /p message=Say: 
set thismessage="%message%"
if %thismessage% == "/exit" (
echo %rusername% has left the chat room. >> "Z:\%room%\%room%.crm"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
rmdir "Z:\players\%rusername% [%rank%]"
exit
)
if %thismessage% == "/disconnect" (
echo %rusername% has left the chat room. >> "Z:\%room%\%room%.crm"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
rmdir "Z:\players\%rusername% [%rank%]"
exit
)
if %thismessage% == "/rcls" goto msgcls
if %thismessage% == "/cls" (
echo cls> "Z:\usernames\%rusername%\cls.bc"
goto msg%rank%
)
if %thismessage% == "/create" goto rcreate
if %thismessage% == "/dimensions" goto dementions
if %thismessage% == "/join" goto join
if %thismessage% == "/delete" goto rdelete
if %thismessage% == "/list" goto list
if %thismessage% == "/color" goto msgcolor
if %thismessage% == "/msg" goto cmdmsg
if %thismessage% == "/chat" goto cmdchats
if %thismessage% == "/plist" goto plist
if %thismessage% == "/rank" goto rank
if %thismessage% == "/help" goto help
if %thismessage% == "/help dimensions" goto helpdim
if %thismessage% == "/help plist" goto helpplist
if %thismessage% == "/help exit" goto helpexit
if %thismessage% == "/help disconnect" goto helpdis
if %thismessage% == "/help cls" goto helpcls
if %thismessage% == "/help rcls" goto helprcls
if %thismessage% == "/host" goto msghost
if %thismessage% == "/help host" goto helphost
if %thismessage% == "/help color" goto helpcolor
if %thismessage% == "/help create" goto helpcreate
if %thismessage% == "/help join" goto helpjoin
if %thismessage% == "/help delete" goto helpdel
if %thismessage% == "/help list" goto helplist
if %thismessage% == "/help rank" goto helprank
if %thismessage% == "/help connectinst" goto helpconnectinst
if %thismessage% == "/connectinst" goto connectinst
if %thismessage:~1,1% == "/" echo %rusername% has exicuted an unknown command! >> "Z:\%room%\%room%.crm"
if not "%message%" == "%message:@=at%" goto hgf
echo [8]%TIME:~0,2%:%TIME:~3,2% [%colousc%]%rank% [%percol%]%rusername%: [%permsg%]%message% >> "Z:\%room%\%room%.crm"
cd "%appdata%\Batch_Chat"
goto msgAdmin
:hgf
start %cddefault%\Chat-%fileversion%.bat at
cd %appdata%\Batch_Chat
echo set messaget=%message%>> "settings.bat"
:msgDirector
mode con cols=30 lines=2
cd "%appdata%\Batch_Chat"
call "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
set permsg=%permsg:~0,-1%
set percol=%percol:~0,-1%
set colousc=%colousc:~0,-1%
title Message
color %col1%%col2%
if not "%rank%" == "Director" goto msg%rank%
cls
set /p message=Say: 
set thismessage="%message%"
if %thismessage% == "/exit" (
echo %rusername% has left the chat room. >> "Z:\%room%\%room%.crm"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
rmdir "Z:\players\%rusername% [%rank%]"
exit
)
if %thismessage% == "/disconnect" (
echo %rusername% has left the chat room. >> "Z:\%room%\%room%.crm"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
rmdir "Z:\players\%rusername% [%rank%]"
exit
)
if %thismessage% == "/rcls" goto msgcls
if %thismessage% == "/cls" (
cls
goto msg%rank%
)
if %thismessage% == "/delete" goto rdelete
if %thismessage% == "/create" goto rcreate
if %thismessage% == "/join" goto join
if %thismessage% == "/plist" goto plist
if %thismessage% == "/help dimensions" goto helpdim
if %thismessage% == "/dimensions" goto dementions
if %thismessage% == "/color" goto msgcolor
if %thismessage% == "/msg" goto cmdmsg
if %thismessage% == "/chat" goto cmdchats
if %thismessage% == "/connectinst" goto connectinst
if %thismessage% == "/help" goto help
if %thismessage% == "/help exit" goto helpexit
if %thismessage% == "/help disconnect" goto helpdis
if %thismessage% == "/help cls" goto helpcls
if %thismessage% == "/help rcls" goto helprcls
if %thismessage% == "/host" goto msghost
if %thismessage% == "/help color" goto helpcolor
if %thismessage% == "/help host" goto helphost
if %thismessage% == "/help plist" goto helpplist
if %thismessage% == "/help create" goto helpcreate
if %thismessage% == "/help join" goto helpjoin
if %thismessage% == "/help delete" goto helpdel
if %thismessage% == "/help list" goto helplist
if %thismessage% == "/help rank" goto helprank
if %thismessage% == "/help connectinst" goto helpconnectinst
if %thismessage% == "/list" goto list
if %thismessage:~1,1% == "/" echo %rusername% has exicuted an unknown command! >> "Z:\%room%\%room%.crm"
echo [8]%TIME:~0,2%:%TIME:~3,2% [%colousc%]%rank% [%percol%]%rusername%: [%permsg%]%message% >> "Z:\%room%\%room%.crm"
cd "%appdata%\Batch_Chat"
goto msgDirector
:msgModerator
mode con cols=30 lines=2
cd "%appdata%\Batch_Chat"
call "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
set permsg=%permsg:~0,-1%
set percol=%percol:~0,-1%
set colousc=%colousc:~0,-1%
title Message
color %col1%%col2%
if not "%rank%" == "Moderator" goto msg%rank%
cls
set /p message=Say: 
set thismessage="%message%"
if %thismessage% == "/exit" (
echo %rusername% has left the chat room. >> "Z:\%room%\%room%.crm"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
rmdir "Z:\players\%rusername% [%rank%]"
exit
)
if %thismessage% == "/disconnect" (
echo %rusername% has left the chat room. >> "Z:\%room%\%room%.crm"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
rmdir "Z:\players\%rusername% [%rank%]"
exit
)
if %thismessage% == "/rcls" goto msgcls
if %thismessage% == "/cls" (
cls
goto msg%rank%
)
if %thismessage% == "/delete" goto rdelete
if %thismessage% == "/create" goto rcreate
if %thismessage% == "/join" goto join
if %thismessage% == "/connectinst" goto connectinst
if %thismessage% == "/help" goto help
if %thismessage% == "/color" goto msgcolor
if %thismessage% == "/msg" goto cmdmsg
if %thismessage% == "/chat" goto cmdchats
if %thismessage% == "/dimensions" goto dementions
if %thismessage% == "/help plist" goto helpplist
if %thismessage% == "/plist" goto plist
if %thismessage% == "/help dimensions" goto helpdim
if %thismessage% == "/help exit" goto helpexit
if %thismessage% == "/help disconnect" goto helpdis
if %thismessage% == "/help cls" goto helpcls
if %thismessage% == "/help rcls" goto helprcls
if %thismessage% == "/host" goto msghost
if %thismessage% == "/help color" goto helpcolor
if %thismessage% == "/help host" goto helphost
if %thismessage% == "/help create" goto helpcreate
if %thismessage% == "/help join" goto helpjoin
if %thismessage% == "/help delete" goto helpdel
if %thismessage% == "/help list" goto helplist
if %thismessage% == "/help rank" goto helprank
if %thismessage% == "/help connectinst" goto helpconnectinst
if %thismessage% == "/list" goto list
if %thismessage:~1,1% == "/" echo %rusername% has exicuted an unknown command! >> "Z:\%room%\%room%.crm"
echo [8]%TIME:~0,2%:%TIME:~3,2% [%colousc%]%rank% [%percol%]%rusername%: [%permsg%]%message% >> "Z:\%room%\%room%.crm"
cd "%appdata%\Batch_Chat"
goto msgModerator
:msgOperator
mode con cols=30 lines=2
cd "%appdata%\Batch_Chat"
call "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
set permsg=%permsg:~0,-1%
set percol=%percol:~0,-1%
set colousc=%colousc:~0,-1%
title Message
color %col1%%col2%
if not "%rank%" == "Operator" goto msg%rank%
cls
set /p message=Say: 
set thismessage="%message%"
if %thismessage% == "/exit" (
echo %rusername% has left the chat room. >> "Z:\%room%\%room%.crm"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
rmdir "Z:\players\%rusername% [%rank%]"
exit
)
if %thismessage% == "/disconnect" (
echo %rusername% has left the chat room. >> "Z:\%room%\%room%.crm"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
rmdir "Z:\players\%rusername% [%rank%]"
exit
)
if %thismessage% == "/cls" (
cls
goto msg%rank%
)
if %thismessage% == "/join" goto join
if %thismessage% == "/delete" goto rdelete
if %thismessage% == "/help" goto help
if %thismessage% == "/dimensions" goto dementions
if %thismessage% == "/plist" goto plist
if %thismessage% == "/help exit" goto helpexit
if %thismessage% == "/help disconnect" goto helpdis
if %thismessage% == "/help cls" goto helpcls
if %thismessage% == "/help rcls" goto helprcls
if %thismessage% == "/color" goto msgcolor
if %thismessage% == "/msg" goto cmdmsg
if %thismessage% == "/chat" goto cmdchats
if %thismessage% == "/help dimensions" goto helpdim
if %thismessage% == "/help create" goto helpcreate
if %thismessage% == "/help join" goto helpjoin
if %thismessage% == "/host" goto msghost
if %thismessage% == "/help color" goto helpcolor
if %thismessage% == "/help host" goto helphost
if %thismessage% == "/help plist" goto helpplist
if %thismessage% == "/help delete" goto helpdel
if %thismessage% == "/help list" goto helplist
if %thismessage% == "/help rank" goto helprank
if %thismessage% == "/help connectinst" goto helpconnectinst
if %thismessage% == "/connectinst" goto connectinst
if %thismessage% == "/create" goto rcreate
if %thismessage% == "/list" goto list
if %thismessage:~1,1% == "/" echo %rusername% has exicuted an unknown command! >> "Z:\%room%\%room%.crm"
echo [8]%TIME:~0,2%:%TIME:~3,2% [%colousc%]%rank% [%percol%]%rusername%: [%permsg%]%message% >> "Z:\%room%\%room%.crm"
cd "%appdata%\Batch_Chat"
goto msgOperator
:msgGuest
mode con cols=30 lines=2
cd "%appdata%\Batch_Chat"
call "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
set permsg=%permsg:~0,-1%
set percol=%percol:~0,-1%
set colousc=%colousc:~0,-1%
title Message
color %col1%%col2%
if not "%rank%" == "Guest" goto msg%rank%
cls
set /p message=Say: 
set thismessage="%message%"
if %thismessage% == "/exit" (
echo %rusername% has left the chat room. >> "Z:\%room%\%room%.crm"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
rmdir "Z:\players\%rusername% [%rank%]"
exit
)
if %thismessage% == "/disconnect" (
echo %rusername% has left the chat room. >> "Z:\%room%\%room%.crm"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
rmdir "Z:\players\%rusername% [%rank%]"
exit
)
if %thismessage% == "/delete" goto rdelete
if %thismessage% == "/create" goto rcreate
if %thismessage% == "/connectinst" goto connectinst
if %thismessage% == "/help" goto help
if %thismessage% == "/cls" (
cls
goto msg%rank%
)
if %thismessage% == "/dimensions" goto dementions
if %thismessage% == "/plist" goto plist
if %thismessage% == "/help dimensions" goto helpdim
if %thismessage% == "/help exit" goto helpexit
if %thismessage% == "/help disconnect" goto helpdis
if %thismessage% == "/help cls" goto helpcls
if %thismessage% == "/color" goto msgcolor
if %thismessage% == "/msg" goto cmdmsg
if %thismessage% == "/chat" goto cmdchats
if %thismessage% == "/help rcls" goto helprcls
if %thismessage% == "/help plist" goto helpplist
if %thismessage% == "/help create" goto helpcreate
if %thismessage% == "/help join" goto helpjoin
if %thismessage% == "/host" goto msghost
if %thismessage% == "/help color" goto helpcolor
if %thismessage% == "/help host" goto helphost
if %thismessage% == "/help delete" goto helpdel
if %thismessage% == "/help list" goto helplist
if %thismessage% == "/help rank" goto helprank
if %thismessage% == "/help connectinst" goto helpconnectinst
if %thismessage% == "/list" goto list
if %thismessage% == "/join" goto join
if %thismessage:~1,1% == "/" echo %rusername% has exicuted an unknown command! >> "Z:\%room%\%room%.crm"
echo [8]%TIME:~0,2%:%TIME:~3,2% [%colousc%]%rank% [%percol%]%rusername%: [%permsg%]%message% >> "Z:\%room%\%room%.crm"
cd "%appdata%\Batch_Chat"
goto msgGuest
:msgDispicable
mode con cols=30 lines=2
cd "%appdata%\Batch_Chat"
call "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
set permsg=%permsg:~0,-1%
set percol=%percol:~0,-1%
set colousc=%colousc:~0,-1%
title Message
color %col1%%col2%
if not "%rank%" == "Dispicable" goto msg%rank%
cls
set /p message=Say: 
set thismessage="%message%"
if %thismessage% == "/exit" (
echo %rusername% has left the chat room. >> "Z:\%room%\%room%.crm"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
rmdir "Z:\players\%rusername% [%rank%]"
exit
)
if %thismessage% == "/disconnect" (
echo %rusername% has left the chat room. >> "Z:\%room%\%room%.crm"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
rmdir "Z:\players\%rusername% [%rank%]"
exit
)
if %thismessage% == "/help" goto help
if %thismessage% == "/help exit" goto helpexit
if %thismessage% == "/help disconnect" goto helpdis
if %thismessage% == "/help cls" goto helpcls
if %thismessage% == "/help rcls" goto helprcls
if %thismessage% == "/help create" goto helpcreate
if %thismessage% == "/help join" goto helpjoin
if %thismessage% == "/help delete" goto helpdel
if %thismessage% == "/help list" goto helplist
if %thismessage% == "/help color" goto helpcolor
if %thismessage% == "/host" goto msghost
if %thismessage% == "/help host" goto helphost
if %thismessage% == "/help rank" goto helprank
if %thismessage% == "/help plist" goto helpplist
if %thismessage% == "/help connectinst" goto helpconnectinst
if %thismessage% == "/connectinst" goto connectinst
if %thismessage:~1,1% == "/" echo %rusername% has exicuted an unknown command! >> "Z:\%room%\%room%.crm"
echo [8]%TIME:~0,2%:%TIME:~3,2% [%colousc%]%rank% [%percol%]%rusername%: [%permsg%]%message% >> "Z:\%room%\%room%.crm"
cd "%appdata%\Batch_Chat"
goto msgDispicable
:msgcolor
mode con cols=50 lines=15
title Batch Chat - Color Changer
cls
echo.
echo What colors do you want to change?
echo.
echo  1.) Background/Normal Text Color
echo  2.) Text You Send/Your Name Color
echo.
echo  3.) Exit
echo.
set /p colort=">"
if "%colort%" == "1" goto msgcolorreg
if "%colort%" == "2" goto msgcolorcol
if "%colort%" == "3" goto msg%rank%
goto msgcolor
:msgcolorcol
title Batch Chat - Color Changer
cls
echo.
echo  What color do you want your text to be?
echo.
echo     0 = Black       8 = Gray
echo     1 = Blue        9 = Light Blue
echo     2 = Green       A = Light Green
echo     3 = Aqua        B = Light Aqua
echo     4 = Red         C = Light Red
echo     5 = Purple      D = Light Purple
echo     6 = Yellow      E = Light Yellow
echo     7 = White       F = Bright White
echo.
echo  Type: "exit" to exit.
echo.
set /p txtc=">"
if "%txtc%" == "exit" goto msgcolor
:msgcolorcol2
title Batch Chat - Color Changer
cls
echo.
echo  What color do you want your name to be?
echo.
echo     0 = Black       8 = Gray
echo     1 = Blue        9 = Light Blue
echo     2 = Green       A = Light Green
echo     3 = Aqua        B = Light Aqua
echo     4 = Red         C = Light Red
echo     5 = Purple      D = Light Purple
echo     6 = Yellow      E = Light Yellow
echo     7 = White       F = Bright White
echo.
echo  Type: "exit" to exit.
echo.
set /p nc=">"
if "%nc%" == "exit" goto msgcolor
cd "%appdata%\Batch_Chat
call "settings.bat"
set percol=%nc% 
set permsg=%txtc% 
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set pmsgn=%pmsgn%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
goto msg%rank%
:msgcolorreg
title Batch Chat - Color Changer
cls
echo.
echo  What do you want the Background color to be?
echo.
echo     0 = Black       8 = Gray
echo     1 = Blue        9 = Light Blue
echo     2 = Green       A = Light Green
echo     3 = Aqua        B = Light Aqua
echo     4 = Red         C = Light Red
echo     5 = Purple      D = Light Purple
echo     6 = Yellow      E = Light Yellow
echo     7 = White       F = Bright White
echo.
echo  Type: "exit" to exit.
echo.
set /p bcg=">"
if "%bcg%" == "exit" goto msgcolor
:msgcolorreg2
title Batch Chat - Color Changer
cls
echo.
echo  What do you want the text color to be?
echo.
echo     0 = Black       8 = Gray
echo     1 = Blue        9 = Light Blue
echo     2 = Green       A = Light Green
echo     3 = Aqua        B = Light Aqua
echo     4 = Red         C = Light Red
echo     5 = Purple      D = Light Purple
echo     6 = Yellow      E = Light Yellow
echo     7 = White       F = Bright White
echo.
echo  Type: "exit" to exit.
echo.
set /p txt=">"
if "%txt%" == "exit" goto msgcolor
cd "%appdata%\Batch_Chat
call "settings.bat"
set col1=%bcg% 
set col2=%txt% 
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set pmsgn=%pmsgn%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
goto msg%rank%
:msghost
mode con cols=50 lines=15
cls
title Batch Chat - Change Host
echo.
echo  1.) Change Host for Lan
echo  2.) Change Host for Internet/Hamachi
echo.
echo  3.) Exit
echo.
set /p hosc=">"
if "%hosc%" == "1" goto hostlanmsg
if "%hosc%" == "2" goto hostintmsg
if "%hosc%" == "3" goto msg%rank%
goto msghost
:hostlanmsg
cls
title Batch Chat - Change for Lan
echo.
echo  Enter the name of the computer on your lan        network.
echo.
echo  PC Name Obtaining Instructions
echo.
echo Type:
echo        1.) Windows 7
echo        2.) Windows Vista
echo        3.) Windows XP
echo.
echo        4.) Exit
set /p forch=">"
if "%forch%" == "1" goto lanwin7msg
if "%forch%" == "2" goto lanwinvistmsg
if "%forch%" == "3" goto lanwinxpmsg
if "%forch%" == "4" goto msghost
cd "%appdata%\Batch_Chat"
call "settings.bat"
set pcname=%forch%
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set pmsgn=%pmsgn%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
pushd \\%pcname%\chat
goto finlan
:hostintmsg
cls
title Batch Chat - Change for Internet/Hamachi
echo.
echo  Enter the ip of the host listed in Hamachi.
echo.
echo  PC Name Obtaining Instructions
echo.
echo Type:
echo        1.) Windows 7
echo        2.) Windows Vista
echo        3.) Windows XP
echo.
echo        4.) Exit
set /p forch=">"
if "%forch%" == "1" goto lanwin7msg
if "%forch%" == "2" goto lanwinvistmsg
if "%forch%" == "3" goto lanwinxpmsg
if "%forch%" == "4" goto msghost
cd "%appdata%\Batch_Chat"
call "settings.bat"
set pcname=%forch%
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set pmsgn=%pmsgn%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
pushd \\%pcname%\chat
goto finlan
:finlan
cls
title Batch Chat - Changed
echo.
echo  Batch Chat host has been changed.
echo.
echo  Press Enter to Continue.
echo.
pause >NUL
goto msghost
:lanwinvistmsg
cls
title Batch Chat - Windows Vista PC Name Instructions
echo.
echo  Windows Vista PC Name Instructions:
echo.
echo   1.) Goto your startmenu at the bottom lefthand corrner of your screen.
echo   2.) Click "Control Panel"
echo   3.) Click "System and Maintenance"
echo   4.) Click "System"
echo   5.) Now look for the section labeled "Computer Name" and take the computer name and that is your computer name.
echo.
echo  Press enter to Continue.
echo.
pause >NUL
goto msghost
:lanwin7msg
cls
title Batch Chat - Win 7 PC Name Instructions
echo.
echo  Win 7 PC Name Instructions
echo.
echo  No info yet.
echo.
echo  Press enter to Continue.
echo.
pause >NUL
goto msghost
:lanwinxpmsg
cls
title Batch Chat - Win XP PC Name Instructions
echo.
echo  Win XP PC Name Instructions
echo.
echo  No info yet.
echo.
echo  Press enter to Continue.
echo.
pause >NUL
goto msghost
:msgcls
echo [4]%rusername% has cleared the chat log. > "Z:\%room%\%room%.crm"
set x=0
for %%x in (Z:\usernames\) do set /a count+=1
:msgcls2
for /f "delims=" %%a IN ('dir /b Z:\usernames\') DO (call :clsecho %%a)
:clsecho
if "%x%" == "%count%" goto msg%rank%
if "%1" == "messages" goto msg%rank%
set /a x=%x%+1
if not exist "Z:\usernames\%rusername%\rooms" mkdir "Z:\usernames\%rusername%\rooms"
if not exist "Z:\usernames\%rusername%\rooms\%room%" mkdir "Z:\usernames\%rusername%\rooms\%room%"
echo %rusername%> "Z:\usernames\%1\rooms\%room%\cls.bc"
goto :eof
:cmdmsg
mode con cols=50 lines=15
cls
title Batch Chat - Private Messaging
echo.
echo  Who would you like to message?
echo.
echo  1.) Exit
echo.
set /p msgn=">"
if "%msgn%" == "1" goto msg%rank%
if "%msgn%" == "%rusername%" goto uemsg
if not exist Z:\usernames\%msgn% goto pnotmsge
goto cmdmsg2
:uemsg
cls
title Batch Chat - Private Messaging
echo.
echo  You cant message yourself stupid!
echo.
pause >NUL
goto cmdmsg
:pnotmsge
cls
title Batch Chat - Private Messaging
echo.
echo  The username %msgn% does not exist!
echo.
pause >NUL
goto cmdmsg
:cmdmsg2
cls
title Batch Chat - Private Messaging
echo.
echo  What would you like to say?
echo.
echo  1.) Back
echo.
set /p txtmsg=">"
if "%txtmsg%" == "1" goto cmdmsg
if not exist "Z:\usernames\%msgn%\msging" mkdir "Z:\usernames\%msgn%\msging"
if not exist "Z:\usernames\%msgn%\msging\%rusername%" (
mkdir "Z:\usernames\%msgn%\msging\%rusername%"
echo %rusername%> "Z:\usernames\%msgn%\newmsg.bc"
)
cd %appdata%\Batch_Chat
call "settings.bat"
set pmsgn=%msgn%
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set pmsgn=%pmsgn%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
set permsg=%permsg:~0,-1%
set percol=%percol:~0,-1%
set colousc=%colousc:~0,-1%
echo [8]%TIME:~0,2%:%TIME:~3,2% [%colousc%]%rank% [%percol%]%rusername%: [%permsg%]%txtmsg%>> "Z:\usernames\%msgn%\msging\%rusername%\chat.crm"
goto cmdmsg3
:cmdmsg3
cls
title Batch Chat - Private Messaging
echo.
echo  Message to %msgn% has been sent!
echo.
pause >NUL
start %cddefault%\Chat-%fileversion%.bat msgings
goto msg%rank%
:cmdchats
mode con cols=50 lines=15
cls
title Batch Chat - Access a chat
echo.
echo  1.) Access a Chat that you started
echo  2.) Access a Chat that the other
echo               person started.
echo.
echo  3.) Exit
echo.
set /p chatrs=">"
if "%chatrs%" == "1" goto cmdchatss
if "%chatrs%" == "2" goto cmdchatsr
if "%chatrs%" == "3" goto msg%rank%
goto cmdchats
:cmdchatsr
cls
title Batch Chat - Access a chat
echo.
echo  Enter the name of the person
echo  that you have messaged.
echo.
echo  1.) Back
echo.
set /p pnamec=">"
if "%pnamec%" == "1" goto cmdchats
cd %appdata%\Batch_Chat
call "settings.bat"
set pmsgn=%pnamec%
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set pmsgn=%pmsgn%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
start %cddefault%\Chat-%fileversion%.bat msgingr
goto msg%rank%
:cmdchatss
cls
title Batch Chat - Access a chat
echo.
echo  Enter the name of the person
echo  that you have been messaged
echo  by.
echo.
echo  1.) Back
echo.
set /p pnamec=">"
if "%pnamec%" == "1" goto cmdchats
cd %appdata%\Batch_Chat
call "settings.bat"
set pmsgn=%pnamec%
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set pmsgn=%pmsgn%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
start %cddefault%\Chat-%fileversion%.bat msgings
goto msg%rank%
:dementions
mode con cols=50 lines=15
cd "%appdata%\Batch_Chat"
call "settings.bat"
title Dimensions
echo.
echo  What size do you want?
echo.
echo   1.) Extra Large
echo   2.) Large
echo   3.) Medium
echo   4.) Small
echo   5.) Mini
echo.
echo   6.) Custom
echo.
echo   7.) Exit
echo.
set /p size=">"
if %size%==1 (
set cols=168 
set lines=58 
)
if %size%==2 (
set cols=108 
set lines=58 
)
if %size%==3 (
set cols=88 
set lines=43 
)
if %size%==4 (
set cols=58 
set lines=28 
)
if %size%==5 (
set cols=40 
set lines=10 
)
if %size%==6 goto custdem
if %size%==7 goto msg%rank%
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
goto msg%rank%
:custdem
cd "%appdata%\Batch_Chat"
call "settings.bat"
cls
title Custom Dimensions
echo.
echo  Type how long you would like the window to be.
echo.
set /p col=">"
set cols=%col% 
cls
echo.
echo  Type how tall you would like the window to be.
echo.
set /p lin=">"
set lines=%lin% 
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
goto msg%rank%
:plist
mode con cols=50 lines=15
cls
title Player List
echo.
echo  -=-=-=-=-=-= Players Online =-=-=-=-=-=-
echo.
dir /b "Z:\players"
echo.
echo  1.) Open in a seperate window.
echo  2.) Refresh
echo  3.) Exit
echo.
set /p pq=">"
if %pq%==1 start %cddefault%\Chat-%fileversion%.bat plist
if %pq%==2 goto plist
if %pq%==3 goto msg%rank%
goto plist
:plistsep
mode con cols=30 lines=15
title Player List
:dirc
cls
echo.
echo  -=-=-= Players Online =-=-=-
echo.
for /f "delims=" %%t IN ('dir /b Z:\players') DO (echo %%t &set check1=%%t)
set old1=%check1%
:ploop
for /f "tokens=1,2,3* delims=" %%t IN ('dir /b Z:\players') DO (set check1=%%t)
if not "%check1%" == "%old1%" goto dirc
goto ploop
:rcreate
title Create Room
mode con cols=50 lines=15
color %col1%%col2%
cls
echo.
echo What is the name of the room you want to create?
echo.
echo    1.) Exit
echo.
set /p roomn=">"
if "%roomn%" == "1" goto msg%rank%
if exist "Z:\%roomn%" goto rexist
mkdir "Z:\%roomn%"
echo %rank%> "Z:\usernames\%rusername%\%roomn%.bc"
echo %rusername%> "Z:\ranks\%rank%\%roomn%.bc"
echo %rusername%, has created a new room called %roomn%! >> "Z:\%room%\%room%.crm"
echo Welcome to the new room, %roomn%! > "Z:\%roomn%\%roomn%.crm"
cd "%appdata%\Batch_Chat"
call "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
goto msg%rank%
:rexist
cls
echo.
echo This room already exists!
echo.
pause >NUL
goto rcreate
:join
title Join Room
mode con cols=50 lines=15
cd "%appdata%\Batch_Chat"
color %col1%%col2%
cls
echo.
echo What's the name of the room you want to join?
echo.
echo    1.) Exit
echo.
set /p roomj=">"
if "%roomj%" == "1" goto msg%rank%
if not exist "Z:\%roomj%" goto jnotexist
echo %rusername% has left the chat. >> "Z:\%room%\%room%.crm"
cd "%appdata%\Batch_Chat"
set room=%roomj%
echo set rusername=%rusername%> "settings.bat"
echo set room=%room%>> "settings.bat"
echo set rank=%rank%>> "settings.bat"
echo set cols=%cols%>> "settings.bat"
echo set lines=%lines%>> "settings.bat"
echo set col1=%col1%>> "settings.bat"
echo set col2=%col2%>> "settings.bat"
echo set permsg=%permsg%>> "settings.bat"
echo set percol=%percol%>> "settings.bat"
echo set colousc=%colousc%>> "settings.bat"
echo set fileversion=%fileversion%>> "settings.bat"
echo set cddefault=%cddefault%>> "settings.bat"
echo set pcname=%pcname%>> "settings.bat"
goto rankident
:jnotexist
cls
echo.
echo This room does not exist!
echo.
pause >NUL
goto join
:list
cls
cd "%appdata%\Batch_Chat"
call "settings.bat"
set col1=%col1:~0,-1%
set col2=%col2:~0,-1%
title Room List
mode con cols=50 lines=15
color %col1%%col2%
dir Z:\ /A:D
pause >NUL
goto msg%rank%
:rank
cd "%appdata%\Batch_Chat"
call "settings.bat"
title Rank - Who
mode con cols=50 lines=15
cls
echo.
echo  Who's rank would you like to change?
echo.
echo  1.) Exit
echo.
set /p urank=">"
if "%urank%" == "1" goto msg%rank%
if not exist "Z:\usernames\%urank%" goto pnotexist
if %rank%==Admin goto userpass
if "%urank%" == "%rusername%" goto urusern
if not exist "Z:\usernames\%urank%" goto usernote
goto userpass
:userpass
if exist "Z:\usernames\%urank%\rankGuest.bc" (
if exist "Z:\usernames\%rusername%\rankModerator.bc" goto rank2
if exist "Z:\usernames\%rusername%\rankDirector.bc" goto rank2
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank2
goto notallow
)
if exist "Z:\usernames\%urank%\rankDispicable.bc" (
if exist "Z:\usernames\%rusername%\rankModerator.bc" goto rank2
if exist "Z:\usernames\%rusername%\rankDirector.bc" goto rank2
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank2
goto notallow
)
if exist "Z:\usernames\%urank%\rankOperator.bc" (
if exist "Z:\usernames\%rusername%\rankDirector.bc" goto rank2
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank2
goto notallow
)
if exist "Z:\usernames\%urank%\rankModerator.bc" (
if exist "Z:\usernames\%rusername%\rankDirector.bc" goto rank2
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank2
goto notallow
)
if exist "Z:\usernames\%urank%\rankDirector.bc" (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank2
goto notallow
)
if exist "Z:\usernames\%urank%\rankAdmin.bc" (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank2
goto notallow
)
goto error
:usernote
cls
title Rank - Error
echo.
echo  Username does not exist!
echo.
pause >NUL
goto rank
:urusern
title Rank - Error
cls
echo.
echo  You cannot rank yourself!
echo.
pause >NUL
goto rank
:notallow
title Rank - Error
cls
echo.
echo  You can are either to low to change %urank%'s rank
echo  or %urank% is to high to be changed.
echo.
pause >NUL
goto rank
:rdelete
mode con cols=50 lines=15
cls
title Batch Chat - Room Delete
echo.
echo  What room would you like to delete?
echo   1.) exit
echo.
set /p vrdelete=">"
if "%vrdelete%" == "1" goto msg%rank%
if "%vrdelete%" == "%room%" goto rdelcannot
if "%vrdelete%" == "Lobby" goto mdelete
if not exist ""Z:\%vrdelete%"" goto rmnotexist
if %rank%==Admin goto admindel
if %rank%==Director goto directdel
if %rank%==Moderator goto moddel
if %rank%==Operator goto opdel
if %rank%==Guest goto guestdel
goto msg%rank%
:rdelcannot
cls
title Batch Chat - Delete Error
echo.
echo  You cannot delete a room you or someone is in!
echo.
pause >NUL
goto rdelete
:rmnotexist
cls
title Batch Chat - Room Error
echo.
echo  This room does not exist!
echo.
pause >NUL
goto rdelete
:dirdel
set userr=<"Z:\ranks\Director\%vrdelete%.bc"
del "Z:\usernames\%userr%\%vrdelete%.bc"
del "Z:\ranks\Director\%vrdelete%.bc"
goto deldone
:model
set userr=<"Z:\ranks\Moderator\%vrdelete%.bc"
del "Z:\usernames\%userr%\%vrdelete%.bc"
del "Z:\ranks\Moderator\%vrdelete%.bc"
goto deldone
:odel
set userr=<"Z:\ranks\Operator\%vrdelete%.bc"
del "Z:\usernames\%userr%\%vrdelete%.bc"
del "Z:\ranks\Operator\%vrdelete%.bc"
goto deldone
:gudel
set userr=<"Z:\ranks\Guest\%vrdelete%.bc"
del "Z:\usernames\%userr%\%vrdelete%.bc"
del "Z:\ranks\Guest\%vrdelete%.bc"
goto deldone
:admindel
if exist "Z:\usernames\%rusername%\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
del "Z:\usernames\%rusername%\%vrdelete%.bc"
if exist "Z:\ranks\Admin\%vrdelete%.bc" del "Z:\ranks\Admin\%vrdelete%.bc"
if exist "Z:\ranks\Director\%vrdelete%.bc" goto dirdel
if exist "Z:\ranks\Moderator\%vrdelete%.bc" goto model
if exist "Z:\ranks\Operator\%vrdelete%.bc" goto odel
if exist "Z:\ranks\Guest\%vrdelete%.bc" goto gudel
goto deldone
)
if exist "Z:\ranks\Admin\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
del "Z:\ranks\Admin\%vrdelete%.bc"
goto deldone
)
if exist "Z:\ranks\Director\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
goto dirdel
)
if exist "Z:\ranks\Moderator\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
goto model
)
if exist "Z:\ranks\Operator\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
goto odel
)
if exist "Z:\ranks\Guest\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
goto gudel
)
goto error
:directdel
if exist "Z:\usernames\%rusername%\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
del "Z:\usernames\%rusername%\%vrdelete%.bc"
if exist "Z:\ranks\Director\%vrdelete%.bc goto dirdel"
if exist "Z:\ranks\Moderator\%vrdelete%.bc goto model"
if exist "Z:\ranks\Operator\%vrdelete%.bc goto odel"
if exist "Z:\ranks\Guest\%vrdelete%.bc goto gudel"
goto deldone
)
if exist "Z:\ranks\Moderator\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
goto model
)
if exist "Z:\ranks\Operator\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
goto odel
)
if exist "Z:\ranks\Guest\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
goto gudel
)
goto error
:moddel
if exist "Z:\usernames\%rusername%\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
del "Z:\usernames\%rusername%\%vrdelete%.bc"
if exist "Z:\ranks\Moderator\%vrdelete%.bc" goto model
if exist "Z:\ranks\Operator\%vrdelete%.bc" goto odel
if exist "Z:\ranks\Guest\%vrdelete%.bc" goto gudel
goto deldone
)
if exist "Z:\ranks\Operator\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
goto odel
)
if exist "Z:\ranks\Guest\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
goto gudel
)
goto error
:opdel
if exist "Z:\usernames\%rusername%\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
del "Z:\usernames\%rusername%\%vrdelete%.bc"
if exist "Z:\ranks\Operator\%vrdelete%.bc" goto odel
if exist "Z:\ranks\Guest\%vrdelete%.bc" goto gudel
goto deldone
)
if exist "Z:\ranks\Guest\%vrdelete%.bc" (
rmdir /S /Q "Z:\%vrdelete%"
goto gudel
)
goto error
:guestdel
if not exist "Z:\usernames\%rusername%\%vrdelete%.bc" goto delerror
rmdir /S /Q "Z:\%vrdelete%"
del "Z:\usernames\%rusername%\%vrdelete%.bc"
if exist "Z:\ranks\Guest\%vrdelete%.bc" goto gudel
goto deldone
:delerror
cls
title Batch Chat - Delete Error
echo.
echo  You are not authorized to delete the room
echo                %vrdelete%!
echo.
pause >NUL
goto rdelete
:deldone
cls
title Batch Chat - Delete Successful
echo.
echo  The room %vrdelete% has been deleted!
echo.
pause >NUL
goto msg%rank%
:mdelete
cls
title Back Chat - Delete Error
echo.
echo  You cannot delete the main room!
echo.
pause >NUL
goto rdelete
:urankident
cd "%appdata%\Batch_Chat"
call "settings.bat"
goto msg%rank%
:pnotexist
title Rank - Who - Error
mode con cols=50 lines=15
cls
echo.
echo  That person does not exist!
echo.
pause >NUL
goto rank
:rank2
title Rank - What
mode con cols=50 lines=15
cls
echo.
echo  What rank do you want them to be?
echo.
echo  1.) exit
echo.
set /p srank=">"
if %srank%==1 goto urankident
if %srank%==Admin (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank3
)
if %srank%==Director goto rank3 (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank3
)
if %srank%==Moderator (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankDirector.bc" goto rank3
)
if %srank%==Operator (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankDirector.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankModerator.bc" goto rank3
)
if %srank%==Guest (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankDirector.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankModerator.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankOperator.bc" goto rank3
)
if %srank%==Dispicable (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankDirector.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankModerator.bc" goto rank3
)
if %srank%==admin (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank3
)
if %srank%==director goto rank3 (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank3
)
if %srank%==moderator (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankDirector.bc" goto rank3
)
if %srank%==operator (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankDirector.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankModerator.bc" goto rank3
)
if %srank%==guest (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankDirector.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankModerator.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankOperator.bc" goto rank3
)
if %srank%==dispicable (
if exist "Z:\usernames\%rusername%\rankAdmin.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankDirector.bc" goto rank3
if exist "Z:\usernames\%rusername%\rankModerator.bc" goto rank3
)
goto ranke
:ranke
title Rank - What - Error
mode con cols=50 lines=15
cls
echo.
echo  That rank does not exist!
echo  Make sure every letter is correct!
echo  Case sensitive!
echo.
pause >NUL
goto rank2
:rank3
echo %srank%> Z:\usernames\%urank%\rank.bc
echo %urank%'s rank has been changed to %srank% by %rusername%! >> "Z:\%room%\%room%.crm"
goto rankfin
:rankfin
title Rank - Success
mode con cols=50 lines=15
cls
echo.
echo  %urank% has been successfully ranked to %srank%
echo.
pause >NUL
echo %urank% has been ranked to %srank%
goto urankident
:help
mode con cols=50 lines=25
cls
title Batch Chat - Help
echo Help Menu
echo.
echo       1.) Commands
echo       2.) Commands + Descriptions
echo.
echo       3.) Exit
echo.
set /p comdsdesin=">"
if %comdsdesin%==1 goto helpcommands
if %comdsdesin%==2 goto helpcmdsdes
if %comdsdesin%==3 goto msg%rank%
goto help
:helpdim
title Help - /dimensions
cls
echo.
echo  This command changes the window dimensions.
echo.
pause >NUL
goto msg%rank%
:helpcommands
cls
title Batch Chat - Help Commands
echo Help Commands
echo.
echo   /help
echo   /help [command]
echo   /cls
echo   /rcls
echo   /disconnect
echo   /exit
echo   /host
echo   /rank
echo   /list
echo   /join
echo   /color
echo   /create
echo   /delete
echo   /plist
echo   /dimensions
echo   /connectinst
echo.
pause >NUL
goto help
:helpcmdsdes
cls
title Batch Chat - Help Commands
echo Help Commands + Descriptions
echo.
echo   /help - Shows you all commands
echo   /help [command] - Shows you the command           specified.
echo   /cls - Clears your screen only
echo   /rcls - Clears your room's log.
echo   /disconnect - Disconnect from chatroom
echo   /exit - Exit from chatroom
echo   /host - Changes your host computer
echo   /rank - Change users ranks
echo   /plist - List of Online Players
echo   /list - List of rooms
echo   /join - Join chatrooms
echo   /color - Change the color of the chat
echo   /create - Create a chatroom
echo   /delete - Delete a chatroom
echo   /dimensions - Change window dimensions.
echo   /connectinst - Instructions on how to
echo                    connect chats together.
echo.
pause >NUL
goto help
:connectinst
mode con cols=75 lines=42
cls
title Batch Chat - Connection Instructions
echo.
echo How to connect chats together.
echo.
echo  1.) How to connect Lan chats.
echo  2.) How to connect any chats together, over the internet.
echo.
echo  3.) Offical Chat Connection Info
echo.
echo  4.) Exit
echo.
set /p begi=">"
if %begi%==1 goto connectinstlan
if %begi%==2 goto connectinstany
if %begi%==3 goto connectoffchat
if %begi%==4 goto msg%rank%
goto connectinst
:connectinstlan
cls
title Batch Chat - Lan Connect Choice
echo.
echo  Lan Connect Choice
echo.
echo   Info: Host is the computer hosting the chat the Client if the computer     connecting to the Host.
echo.
echo   1.) Host Info
echo   2.) Client Info
echo.
echo   3.) Exit
echo.
set /p lanc=">"
if %lanc%==1 goto connectinsthlan
if %lanc%==2 goto connectinstclan
if %lanc%==3 goto connectinst
goto connectinstlan
:connectinsthlan
cls
title Batch Chat - Lan Host Connection Instructions
echo.
echo  Lan Host Connection Instructions.
echo.
echo   1.) No instructions really you are the host, when you start it up and      enter the PC Name you are the host.
echo.
echo  PC Name Obtaining Instructions
echo.
echo Type:
echo        1.) Windows 7
echo        2.) Windows Vista
echo        3.) Windows XP
echo.
echo        4.) Exit
echo.
set /p lann=">"
if %lann%==1 goto win7name
if %lann%==2 goto winvistname
if %lann%==3 goto winxpname
if %lann%==4 goto connectinst
goto connectinsthlan
:connectinstclan
cls
title Batch Chat - Lan Client Connection Instructions
echo.
echo  Lan Client Connection Instructions.
echo.
echo   1.) Obtain the Host computer name using the instructions below.
echo   2.) Once done take that name and enter it with the "/host" command.
echo   3.) When that is done you are now chatting on the host computer.
echo.
echo  PC Name Obtaining Instructions
echo.
echo Type:
echo        1.) Windows 7
echo        2.) Windows Vista
echo        3.) Windows XP
echo.
echo        4.) Exit
echo.
set /p lann=">"
if %lann%==1 goto win7name
if %lann%==2 goto winvistname
if %lann%==3 goto winxpname
if %lann%==4 goto connectinst
goto connectinstclan
:winvistname
cls
title Batch Chat - Windows Vista PC Name Instructions
echo.
echo  Windows Vista PC Name Instructions:
echo.
echo   1.) Goto your startmenu at the bottom lefthand corrner of your screen.
echo   2.) Click "Control Panel"
echo   3.) Click "System and Maintenance"
echo   4.) Click "System"
echo   5.) Now look for the section labeled "Computer Name" and take the          computer name and that is your computer name.
echo.
echo  Press enter to Continue.
echo.
pause >NUL
goto connectinstlan
:win7name
cls
title Batch Chat - Win 7 PC Name Instructions
echo.
echo  Win 7 PC Name Instructions
echo.
echo  No info yet.
echo.
echo  Press enter to Continue.
echo.
pause >NUL
goto connectinstlan
:winxpname
cls
title Batch Chat - Win XP PC Name Instructions
echo.
echo  Win XP PC Name Instructions
echo.
echo  No info yet.
echo.
echo  Press enter to Continue.
echo.
pause >NUL
goto connectinstlan
:connectinstany
cls
title Batch Chat - Chat Internet Connection Instructions
echo.
echo  Chat Internet Connection Instructions
echo.
echo  If you you are planning to make your own Batch Chat connection
echo  go to "Host Info," if you want to connect to someones Batch Chat
echo  go to "Client Info."  If you want to connect to the Offical
echo  Batch Chat host go to "Offical Chat Info"
echo.
echo  1.) Host Info
echo  2.) Client Info
echo.
echo  3.) Offical Chat Connection Info
echo.
echo  4.) Exit
echo.
set /p none=">"
if %none%==1 goto hostinfo
if %none%==2 goto clientinfo
if %none%==3 goto connectoffchat
if %none%==4 goto connectinst
goto connectinstany
:clientinfo
cls
title Batch Chat - Client Connection Instructions
echo.
echo Client Connection Instructions
echo.
echo  First some notes.  These are instructions how to connect to Hosts chats.
echo  If you want to be a Host look at the bottom of the window.
echo.
echo   1.) Download a program called Hamachi, make sure it is version 1.0.3.0.
echo   2.) Next make Hamachi a Service
echo       1.) By opening up Hamachi.
echo       2.) Click the bottom right hand corrner of the window.
echo       3.) Click "Preferences,"
echo       4.) Then click "System"
echo       5.) Click "Run Hamachi as a Service" possible authentication               requirement, also you should have to restart Hamachi now and open it       up again.
echo   3.) Once Hamachi is up again click the triangle at the bottom right hand   corrner of the Hamachi window.
echo   4.) Click "Join an existing network""
echo   5.) Now figure out the name and password (If the network has one.) of the  network.
echo   6.) Take that info and enter it in the window that has just come up for    Hamachi.
echo   7.) Click "Join"
echo   8.) And now you have joined the network.
echo   9.) Note when you want to use the chat over the internet you need to       leave Hamachi up.
echo  10.) Once open and in a room type the command "/host"
echo  11.) Now you need the information, get it by:
echo       1.) Put your cursor over the network
echo       2.) Copy the numbers beside "Owner:"
echo       3.) Thats the info you need.
echo  12.) Take that info and enter it when specifed with the /host command.
echo  13.) Now you should be connected to the host chat and be able to chat with other people also connected including the host.
echo.
echo  Type:
echo          1.) Exit
echo          2.) Host Info
echo          3.) Copy Hamachi download link to clipboard.
echo          4.) Offical Chat Connection Info
echo.
set /p cli=">"
if %cli%==1 goto connectinst
if %cli%==2 goto hostinfo
if %cli%==3 echo http://www.oldapps.com/Hamachi.php?app=b40fa067c8c2340957fd0779aaafd336| clip
if %cli%==4 goto connectoffchat
goto clientinfo
:hostinfo
cls
title Batch Chat - Host Connection Instructions
echo.
echo Host Connection Instructions
echo.
echo   1.) Download a program called Hamachi, make sure it is version 1.0.3.0.
echo   2.) Next make Hamachi a Service
echo       1.) By opening up Hamachi.
echo       2.) Click the bottom right hand corrner of the window.
echo       3.) Click "Preferences,"
echo       4.) Then click "System"
echo       5.) Click "Run Hamachi as a Service" possible authentication               requirement, also you should have to restart Hamachi now and open it       up again.
echo   3.) Once Hamachi is up again click the triangle at the bottom right hand   corrner of the Hamachi window.
echo   4.) Click "Create a New Network"
echo   5.) Type a name for the network and a password.
echo   6.) Click "Create"
echo   7.) Now your ready to give the client your info to connect to your chat.
echo.
echo  Type:
echo          1.) Exit
echo          2.) Client Info
echo          3.) Copy Hamachi download link to clipboard.
echo          4.) How to make it so you only need the username and there is no           password.
echo.
set /p beta=">"
if %beta%==1 goto connectinst
if %beta%==2 goto clientinfo
if %beta%==3 echo http://www.oldapps.com/Hamachi.php?app=b40fa067c8c2340957fd0779aaafd336| clip
if %beta%==4 goto rempass
goto hostinfo
:rempass
cls
title Batch Chat - How to remove the Hamachi Network Password
echo.
echo How to remove the Hamachi Network Password
echo.
echo   1.) Make sure you already have a Network set up, if not look at the bottom of the window for "Host Info."
echo   2.) Next open Hamachi.
echo   3.) Right-Click on your Network.
echo   4.) Click "Details."
echo   5.) Once in Details Click "Access" on the left of that little pop-up window.
echo   6.) Look under "Network Password" and you should see a checkbox that says, "Require a password to join the network" now un check it.  If it is already unchecked then the network doesn't need the password for people to join.
echo   7.) Click "Ok" at the bottom of the little pop-up window, and now you have a passwordless Network!
echo.
echo  Type:
echo          1.) Exit
echo          2.) Host Info
echo.
set /p hamn=">"
if %hamn%==1 goto connectinst
if %hamn%==2 goto hostinfo
goto rempass
:connectoffchat
cls
title Batch Chat - Offical Chat Connect
echo.
echo  Offical Batch Chat Connection
echo.
echo  In the program "Hamachi" enter the username
echo  "Batch_Chat" and connect then you will be
echo  able to connect to the offical chat.
echo.
pause >NUL
goto connectinst
:helpexit
mode con cols=30 lines=4
cls
title Help - /exit
echo.
echo This command exits you out of Batch Chat.
echo.
pause >NUL
goto msg%rank%
:helpplist
mode con cols=30 lines=4
cls
title Help - /plist
echo.
echo This command lets you view all of the players online.
echo.
pause >NUL
goto msg%rank%
:helpdis
mode con cols=30 lines=4
cls
title Help - /dis
echo.
echo This command exits you out of Batch Chat.
echo.
pause >NUL
goto msg%rank%
:helphost
mode con cols=30 lines=5
cls
title Help - /host
echo.
echo This command allows you to change your
echo host computer.
echo.
pause >NUL
goto msg%rank%
:helprcls
mode con cols=30 lines=4
cls
title Help - /rcls
echo.
echo This command clears your room's chat log.
echo.
pause >NUL
goto msg%rank%
:helpcls
mode con cols=30 lines=4
cls
title Help - /cls
echo.
echo This command clears your screen.
echo.
pause >NUL
goto msg%rank%
:helpcreate
mode con cols=30 lines=4
cls
title Help - /create
echo.
echo This command creates a new Batch Chat room.
echo.
pause >NUL
goto msg%rank%
:helpdel
mode con cols=30 lines=4
cls
title Help - /delete
echo.
echo This command deletes a Batch Chat room.
echo.
pause >NUL
goto msg%rank%
:helplist
mode con cols=30 lines=4
cls
title Help - /list
echo.
echo This command lists the Batch Chat rooms.
echo.
pause >NUL
goto msg%rank%
:helpcolor
cls
mode con cols=30 lines=5
title Help - /color
echo.
echo This command allows you to
echo change the Batch Chat color.
echo.
pause >NUL
goto msg%rank%
:helprank
mode con cols=30 lines=4
cls
title Help - /rank
echo.
echo This command allows you to rank people.
echo.
pause >NUL
goto msg%rank%
:helpjoin
mode con cols=30 lines=4
cls
title Help - /join
echo.
echo This command makes you join another Batch Chat room.
echo.
pause >NUL
goto msg%rank%
:helpconnectinst
mode con cols=30 lines=4
cls
title Help - /connectinst
echo.
echo This command gives you instructions on how to connect Batch Chats.
echo.
pause >NUL
goto msg%rank%