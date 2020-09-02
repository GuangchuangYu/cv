all: cv pdf

cv: citation2
	Rscript -e 'rmarkdown::render("index.Rmd")'

cv2:
	Rscript -e 'rmarkdown::render("index.Rmd")'

pdf:
	Rscript -e 'pagedown::chrome_print("index.html", "ygc.pdf")'

citation: 
	source /data/gitee/ygc-utilities/proxy.sh; \
	Rscript -e 'source("citation.R")'; \
	source /data/gitee/ygc-utilities/unproxy.sh

citation2:
	Rscript -e 'source("citation.R")'
