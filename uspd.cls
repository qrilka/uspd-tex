%% Copyright (c) Kirill V. Zaborsky, 2013
%%               Alexander V. Inyukhin, 2004.
%%
%% This system is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{uspd}
              [1995/11/30 v1.3l
               USPD LaTeX document class]
\DeclareOption{a5paper}
    {\ClassError{uspd}{Option `a5paper' not supported}{}}
\DeclareOption{b5paper}
    {\ClassError{uspd}{Option `b5paper' not supported}{}}
\DeclareOption{onecolumn}%
    {\ClassError{uspd}{Option `onecolumn' not supported}{}}
\DeclareOption{twocolumn}{%
    \ClassError{uspd}{Option `twocolumn' not supported}{}
}
\DeclareOption{titlepage}%
    {\ClassError{uspd}{Option `titlepage' not supported}{}}
\PassOptionsToClass{onecolumn}{extarticle}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions
\LoadClass[a4paper,onecolumn]{extarticle}

\RequirePackage{rotating}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\RequirePackage{polyglossia}
\setdefaultlanguage{russian}
\RequirePackage[top=25mm,right=10mm,bottom=15mm,left=20mm]{geometry}
\RequirePackage{pgfkeys}

\setlength{\unitlength}{1mm}

\def\ps@uspdluheadings{
  \def\@oddfoot{\\{Литера <<О>>}} % ГОСТ 2.103-68
  \def\@evenfoot{\\{Литера <<О>>}}
  \let\@oddhead\@empty\let\@evenhead\@empty
  \let\@mkboth\@gobbletwo
  \let\sectionmark\@gobble
  \let\subsectionmark\@gobble
}

\def\ps@uspdnormheadings{
  \let\@oddfoot\@empty\let\@evenfoot\@empty
  \def\@oddhead{
  	\vbox{
		\vbox{\hfil\thepage\hfil}
		{\vskip 5mm}
		\vbox{\hfil\rightmark\hfil}
	}
  }
  \def\@evenhead{\\{\leftmark}\\}
  \let\@mkboth\@gobbletwo
  \let\sectionmark\@gobble
  \let\subsectionmark\@gobble
}

\newcommand\stamp[1]{{
\newpage
\noindent\begin{picture}(0,0)(0,0)
\put(-12,-252){\framebox(12,145)}
\put(-7,-252){\line(0,1){145}}
\put(-12,-142){\line(1,0){12}}
\put(-12,-167){\line(1,0){12}}
\put(-12,-192){\line(1,0){12}}
\put(-12,-227){\line(1,0){12}}
\put(-11,-251){\begin{sideways}\parbox[t]{25mm}{\small Инв. {\No} подп.}\end{sideways}}
\put(-11,-226){\begin{sideways}\parbox[t]{35mm}{\small Подп. и дата}\end{sideways}}
\put(-11,-191){\begin{sideways}\parbox[t]{25mm}{\small Взам инв. {\No}}\end{sideways}}
\put(-11,-166){\begin{sideways}\parbox[t]{25mm}{\small Инв. {\No} дубл.}\end{sideways}}
\put(-11,-141){\begin{sideways}\parbox[t]{35mm}{\small Подп. и дата}\end{sideways}}
\end{picture}
#1
\newpage
}}

\newcommand\signfield[1]{\underline{\phantom{ЖЖЖЖЖ}}~{#1}}
\newcommand\datefield{<<\underline{\phantom{Ж}}>>~\underline{\phantom{ЖЖЖЖЖ}}~{\number\year}~г.}
\newcommand\signeefield[3]{#1\newline\signfield{#2}\newline\datefield\newline\newline}
\newcommand\pagesfield[1]{\ifthenelse{\pageref{#1} > 1}{Листов \pageref{#1}}{}}

\newcommand\LU[1]{\markboth{{#1}--ЛУ}{{#1}--ЛУ}\setcounter{page}{1}
\thispagestyle{uspdnormheadings}\stamp{
% field 0, label
%{\noindent\hfill Совершенно секретно}

\begin{center}

% field 1, organization
%{Московский Государственный Университет имени М. В. Ломоносова}

% field 2, names and signatures
\begin{tabular}{p{70mm}cp{70mm}}
\multicolumn{1}{c}{
  \setbox0=\hbox{\agreeingsT{}\unskip}\ifdim\wd0=0pt
    % empty
  \else
    СОГЛАСОВАНО%
  \fi
} & & \multicolumn{1}{c}{УТВЕРЖДАЮ} \\
& & \\
\agreeingsT{} & & \approversT{} \\
\end{tabular}

\vskip 20mm

% field 3, program name, allcaps

%\makeatletter
\@title
%\makeatother

\vskip 7mm

{\large ЛИСТ УТВЕРЖДЕНИЯ}

\vskip 10mm

% field 4, document id, storage type

{{#1}--ЛУ}

%{\scriptsize (вид носителя данных)}

% field 5, number of sheets (only if > 1)
\pagesfield{endlu}

\vskip 10mm

% field 6,
\begin{tabular}{p{70mm}cp{70mm}}
\agreeingsB{} & & \approversB{} \\
\end{tabular}

% field 7, year
\vfill
{{\number\year}}
\end{center}
\label{endlu}
\thispagestyle{uspdluheadings}
}

\newcommand\TP[1]{{\markboth{{#1}}{{#1}}\setcounter{page}{1}\stamp{
\thispagestyle{uspdluheadings}

{УТВЕРЖДЕНО}

{{#1}--ЛУ}

\vskip 10mm

% field 1, organization
%\begin{center}
%{Московский Государственный Университет имени М. В. Ломоносова}
%\end{center}

% field 2, names and signatures
{}

\vskip 20mm

% field 3, program name, allcaps
\begin{center}
\makeatletter
\@title
\makeatother

\end{center}

\vskip 20mm

% field 4, document id, storage type
\begin{center}
{{#1}}
%{\scriptsize (вид носителя данных)}
\end{center}

% field 5, number of sheets (only if > 1)
\begin{center}
\pagesfield{enddoc}
\end{center}

% field 6,

% field 7, year
\vfill
\begin{center}
{{\number\year}}
\end{center}
}}
}}

\newcommand\uspd@LI{{
\newpage
\noindent\begin{picture}(185,247)(0,0)
\put(0,0){\line(0,1){247}}
\put(8,0){\line(0,1){232}}
\put(28,0){\line(0,1){232}}
\put(48,0){\line(0,1){232}}
\put(68,0){\line(0,1){232}}
\put(88,0){\line(0,1){237}}
\put(108,0){\line(0,1){237}}
\put(133,0){\line(0,1){237}}
\put(158,0){\line(0,1){237}}
\put(173,0){\line(0,1){237}}
\put(185,0){\line(0,1){247}}
\put(0,247){\line(1,0){185}}
\put(0,237){\line(1,0){185}}
\put(0,232){\line(1,0){88}}
\put(0,212){\line(1,0){185}}
\put(0,0){\line(1,0){185}}
\multiput(0,207)(0,-5){41}{\line(1,0){185}}
\put(0,237){\makebox[185mm][c]{\raisebox{2\depth}{\Large Лист регистрации изменений}}}
\put(0,232){\makebox[88mm][c]{\raisebox{1.5\depth}{\small Номера листов (страниц)}}}
\put(0.5,227){\parbox[t]{7mm}{\small Изм}}
\put(9,227){\parbox[t]{18mm}{\small из\-ме\-нён\-ных}}
\put(29,227){\parbox[t]{18mm}{\small за\-ме\-нён\-ных}}
\put(49,227){\parbox[t]{18mm}{\small но\-вых}}
\put(69,227){\parbox[t]{18mm}{\small ан\-ну\-ли\-ро\-ван\-ных}}
\put(89,232){\parbox[t]{18mm}{\small Всего листов (страниц) в докум}}
\put(109,232){\parbox[t]{23mm}{\small {\No} документа}}
\put(134,232){\parbox[t]{23mm}{\small Входящий {\No} сопроводительного докум и дата}}
\put(159,232){\parbox[t]{13mm}{\small Подп}}
\put(174,232){\parbox[t]{10mm}{\small Дата}}
\label{enddoc}
\end{picture}
\newpage
}}


\pgfkeys{
  /uspd/.cd,
  designation/.store in =\designation,
  abstract/.store in =\abstract,
  agreeingsT/.store in = \agreeingsT,
  agreeingsB/.store in = \agreeingsB,
  approversT/.store in = \approversT,
  approversB/.store in = \approversB,
  agreeingsT,agreeingsB,
  approversT,approversB
}


\newcommand{\uspdset}[1][]{
  \pgfkeys{/uspd/.cd,#1}
}

\AtBeginDocument{
  \sloppy
  \LU{\designation{}}
  \TP{\designation{}}
  \pagestyle{uspdnormheadings}
  \section*{Аннотация}\abstract{}\newpage
  \tableofcontents\newpage
}

\AtEndDocument{\uspd@LI}
