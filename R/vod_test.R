

get_vod <- function(client_id,vod_id){

  httr::set_config(httr::add_headers('Client-ID' = client_id))# 'Accept'='application/vnd.twitchtv.v5+json'))
  pre <- 'https://api.twitch.tv/kraken/videos/v'
  link <- paste(pre,vod_id,sep = "")
  link <- paste(pre,o$vod$id,sep = "")


  vod <- GET(link) %>% content()
}

o$vod$url
vod_id<-o$vod$id
clip_offset<-o$vod$offset # start of clip

endofclipoffset = (o$vod$offset + o$duration)

messages_json = c()


pre_link <- 'https://api.twitch.tv/v5/videos/'

chats = NA

while(is.na(chats) | (names(chats[2]) == '_next'& chats$comments[[1]]$content_offset_seconds < endofclipoffset+1)){ # so long as chat is null or the offset is less than clip offset -> next.
  if (!is.na(chats) & names(chats[2]) == '_next'){ # can't use [2] because after the first one, [2] is == '_prev'
    link =  paste(pre_link,vod_id,'/comments?cursor=',chats$`_next`, sep = "")

  }
  else{
    paste('content_offset_seconds=',clip_offset,sep = '')
    link <- paste(pre_link,vod_id,'/comments?cursor=', sep = "")
    }

  for(i in c(0:10)){

    chats<-tryCatch({chats <- GET(link) %>% content()},
                          warning = function(w){is_clip_alb <- "video missing"},
                          error = function(e){is_clip_alb <-"video missing"})
    messages_json = c(messages_json,chats[2])

  }
}


x = NULL
y = 1

while((!is.null(y) | x[1] == 'test')){
  print(1)
}

chats %>%

is.null(chats$`_next`)

match('_next' %in% chats)

names(chats[2]) == '_next'



# steps get the chat data then use that to get the vod data
