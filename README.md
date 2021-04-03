<img align="right" src="https://i.imgur.com/ib1tQWi.png" width="300" height="300"> 

# An R package to flirt with Twitch API

``` Rchamp ``` is an R package to interact :wink: with the twitch API. This makes calls to the helix version and V5 version (depreciated) of the Twitch api. 

But why :question-mark:, well...

If you love R & Twitch like I do, then this package saves you the effort of going 'off-platform' to another language to fetch the data and the headache of messy dense code when making calls to twich using `httr`. This package is not supported or affiliated with Twitch. By using it, you abide by their [dev agreement](https://www.twitch.tv/p/en/legal/developer-agreement/).  

# Installation
---
Using devtools from CRAN, do it like this :smart:

```R
devtools::install_github(mowgl-i/Rchamp)

```




# O-auth
----
Thanks to [Freguglia and Favstats](https://github.com/Freguglia/rTwitchAPI). They've created a function `twitch_auth()` to leverage the new helix api from Twitch. 

Make sure you have a valid [client id and secret](https://dev.twitch.tv/docs/authentication#registration) to access the api. Once you have it, you can leverage the `twitch_auth()` function which relies on the `use_this` package to edit the environment. Follow step by step below or [see here for more info on Twitch Authentication from Freguglia and Favstats](https://github.com/Freguglia/rTwitchAPI). 


### Step by step O-auth
---
 1. In console 
  ```R 
    
    usethis::edit_r_environ() 
    
  ```
 
 2. Edit file:  
  
  ```R 
  
  TWITCH_CLIENT_ID=YOUR_CLIENT_ID 
  TWITCH_CLIENT_SECRET=YOUR_CLIENT_SECRET
  
  ```
 3. Save and restart R

# Wana know how to use it? Check out the [vignette](https://github.com/mowgl-i/Rchamp/blob/Development/vignettes/Rchamp_readmet.md)

This project would have been way harder without the following open-source masterminds.
[Ogulcan Celik](https://github.com/OgulcanCelik/twitch-clip-chat) - Genius idea of locating clip location via `_next` and comment time stamp. 
[Freguglia and Favstats](https://github.com/Freguglia/rTwitchAPI) - The O-auth function to begin using the helix version of Twitch API.
