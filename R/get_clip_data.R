#'  Get Clip Data
#'  @return A list with clip information
#'  @param clip_id the clip slug. Can be found in the url of the twitch clip.
#'  @references https://github.com/Freguglia/rTwitchAPI/blob/master/R/get_clip.R
#'  @import dplyr
#'  @import httr
#' @importFrom purrr simplify_all
#' @importFrom purrr transpose
#' @importFrom httr content
#' @importFrom httr GET
#' @importFrom magrittr %>%
#' @export

get_clip_data <- function(clip_id){

  client_id <- Sys.getenv("TWITCH_CLIENT_ID")
  #client_secret <- Sys.getenv("TWITCH_CLIENT_SECRET")
  httr::set_config(httr::add_headers('client-id'=client_id, 'Accept'='application/vnd.twitchtv.v5+json'))

  url <- 'https://api.twitch.tv/kraken/clips/'
  clip_data <- httr::GET(paste(url,clip_id,sep = "")) # used this to get clip-id
  clip_content <- httr::content(clip_data)
  #clip_data <- httr::GET(paste(url,'GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ',sep = "")) %>% content()
  if(!is.null(clip_data$status_code) & clip_data$status_code=="200"){
    print('Got the clip data B)')
    return(clip_content)
    }
  if(length(clip_content)<1){ print("No results for this query parameters.")}

}

#test<-get_clip_data('GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ')

