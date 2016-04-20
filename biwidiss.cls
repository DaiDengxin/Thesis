%% BIWI PhD Thesis class
%%
%% Martin Berger         07 Feb 1996  started
%% Martin Berger         04 Nov 1999  changed
%% Dominik Auf der Maur  16 Oct 2003  simplified and slightly extended
%% Angela Yao                   2012  added publications list environment
%%
%% Based on 'report' class
%% Options: a4paper/a5paper       for large/small version
%%          modern                for AvantGarde title font
%%          oneside/twoside etc.  from report class
%% Default: a4paper,oneside
%%
%% Provides a boolean 'Afive' to check the current format:
%%   \ifthenelse{\boolean{Afive}}{(then)}{(else)}
%%
%% TODO: other languages if required


%% ----- Identification part

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{biwidiss}[2003/10/16 V1.1 PhD thesis class (mb,AdM)]

%% ----- Initial code part

\RequirePackage{ifthen}
\newboolean{Afive}
\newboolean{modern}

%% ----- Declaration of options

\DeclareOption{a4paper}{%
  \PassOptionsToClass{\CurrentOption}{report}
  \setboolean{Afive}{false}
}
\DeclareOption{a5paper}{%
  \PassOptionsToClass{\CurrentOption}{report}
  \setboolean{Afive}{true}
}
\DeclareOption{modern}{% -> AvantGarde chapter/section titles
  \setboolean{modern}{true}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

%% ----- Execution of options

\ExecuteOptions{a4paper,oneside} % default
\ProcessOptions

%% ----- Base class

\LoadClass{report}

%% ----- Packet loading

\RequirePackage{named-nocomma} % citations
\ifthenelse{\boolean{modern}}{\RequirePackage{avant}}{}
\RequirePackage{fancyhdr} % headers
\RequirePackage{multicol} % just for the index

%% ----- Defaults for English language.
%%       This should probably go somewhere else.
%%       How to implement other languages compliant with 'babel'?

\newcommand{\listabbrevname}{List of Abbreviations}
\newcommand{\listsymbolname}{List of Symbols}
\newcommand{\acknowledgename}{Acknowledgements}
\newcommand{\curriculumvitaename}{Curriculum Vitae}
\newcommand{\publicationsname}{List of Publications}

%% ----- Page setup

\ifthenelse{\boolean{Afive}}{
  \setlength{\topmargin}{-14.4mm}%      top:     11mm
  \setlength{\headheight}{4mm}
  \setlength{\headsep}{8mm}
  \setlength{\textheight}{169mm}%       bottom:  18mm
  \setlength{\textwidth}{110mm}
  \setlength{\oddsidemargin}{-4.4mm}%   inside:  21mm
  \setlength{\evensidemargin}{-7.9mm}%  outside: 17.5mm
  \setlength{\footskip}{8mm}
}{
  %% LaTeX default values for A4 paper:
  %%  \topmargin ........  7.0mm   ( 20pt)
  %%  \headheight .......  4.3mm   ( 12pt)
  %%  \headsep ..........  8.7mm   ( 25pt)
  %%  \textheight .......          (592pt)
  %%  \textwidth ........          (390pt)
  %%  \oddsidemargin ....          ( 10pt)
  %%  \evensidemargin ...          ( 52pt)
  %%  \footskip .........          ( 30pt)
  %%
  %% new margins:
  %% - top .......... 25mm
  %% - bottom ....... 32mm
  %% - left/right ... 30mm
  \setlength{\topmargin}{-0.4mm}
  \setlength{\headheight}{5mm}
  \setlength{\headsep}{10mm}
  \setlength{\textheight}{225mm}
  \setlength{\textwidth}{150mm}
  \setlength{\oddsidemargin}{4.6mm}
  \setlength{\evensidemargin}{4.6mm}
}

%% ----- Header/footer (based on package fancyhdr)

\pagestyle{fancyplain}
%\addtolength{\headwidth}{\marginparsep}
%\addtolength{\headwidth}{\marginparwidth}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\lhead[\fancyplain{}{\bfseries\small \thepage}]{\fancyplain{}
  {\scshape\small\rightmark}}
\rhead[\fancyplain{}{\scshape\small\leftmark}]{\fancyplain{}
  {\bfseries\small\thepage}}
\cfoot{}
\setlength{\headheight}{15.0pt} % AdM: was 12pt, but fancyhdr complained

%% ----- Paragraph format

\setlength{\parindent}{0mm}
\renewcommand{\baselinestretch}{1.05}
% \parskip: see \chapter below

%% ----- Various formatting parameters

\widowpenalty=10000          % keine Hurenkinder
\displaywidowpenalty=10000
\clubpenalty=10000           % keine Schusterjungen

\renewcommand{\floatpagefraction}{0.7}

%% -----  \cleardoublepage to leave empty page really empty (without header)

\renewcommand{\cleardoublepage}{%
  \clearpage
  \if@twoside%
    \ifodd\c@page\else
      \hbox{}\thispagestyle{empty}\newpage
      \if@twocolumn\hbox{}\newpage\fi
    \fi
  \fi
}

%% ----- Chapter, chapter titles

\renewcommand{\chapter}{%
  \cleardoublepage
  \thispagestyle{plain}
  \global\@topnum\z@
  \@afterindentfalse
  \setlength{\parskip}{1.5ex plus 0.5ex minus 0.5ex}
  \secdef\@chapter\@schapter
}

\newcommand{\printchaptitle}[1]{%
  \parindent \z@ \raggedright \normalfont
  \interlinepenalty\@M
  \ifthenelse{\boolean{modern}}{
    \sffamily\ifthenelse{\boolean{Afive}}{\LARGE}{\huge}
  }{
    \ifthenelse{\boolean{Afive}}{\huge}{\Huge}
  }
  \bfseries #1\par\nobreak
  \ifthenelse{\boolean{Afive}}{\vskip 28\p@}{\vskip 40\p@}
}

\def\@makechapterhead#1{% Heading for \chapter command
  \ifthenelse{\boolean{Afive}}{%
    \ifthenelse{\boolean{modern}}{\font\nrfont=pagd at 54pt}
                                 {\font\nrfont=cmbx12 at 54pt}%
    %\font\nrfont=ptmb at 54pt
  }{
    \ifthenelse{\boolean{modern}}{\font\nrfont=pagd at 75pt}
                                 {\font\nrfont=cmbx12 at 75pt}%
    %\font\nrfont=ptmb at 75pt
  }
  \vspace*{5\p@}%
  {
    \parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne    % IF secnumdepth > -1 THEN
      {\nrfont \thechapter}%          print number.
      \par\nobreak
      \ifthenelse{\boolean{Afive}}{\vskip 15\p@}{\vskip 20\p@}
                                    % space between number and title.
    \fi
    \printchaptitle{#1}
  }
}

\def\@makeschapterhead#1{% Heading for \chapter* command
  \ifthenelse{\boolean{Afive}}{\vspace*{35\p@}}{\vspace*{50\p@}}
  {
    \printchaptitle{#1}
  }
}

%% ----- Section/subsection titles

\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}{2.3ex \@plus.2ex}%
  {\normalfont\ifthenelse{\boolean{modern}}{\sffamily\large}{\Large}\bfseries}
}

