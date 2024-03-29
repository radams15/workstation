PERLTEX?=perltex
BIBTEX?=bibtex
SRC?=src
MAIN?=src/main.tex
OUT?=doc.pdf
IMAGE?=tex
DOCKER?=podman

all: doc.pdf

.PHONY: docker
docker:
	${DOCKER} run -v "$$(pwd)":/wdir -it --rm ${IMAGE} doc.pdf

words:
	@for file in src/*.tex; do count=$$(perl latexcount.pl $$file | grep -oP '[0-9]+(?= total)'); printf "$$file:$$count\n"; words=$$(($$words+$$count)) ; done; printf "Total: $$words\n"

spellcheck:
	@for file in src/*.tex; do aspell --lang en_GB -t -c $$file; done

.PHONY: docker-image
docker-image:
	${DOCKER} build -t ${IMAGE} .

.PHONY: doc.pdf
doc.pdf:
	${PERLTEX} --latex=shell_xelatex ${MAIN} -o ${OUT}
	${BIBTEX} main
	${PERLTEX} --latex=shell_xelatex ${MAIN} -o ${OUT}
	${PERLTEX} --latex=shell_xelatex ${MAIN} -o ${OUT}

clean:
	rm -rf *.{log,lgpl,dvi,aux,xml,pdf,toc,out,dfpl,frpl,tfpl,topl,bbl,blg} *-blx.bib _minted-main
