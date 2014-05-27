@echo off
::Is win XP?
ver | findstr "Windows XP"
cls
if %ERRORLEVEL% == 1 set winxp=true
::Check to see if the network has been setup yet
if not exist "%appdata%\Batch_Chat" goto net
::Saves the directory of the chat
set cdd=%cd%
::Specifies the room you are in
set room=Lobby
::Checks for the messages arguement for the messages window
if "%1" == "messages" goto messagesstart
::Checks for the reset argument to reset the batch chat
if "%1" == "-reset" goto resetstart
title Batch Chat - v1.2
goto config

::Adds required files to data directory
:config
cd "%appdata%\Batch_Chat"
if not exist "colous.exe" (
cd "%cdd%"
xcopy "colous.exe" "%appdata%\Batch_Chat"
cd "%appdata%\Batch_Chat"
)
cd "%appdata%\Batch_Chat"
if not exist "crypt.exe" (
cd "%cdd%"
xcopy "crypt.exe" "%appdata%\Batch_Chat"
cd "%appdata%\Batch_Chat"
)
goto start

:start
::Some display settings...
color F0
mode con cols=40lines=10
::Preparing to save data
cd "%appdata%\Batch_Chat"
::Checking to see if you have already set your username and other settings, if so skips this part
if exist "settings.bat" goto chat
::Asks for you to enter your name to be used for chatting
echo.
echo  What is your name?
echo.
set /p name=">"
::If special network drive config exists
set networkdrive=Z:
if exist "networkdrive.bat" call "networkdrive.bat"
::Adds your username and other data into the chat drive
if exist "%networkdrive%\users\%name%" (
  cls
  echo.
  echo %name% is taken.
  echo.
  pause >NUL
  goto start
)
if not exist "%networkdrive%\users\%name%" mkdir "%networkdrive%\users\%name%"
::Creates chat file
if not exist "%networkdrive%\chat.crm" echo > "%networkdrive%\chat.crm"
if exist "networkdrive.bat" del /F "networkdrive.bat"
::Sets the place where it is supposed to be
set presection=chat
goto load

::Methods

:load
::Puts your name and rank in a file for future use
echo set name=%name%> "in.bat"
echo set rank=Guest>> "in.bat"
echo set networkdrive=%networkdrive%>> "in.bat"
crypt -encrypt -key "7;;d;ss;9&*((*302!)_-!@#(021" -infile "in.bat" -outfile "settings.bat">NUL
del /F "in.bat"
goto %presection%

:decryptsettings
cd "%appdata%\Batch_Chat"
crypt -decrypt -key "7;;d;ss;9&*((*302!)_-!@#(021" -infile "settings.bat" -outfile "out.bat">NUL
call "out.bat"
del /F "out.bat"
goto %presection%

:sendmsg
crypt -decrypt -key "&492((@$*9Hfyibni#*9n8034-=_)r9" -infile "%networkdrive%\chat.crm" -outfile "%appdata%\Batch_Chat\chatout.crm">NUL
echo %sendmessage%>> "%appdata%\Batch_Chat\chatout.crm"
del /F "%networkdrive%\chat.crm"
crypt -encrypt -key "&492((@$*9Hfyibni#*9n8034-=_)r9" -infile "%appdata%\Batch_Chat\chatout.crm" -outfile "%networkdrive%\chat.crm">NUL
del /F "%appdata%\Batch_Chat\chatout.crm"
goto %presection%





:chat
::Resets the directory to the files
cd "%cdd%"
::Starts the messages window
start Batch_Chat.bat messages
::Assures that you are in the Data folder
cd "%appdata%\Batch_Chat"
::Calls the latest variables from the user data files
set presection=chatcall
goto decryptsettings
:chatcall
::Remake user folder
mkdir "%networkdrive%\users\%name%"
::Resize window
mode con cols=80lines=20
::Reverts back to the Data directory
cd "%appdata%\Batch_Chat"
cls
title Batch Chat - %room%
echo Lobby
echo.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
::Decrypts and prints chat to the screen and sets the last line to a variable
crypt -decrypt -key "&492((@$*9Hfyibni#*9n8034-=_)r9" -infile "%networkdrive%\chat.crm" -outfile "%appdata%\Batch_Chat\outloop.crm"
for /f "tokens=1,2,3 delims=" %%a IN ("%appdata%\Batch_Chat\outloop.crm") DO (colous Writesec "%%a"&set check=%%a)
del /F "%appdata%\Batch_Chat\outloop.crm">NUL
::Saves the last line to another variable
set old=%check%
goto loop

