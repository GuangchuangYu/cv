all: cv pdf

cv: citation
	source ../ygc-utilities/unproxy.sh; \
	Rscript -e 'rmarkdown::render("index.Rmd")'

cv2:
	Rscript -e 'rmarkdown::render("index.Rmd")'

pdf:
	Rscript -e 'pagedown::chrome_print("index.html", "ygc.pdf")'

citation: 
	source ../ygc-utilities/proxy.sh; \
	Rscript -e 'source("citation.R")'

