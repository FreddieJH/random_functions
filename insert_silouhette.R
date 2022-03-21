library(tidyverse)
library(magick)
library(cowplot)

# URL to required image
"https://ian.umces.edu/media-library/chelonia-mydas-green-sea-turtle/" |> 
  paste0("/download/svg/") |> 
  download.file("image1.svg")

image1 <-
  magick::image_read_svg("image1.svg", width = 100) |> 
  magick::image_colorize(opacity = 100, color = "black")

tibble(x = 1:10, y = 1:10) |> 
  ggplot(aes(x, y)) +
  geom_line() +
  cowplot::draw_image(image = image1,
             x = 5, 
             y = 7.5, 
             scale = 1, 
             hjust = 0.5, 
             vjust = 0.5)