:loop
::Assures that you are in the Data folder
cd "%appdata%\Batch_Chat"
::Checks to see if a file is there so that it can excute a certain command
if exist "%networkdrive%\users\%name%\cls.dat" goto cls
::Checks if command to quit has been made
if exist "%networkdrive%\users\%name%\quit.dat" rmdir /S /Q "%networkdrive%\users\%name%"&exit
::Prints history to screen
if exist "%networkdrive%\users\%name%\history.dat" goto history
::Decrypts and prints chat to the screen and sets the last line to a variable
crypt -decrypt -key "&492((@$*9Hfyibni#*9n8034-=_)r9" -infile "%networkdrive%\chat.crm" -outfile "%appdata%\Batch_Chat\outloop.crm"
for /f "usebackq tokens=1,2,3 delims=" %%a IN (`type "%appdata%\Batch_Chat\outloop.crm"`) DO (set check=%%a)
del /F "%appdata%\Batch_Chat\outloop.crm">NUL
::Checks to see if the last line has changed (a new message has been sent) if it has then it prints it to the screen, makes the directory the files, sets it as the new old variable, and plays a tune if a file isn't there
if NOT "%check%" == "%old%" (
  colous Writesec "%check%"
  set old=%check%
  cd "%cdd%"
  if not exist "%networkdrive%\users\%name%\ping.dat" (
    madplay -Q ping.mp3
  ) else (
    del /F "%networkdrive%\users\%name%\ping.dat"
  )
)
goto loop





:net
::Seting up the network drive
title Network Setup
cls
echo.
echo  Press 1 to setup. After
echo  pressing 1 follow the
echo  instructions. Press
echo  2 to reset all data.
echo.
echo   1.) Setup as host
echo   2.) Setup as client
echo   3.) Reset
echo   4.) Exit
echo.
::Checks to see if there needs to be a different setup for a diff OS
if winxp == true goto winxpsetup
choice /c 1234>NUL
if "%ERRORLEVEL%" == "1" goto setup
if "%ERRORLEVEL%" == "2" goto hostchange
if "%ERRORLEVEL%" == "3" goto resetstart
if "%ERRORLEVEL%" == "4" exit
goto net
:winxpsetup
set /p step="> "
if "%step%" == "1" goto setup
if "%step%" == "2" goto hostchange
if "%step%" == "3" goto resetstart
if "%step%" == "4" exit
goto net

:setup
cls
echo.
echo   Do you have a pre-existing
echo  drive that you wish to host the
echo  chat on? [Y/N]
echo.
set /p answer="> "
if /I "%answer%" == "Y" goto setupnet
if /I "%answer%" == "N" goto setup1
goto setup

::Instructions to setup sharing for the network drive
:setup1
if not exist "C:\chat" mkdir "C:\chat"
if not exist "C:\chat\users" mkdir "C:\chat\users"
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
echo   11.) Click "Share" at the bottom
echo          of the window.
echo   12.) if prompted accept administrator
echo                      access.
echo   13.) Exit out of everything.
echo.
echo     Press Enter to Continue.
pause >NUL
goto setup2

:setup2
::Creates the network drive
net use Z: \\%computername%\chat
::Creates the Data folder
if not exist "%appdata%\Batch_Chat" mkdir "%appdata%\Batch_Chat"
cls
echo.
echo  Setup completed!
echo.
echo  Press Enter to exit.
echo.
pause >NUL
exit

