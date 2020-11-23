library(scholar)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(ggstance)
library(ggimage)
library(ggtree)


#Sys.setenv(http_proxy="http://127.0.0.1:43723")


id <- 'DO5oG40AAAAJ'

profile <- tryCatch(get_profile(id), error = function(e) return(NULL))
if (!is.null(profile)) {
    profile$date <- Sys.Date()
    cat(toJSON(profile), file ="profile.json")
}

cites <- tryCatch(get_citation_history(id), error = function(e) return(NULL))

if (is.null(cites)) {
    cites <- tinyscholar::tinyscholar(id)$citation

    profile = jsonlite::fromJSON("profile.json")
    if (profile$total_cites < cites[1,2])
        profile$total_cites <- cites[1,2]
    cat(toJSON(profile), file ="profile.json")


    cites <- cites[-1, ] # remove 'total' row
    names(cites) <- c("year", "cites")
    cites$year <- as.numeric(cites$year)
}

if (!is.null(cites)) {
    cat(toJSON(cites), file = "citation.json")
}

cites <- fromJSON("citation.json")
cites <- slice(cites, tail(row_number(), 6))
cites$year <- factor(cites$year)

p <- ggplot(cites, aes(cites, year)) + 
    geom_barh(stat='identity', fill = "#96B56C") + 
    geom_text2(aes(label=cites, subset = cites > 500), hjust=1.1, size=5) + 
    labs(caption = "data from Google Scholar") +
    scale_x_continuous(position="top") +
    theme_minimal(base_size=14) + xlab(NULL) + ylab(NULL) +
    theme(panel.grid.major.y = element_blank(), 
          panel.grid.minor = element_blank(),
          panel.grid.major.x = element_line(linetype="dashed"),
          plot.caption=element_text(colour='grey30')) +
    theme_transparent() 

ggsave(p, file = "citation.png", width=3.5, height=4, bg = "transparent")


## library(magick)
## p <- image_read("citation.png")
## p <- image_transparent(p, "white")
## image_write(p, path="citation.png")
