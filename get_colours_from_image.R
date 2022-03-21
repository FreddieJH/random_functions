
library(tidyverse)
library(magick)

get_colours <- function(path, slice = 1:10){
  
  path |> 
    magick::image_read() |> 
    magick::image_raster() |> 
    count(col) |> 
    arrange(desc(n)) |> 
    as_tibble() |>  
    slice(slice) |> 
    mutate(col = fct_reorder(.f = col, .x = n, .desc = TRUE))
  
}

plot_colours <- function(colour_df){
  
  colour_df |> 
    ggplot() +
    geom_rect(aes(fill = col), 
              xmin = -Inf, 
              xmax = Inf, 
              ymin = -Inf, 
              ymax = Inf) +
    geom_label(aes(x = 0, y = 0, label = n)) +
    scale_fill_identity() +
    facet_wrap(~col) +
    theme_bw() +
    theme(axis.title = element_blank(), 
          axis.text = element_blank(),
          axis.ticks = element_blank())
}

# path to image
"homer.png" |> 
  get_colours(1:12) |> # 1:12 gets top 12 colours
  plot_colours()