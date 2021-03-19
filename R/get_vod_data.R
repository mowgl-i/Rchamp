#'  Get Vod Data
#'  @return VOD INFO
#'  @param vod_id this vod id can be found after using the get_clip_data function.
#'  @references https://github.com/Freguglia/rTwitchAPI/blob/master/R/get_clip.R
#'  @import dplyr
#'  @import httr
#' @importFrom purrr simplify_all
#' @importFrom purrr transpose
#' @importFrom httr content
#' @importFrom httr GET
#' @importFrom magrittr %>%
#' @export



get_vod_data <- function(vod_id){

  client_id <- Sys.getenv("TWITCH_CLIENT_ID")
  #client_secret <- Sys.getenv("TWITCH_CLIENT_SECRET")
  httr::set_config(httr::add_headers('client-id'=client_id, 'Accept'='application/vnd.twitchtv.v5+json'))

  pre <- 'https://api.twitch.tv/kraken/videos/v'
  link <- paste(pre,vod_id,sep = "")
  #link <- paste(pre,o$vod$id,sep = "")
  vod_data <- httr::GET(link)
  vod_content <- httr::content(vod_data)

  if(!is.null(vod_data$status_code) & clip_data$status_code=="200"){
    print('Got the VOD data B)')
    return(vod_content)
  }
  if(length(vod_content)<1){ print("No results for this query parameters.")}

}



