server = 'irc.chat.twitch.tv'
port = 6667
nickname = 'mowgl_i'
token = 'oauth:6gasi0wylcqm7tm8wv062ikpwgesnr'
channel = '#xqcow'

library(stringi)
library(websocket)

live_socket <- function(channel){
  password = stri_enc_toutf8(paste0('PASS ',token))
  nickname = stri_enc_toutf8(paste0('NICK ',nickname))
  channel = stri_enc_toutf8(paste0('JOIN ',channel))
 con <-make.socket(port = 1234,host = 'irc.chat.twitch.tv',server=F)
 on.exit(close.socket(con))
 open.connection(con)
 write.socket(con,paste0('PASS ',token))
 write.socket(con,nickname)
 write.socket(con,channel)
 responce <- enc2utf8(read.socket(con))
 }

#https://cran.r-project.org/web/packages/websocket/readme/README.html

ws <- WebSocket$new('ws://irc-ws.chat.twitch.tv:80')

ws$onMessage(function(event){
  cat('client got msg: ',event$data, "\n")
})

ws$send(stri_enc_toutf8(password))
ws$send(stri_enc_toutf8(nickname))
ws$send(stri_enc_toutf8(channel))

ws$send(stri_enc_toutf8('PONG :tmi.twitch.tv'))



