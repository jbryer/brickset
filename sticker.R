library(hexSticker)

p <- 'bricks.png'

hexSticker::sticker(p,
					filename = 'brickset.png',
					p_size = 6,
					package = 'brickset',
					url = "github.com/jbryer/brickset",
					u_color = 'darkgreen',
					s_width = .8, s_height = .8,
					s_x = 1, s_y = 0.8,
					p_x = 1, p_y = 1.5,
					p_color = "darkgreen",
					h_fill = 'lightyellow',
					h_color = 'red',
					white_around_sticker = FALSE)

