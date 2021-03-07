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
  client_secret <- Sys.getenv("TWITCH_CLIENT_SECRET")

  url <- 'https://api.twitch.tv/kraken/clips/'
  o <- GET(paste(url,clip_id,sep = ""),config = add_headers('client-id'=client_id, 'Accept'='application/vnd.twitchtv.v5+json')) %>% content()

  if(!is.null(o$error) && o$error=="Unauthorized") stop(o$message)
  if(length(o$data)<1) stop("No results for this query parameters.")

  o$data %>% transpose() %>% simplify_all()
}

#
#
# test<-get_clip('GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ')
# # example
#
# paste(url,'GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ',sep = "")