:setupnet
cls
echo.
echo  What is the directory of
echo   the network drive where
echo   you want to store the chat?
echo.
echo      Ex: Z:\chat folder\foo
echo.
set /p networkdrive="> "
if not exist "%networkdrive%" goto drivenot
if not exist "%networkdrive%\users" mkdir "%networkdrive%\users"
if not exist "%appdata%\Batch_Chat" mkdir "%appdata%\Batch_Chat"
echo set networkdrive=%networkdrive%> "%appdata%\Batch_Chat\networkdrive.bat"
goto setupnetcomplete

:drivenot
cls
echo.
echo  "%networkdrive%" does not exist.
echo.
echo   Press Enter to return.
pause >NUL
goto setupnet

:setupnetcomplete
cls
echo.
echo  Setup completed!
echo.
echo  Press Enter to exit.
echo.
pause >NUL
exit

:: RESET

:stepreset
::Remove data directory
rmdir /S /Q "%appdata%\Batch_Chat"
::Disconnect network drive
net use Z: /delete /y
::Delete shared folder
rmdir /S /Q "C:\chat"
cls
echo.
echo  Reset complete!
echo.
echo Press Enter to Return.
echo.
pause >NUL
goto net

:resetstart
title Batch Chat - Reset
cls
echo.
echo  If you continue this will remove all settings and
echo  chat data from your computer, thus allowing you
echo  to restart the Batch Chat fresh due to any errors.
echo.
echo    Do you want to continue? [Y/N]
echo.
set /p resetinput=">"
if /I "%resetinput%" == "Y" goto stepreset
if /I "%resetinput%" == "N" goto net
goto resetstart


:: MESSAGES

:messagesstart
::Going back to the Data folder
cd "%appdata%\Batch_Chat"
::Calling variables
set presection=messagestartcall
goto decryptsettings
:messagestartcall
::Sends a joining message to the chat
set presection=joinmsg
set sendmessage=[16]%TIME:~0,2%:%TIME:~3,2% [10]%name% [9]has joined
goto sendmsg
:joinmsg
echo chat>> "%networkdrive%\users\%name%\ping.dat"
goto messages

:messages
::Display settings
color F0
mode con cols=30lines=2
title Messages
::Still setting the Data folder
cd "%appdata%\Batch_Chat"
::Goes to your ranks commands
goto msg%rank%




:msgAdmin
cls
::Prompts for users input
set /p message=Say: 
::Checks to see if the msg is a command
if /I "%message%" == "/clsfile" echo > "%networkdrive%\chat.crm"&&goto msg%rank%
if /I "%message%" == "/say" goto say
goto commandsDirector
:inheritAdmin
::If the msg is not a command it is a msg so it sends it into the chat
set presection=adminMessage
set sendmessage=[16]%TIME:~0,2%:%TIME:~3,2% [09]%rank% [08]%name%: [15]%message%
goto sendmsg
:adminMessage
echo chat> "%networkdrive%\users\%name%\ping.dat"
goto msgAdmin

:msgDirector
cls
::Prompts for users input
set /p message=Say: 
::Checks to see if the msg is a command
:commandsDirector
goto commandsModerator
:inheritDirector
::If the msg is not a command it is a msg so it sends it into the chat
set presection=directorMessage
set sendmessage=[16]%TIME:~0,2%:%TIME:~3,2% [12]%rank% [08]%name%: [15]%message%
goto sendmsg
:directorMessage
echo chat> "%networkdrive%\users\%name%\ping.dat"
goto msgDirector

:msgModerator
cls
::Prompts for users input
set /p message=Say: 
::Checks to see if the msg is a command
:commandsModerator
goto commandsOperator
:inheritModerator
::If the msg is not a command it is a msg so it sends it into the chat
set presection=moderatorMessage
set sendmessage=[16]%TIME:~0,2%:%TIME:~3,2% [13]%rank% [08]%name%: [15]%message%
goto sendmsg
:moderatorMessage
echo chat> "%networkdrive%\users\%name%\ping.dat"
goto msgModerator

:msgOperator
cls
::Prompts for users input
set /p message=Say: 
::Checks to see if the msg is a command
:commandsOperator
goto commandsGuest
:inheritOperator
::If the msg is not a command it is a msg so it sends it into the chat
set presection=operatorMessage
set sendmessage=[16]%TIME:~0,2%:%TIME:~3,2% [14]%rank% [08]%name%: [15]%message%
goto sendmsg
:operatorMessage
echo chat> "%networkdrive%\users\%name%\ping.dat"
goto msgOperator

