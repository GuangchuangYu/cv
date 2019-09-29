cv: citation
	Rscript -e 'rmarkdown::render("index.Rmd")'

cv2:
	Rscript -e 'rmarkdown::render("index.Rmd")'

citation:
	Rscript -e 'source("citation.R")'
