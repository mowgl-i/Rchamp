#' scrap paper to write stuff on
#'
#'

messages = c()
authors = c()



pre_link <- 'https://api.twitch.tv/v5/videos/'


# Chats is just replica json, so that we can reference it in our while/for looops.
chats = '{"comments": [[{"id":"12304987","content_offset_seconds":"0.1"}],
                      [{"id":"12304987","content_offset_seconds":"0.1"}]] ,
                      "_prev":"arsotn_",
                      "_next":"arstnnn_"}'


chats<-fromJSON(chats)

link

# if ((names(chats[2]) == '_next'| names(chats[3]) == '_next') & chats$`_next` != 'arstnnn_'){ # can't use [2] because after the first one, [2] is == '_prev'
#  print(2)
# } else{
#   print(1)}

pre_link

#!is.na(chats) taken out


attemps = 6
attemp_sleep = 10


while(((names(chats[2]) == '_next'| names(chats[3]) == '_next') & chats$comments[[1]]$content_offset_seconds < endofclipoffset+1)){ # so long as chat is null or the offset is less than clip offset -> next.
  if ((names(chats[2]) == '_next'| names(chats[3]) == '_next') & chats$`_next` != 'arstnnn_'){ # can't use [2] because after the first one, [2] is == '_prev'
    link =  paste(pre_link,vod_id,'/comments?cursor=',chats$`_next`, sep = "")
    }
  else{
    paste('content_offset_seconds=',clip_offset,sep = '')
    link <- paste(pre_link,vod_id,'/comments?cursor=', sep = "")
  }
    for(i in c(0:10)){ # should instead put/add a sleep or something for the api
      print(i)
      chats<-tryCatch({chats <- GET(link) %>% content() },
                      warning = function(w){is_clip_alb <- "video missing"},
                      error = function(e){is_clip_alb <-"video missing"}) # try and run this request
      messages_json = c(messages_json,chats$`_next`, chats$comments[[1]]$content_offset_seconds)

      total_comments = length(chats$comments)
      chat_offset = chats$comments[[total_comments]]$content_offset_seconds
      progress =  (chat_offset/vod_len)*100

      if (progress >= 100){
        for(comment in chats$comments){
          if(comment$content_offset_seconds >= clip_offset & comment$content_offset_seconds <= endofclipoffset)
          messages <- append(messages, comment$message$body)
          author <- append(author, comment$commenter$display_name)

        } else{print('somn broke inside the nested if and for')}


      break
      }
      else{print('idek homie')

        if(i < attemps-1){

          print('let me sleep..')
          Sys.sleep(attemp_sleep)
        }
      }


      # this is happening 10x before getting the next link :( try again) break statement needed?

    }
}



for(comments in chats$comments){
  print(comments$message$body)
}



link

clip_offset

fromJSON(txt = chats) %>%  as.data.frame()

vod$content

chats$comments[[1]]$content_offset_seconds

###### TRYING TO PASS ZERO Values through while/if statement

x = NA
y = 1

while((!is.na(y) | is.null(x[1] == 'test'))){
  print(1)
}

toJSON(chats)

  is.null(chats$`_next`)


#######################
match('_next' %in% chats)

names(chats[2]) == '_next'