:msgGuest
cls
::Prompts for users input
set /p message=Say: 
::Checks to see if the msg is a command
:commandsGuest
if /I "%message%" == "/afk" (
  echo hshsfks >> "%networkdrive%\users\%name%\ping.dat"
  set presection=messages
  set sendmessage=[05] %name% is afk
  goto sendmsg
)
if /I "%message%" == "/back" (
  echo hshsfks >> "%networkdrive%\users\%name%\ping.dat"
  set presection=messages
  set sendmessage=[05] %name% is back
  goto sendmsg
)
if /I "%message%" == "/list" (
  mode con cols=30lines=10
  echo.
  dir /B /P "%networkdrive%\users"
  echo.
  pause >NUL
  goto messages
)
if /I "%message%" == "/history" echo hshsfks >> "%networkdrive%\users\%name%\history.dat"&goto messages
if /I "%message%" == "/me" goto me
goto commandsHater
:inheritGuest
::If the msg is not a command it is a msg so it sends it into the chat
set presection=guestMessage
set sendmessage=[16]%TIME:~0,2%:%TIME:~3,2% [15]%rank% [08]%name%: [15]%message%
goto sendmsg
:guestMessage
echo chat> "%networkdrive%\users\%namfe%\ping.dat"
goto msgGuest

:msgHater
cls
::Prompts for users input
set /p message=Say: 
::Checks to see if the msg is a command
:commandsHater
if /I "%message%" == "/host" goto hostchange
if /I "%message%" == "/help" goto helpMain
if /I "%message%" == "/cls" echo hshsfks >> "%networkdrive%\users\%name%\cls.dat"&goto messages
if /I "%message%" == "/quit" goto quit
if /I "%message%" == "/q" goto quit
if /I "%message:~0,1%" == "/" goto notCommand
goto inherit%rank%
:inheritHater
::If the msg is not a command it is a msg so it sends it into the chat
set presection=haterMessage
set sendmessage=[16]%TIME:~0,2%:%TIME:~3,2% [04]%rank% [08]%name%: [15]%message%
goto sendmsg
:haterMessage
echo chat> "%networkdrive%\users\%name%\ping.dat"
goto msgHater




:hostchange
mode con cols=40lines=15
cls
echo.
echo  There are two ways to connect
echo  to other chats.  1 is to only
echo  chat with people on your router
echo  (LAN) or 2 use a Virtual LAN
echo  network, program such as
echo  Hamachi.  For 1 you only need
echo  the persons computer name, like
echo  Bobjoe-PC.  For 2 you need their
echo  Virtual LAN IP.
echo.
echo  Press Enter to input one of these
echo         two things, or exit.
echo.
pause >NUL
goto hostchange2

:hostchange2
cls
echo.
echo  Enter "computer name" or
echo     Virtual LAN IP.
echo.
echo  type "exit" to Exit.
echo.
set /p push=">"
if "%push%" == "exit" goto messages
net use %networkdrive% /DELETE /y
cls
net use %networkdrive% \\%push%\chat
if exist "%networkdrive%\users\%name%" rmdir /S /Q "%networkdrive%\users\%name%"
del /F "%appdata%\Batch_Chat\settings.bat"
set presection=hostchange3
goto load

:hostchange3
::Creates the Data folder
if not exist "%appdata%\Batch_Chat" mkdir "%appdata%\Batch_Chat"
cls
echo.
echo  You are now connected to their chat!
echo    Press enter to restart the chat!
echo.
pause >NUL
cd "%cdd%"
taskkill /f /fi "WINDOWTITLE eq Batch Chat - %room%
exit

