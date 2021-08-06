library(stringi)
library(stringr)
library(websocket)
library(logger)
library(dplyr)
library(readr)

#'  Get Clip Data
#'  @return A list with clip information
#'  @param clip_id the clip slug. Can be found in the url of the twitch clip.
#'  @references https://github.com/Freguglia/rTwitchAPI/blob/master/R/get_clip.R
#'  @import stringi
#'  @import stringr
#'  @import websocket
#'  @import logger
#'  @import dplyr
#'  @import readr
#' @importFrom stringi stri_enc_toutf8
#' @importFrom stringr str_detect
#' @importFrom stringr str_extract
#' @importFrom dplyr tibble
#' @importFrom magrittr %>%
#' @importFrom readr readlines
#' @export


live_socket <- function(channel_name){
  port = 6667
  channel <- paste0("#",channel_name)
  #channel <- '#mizkif'
  password <- stri_enc_toutf8(paste0('PASS ',Sys.getenv('TWITCH_OAUTH')))
  nickname <- stri_enc_toutf8(paste0('NICK ',Sys.getenv('TWITCH_USER')))
  channel <- stri_enc_toutf8(paste0('JOIN ',channel))
  print(password)
  print(nickname)
  print(channel)
  ws <- WebSocket$new('ws://irc-ws.chat.twitch.tv:80')

  ws$onClose(function(event){
    cat('Client Disconnected\n')
    ws$close()

  })

  wsws$onOpen(function(event){
    cat('Client Connected \n')
  })

  log_appender(appender_file('twitch_data_1.log'))

  ws$onMessage(function(event){
    cat('client got msg: ',event$data, "\n")
    data <- event$data
    log_info(data)
    log_appender()
    if (str_detect(string = data,pattern = 'PING')){
      ws$send(stri_enc_toutf8('PONG :tmi.twitch.tv'))



    }})

  Sys.sleep(2)
  ws$send(password)
  Sys.sleep(2)
  ws$send(nickname)
  Sys.sleep(2)
  ws$send(channel)
  return(ws)

}

test<-live_socket('mizkif')

clean_log <- function(log_file)
  { log_3 <- read_lines(log_file)
  log_4<-str_detect(string = log_3,pattern = 'INFO')
  log_5<-log_3[log_4]
  user <-str_extract(string = log_5,pattern = '(?<=........................:)\\w+')
  channel <-str_extract(string = log_5,pattern = '(?<= #).*(?=:)')
  message <- str_extract(string = log_5,pattern = '([^:]*$)')
  timestamp <- str_extract(string = log_5, pattern = '(?<=\\[).*(?=\\])')
  data <- tibble('user' = user, 'channel' = channel, 'message' = message, 'timestamp'= timestamp)
  return(data)
  }

data<-clean_log('twitch_data.log')
