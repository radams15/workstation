FROM fedora:latest

RUN dnf in -y texlive texlive-perltex make texlive-svg texlive-lastpage texlive-exsheets julietaula-montserrat-fonts texlive-mwe texlive-textpos texlive-minted python3-pygments which texlive-tikzpagenodes texlive-appendix

RUN echo 'xelatex -shell-escape $@' > /bin/shell_xelatex && chmod +x /bin/shell_xelatex

WORKDIR /wdir

ENTRYPOINT ["make"]
