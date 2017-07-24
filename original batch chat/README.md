Old Batch Chat - v1.9.2
==========

A chat made in Batch of all things.
This is the original version of the chat I created in 2011-2012.
It has some nice features like rooms, fully implemented ranks, etc,
but it has a lot of bugs, is extremely vulnerable x10, and has messy/
inefficient code. Like the newer chat, it cannot communicate over the
internet directly, it can only send messages locally on your network.
BUT you can use Hamachi or a similar program to chat over the internet.

### Features:
  - Local Area Network (LAN) chat
  - Support for Virtual LAN IP's
  - Group chat
  - Colors (via colous binary)
  - Help and command inheritance
  - Ranks!
  - Rooms!
  - **unfinished**: Private messaging

### Commands:
  - /help - Shows you all commands
  - /help [command] - Shows you the command specified.
  - /cls - Clears your screen only
  - /rcls - Clears your room's log.
  - /disconnect - Disconnect from chatroom
  - /exit - Exit from chatroom
  - /host - Changes your host computer
  - /rank - Change users ranks
  - /plist - List of Online Players
  - /list - List of rooms
  - /join - Join chatrooms
  - /color - Change the color of the chat
  - /create - Create a chatroom
  - /delete - Delete a chatroom
  - /dimensions - Change window dimensions.
  - /connectinst - Instructions on how to connect chats together.
  - /msg - **unfinished**: Open a Private Chat with another player
  - /chat - **unfinished**: Return to a Private Chat with another player





### Color codes:

To use color codes while chatting, simply type "[&lt;insert color code&gt;]&lt;my text&gt;".
So, for example, I could type "[12]Hello [5]world[12]!" to send a message
that looks like this:

![color code example](http://i.imgur.com/BirW5sj.png)

Here's a key for the color codes:

![colous color codes](http://i.imgur.com/705yk3s.png)




### Becoming Admin:

Like I said, this version of the chat is beyond vulnerable.
When I first created the chat, I wasn't designing it for any form
of real use, just experimenting with Batch, so the only way to become
Admin, use the ranking system, and commands higher than guest, is to
go through the temporary files and make yourself an Admin.

To do this, the first file you need to modify is located in your
roaming AppData in the folder "Batch_Chat".  Its name is "settings.bat"
and all you need to do is open it up, change "Guest" to "Admin".  Then,
you have to browse to "C:\chat", open the "players" folder, find your
folder and change "[Guest]" to "[Admin]".  Lastly, open the "usernames"
folder, open the folder with your username, change all instances of
"Guest" to "Admin" both in the file names and in the files themselves.

That's it!  Now you should be an Admin and all Admin
commands ready for you to use.
