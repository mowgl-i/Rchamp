server = 'irc.chat.twitch.tv'
port = 6667
nickname = 'lsf_mowgli_chat'
token = 'oauth:vxcow8r2e4iqtuu34vbzso9bbptz2y'
channel = '#adrianachechik_'

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


ws <- WebSocket$new('irc.chat.twitch.tv')
