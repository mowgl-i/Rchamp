
get_clip <- function(client_id,clip_id){

  httr::set_config(httr::add_headers('Client-ID' = client_id, 'Accept'='application/vnd.twitchtv.v5+json'))
  pre <- 'https://api.twitch.tv/kraken/clips/'
  link <- paste(pre,clip_id,sep = "")

  o <- GET(link) %>% content()

  #if(!is.null(o$error) && o$error=="Unauthorized") stop(o$message)
  #if(length(o$data)<1) stop("No results for this query parameters.")


}

client_id <- Sys.getenv("TWITCH_CLIENT_ID")

clip_id = 'GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ'


test<-get_clip('GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ')
# example

paste(url,'GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ',sep = "")



o <- GET(link)

client_id
