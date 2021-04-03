Rchamp\_readme
================

# How to get started.

Right now, the package is being developed so use the following code to
install the package.

``` r
devtools::install_github('mowgl-i/Rchamp@Development')
library(Rchamp)
```

## Twitch clip id

You’ll want to have a slug/clip id to start with.

This is the url a twitch clip :
<https://clips.twitch.tv/GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ>

The slug/id can be found after the last shash :
GracefulIntelligentKathyMikeHogu-uIO9Kd0g\_KDqb4mQ

You will use this slug in the `get_clip_data()` and `get_clip_chat()`
functions like so… `get_clip_data('slug')`

This will return:

Dataframe containing messages,users,badge,badge version,and emotes.

``` r

get_clip_chat('GracefulIntelligentKathyMikeHogu-uIO9Kd0g_KDqb4mQ')
#> [1] "Got the clip data B)"
#> [1] 1.632483
#> [1] 8.29248
#> [1] 19.61147
#> [1] 30.97049
#> [1] 44.9358
#> [1] 54.80073
#> [1] 61.94931
#> [1] 71.61914
#> [1] 81.33067
#> [1] 86.99183
#> [1] 95.02585
#> [1] "Downloading 100% complete"
#> [1] 100
#> [1] "Downloading 100% complete"
#> [1] 100
```

``` r
head(chat_dataframe)
#>                        message         user     badges badge_version
#> 1                  based jerma  chill_idler subscriber             3
#> 2 thank you so much jerma <333 silverschoon   No Badge      No Badge
#> 3                  BASED JERMA     DJOniFam    premium             1
#> 4                GET THEIR ASS   jengatoads   No Badge      No Badge
#> 5                        BASED     Hackoon_ subscriber            12
#> 6             TransgenderPride      ATB2345   No Badge      No Badge
#>      global_emotes
#> 1        No Emotes
#> 2        No Emotes
#> 3        No Emotes
#> 4        No Emotes
#> 5        No Emotes
#> 6 TransgenderPride
```
