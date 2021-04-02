#'  Get Clip chat by using vod info
#'
#'  @description Uses the clip slug to determine the clip offset and gather the chat from the clip by navitating to the VOD at the offset.
#'
#'  @param clip_id the clip slug. Can be found in the url of the twitch clip.
#'
#'  @return Messages, usernames as list. Message information as json.
#'
#'  @references https://github.com/Freguglia/rTwitchAPI/blob/master/R/get_clip.R
#'  @references https://github.com/OgulcanCelik/twitch-clip-chat
#'
#'  @import dplyr
#'  @import httr
#'  @import httr
#'  @import jsonlite
#' @importFrom purrr simplify_all
#' @importFrom purrr transpose
#' @importFrom httr content
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom magrittr %>%
#' @export





get_clip_chat <- function(clip_id, json_output = FALSE){

   attemps = c(0:6)
   attemp_sleep = 10
  pre_link <- 'https://api.twitch.tv/v5/videos/'



  chats <- '{"comments": [[{"id":"12304987","content_offset_seconds":"0.1"}],
                      [{"id":"12304987","content_offset_seconds":"0.1"}]] ,
                      "_prev":"arsotn_",
                      "_next":"arstnnn_"}'

  chats<-jsonlite::fromJSON(chats)


  clip_content<-Rchamp::get_clip_data(clip_id)

  endofclipoffset <- clip_content$vod$offset + clip_content$duration
  clipoffset <- clip_content$vod$offset
  vod_id = clip_content$vod$id
  messages_json <<- c()
  users <- c()
  messages <- c()
  badge <- c()
  badge_type <- c()
  emotes <- c()



  while(( '_next' %in% names(chats) & chats$comments[[1]]$content_offset_seconds <= endofclipoffset)){ # so long as chat is null or the offset is less than clip offset -> next.

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

        if(json_output == TRUE){
          messages_json <<- append(messages_json, chats$comments)
        }

        for(comment in chats$comments){
          if(comment$content_offset_seconds >= clipoffset & comment$content_offset_seconds <= endofclipoffset){

            messages <- append(messages, comment$message$body)
            users <- append(users, comment$commenter$display_name)

              if('user_badges' %in% names(comment$message)){
                badge<-append(badge,comment$message$user_badges[[1]]$`_id`)
                badge_type <- append(badge_type,comment$message$user_badges[[1]]$version)
              }else{badge<-append(badge,'No Badge')
              badge_type<-append(badge_type,'No Badge')}

            emotes_in_message <- c()

            for(frag in comment$message$fragments){

              if('emoticon' %in% names(frag)){
                emotes_in_message <- append(emotes_in_message,frag$text)}
            }

            if(is.null(emotes_in_message)){emotes_in_message <- 'No Emotes'}

            emotes_in_message <- unique(emotes_in_message)

            emotes_in_message <- paste(emotes_in_message,collapse = " ")

            emotes <- append(emotes,emotes_in_message)


            }
        }

        if(progress_number >= 100){
            progress_number = 100
            print('Downloading 100% complete')
          }
        print(progress_number)
        break
        }

        else{print('No chats recieved, something is wrong')}
        break
      }}

  data <- c(list(messages),list(users),list(badge),list(badge_type),list(emotes))
  chat_dataframe <<- as.data.frame(data, col.names = c('message','user','badges','badge_version','global_emotes'))
}

#
#get_clip_chat('GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ')
#
# # badge <- c()
# # messages <- c()
# # users <- c()
# # badge_type <- c()
# # emotes <- c()
# # emotes_in_message <- c()
# # chat_dataframe_test <- c()
#
# for(comment in messages_json){
#   # if(comment$content_offset_seconds >= clipoffset & comment$content_offset_seconds <= endofclipoffset){
#
#   messages <- append(messages, comment$message$body)
#   users <- append(users, comment$commenter$display_name)
#
#   if('user_badges' %in% names(comment$message)){
#     badge<-append(badge,comment$message$user_badges[[1]]$`_id`)
#     badge_type <- append(badge_type,comment$message$user_badges[[1]]$version)
#   }else{badge<-append(badge,'No Badge')
#   badge_type<-append(badge_type,'No Badge')}
#
#   emotes_in_message <- c()
#
#   for(frag in comment$message$fragments){
#
#     if('emoticon' %in% names(frag)){
#       emotes_in_message <- append(emotes_in_message,frag$text)}
#   }
#
#   if(is.null(emotes_in_message)){emotes_in_message <- 'No Emotes'}
#
#   emotes_in_message <- unique(emotes_in_message)
#
#   emotes_in_message <- paste(emotes_in_message,collapse = " ")
#
#   print(emotes_in_message)
#
#   emotes <- append(emotes,emotes_in_message)
#
#   }
#
#   data_test <- c(list(messages),
#                  list(users),
#                  list(badge),
#                  list(badge_type),
#                  list(emotes))
#
#   chat_dataframe_test <<- as.data.frame(data_test, col.names = c('message','user','badges','badge_version','emotes'))
# # }


