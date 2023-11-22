# Discord for powershell  
### NOTE: THIS MIGHT GET YOU BANNED BECAUSE THIS IS AGAINST DISCORD TOS I AM NOT RESPONSIBLE FOR YOU GETTING BANNED I AM JUST A GUY WHO WRITES CODE FOR FUN  
this is some code I wrote that sends discord messages in powershell via http post requests

### example  
[![discord test](https://i.imgur.com/RvbZkyr.png)](https://www.youtube.com/watch?v=bR4b6MI4qO8 "discord test")  
[![theme test](https://i.imgur.com/aCXWZCC.png)](https://www.youtube.com/watch?v=P8yfwFWvinA "theme test")

## Requirements  
* A discord account *(not bot)* token | you can learn to get yours [here](https://www.youtube.com/watch?v=DTFXUfzbmWE)  
* Discord developer mode *(to get the channel id)* | you can enable it in the advanced tab in settings
## DOCS  
* Custom Emotes  
Emotes are  stored in ***Emotes.txt*** and are in the format `emote_name emote_url`

* Custom Signatures  
Signatures can be found on line 31 of ***discord.ps1*** and can be disabled if you make the variable `$signature` blank

* Custom Themes  
Themes can be applied with `/themes` and new themes can be added / edited via ***theme.ps1***.