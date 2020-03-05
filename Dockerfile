FROM docker.pkg.github.com/burkh4rt/docker-test/texlive2018:ubuntu
MAINTAINER burkh4rt

RUN tlmgr install bbm \
                  doublestroke \
                  was \
                  csquotes \
                  hyperxmp \
                  newtx \
                  imakeidx \
                  tabu \
                  epigraph \
                  babel-russian \
                  babel-japanese \
                  tikz-cd \
                  ifmtarg \
                  varwidth \
                  txfonts \
                  cm-super \
                  ec \
                  boondox \
                  babel-greek \
                  greek-fontenc \
                  cm-lgc \
                  hyphen-greek \
                  libgreek \
                  cbfonts \
 && tlmgr backup --clean --all \
 && fmtutil-sys --all \
 && apt-get clean
