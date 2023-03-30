all: cv pdf

cv: citation2
	Rscript -e 'rmarkdown::render("index.Rmd")'

cv2:
	Rscript -e 'rmarkdown::render("index.Rmd")'

pdf:
	#Rscript -e 'pagedown::chrome_print("index.html", "ygc.pdf", browser = "microsoft-edge-stable")'
	Rscript -e 'pagedown::chrome_print("index.html", "ygc.pdf", browser = "MicrosoftEdge")'

citation: 
	source /data/gitee/ygc-utilities/proxy.sh; \
	Rscript -e 'source("citation.R")'; \
	source /data/gitee/ygc-utilities/unproxy.sh

citation2:
	Rscript -e 'source("citation.R")'

tolabsite:
	cp index.html ~/mybook/yulab-smu.github.io/static/cv/ygc/


