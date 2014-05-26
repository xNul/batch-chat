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
if "%1" == "-reset" goto net
title Batch Chat - %version%
goto config

::Adds required files to data directory
:config
cd "%appdata%\Batch_Chat"
if not exist "colous.exe" (
cd "%cdd%"
xcopy "colous.exe" "%appdata%\Batch_Chat"
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
::Adds your username and other data into the chat drive
if exist "Z:\users\%name%" echo Name taken && pause >NUL && goto start
if not exist "Z:\users\%name%" mkdir "Z:\users\%name%"
::Creates chat file
if not exist "Z:\chat.crm" echo > "Z:\chat.crm"
::Sets the place where it is supposed to be
set presection=chat
goto load
:load
::Puts your name and rank in a file for future use
echo set name=%name%> "settings.bat"
echo set rank=Guest>> "settings.bat"
goto %presection%





:chat
::Resets the directory to the files
cd "%cdd%"
::Starts the messages window
start Batch-Chat.bat messages
::Assures that you are in the Data folder
cd "%appdata%\Batch_Chat"
::Calls the latest variables from the user data files
call "settings.bat"
::Remake user folder
mkdir "Z:\users\%name%"
::Resize window
mode con cols=80lines=20
::Reverts back to the Data directory
cd "%appdata%\Batch_Chat"
cls
title Batch Chat - %room%
echo Lobby
echo.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
::Prints chat to the screen and sets the last line to a variable
for /f "tokens=1,2,3 delims=" %%a IN (Z:\chat.crm) DO (colous Writesec "%%a"&set check=%%a)
::Saves the last line to another variable
set old=%check%
goto loop

:loop
::Assures that you are in the Data folder
cd "%appdata%\Batch_Chat"
::Calls the latest variables from the user data files
call "settings.bat"
::Checks to see if a file is there so that it can excute a certain command
if exist "Z:\users\%name%\cls.dat" goto cls
::Checks if command to quit has been made
if exist "Z:\users\%name%\quit.dat" rmdir /S /Q "Z:\users\%name%"&exit
::Prints history to screen
if exist "Z:\users\%name%\history.dat" goto history
::Prints chat to the screen and sets the last line to a variable
for /f "tokens=1,2,3 delims=" %%a IN (Z:\chat.crm) DO (set check=%%a)
::Checks to see if the last line has changed (a new message has been sent) if it has then it prints it to the screen, makes the directory the files, sets it as the new old variable, and plays a tune if a file isn't there
if NOT "%check%" == "%old%" (
  colous Writesec "%check%"
  set old=%check%
  cd "%cdd%"
  if not exist "Z:\users\%name%\ping.dat" (
    madplay -Q ping.mp3
  ) else (
    del /F "Z:\users\%name%\ping.dat"
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
if %ERRORLEVEL% == 1 goto setup1
if %ERRORLEVEL% == 2 goto hostchange
if %ERRORLEVEL% == 3 goto resetstart
if %ERRORLEVEL% == 4 exit
goto net
:winxpsetup
set /p step=">"
if %step% == 1 goto setup1
if %step% == 2 goto hostchange
if %step% == 3 goto resetstart
if %step% == 4 exit
goto net

:setup1
::Instructions to setup Sharing for the network drive
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
echo  to reinstall the Batch Chat due to any errors.
echo.
echo    Do you want to continue? [Y/N]
echo.
set /p resetinput=">"
if "%resetinput%" == "Y" goto stepreset
if "%resetinput%" == "y" goto stepreset
if "%resetinput%" == "N" goto net
if "%resetinput%" == "n" goto net
goto resetstart


:: MESSAGES

:messagesstart
::Going back to the Data folder
cd "%appdata%\Batch_Chat"
::Calling variables
call "settings.bat"
::Sends a joining message to the chat
echo [16]%TIME:~0,2%:%TIME:~3,2% [10]%name% [9]has joined>> "Z:\chat.crm"&&echo chat>> "Z:\users\%name%\ping.dat"
goto messages

:messages
::Display settings
color F0
mode con cols=30lines=2
title Messages
::Still setting the Data folder
cd "%appdata%\Batch_Chat"
::Still calling variables
call "settings.bat"
::Goes to your ranks commands
goto msg%rank%




:msgAdmin
cls
::Prompts for users input
set /p message=Say: 
::Checks to see if the msg is a command
if /I "%message%" == "/clsfile" echo > "Z:\chat.crm"&&goto msg%rank%
if /I "%message%" == "/say" goto say
goto commandsDirector
:inheritAdmin
::If the msg is not a command it is a msg so it sends it into the chat
echo [16]%TIME:~0,2%:%TIME:~3,2% [09]%rank% [08]%name%: [15]%message%>> "Z:\chat.crm"&echo chat> "Z:\users\%name%\ping.dat"
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
echo [16]%TIME:~0,2%:%TIME:~3,2% [12]%rank% [08]%name%: [15]%message%>> "Z:\chat.crm"&echo chat> "Z:\users\%name%\ping.dat"
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
echo [16]%TIME:~0,2%:%TIME:~3,2% [13]%rank% [08]%name%: [15]%message%>> "Z:\chat.crm"&echo chat> "Z:\users\%name%\ping.dat"
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
echo [16]%TIME:~0,2%:%TIME:~3,2% [14]%rank% [08]%name%: [15]%message%>> "Z:\chat.crm"&echo chat> "Z:\users\%name%\ping.dat"
goto msgOperator

:msgGuest
cls
::Prompts for users input
set /p message=Say: 
::Checks to see if the msg is a command
:commandsGuest
if /I "%message%" == "/afk" (
  echo hshsfks >> "Z:\users\%name%\ping.dat"
  echo [05] %name% is afk>> "Z:\chat.crm"
  goto messages
)
if /I "%message%" == "/back" (
  echo hshsfks >> "Z:\users\%name%\ping.dat"
  echo [05] %name% is back>> "Z:\chat.crm"
  goto messages
)
if /I "%message%" == "/list" (
  mode con cols=30lines=10
  echo.
  dir /B /P "Z:\users"
  echo.
  pause >NUL
  goto messages
)
if /I "%message%" == "/history" echo hshsfks >> "Z:\users\%name%\history.dat"&goto messages
if /I "%message%" == "/me" goto me
goto commandsHater
:inheritGuest
::If the msg is not a command it is a msg so it sends it into the chat
echo [16]%TIME:~0,2%:%TIME:~3,2% [15]%rank% [08]%name%: [15]%message%>> "Z:\chat.crm"&echo chat> "Z:\users\%name%\ping.dat"
goto msgGuest

:msgHater
cls
::Prompts for users input
set /p message=Say: 
::Checks to see if the msg is a command
:commandsHater
if /I "%message%" == "/host" goto hostchange
if /I "%message%" == "/help" goto helpMain
if /I "%message%" == "/cls" echo hshsfks >> "Z:\users\%name%\cls.dat"&goto messages
if /I "%message%" == "/quit" (
  echo chat> "Z:\users\%name%\ping.dat"
  echo hshsfks >> "Z:\users\%name%\quit.dat"
  echo [16]%TIME:~0,2%:%TIME:~3,2% [10]%name% [9]has left>> "Z:\chat.crm"
  exit
)
if /I "%message%" == "/q" (
  echo chat> "Z:\users\%name%\ping.dat"
  echo hshsfks >> "Z:\users\%name%\quit.dat"
  echo [16]%TIME:~0,2%:%TIME:~3,2% [10]%name% [9]has left>> "Z:\chat.crm"
  exit
)
if /I "%message:~0,1%" == "/" goto notCommand
goto inherit%rank%
:inheritHater
::If the msg is not a command it is a msg so it sends it into the chat
echo [16]%TIME:~0,2%:%TIME:~3,2% [04]%rank% [08]%name%: [15]%message%>> "Z:\chat.crm"&echo chat> "Z:\users\%name%\ping.dat"
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
net use Z: /DELETE /y
cls
net use Z: \\%push%\chat
if exist "Z:\users\%name%" rmdir /S /Q "Z:\users\%name%"
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
del /F "Z:\users\%name%\cls.dat"
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

:say
cls
set /p say="> "
echo chat> "Z:\users\%name%\ping.dat"
echo [19] CONSOLE: %say%>> "Z:\chat.crm"
goto messages

:me
cls
set /p me="> "
echo chat> "Z:\users\%name%\ping.dat"
echo [05] * %name% %me%>> "Z:\chat.crm"
goto messages

:history
cls
echo Lobby
echo.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
for /f "tokens=1,2,3 delims=" %%a IN (Z:\chat.crm) DO (colous Writesec "%%a"&set check=%%a)
del /F "Z:\users\%name%\history.dat"
goto loop