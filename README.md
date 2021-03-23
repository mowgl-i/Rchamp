# Rchamp - Rpackage to flirt with Twitch API

![image](https://i.imgur.com/ib1tQWi.png)

----

This use this package to interact with the twitch API. This uses the Hexlix version and V5 version of the api. The main purpose for the creation of this package is to access chat from Twitch Clips. It's limited to clips that have not been taken down and for clips for which a VOD exists. 


# O-auth
----

Make sure you have a valid [client id and secret](https://dev.twitch.tv/docs/authentication#registration) to access the api. Once you have it, you can leverage the `twitch_auth()` function which relies on the `use_this` package to edit the environment. [See here](https://github.com/Freguglia/rTwitchAPI). 

