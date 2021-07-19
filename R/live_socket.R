server = 'irc.chat.twitch.tv'
port = 6667
nickname = 'mowgl_i'
token = 'oauth:t0b5hj5zkbhdtt8its7rot6uze0ax5'
channel = '#healthygamer_gg'

library(stringi)
library(stringr)
library(websocket)
#library(logging)
library(logger)
library(dplyr)

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

#logging::basicConfig(level = 'FINEST')
#logging::addHandler(writeToFile,logger = "Twitch_log",file ='~/twitch.log')

log_appender(appender_file('twitch_data.log'))

ws <- WebSocket$new('ws://irc-ws.chat.twitch.tv:80')

ws$onMessage(function(event){
  cat('client got msg: ',event$data, "\n")
  data <<- event$data
  log_info(data)
  log_appender()
  if (str_detect(string = data,pattern = 'PING')){
    ws$send(stri_enc_toutf8('PONG :tmi.twitch.tv'))
  }})


ws$send(stri_enc_toutf8(password))
ws$send(stri_enc_toutf8(nickname))
ws$send(stri_enc_toutf8(channel))

ws$close()
ws$connect()



log <- read.table('twitch_data.log',fill =T,sep = ":")

