#' Authentication
#' @name Auth
#' @references https://github.com/Freguglia/rTwitchAPI/blob/master/R/authentication.R
#' @export
twitch_auth = function(){

  client_id <- Sys.getenv("TWITCH_CLIENT_ID")
  client_secret <- Sys.getenv("TWITCH_CLIENT_SECRET")

  if (client_id == "" | client_secret == ""){
    stop("Please add TWITCH_CLIENT_ID and TWITCH_CLIENT_SECRET to your environment variables (see documentation for reference).")
  }

  o <- httr::POST("https://id.twitch.tv/oauth2/token",
                  query = query_list(client_id=client_id,
                                     client_secret = client_secret,
                                     grant_type="client_credentials")) %>% content()

  httr::set_config(httr::add_headers('Client-ID' = client_id, Authorization=paste0("Bearer ",o$access_token)))
}


#' @rdname authentication
#' @export

twitch_auth_forget = function(){
  httr::reset_config()
}


