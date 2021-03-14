#' scrap paper to write stuff on
#'
#'

messages = c()
authors = c()

#client_id = 'vof18oof360nvyvx4qqzjpvb6d90pc'


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


attemps = c(0:6)
attemp_sleep = 10


while(( '_next' %in% names(chats) & chats$comments[[1]]$content_offset_seconds < endofclipoffset+1)){ # so long as chat is null or the offset is less than clip offset -> next.
  if (chats$`_next` != 'arstnnn_'){
    link <-  paste(pre_link,vod_id,'/comments?cursor=',chats$`_next`, sep = "")
    }
  else{
    #paste('content_offset_seconds=',clip_offset,sep = '') don't really know why this is included., I wonder if this is supposed to skip to this part of the vod
    link <- paste(pre_link,vod_id,'/comments?cursor=', sep = "")
  }
    for(i in attemps){ # should instead put/add a sleep or something for the api
      print(i)

      chats_data<-tryCatch({chats <- GET(link)},
                      warning = function(w){is_clip_alb <- "video missing"},
                      error = function(e){is_clip_alb <-"video missing"}) # try and run this request
      if(chats_data$status_code == 200){
        chats <- httr::content(chats_data)
        messages_json = c(messages_json,chats$`_next`, chats$comments[[1]]$content_offset_seconds)
        total_comments = length(chats$comments)
        chat_offset = chats$comments[[total_comments]]$content_offset_seconds
        progress =  (chat_offset/vod_len)*100
      }
      else{print('status code wrong')}

      if (progress >= 100){
        for(comment in chats$comments){
          if(comment$content_offset_seconds >= clip_offset & comment$content_offset_seconds <= endofclipoffset){
          messages <- append(messages, comment$message$body)
          author <- append(author, comment$commenter$display_name)
          }}
      else{print('somn broke inside the nested if and for')}

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

endofclipoffset <- clip_content$vod$offset + clip_content$duration
clipoffset <- clip_content$vod$offset


messages_json = c()
users = c()
messages = c()

while(( '_next' %in% names(chats) & chats$comments[[1]]$content_offset_seconds < endofclipoffset+0.01)){ # so long as chat is null or the offset is less than clip offset -> next.
  if (chats$`_next` != 'arstnnn_'){
    link <-  paste(pre_link,vod_id,'/comments?cursor=',chats$`_next`, sep = "")
    print('next != arstn')
    }
  else{
    #paste('content_offset_seconds=',clip_offset,sep = '') don't really know why this is included., I wonder if this is supposed to skip to this part of the vod
    link <- paste(pre_link,vod_id,'/comments?content_offset_seconds=',clipoffset, sep = "")
  }
    for(i in attemps){ # should instead put/add a sleep or something for the api
      print(i)
      chats_data<-tryCatch({chats_2 <- GET(link)},
                      warning = function(w){is_clip_alb <- "video missing"},
                      error = function(e){is_clip_alb <-"video missing"}) # try and run this request
      print(chats_data$status_code)
      #messages_json = c(messages_json,chats$`_next`, chats$comments[[1]]$content_offset_seconds)
      if(chats_data$status_code == 200){
      chats <- httr::content(chats_data)
      total_comments = length(chats$comments)
      chat_offset = chats$comments[[total_comments]]$content_offset_seconds
      progress = chat_offset - clipoffset
      progress_number = (progress*100/clip_content$duration)
      if(progress_number > 100){
      progress_number = 100
      print('Downloading 100% complete')
      }

      for(comment in chats$comments){
        if(comment$content_offset_seconds >= clipoffset & comment$content_offset_seconds <= endofclipoffset){
          messages = append(messages, comment$message$body)
          users = append(users, comment$commenter$display_name)
          messages_json = append(messages_json, comment)
        }
      }

      print('breaking')
      break
      }

      else{print('No chats recieved, break')}
      break
    }}

messages[580:586]
chats = '{"comments": [[{"id":"12304987","content_offset_seconds":"0.1"}],
                      [{"id":"12304987","content_offset_seconds":"0.1"}]] ,
                      "_prev":"arsotn_",
                      "_next":"arstnnn_"}'

chats<-fromJSON(chats)





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