:helpMain
mode con cols=45lines=10
cls
echo.
echo  What would you like to do?
echo.
echo   1.) View all of the commands?
echo   2.) View your commands?
echo    3.) Exit
echo.
if winxp == true goto winxphelpMain
choice /c 123>NUL
if "%ERRORLEVEL%" == "1" mode con cols=45lines=20&goto helpCommandsAll
if "%ERRORLEVEL%" == "2" mode con cols=45lines=20&goto helpYour%rank%
if "%ERRORLEVEL%" == "3" goto messages
goto helpMain
:winxphelpMain
set /p helpMain=">"
if "%helpMain%" == "1" goto helpCommandsAll
if "%helpMain%" == "2" goto helpYour%rank%
if "%helpMain%" == "3" goto messages
goto helpMain

:helpCommandsAll
cls
echo.
echo  All of the commands:
set tempRank=%rank%
set rank=All
goto helpAdmin
:helpInheritAll
set rank=%tempRank%
set tempRank=""
echo.
echo   Press enter to return
echo.
pause >NUL
goto helpMain

:helpYourAdmin
cls
echo.
echo  Your commands are:
:helpAdmin
echo   /clsfile - Clears the chat file
echo   /say - Prints server message
goto helpDirector
:helpInheritAdmin
echo.
echo   Press enter to return
echo.
pause >NUL
goto helpMain

:helpYourDirector
cls
echo.
echo  Your commands are:
:helpDirector
goto helpModerator
:helpInheritDirector
echo.
echo   Press enter to return
echo.
pause >NUL
goto helpMain

:helpYourModerator
cls
echo.
echo  Your commands are:
:helpModerator
goto helpOperator
:helpInheritModerator
echo.
echo   Press enter to return
echo.
pause >NUL
goto helpMain

:helpYourOperator
cls
echo.
echo  Your commands are:
:helpOperator
goto helpGuest
:helpInheritOperator
echo.
echo   Press enter to return
echo.
pause >NUL
goto helpMain

:helpYourGuest
cls
echo.
echo  Your commands are:
:helpGuest
echo   /afk - Says you've gone afk
echo   /back - Says you're back
echo   /list - Lists players online
echo   /me - Say stuff about yourself
echo   /history - Loads chat history
goto helpHater
:helpInheritGuest
echo.
echo   Press enter to return
echo.
pause >NUL
goto helpMain

:helpYourHater
cls
echo.
echo  Your commands are:
:helpHater
echo   /host - Changes the host computer to a
echo           LAN/Virtual LAN IP
echo   /cls - Clears your screen of previous text
echo   /quit or q - Quits the chat properly
goto helpInherit%rank%
:helpInheritHater
echo.
echo   Press enter to return
echo.
pause >NUL
goto helpMain

:cls
cls
echo Lobby
echo.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
del /F "%networkdrive%\users\%name%\cls.dat"
goto loop

:notCommand
mode con cols=40lines=8
title Invalid Command
cls
echo.
echo  "%message%" is an invalid command
echo.
echo   Press Enter to exit.
pause >NUL
goto messages

:quit
echo chat> "%networkdrive%\users\%name%\ping.dat"
echo hshsfks >> "%networkdrive%\users\%name%\quit.dat"
set presection=quitMessage
set sendmessage=[16]%TIME:~0,2%:%TIME:~3,2% [10]%name% [9]has left
goto sendmsg
:quitMessage
exit

:say
cls
set /p say="> "
echo chat> "%networkdrive%\users\%name%\ping.dat"
set presection=messages
set sendmessage=[19] CONSOLE: %say%
goto sendmsg

:me
cls
set /p me="> "
echo chat> "%networkdrive%\users\%name%\ping.dat"
set presection=messages
set sendmessage=[05] * %name% %me%
goto sendmsg

:history
cls
echo Lobby
echo.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
crypt -decrypt -key "&492((@$*9Hfyibni#*9n8034-=_)r9" -infile "%networkdrive%\chat.crm" -outfile "%appdata%\Batch_Chat\hisout.crm">NUL
for /f "usebackq tokens=1,2,3 delims=" %%a IN (`type "%appdata%\Batch_Chat\hisout.crm"`) DO (colous Writesec "%%a"&set check=%%a)
del /F "%appdata%\Batch_Chat\hisout.crm"
del /F "%networkdrive%\users\%name%\history.dat"
goto loop