\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}{1.5ex \@plus .2ex}%
  {\normalfont\ifthenelse{\boolean{modern}}{\sffamily\normalsize}{\large}\bfseries}}

%% ----- Captions

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\textsl{\textbf{#1}: #2}}%
  \ifdim \wd\@tempboxa >\hsize
    \textsl{\textbf{#1}: #2}\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip%
}

%% ----- "Table of"/"List of" special chapters; used below

\newcommand{\contentschap}[3]{ % 1: chapter name, 2: TOC name, 3: in main TOC?
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{#1\@mkboth{#1}{#1}}
  \ifthenelse{\equal{#3}{0}}{}{
    \addcontentsline{toc}{chapter}{\protect\numberline{}{#1}}}
  \setlength{\parskip}{0ex plus 0ex minus 0ex}
  \@starttoc{#2}
  \if@restonecol\twocolumn\fi
}

%% ----- Title page

\def\@dissNo{} \newcommand{\dissNo}[1]{\def\@dissNo{#1}}
\def\@degreeETH{} \newcommand{\degreeETH}[1]{\def\@degreeETH{#1}}
\def\@examiners{} \newcommand{\examiners}[1]{\def\@examiners{#1}}

\renewcommand{\maketitle}{\begin{titlepage}
%   \begin{flushleft}
  \begin{center}
    DISS.~ETH NO.~\@dissNo
  \end{center}
%   \end{flushleft}
  \vfill
  \begin{center}
    {\LARGE \@title}
    \vfill
    A dissertation submitted to\\
    \vspace{1ex}
    %SWISS FEDERAL INSTITUTE OF TECHNOLOGY ZURICH
    ETH ZURICH
    \vfill
    for the degree of\\
    \vspace{1ex}
    \@degreeETH
    \vfill
    presented by\\
    \vspace{1ex}
    \@author
    \vfill
    accepted on the recommendation of\\
    \vspace{1ex}
    \@examiners
    \vfill
    \@date
  \end{center}
\end{titlepage}}

%% ----- Environments: dedication, abstract, TOC, list of X, ...

\newenvironment{dedication}{%
  \cleardoublepage
  \thispagestyle{empty}
  \vspace*{\stretch{1}}
  \normalfont\normalsize\scshape
  \begin{flushright}
}{
  \end{flushright}
  \normalfont
  \vspace*{\stretch{5}}
}

\renewenvironment{abstract}{\chapter*{\abstractname
    \@mkboth{\abstractname}{\abstractname}}
}{}

\setcounter{tocdepth}{2}
\renewcommand{\tableofcontents}{\contentschap{\contentsname}{toc}{0}}

\renewcommand{\listoffigures}{\contentschap{\listfigurename}{lof}{1}}

\renewcommand{\listoftables}{\contentschap{\listtablename}{lot}{1}}

\newcommand{\@loalabel}[1]{\textbf{#1}}
\newenvironment{listofabbrevs}[1]{\chapter*{\listabbrevname
    \@mkboth{\listabbrevname}{\listabbrevname}}%
  \addcontentsline{toc}{chapter}{\protect\numberline{}{\listabbrevname}}
  \list{}{%
    \settowidth\labelwidth{\@loalabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \itemsep 0pt
    \renewcommand{\makelabel}[1]{\@loalabel{##1}\hfill}}%
  }
{\endlist}

\newcommand{\@loslabel}[1]{#1}
\newenvironment{listofsymbols}[1]{\chapter*{\listsymbolname
    \@mkboth{\listsymbolname}{\listsymbolname}}%
  \addcontentsline{toc}{chapter}{\protect\numberline{}{\listsymbolname}}
  \list{}{%
    \settowidth\labelwidth{\@loslabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \itemsep 0pt
    \renewcommand{\makelabel}[1]{\@loslabel{##1}\hfill}}%
  }
{\endlist}

% \bibliographystyle{named-nocomma-shortname}
% \bibliographystyle{ieee}
\renewenvironment{thebibliography}[1]{\chapter*{\bibname
   \@mkboth{\bibname}{\bibname}}%
 \addcontentsline{toc}{chapter}{\protect\numberline{}{\bibname}}
 \list{\@biblabel{\@arabic\c@enumiv}}{%
   \settowidth\labelwidth{\@biblabel{#1}}%
   \leftmargin\labelwidth
   \itemsep 0pt
   \advance\leftmargin\labelsep
   \@openbib@code
   \usecounter{enumiv}%
   \let\p@enumiv\@empty
   \renewcommand\theenumiv{\@arabic\c@enumiv}}%
 \sloppy\clubpenalty4000\widowpenalty4000%
 \sfcode`\.\@m}
{\def\@noitemerr
 {\@latex@warning{Empty `thebibliography' environment}}%
 \endlist}

\renewcommand{\indexspace}{} % remove the large line spacing
\renewenvironment{theindex}{\chapter*{\indexname
    \@mkboth{\indexname}{\indexname}}
  \addcontentsline{toc}{chapter}{\protect\numberline{}{\indexname}}
  \setlength{\parskip}{0ex plus 0ex minus 0ex}
  \itemsep 0pt
  \let\item\@idxitem%
  \columnseprule \z@
  \columnsep 35\p@
  \begin{multicols}{2}
}{\end{multicols}}

\newenvironment{acknowledgement}
{\chapter*{\acknowledgename\@mkboth{\acknowledgename}{\acknowledgename}}}
{}

\newenvironment{curriculumvitae}
{\chapter*{\curriculumvitaename
\@mkboth{\curriculumvitaename}{\curriculumvitaename}}}
{}

\newenvironment{publications}
{\chapter*{\publicationsname\@mkboth{\publicationsname}{\publicationsname}}}
{}
