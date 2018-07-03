% brownthesis.cls -- A document class for Brown University PhD theses
% Copyright (c) 2018, Michael C. Burkhart
% Copyright (c) 1998, Emmanuel Renieris
% Copyright (c) 1997, 1998 Dimitris Michailidis

% Based on earlier work by John Stasko, Randy Calistri, Lynn Andrea Stein,
% Robert Goldman and Kate Sanders
% with chapter headings modified from the work of Janusz Konrad, Stephen Gildea, 
% Paolo Gaudiano, and Jonathan Polimeni

% This class modifies the standard book class to follow the Graduate
% School's "Instructions for the Preparation and Presentation of Ph.D.
% Dissertations."  It sets the margins, interline spacing, the figure and table
% numbering style, and disallows page breaks at hyphens.
%
%
% The following commands can control what goes in the front matter material:
%     \title{thesis title}
%     \author{author's name}
%     \degrees{Previous degrees earned by candidate}
%     \dept{author's department}
%         - Computer Science if omitted
%     \principaladvisor{the principal advisor's name}
%        (or \principaladviser, if you prefer advisor spelled with e)
%     \reader[affiliation]{reader's name}
%         - thesis readers and their affiliations if non-Brown
%     \dean{dean's name}
%         - name of the dean of the grad school
%     \submitdate{month year in which submitted to GPO}
%         - date LaTeX'd if omitted
%     \copyrightyear{year degree conferred (next year if submitted in Dec.)}
%         - year LaTeX'd (or next year, in December) if omitted
%           This is a little tricky.  Check the grad school's document.
%
% The following options are available.  Options marked with * can take an
% optional ``no'' prefix to negate their result:
%
% draft, final, copyright*, contents*, tables*, figures*, examples*,
% signature*, plus the options accepted by the standard book document class
%
% This class uses interline spacing that is 1.3 times normal, except in the
% figure and table environments and in footnotes where normal spacing is used.
% That can be changed by redefining \baselinestretch.
%
% In addition there are the macros \abstract and \abstractpage to produce the
% thesis abstract.
%
% There is also a command
%     \disclaimer{Parts of this thesis...}
% If you use it, an asterisked paragraph will appear after the toc,
%    with the specified text, which is supposed to mention that parts
%    of the thesis have been previously published elsewhere with such
%    and such co-authors. If some of these publications have earlier
%    dates than the year of your PhD, you need to include their
%    dates in the copyright as well
%
% Example of use:
%
%     \documentclass{brownthesis}
%     \begin{document}
%     \title{How to Write Theses\\
%         With Two-Line Titles}
%     \author{Robin Candidate}
%     \degrees{B.~S., Whatsamatta U., 1983\\
%          Sc.~M., Brown University, 1985}
%     \principaladvisor{Don Knuth}
%     \reader{Marvin Minsky}
%     \reader[(Another Department)]{Marlin Perkins}
%     \reader{John Stasko}
%     \dean{The Man}
%     \abstract{What an abstract!}
%     \abstractpage
%     \abstractpage
%     \beforepreface
%     \prefacesection{Vita}
%        It all started in a little log cabin ...
%     \prefacesection{Preface}
%        This thesis tells you all you need to know about...
%     \prefacesection{Acknowledgements}
%        I would like to thank the academy...
%     \afterpreface
%
%     \chapter{Introduction}
%        \input{chapter1}
%     \chapter{Conclusions}
%      ...
%     \appendix
%     \chapter{A Long Proof}
%      ...
%     \bibliographystyle{plain}
%     \bibliography{mybib}

\def\fileversion{v3.14}
\def\filedate{2018/05/02}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{brownthesis}[\filedate\space\fileversion\space Brown
University PhD Thesis Class]

\newif\if@draft
\newif\ifc@pyright
\newif\ifl@fpage
\newif\ifl@tpage
\newif\ifl@epage
\newif\ift@cpage
\newif\if@sigpage

\DeclareOption{draft}{\@drafttrue\PassOptionsToClass{draft,twoside}{book}}
\DeclareOption{final}{\@draftfalse\PassOptionsToClass{final,oneside}{book}}
\DeclareOption{twoside}{\PassOptionsToClass{twoside}{book}}
\DeclareOption{oneside}{\PassOptionsToClass{oneside}{book}}
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{book}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{book}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{book}}
\DeclareOption{contents}{\t@cpagetrue}
\DeclareOption{nocontents}{\t@cpagefalse}
\DeclareOption{figures}{\l@fpagetrue}
\DeclareOption{nofigures}{\l@fpagefalse}
\DeclareOption{tables}{\l@tpagetrue}
\DeclareOption{notables}{\l@tpagefalse}
\DeclareOption{examples}{\l@epagetrue}
\DeclareOption{noexamples}{\l@epagefalse}
\DeclareOption{copyright}{\c@pyrighttrue}
\DeclareOption{nocopyright}{\c@pyrightfalse}
\DeclareOption{signature}{\@sigpagetrue}
\DeclareOption{nosignature}{\@sigpagefalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{12pt,final,copyright,contents,figures,tables,noexamples,signature} % why squint?
\ProcessOptions\relax

\LoadClass{book}

% Page geometry
\hoffset 0pt
\voffset 0pt
\footskip 18pt
\textwidth 6in
\textheight 8.5in
\headheight 12pt
\headsep 24pt
\oddsidemargin 0.5in
\evensidemargin 0pt
\marginparsep 0pt
\marginparwidth 0pt
\topmargin 0pt

% Disallow page breaks at hyphens (this will give some underfull vbox's,
% so an alternative is to use \brokenpenalty=100 and manually search
% for and fix such page breaks)
\brokenpenalty=10000

% For the final version use 1.3 times the normal baseline-to-baseline skip
% However if this is a draft we use single spacing to save some trees
\def\single@spacing{\def\baselinestretch{1}}
\def\final@spacing{\def\baselinestretch{1.3}}
\if@draft\single@spacing\else\final@spacing\fi

% Reset interline spacing to normal inside float environments
% We do this by extending the \@floatboxreset macro
\let\old@floatboxreset=\@floatboxreset
\def\@floatboxreset{\single@spacing\old@floatboxreset}

% Redefine the macro used for footnotes to use single spacing
\long\def\@footnotetext#1{\insert\footins{%
    \hangindent\parindent % -- Manos
    \single@spacing\reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
       \csname p@footnote\endcsname\@thefnmark
    }%
    \color@begingroup
      \@makefntext{%
        %\rule\z@\footnotesep%
	\ignorespaces#1\@finalstrut\strutbox}%
	\vspace{0.5\footnotesep}%
    \color@endgroup}}
% However, footnotes need a blank line between them -- Manos
%\setlength{\footnotesep}{1.3\baselineskip}

% Redefine thebibliography to add an entry in the table of contents
\let\@ldthebibliography=\thebibliography
\def\thebibliography#1{\@ldthebibliography{#1}%
  \addcontentsline{toc}{chapter}{\bibname}}

% \author, \title are defined in book; here are the rest of the
% front matter defining macros
\def\dept#1{\gdef\@dept{#1}}
\def\degrees#1{\gdef\@degrees{#1}}
\def\principaladviser#1{\gdef\@principaladviser{#1, Director}}
\def\advis@r{Adviser}
\def\principaladvisor#1{\gdef\@principaladviser{#1, Director}%
  \gdef\advis@r{Advisor}}
\def\dean#1{\gdef\@dean{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}}

% --  Macros
% A paragraph must be inserted after the toc, that gives the
% places where parts of the thesis have been published before
\def\disclaimer#1{\gdef\@disclaimer{#1}}
%the default, however, is nothing
\let\@disclaimer\@empty

% the date is always May -- if it is 
% after May 1, the date needs to be May of
% next year
\def\@principaladviser{}
\def\@dean{}
\ifnum\month>4
   \@tempcnta=\year \advance\@tempcnta by 1
   \edef\@copyrightyear{\number\the\@tempcnta}
   \edef\@submitdate{May\space\number\the\@tempcnta}
\else
   \def\@copyrightyear{\number\the\year}
   \def\@submitdate{May\space\number\the\year}
\fi

% macros to deal with thesis readers.
% Up to 3 readers are allowed and at least 2 must be supplied
\newcount\@readers \@readers=1
\def\reader@one{\@latex@error{No \noexpand\reader supplied}\@ehc}
\def\reader@two{\@latex@error{At least two thesis readers are needed}\@ehc}
\let\reader@three\@empty
\let\@firstreaderfrom\@empty
\let\@secondreaderfrom\@empty
\let\@thirdreaderfrom\@empty
\newcommand*{\reader}[2][\@empty]{\ifcase\the\@readers\or
  \gdef\@firstreaderfrom{#1}  \gdef\reader@one{#2, Reader}\or
  \gdef\@secondreaderfrom{#1} \gdef\reader@two{#2, Reader}\or
  \gdef\@thirdreaderfrom{#1}  \gdef\reader@three{#2, Reader}\or
  \@latex@error{Too many readers supplied (max 3)\@ehc}\fi
  \ifnum\@readers < 4 \global\advance\@readers\@ne\fi}

\def\titlep{%
  \null\vskip 0.5in%
  \begin{center}\Huge\@title\end{center}
  \vfill
  \begin{center}%
    by\\
    \@author\\
    \@degrees%
  \end{center}
  \vfill
  \begin{center}%
    A dissertation submitted in partial fulfillment of the\\
    requirements for the Degree of Doctor of Philosophy\\
    in the Division of Applied Mathematics at Brown University%
  \end{center}
  \vfill
  \begin{center}%
    Providence, Rhode Island\\
    \@submitdate%
  \end{center}
  \vskip.5in}

% as per the US Copyright Office, we want "(c) 2XXX Author"
\def\copyrightpage{%
  \null\vfill
  \begin{center}
    \Large\copyright\ \@copyrightyear{}\ \@author
  \end{center}
  \vspace{12cm}
  \vfill}

\def\signaturepage{%
\if@sigpage
  \setcounter{page}{3}
  \evensidemargin 0.5in
  \def\make@sigline##1##2{%
    \begin{tabular}{lc}
      Date \rule{1in}{.05mm}\hspace*{.75in} & \rule{3in}{.05mm}\\
      & ##1\\ & ##2
    \end{tabular}}%
  \null\vskip.2in
  \begin{center}
    This dissertation by \@author{} is accepted in its present form by\\
    the Division of Applied Mathematics as satisfying the dissertation requirement \\
    for the degree of Doctor of Philosophy.
  \end{center}
  \vspace{.75in}
  \let\old@stretch\baselinestretch \single@spacing\selectfont
  \make@sigline{\@principaladviser}{\@empty}\\[.4in]
  \centerline{Recommended to the Graduate Council}\\[.75in]
  \make@sigline{\reader@one}{\@firstreaderfrom}\\[.40in]
  \make@sigline{\reader@two}{\@secondreaderfrom}
  \ifnum\@readers>3 \\[.40in]\make@sigline{\reader@three}{\@thirdreaderfrom}\fi
  \\[.5in]\centerline{Approved by the Graduate Council}\\[.75in]
  \make@sigline{\@dean}{Dean of the Graduate School}
  \def\baselinestretch{\old@stretch}\selectfont
  \clearpage\thispagestyle{empty}\setcounter{page}{2}\cleardoublepage
  \setcounter{page}{4}
  \evensidemargin 0in
\else
  \setcounter{page}{1}
\fi
  }

\def\abstract#1{\gdef\d@abstract{#1}}
\def\d@abstract{}
\def\abstractpage{%
  \thispagestyle{empty}
  \noindent Abstract of ``\@title''
  by \@author, Ph.D., Brown University, \@submitdate.\\[.5in]
  \d@abstract\vfill\newpage}

\def\beforepreface{\pagestyle{empty}\pagenumbering{roman}
  \titlep\cleardoublepage
  \ifc@pyright\copyrightpage\cleardoublepage\addtocounter{page}{-1}\fi
  \pagestyle{plain}\signaturepage\cleardoublepage}
  

\def\@makechapterhead#1{         % Heading for \chapter command
    \vspace*{6\p@}
   {\centering                   
    \parindent 0pt
    \Large\bf \MakeUppercase{\@chapapp{} \thechapter} 
    \par
    \vskip 12pt                  % Space between number and title
    \LARGE \bf                       
    \MakeUppercase{#1}\par       
    \nobreak                         
    \vskip 24pt 
    } }

% Must also do the \chapter* command which gets used for table of
% contents, list of figures, and such.
\def\@makeschapterhead#1{        % Heading for \chapter* command 
    \vspace*{6\p@}
  { \centering                   
    \parindent 0pt 
    \LARGE\bf                   
    \MakeUppercase{#1}\par       % ... in uppercase type."
    \nobreak                     
    \vskip 24pt                  % Space between title and text.
  } }

%\def\prefacesection#1{\chapter*{#1}\addcontentsline{toc}{chapter}{#1}}
% We don't really want the preface sections to appear in the TOC
\def\prefacesection#1{\cleardoublepage\chapter*{#1}}

\long
\def\afterpreface{\cleardoublepage
  \ift@cpage
  \tableofcontents
  \ifx\@disclaimer\@empty
      \else
      \vspace{0.5cm}
      \single@spacing
      \noindent
      \hangindent\parindent
      \makebox[\parindent][l]{\raisebox{0.2ex}{\large{$\star$}} }\@disclaimer
      \if@draft\single@spacing\else\final@spacing\fi
  \fi
  \cleardoublepage\fi
  \ifl@tpage\addcontentsline{toc}{chapter}{List of Tables}\listoftables
    \cleardoublepage\fi
  \ifl@fpage\addcontentsline{toc}{chapter}{List of Figures}\listoffigures
    \cleardoublepage\fi
  \ifl@epage\addcontentsline{toc}{chapter}{List of Examples}\listofexamples
    \cleardoublepage\fi
  \pagenumbering{arabic}\pagestyle{myheadings}}

\endinput
