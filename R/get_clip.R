#'  Get Clip
#'  @return A list with clip information
#'  @export
#'  @references https://github.com/Freguglia/rTwitchAPI/blob/master/R/get_clip.R
#'  @import dplyr
#'  @import httr
#' @importFrom purrr simplify_all
#' @importFrom purrr transpose
#' @importFrom httr content
#' @importFrom httr GET
#' @importFrom magrittr %>%

get_clip <- function(clip_id){

  client_id <- Sys.getenv("TWITCH_CLIENT_ID")
  #client_secret <- Sys.getenv("TWITCH_CLIENT_SECRET")
  httr::set_config(httr::add_headers('client-id'=client_id, 'Accept'='application/vnd.twitchtv.v5+json'))

  url <- 'https://api.twitch.tv/kraken/clips/'
  clip_data <- httr::GET(paste(url,clip_id,sep = "")) # used this to get clip-id
  clip_content <- httr::content(clip_data)
  #clip_data <- httr::GET(paste(url,'GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ',sep = "")) %>% content()
  if(!is.null(clip_data$status_code) & clip_data$status_code=="200"){

  }
  if(length(clip_content)<1) stop("No results for this query parameters.")
  clip = clip_data
  return(clip)

}

#
# example
test<-get_clip('GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ')
