#' getting clip chat
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

get_clip_chat <- function(){
  url <- 'https://api.twitch.tv/v5/videos/GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ/comments?content_offset_seconds={1}' ## is {0} the id of the clip?
  o <- get(url) %>% content()
  if(!is.null(o$error) && o$error=="Unauthorized") stop(o$message)
  if(length(o$data)<1) stop("No results for this query parameters.")

  o$data %>% transpose() %>% simplify_all()
}

#get_clip_chat()
