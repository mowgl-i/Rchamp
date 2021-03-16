#'  Get Clip chat by using vod info
#'  @return Messages, usernames as list. Message information as json.
#'  @references https://github.com/Freguglia/rTwitchAPI/blob/master/R/get_clip.R
#'  @import dplyr
#'  @import httr
#'  @import httr
#'  @import jsonlite
#' @importFrom purrr simplify_all
#' @importFrom purrr transpose
#' @importFrom httr content
#' @importFrom httr GET
#' @importFrom magrittr %>%
#' @export





get_clip_chat <- function(clip_id){

   attemps = c(0:6)
   attemp_sleep = 10
  pre_link <- 'https://api.twitch.tv/v5/videos/'



  chats <- '{"comments": [[{"id":"12304987","content_offset_seconds":"0.1"}],
                      [{"id":"12304987","content_offset_seconds":"0.1"}]] ,
                      "_prev":"arsotn_",
                      "_next":"arstnnn_"}'

  chats<-fromJSON(chats)


  clip_content<-get_clip_data(clip_id)

  endofclipoffset <- clip_content$vod$offset + clip_content$duration
  clipoffset <- clip_content$vod$offset
  vod_id = clip_content$vod$id
  messages_json <<- c()
  users <<- c()
  messages <<- c()



  while(( '_next' %in% names(chats) & chats$comments[[1]]$content_offset_seconds < endofclipoffset+0.01)){ # so long as chat is null or the offset is less than clip offset -> next.

    if (chats$`_next` != 'arstnnn_'){
      link <-  paste(pre_link,vod_id,'/comments?cursor=',chats$`_next`, sep = "")
      #print('next != arstn')
      }
    else{
      #paste('content_offset_seconds=',clip_offset,sep = '') don't really know why this is included., I wonder if this is supposed to skip to this part of the vod
      link <- paste(pre_link,vod_id,'/comments?content_offset_seconds=',clipoffset, sep = "")
    }
      for(i in attemps){ # should instead put/add a sleep or something for the api
        chats_data<-tryCatch({chats_data <- httr::GET(link)},
                        warning = function(w){is_clip_alb <- "video missing"},
                        error = function(e){is_clip_alb <-"video missing"}) # try and run this request

        #print(chats_data$status_code)
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
            messages <<- append(messages, comment$message$body)
            users <<- append(users, comment$commenter$display_name)
            messages_json <<- append(messages_json, comment)
          }
        }

        print(progress_number)
        break
        }

        else{print('No chats recieved, something is wrong')}
        break
      }}
}

# messages
#
# get_clip_chat('GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ')
