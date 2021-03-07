

get_vod <- function(client_id,vod_id){

  httr::set_config(httr::add_headers('Client-ID' = client_id))# 'Accept'='application/vnd.twitchtv.v5+json'))
  pre <- 'https://api.twitch.tv/kraken/videos/v'
  link <- paste(pre,vod_id,sep = "")

  v <- GET(link) %>% content()
}
o$vod$url
vod_id<-o$vod$id
o$vod$offset # start of clip

endofclipoffset = (o$vod$offset + o$duration)

messages_json = c()


pre_link <- 'https://api.twitch.tv/v5/videos/'

response = NULL

while(response == is.null() | ('_next' %in% response & response["comments"][0]["content_offset_seconds"]) < (endOfClipoffset+1)){
  if (response != is.null() & ('_next' %in% response))


    query = ('cursor=' + response['_next'])

  else ('content_offset_seconds='+str(offset))

link <- paste(pre_link,vod_id,'/comments?cursor=', sep = "")

chats <- GET(link) %>% content()
}

link


# steps get the chat data then use that to get the vod data
