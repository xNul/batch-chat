![chat preview](http://i.imgur.com/6S5f1Qh.png)

Batch_Chat - v1.1
==========

A chat made in Batch of all things.
This chat was first created in 2011-2012 when I started
to get interested in programming.  I have recently (2014), for no logical reason,
started to improve it.  It cannot communicate over the internet directly,
it can only send messages locally on your network.  BUT you can use Hamachi
or a similar program to chat over the internet.

### Features:
  - Local Area Network (LAN) chat
  - Support for Virtual LAN IP's
  - Group chat
  - Colors (via colous binary)
  - Sound notification
  - Quick start
  - Help and command inheritance (for future ranks)
  - Argument -reset to reset all data
  - File encryption (very weak, look below for more info)

### Commands:
  - /afk - Says you've gone afk
  - /back - Says you're back
  - /cls - Clears your screen of previous text
  - /clsfile - Clears the chat file
  - /help - Lists all commands and their description
  - /history - Loads chat history
  - /host - Changes the host computer to a
          LAN/Virtual LAN IP
  - /list - Lists players online
  - /me - Say stuff about yourself
  - /quit or q - Quits the chat properly
    (PLEASE USE THIS OR ELSE /list IS USELESS!)
  - /say - Prints server message

[Command gallery](http://imgur.com/a/JeTJm)  
  




### Plans:
  - ~~Add custom network drive/custom setup~~
  - ~~Add file encryption with crypt binary~~
  - Add rooms
  - Add legitimate ranks
  - Add an update system (eh, might as well)
  - Add encryption command
  - Add more creative, fun, enjoyable commands
  - Add custom commands
  - Add encryption in the portion of the
      Batch_Chat itself where it actually
      encrypts the chat to stop possible
      decryption from viewing sourcecode.
  - Review chat bugs and delay due to encryption





### Compatible with:
  - Windows
  - Wine
  - DOSBox (if I remember correctly)

### Quick Instructions:
  1. run "Batch_Chat.bat"
  2. follow the onscreen instructions (tip: you need a host before there can be a client)
  3. run Batch Chat again
  4. type "/q" into the "Messages" window that comes up
  5. run Batch Chat again and everything should be working well.  You can now send messages using the Messages window

Note: when connecting to a host, you may need to be authenticated.
For example, my computer has a username and password, so client computers had to put
in my username and password beforehand in order to connect.  A good sign you need to
authenticate is if the Batch Chat keeps asking you to input the host computer's name.
To authenticate, open File Explorer and click Network on the left to view your Network Connections.
Find the host computer and try to double-click it.  It should prompt you with a login
if it is required.  After that, you should be able to see the shared "chat" folder.
If you do, you are all set.

There is a way to remove the restrictions though so no one needs your computer's
username and password.  To do this open the "Network and Sharing Center" on the left
click "Change advanced sharing settings".  Click the dropdown for "All Networks" then
click "Turn off password protected sharing" and turn on "Public folder sharing".

Note 2: if you wish to connect to a host over VLAN (like using Hamachi), then you
should go ahead and set up as a host and once the chat is working correctly, use the
"/host" command to switch to a VLAN host.

Note 3: if you are having trouble figuring out your computer name, I have created a
Batch file to help you out.  On the host computer, open "Batch.getComputerName.bat",
use the name it gives and you should be good.

Lastly, if you have any problems, just open up an issue and I'll be happy to help you.




### Color codes:

To use color codes while chatting, simply type "[&lt;insert color code&gt;]&lt;my text&gt;".
So, for example, I could type "[12]Hello [5]world[12]!" to send a message
that looks like this:

![color code example](http://i.imgur.com/BirW5sj.png)

Here's a key for the color codes:

![colous color codes](http://i.imgur.com/705yk3s.png)





### File encryption:

The file encryption I implemented on this is *extremely* weak.  Not that I expect
highly sensitive material to be sent using my horrible Batch Chat, it's just the
bare minimum to prevent users who aren't familiar with programming from giving
themselves a higher rank (if a ranking system is ever implemented) or changing
what people say.  People can clear the chat log unfortunately, but
nothing too devious.

If you want to make it harder for people to decrypt the chat, you can do two
things. 1, you can change the encryption/decryption key from the default key that
I use to a different one. And 2, it is possible to store the chat in an exe file.
That way the encryption/decryption key isn't as accessible.  For more info,
look into [this](http://www.f2ko.de/en/b2e.php) program.
