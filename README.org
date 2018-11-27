#+STARTUP: indent content
#+TITLE: stockAssessTeX
資源評価TeX版リポジトリ。
HPサンプル　https://smxshxishxad.github.io/stockAssessTeX/
** TODO 環境設定 [50%]
*** TODO Docker環境の整備
*** DONE Redpen
*** TODO 引用文献
*** TODO 目次
*** DONE 柱
*** DONE ページ番号
*** 提出方法を考える
*** TODO Windowsバッチファイル
*** DONE Macシェルスクリプト
** マニュアル作成
** サンプル作成
*** ASSIGNED TAC種（マアジ）
*** 非TAC種（カタクチイワシ）

**** CANCELLED Plan1::Using include and chapterbib
この方法は適さなかったのでやめる。
pdfpageを使うプラン2で進める。

- State "CANCELLED"  from "DONE"       [2018-06-19 Tue 22:56]
- State "DONE"       from "TODO"       [2018-06-19 Tue 22:56]
- State "WAITING"    from "TODO"       [2018-06-19 Tue 22:56]
- State "WAITING"    from "TODO"       [2018-06-19 Tue 22:56]
- State "DONE"       from "TODO"       [2018-06-19 Tue 20:49]
- _Typesetme.tex
  + \include{fish1}
  + \include{fish2}
    + \input{controllingfiles/maegaki}
    + \input{gyogyou_jyoukyou}
    + \biblographystyle{}
    + \bibliography{bib}

***** タイプセット用スクリプト
#+BEGIN_SRC sh :tangle ./typeset_plan1.sh
platex ./master_plan1
pbibtex ./PF_Engraulis-japonicus_nonTAC_1_withB
pbibtex ./TW_Engraulis-japonicus_nonTAC_1_withB
platex ./master_plan1
platex ./master_plan1
dvipdfmx ./master_plan1
open -a Skim ./master_plan1.pdf
#+END_SRC
***** マスターファイル
#+BEGIN_SRC tex :tangle ~/Documents/GitHub/stockAssessTeX/master_plan1.tex
\documentclass[A4j, disablejfam, titlepage, openright, twoside, 10.5pt]{myjsbook}
\linespread{1.5}
\usepackage[dvipdfmx, hiresbb]{graphicx, xcolor}
\usepackage{draftwatermark}
\usepackage{otf}
\usepackage{array, booktabs}
\usepackage{blindtext}
\usepackage{colortbl}
\usepackage{atbegshi}
\usepackage{amsmath}
\usepackage{url}
\usepackage{fancyhdr}
\usepackage{TW_Engraulis-japonicus}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\chaptermark}[1]{\markright{}}
\renewcommand{\sectionmark}[1]{\markright{}}
\chead{\thechapter--\thepage--}
\cfoot{\normalfont\hfil-- \thepage\ --\hfil}
\ifnum 42146=\euc"A4A2
  \AtBeginShipoutFirst{\special{pdf:tounicode EUC-UCS2}}
\else
  \AtBeginShipoutFirst{\special{pdf:tounicode 90ms-RKSJ-UCS2}}
\fi
%\usepackage{footnpag}
%\makeatletter
%\let\original@@makefntext\@makefntext
%\let\original@footnoterule\footnoterule
%\makeatother
%\usepackage{ftnright}
%\makeatletter
%\let\@makefntext\original@@makefntext
%\let\footnoterule\original@footnoterule
%\makeatother

\makeatletter
\newcommand\footnoteref[1]{\protected@xdef\@thefnmark{\ref{#1}}\@footnotemark}
\makeatother

\usepackage[dvipdfmx,
bookmarks=true,%
bookmarksnumbered=true,%
bookmarksopen=true,%
]{hyperref}
%\setlength{\textwidth}{\fullwidth}
\setlength{\textwidth}{15truecm}
\setlength{\hoffset}{0pt}
\setlength{\voffset}{-1.54truecm}
\setlength{\headsep}{2truecm}
\setlength{\footskip}{2truecm}
\setlength{\textheight}{23truecm}
%\setlength{\textwidth}{35zw}
%\setlength{\textheight}{50zw}
%\setlength{\headwidth}{1truemm}
%\addtolength{\textheight}{\topskip}
%\setlength{\topmargin}{0pt}
%\setlength{\voffset}{-15truemm}
%\setlength{\hoffset}{-5truemm}
\setlength{\marginparsep}{1truecm}
\setlength{\marginparwidth}{0pt}
\setlength{\oddsidemargin}{0.46truecm}
\setlength{\evensidemargin}{\oddsidemargin}
\setlength{\abovecaptionskip}{-3truemm}
\setlength{\belowcaptionskip}{-2truemm}
\SetWatermarkLightness{0.9}
\setcounter{tocdepth}{1} %1だとchapterまで目次に表示される
%\usepackage{ctable, dcolumn}
\usepackage[format=hang, labelsep=period]{caption}
\usepackage[sectionbib]{chapterbib}
\usepackage{float}
\usepackage[T1]{fontenc}
%\usepackage[scaled]{helvet}
\usepackage{layout}
\usepackage{pdflscape}
%\usepackage{myCitation}
\usepackage{multirow}
\usepackage{multicol}
\usepackage{newtxtext, newtxmath}
\usepackage{otf}
\usepackage{pifont}
%\usepackage{subcaption}
\usepackage{subfig}
\usepackage{tabularx}
\usepackage{textcomp}
\usepackage{threeparttable}
\usepackage{subfiles} % 独立タイプセットを可能にするが、chapterbibと併用できないので使用を停止。併用のためには正規表現などで工夫する必要がある。
\usepackage{tocbibind}
\usepackage[authoryear, round, sort&compress]{mynatbib} %natbibを使うと引用文献が続きになってしまう。
%\bibliographystyle{mynatbib}
%\usepackage{jecon}
\bibliographystyle{jecon}     %jeconの利用を検討中。\citealtなどの引用文を変更する必要あり
%\setcitestyle{number,close={)}}

%ここから 引用文献レベルをsubsectionに再定義
\makeatletter
\renewenvironment{thebibliography}[1]{%
  %\global\let\presectionname\relax
  %\global\let\postsectionname\relax
  \subsection{\bibname}\@mkboth{\bibname}{}%
  %\addcontentsline{toc}{subsection}{\bibname}%   これをオンにすると目次に2回出てきてしまう
  \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
        \setlength{\itemindent}{-2zw}%      文献リストのインデント
        \setlength{\topsep}{-10zw}%         引用文献」から最初の文献までの空白
        %\leftmargin\labelwidth
        %\advance\leftmargin\labelsep
        %\@openbib@code
        %\usecounter{enumiv}%
        %\let\p@enumiv\@empty
        %\renewcommand\theenumiv{\@arabic\c@enumiv}
        }%
  %\sloppy
  %\clubpenalty4000
  %\@clubpenalty\clubpenalty
  %\widowpenalty4000%
  \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}
\makeatother
%ここまで 引用文献レベルをsubsectionに再定義


%ハイフネーション設定
\hyphenation{Engraulis}
\hyphenation{japonicus}

\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{qtm}
\renewcommand{\baselinestretch}{1}
\renewcommand{\thefootnote}{*\roman{footnote}}
\renewcommand{~}{\phantom{0}}
\makeatletter
   \renewcommand{\thefigure}{\arabic{figure}}%      図番号の体裁
  \@addtoreset{figure}{section}
 \makeatother

 \makeatletter
 \renewcommand{\thetable}{arabic{table}}%       表番号の体裁
  \@addtoreset{table}{section}
\makeatother
%コマンド
\setcounter{secnumdepth}{3}
\newcommand{\fcur}{$F_{current}$}
\newcommand{\fmed}{Fmed}
\newcommand{\要約}{\begin{center}\Large{{\gt 要　　　約}}\end{center}}
\newcommand{\digest}{}
%\newcommand{\}{}

%環境
\newenvironment{OneOfSixFigs}[3]{
\begin{figure}[htp]
    \captionsetup{width=65mm}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=70mm]{#1}
  \end{center}
  \caption{#2}
  \label{#3}
 \end{minipage}
\end{figure}}

\newenvironment{TwoOfSixFigs}[6]{
\begin{figure}[htp]
    \captionsetup{width=65mm}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=70mm]{#1}
  \end{center}
  \caption{#2}
  \label{#3}
 \end{minipage}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=70mm]{#4}
  \end{center}
  \caption{#5}
  \label{#6}
 \end{minipage}
\end{figure}}

\newenvironment{TwoOfEightFigs}[6]{
\begin{figure}[htp]
    \captionsetup{width=60mm}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=60mm]{#1}
  \end{center}
  \caption{#2}
  \label{#3}
 \end{minipage}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=60mm]{#4}
  \end{center}
  \caption{#5}
  \label{#6}
 \end{minipage}
\end{figure}}

%担当機関
\newenvironment{担当機関等}[3]{
\begin{table}[h]
\begin{tabular}{{rp{12.2cm}}}
責任担当水研: &#1 （#2）\\
参画機関: & #3
\end{tabular}
\end{table}
}

%過去5年間の資源量等
\newenvironment{過去五年間の資源量等}[5]{
\begin{center}
\begin{tabular}{cccccc}
\toprule
\multirow{2}{*}{年}	& {資源量}  & {親魚量}  & {漁獲量}	&	{$F$} & {漁獲割合}\tabularnewline
          &   (千トン)	& (千トン)		&	(千トン)&		&	（\%）	\tabularnewline
\hline
#1  \tabularnewline
#2  \tabularnewline
#3  \tabularnewline
#4  \tabularnewline
#5  \tabularnewline
\bottomrule
\end{tabular}
\end{center}
}

\begin{document}
\frontmatter
%\layout
%
%
\title{
{\thisyrjp}年度
\\
{\HUGE 我が国周辺水域の漁業資源評価}}
\author{\\
\\
\\
\\
\\
\\
\\
\\
\\
{\Large 水産庁増殖推進部}
\\
}
\date{\today}
%\maketitle
%
%
%
\mainmatter
%\part*{第1分冊}
\tableofcontents
%\include{_PF_Sardinops-melanostictus}
%\include{_SI_Sardinops-melanostictus}
%\include{output/TW_Sardinops-melanostictus_TAC_rule1}
%\include{_TW_Engraulis-japonicus}
%\part*{第2分冊}
%\include{_PF_Engraulis-japonicus}
%\include{_SI_Engraulis-japonicus}
%\include{_TW_Engraulis-japonicus}
\include{PF_Engraulis-japonicus_nonTAC_1_withB}
\include{TW_Engraulis-japonicus_nonTAC_1_withB}


%\part*{第2分冊}
%\include{_TW_Engraulis-japonicus}
%\include{sweave_test}
%\onecolumn
%\begin{multicols}{2}
%\listoftables
%\listoffigures
%\end{multicols}
%
%
%
\end{document}

#+END_SRC

***** 魚種ファイル1
#+BEGIN_SRC tex :tangle ~/Documents/GitHub/stockAssessTeX/PF_Engraulis-japonicus_nonTAC_1_withB.tex
%編集不要									編集不要
%	編集不要							編集不要
%		編集不要					編集不要
%			編集不要			編集不要
%				編集不要	編集不要
%					編集不要
%					編集不要
%				編集不要	編集不要
%			編集不要			編集不要
%		編集不要					編集不要
%	編集不要							編集不要
%編集不要									編集不要
%
%
%

\chapter{平成\ThisYrJp（\ThisYr）年度カタクチイワシ太平洋系群の資源評価}
%
\input{files_to_edit/TW_Engraulis-japonicus_sekinintantou}
\input{files_to_edit/TW_Engraulis-japonicus_youyaku}
\input{files_to_edit/PF_Engraulis-japonicus_maegaki}
\input{controllingfiles/TW_Engraulis-japonicus_seitai}
\input{controllingfiles/TW_Engraulis-japonicus_gyogyou_joukyou}
\input{controllingfiles/TW_Engraulis-japonicus_shigennojoutai}
\input{controllingfiles/TW_Engraulis-japonicus_abc_santei_thisyear}
\input{files_to_edit/TW_Engraulis-japonicus_abc_igai}

\bibliographystyle{mynatbib}
\bibliography{files_to_edit/PF_Engraulis-japonicus_references}
\clearpage
\input{files_to_edit/TW_Engraulis-japonicus_figures}
%\input{_tables}
%\setcounter{chapter}{0}
#+END_SRC

***** 魚種ファイル2
#+BEGIN_SRC tex :tangle ~/Documents/GitHub/stockAssessTeX/TW_Engraulis-japonicus_nonTAC_1_withB.tex
%編集不要									編集不要
%	編集不要							編集不要
%		編集不要					編集不要
%			編集不要			編集不要
%				編集不要	編集不要
%					編集不要
%					編集不要
%				編集不要	編集不要
%			編集不要			編集不要
%		編集不要					編集不要
%	編集不要							編集不要
%編集不要									編集不要
%
%
%

\chapter{平成\ThisYrJp（\ThisYr）年度カタクチイワシ対馬暖流系群の資源評価}
%
\input{files_to_edit/TW_Engraulis-japonicus_sekinintantou}
\input{files_to_edit/TW_Engraulis-japonicus_youyaku}
\input{files_to_edit/TW_Engraulis-japonicus_maegaki}
\input{controllingfiles/TW_Engraulis-japonicus_seitai}
\input{controllingfiles/TW_Engraulis-japonicus_gyogyou_joukyou}
\input{controllingfiles/TW_Engraulis-japonicus_shigennojoutai}
\input{controllingfiles/TW_Engraulis-japonicus_abc_santei_thisyear}
\input{files_to_edit/TW_Engraulis-japonicus_abc_igai}

\bibliographystyle{mynatbib}
\bibliography{files_to_edit/TW_Engraulis-japonicus_references}
\clearpage
\input{files_to_edit/TW_Engraulis-japonicus_figures}
%\input{_tables}
%\setcounter{chapter}{0}
#+END_SRC
***** DONE Test for separated references
CLOCK: [2018-06-19 Tue 09:06]--[2018-06-19 Tue 10:11] =>  1:05
***** DONE Install redpen system
- State "DONE"       from ""           [2018-06-19 Tue 09:07]
***** DONE Install chapterbib.sty
- State "DONE"       from "TODO"       [2018-06-19 Tue 19:57]
***** CANCELLED 柱の体裁を整える
- State "CANCELLED"  from "TODO"       [2018-06-19 Tue 22:56]
難しそう。
柱は系群名-系群ページ数-
ページ番号は通し
***** CANCELLED 目次の”第何章”を消す

**** TODO Plan2::Using subfiles and pdfpages [50%]
***** DONE とりあえず文書の形になるようにする [100%]
- State "DONE"       from "TODO"       [2018-06-19 Tue 23:25]
- State "DONE"       from "TODO"       [2018-06-19 Tue 21:32]
****** DONE タイプセットファイル
- State "DONE"       from "TODO"       [2018-06-19 Tue 21:16]
#+BEGIN_SRC sh :tangle ./typeset_plan2.sh
platex ./fish1
pbibtex ./fish1
platex ./fish1
platex ./fish1
dvipdfmx ./fish1
platex ./fish2
pbibtex ./fish2
platex ./fish2
platex ./fish2
dvipdfmx ./fish2
platex ./master_plan2
dvipdfmx ./master_plan2
open -a Skim ./master_plan2.pdf

#+END_SRC
****** DONE マスターファイル
- State "DONE"       from "TODO"       [2018-06-19 Tue 21:03]
#+BEGIN_SRC tex :tangle ./master_plan2.tex
\documentclass[A4j, disablejfam, titlepage, openright, twoside, 10.5pt, dvipdfmx, report, uplatex]{myjsbook}
\linespread{1.5}
\usepackage[dvipdfmx, hiresbb]{graphicx, xcolor}
\usepackage{otf}
\usepackage{array, booktabs}
\usepackage{blindtext}
\usepackage{colortbl}
\usepackage{atbegshi}
\usepackage{amsmath}
\usepackage{url}
\usepackage{pdfpages}
\usepackage{fancyhdr}
\pagestyle{fancy}
\cfoot{--\thepage--}
\lhead{}
%\usepackage{footnpag}
%\makeatletter
%\let\original@@makefntext\@makefntext
%\let\original@footnoterule\footnoterule
%\makeatother
%\usepackage{ftnright}
%\makeatletter
%\let\@makefntext\original@@makefntext
%\let\footnoterule\original@footnoterule
%\makeatother

\makeatletter
\newcommand\footnoteref[1]{\protected@xdef\@thefnmark{\ref{#1}}\@footnotemark}
\makeatother

\usepackage[dvipdfmx,
bookmarks=true,%
bookmarksnumbered=true,%
bookmarksopen=true,%
]{hyperref}
%\setlength{\textwidth}{\fullwidth}
\setlength{\textwidth}{15truecm}
\setlength{\hoffset}{0pt}
\setlength{\voffset}{-1.54truecm}
\setlength{\headsep}{2truecm}
\setlength{\footskip}{2truecm}
\setlength{\textheight}{23truecm}
%\setlength{\textwidth}{35zw}
%\setlength{\textheight}{50zw}
%\setlength{\headwidth}{1truemm}
%\addtolength{\textheight}{\topskip}
%\setlength{\topmargin}{0pt}
%\setlength{\voffset}{-15truemm}
%\setlength{\hoffset}{-5truemm}
\setlength{\marginparsep}{1truecm}
\setlength{\marginparwidth}{0pt}
\setlength{\oddsidemargin}{0.46truecm}
\setlength{\evensidemargin}{\oddsidemargin}
\setlength{\abovecaptionskip}{-3truemm}
\setlength{\belowcaptionskip}{-2truemm}
\setcounter{tocdepth}{1} %1だとchapterまで目次に表示される
%\usepackage{ctable, dcolumn}
\usepackage[format=hang, labelsep=period]{caption}
\usepackage[sectionbib]{chapterbib}
\usepackage{float}
\usepackage[T1]{fontenc}
%\usepackage[scaled]{helvet}
\usepackage{layout}
\usepackage{pdflscape}
%\usepackage{myCitation}
\usepackage{multirow}
\usepackage{multicol}
%\usepackage{newtxtext, newtxmath}
\usepackage{otf}
\usepackage{pifont}
%\usepackage{subcaption}
\usepackage{subfig}
\usepackage{tabularx}
\usepackage{textcomp}
\usepackage{threeparttable}
\usepackage{subfiles} % 独立タイプセットを可能にするが、chapterbibと併用できないので使用を停止。併用のためには正規表現などで工夫する必要がある。
\usepackage{tocbibind}
\usepackage[authoryear, round, sort&compress]{mynatbib} %natbibを使うと引用文献が続きになってしまう。
%\bibliographystyle{mynatbib}
%\usepackage{jecon}
\bibliographystyle{jecon}     %jeconの利用を検討中。\citealtなどの引用文を変更する必要あり
%\setcitestyle{number,close={)}}

%ここから 引用文献レベルをsubsectionに再定義
\makeatletter
\renewenvironment{thebibliography}[1]{%
  %\global\let\presectionname\relax
  %\global\let\postsectionname\relax
  \subsection{\bibname}\@mkboth{\bibname}{}%
  %\addcontentsline{toc}{subsection}{\bibname}%   これをオンにすると目次に2回出てきてしまう
  \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
        \setlength{\itemindent}{-2zw}%      文献リストのインデント
        \setlength{\topsep}{-10zw}%         引用文献」から最初の文献までの空白
        %\leftmargin\labelwidth
        %\advance\leftmargin\labelsep
        %\@openbib@code
        %\usecounter{enumiv}%
        %\let\p@enumiv\@empty
        %\renewcommand\theenumiv{\@arabic\c@enumiv}
        }%
  %\sloppy
  %\clubpenalty4000
  %\@clubpenalty\clubpenalty
  %\widowpenalty4000%
  \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}
\makeatother
%ここまで 引用文献レベルをsubsectionに再定義


%ハイフネーション設定
\hyphenation{Engraulis}
\hyphenation{japonicus}

\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{qtm}
\renewcommand{\baselinestretch}{1}
\renewcommand{\thefootnote}{*\roman{footnote}}
\renewcommand{~}{\phantom{0}}
\makeatletter
   \renewcommand{\thefigure}{\arabic{figure}}%      図番号の体裁
  \@addtoreset{figure}{section}
 \makeatother

 \makeatletter
 \renewcommand{\thetable}{arabic{table}}%       表番号の体裁
  \@addtoreset{table}{section}
\makeatother
%コマンド
\setcounter{secnumdepth}{3}
\newcommand{\fcur}{$F_{current}$}
\newcommand{\fmed}{Fmed}
\newcommand{\要約}{\begin{center}\Large{{\gt 要　　　約}}\end{center}}
\newcommand{\digest}{}
%\newcommand{\}{}

%環境
\newenvironment{OneOfSixFigs}[3]{
\begin{figure}[htp]
    \captionsetup{width=65mm}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=70mm]{#1}
  \end{center}
  \caption{#2}
  \label{#3}
 \end{minipage}
\end{figure}}

\newenvironment{TwoOfSixFigs}[6]{
\begin{figure}[htp]
    \captionsetup{width=65mm}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=70mm]{#1}
  \end{center}
  \caption{#2}
  \label{#3}
 \end{minipage}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=70mm]{#4}
  \end{center}
  \caption{#5}
  \label{#6}
 \end{minipage}
\end{figure}}

\newenvironment{TwoOfEightFigs}[6]{
\begin{figure}[htp]
    \captionsetup{width=60mm}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=60mm]{#1}
  \end{center}
  \caption{#2}
  \label{#3}
 \end{minipage}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=60mm]{#4}
  \end{center}
  \caption{#5}
  \label{#6}
 \end{minipage}
\end{figure}}

%担当機関
\newenvironment{担当機関等}[3]{
\begin{table}[h]
\begin{tabular}{{rp{12.2cm}}}
責任担当水研: &#1 （#2）\\
参画機関: & #3
\end{tabular}
\end{table}
}

%過去5年間の資源量等
\newenvironment{過去五年間の資源量等}[5]{
\begin{center}
\begin{tabular}{cccccc}
\toprule
\multirow{2}{*}{年} & {資源量}  & {親魚量}  & {漁獲量}  & {$F$} & {漁獲割合}\tabularnewline
          &   (千トン)  & (千トン)    & (千トン)&   & （\%）  \tabularnewline
\hline
#1  \tabularnewline
#2  \tabularnewline
#3  \tabularnewline
#4  \tabularnewline
#5  \tabularnewline
\bottomrule
\end{tabular}
\end{center}
}

\begin{document}
\frontmatter
%\layout
%
%
\title{
{\thisyrjp}年度
\\
{\HUGE 我が国周辺水域の漁業資源評価}}
\author{\\
\\
\\
\\
\\
\\
\\
\\
\\
{\Large 水産庁増殖推進部}
\\
}
\date{\today}
%\maketitle
%
%
%
\mainmatter
%\part*{第1分冊}
\tableofcontents
%\include{_PF_Sardinops-melanostictus}
%\include{_SI_Sardinops-melanostictus}
%\include{output/TW_Sardinops-melanostictus_TAC_rule1}
%\include{_TW_Engraulis-japonicus}
%\part*{第2分冊}
%\include{_PF_Engraulis-japonicus}
%\include{_SI_Engraulis-japonicus}
%\include{_TW_Engraulis-japonicus}
\includepdf[pages=-, pagecommand={\thispagestyle{plain}}]{fish1}
\includepdf[pages=-, pagecommand={\thispagestyle{plain}}]{fish2}
%\includepdf[pages=-]{fish2}


%\part*{第2分冊}
%\include{_TW_Engraulis-japonicus}
%\include{sweave_test}
%\onecolumn
%\begin{multicols}{2}
%\listoftables
%\listoffigures
%\end{multicols}
%
%
%
\end{document}

#+END_SRC
****** DONE 魚種ファイル1
- State "DONE"       from "TODO"       [2018-06-19 Tue 21:10]
#+BEGIN_SRC tex :tangle ./fish1.tex
\documentclass[A4j, disablejfam, titlepage, openright, twoside, 10.5pt, uplatex]{myjsbook}
\linespread{1.5}
\usepackage[dvipdfmx, hiresbb]{graphicx, xcolor}
\usepackage{draftwatermark}
\usepackage{otf}
\usepackage{array, booktabs}
\usepackage{blindtext}
\usepackage{colortbl}
\usepackage{atbegshi}
\usepackage{amsmath}
\usepackage{url}
\usepackage{fancyhdr}
\usepackage{subfiles}
\usepackage{TW_Engraulis-japonicus}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0.0pt}
\addtolength{\headheight}{20.0pt}

\renewcommand{\chaptermark}[1]{\markright{}}
\renewcommand{\sectionmark}[1]{\markright{}}
\markboth{}{}
\lhead{}
\chead{カタクチイワシ対馬暖流系群 --\thepage--}
\rhead{}
\cfoot{}
\ifnum 42146=\euc"A4A2
  \AtBeginShipoutFirst{\special{pdf:tounicode EUC-UCS2}}
\else
  \AtBeginShipoutFirst{\special{pdf:tounicode 90ms-RKSJ-UCS2}}
\fi
%\usepackage{footnpag}
%\makeatletter
%\let\original@@makefntext\@makefntext
%\let\original@footnoterule\footnoterule
%\makeatother
%\usepackage{ftnright}
%\makeatletter
%\let\@makefntext\original@@makefntext
%\let\footnoterule\original@footnoterule
%\makeatother

\makeatletter
\newcommand\footnoteref[1]{\protected@xdef\@thefnmark{\ref{#1}}\@footnotemark}
\makeatother

\usepackage[dvipdfmx,
bookmarks=true,%
bookmarksnumbered=true,%
bookmarksopen=true,%
]{hyperref}
%\setlength{\textwidth}{\fullwidth}
\setlength{\textwidth}{15truecm}
\setlength{\hoffset}{0pt}
\setlength{\voffset}{-1.54truecm}
\setlength{\headsep}{2truecm}
\setlength{\footskip}{2truecm}
\setlength{\textheight}{23truecm}
%\setlength{\textwidth}{35zw}
%\setlength{\textheight}{50zw}
%\setlength{\headwidth}{1truemm}
%\addtolength{\textheight}{\topskip}
%\setlength{\topmargin}{0pt}
%\setlength{\voffset}{-15truemm}
%\setlength{\hoffset}{-5truemm}
\setlength{\marginparsep}{1truecm}
\setlength{\marginparwidth}{0pt}
\setlength{\oddsidemargin}{0.46truecm}
\setlength{\evensidemargin}{\oddsidemargin}
\setlength{\abovecaptionskip}{-3truemm}
\setlength{\belowcaptionskip}{-2truemm}
\SetWatermarkLightness{0.9}
\setcounter{tocdepth}{1} %1だとchapterまで目次に表示される
%\usepackage{ctable, dcolumn}
\usepackage[format=hang, labelsep=period]{caption}
\usepackage[sectionbib]{chapterbib}
\usepackage{float}
\usepackage[T1]{fontenc}
%\usepackage[scaled]{helvet}
\usepackage{layout}
\usepackage{pdflscape}
%\usepackage{myCitation}
\usepackage{multirow}
\usepackage{multicol}
%\usepackage{newtxtext, newtxmath}
\usepackage{otf}
\usepackage{pifont}
%\usepackage{subcaption}
\usepackage{subfig}
\usepackage{tabularx}
\usepackage{textcomp}
\usepackage{threeparttable}
\usepackage{subfiles} % 独立タイプセットを可能にするが、chapterbibと併用できないので使用を停止。併用のためには正規表現などで工夫する必要がある。
\usepackage{tocbibind}
\usepackage[authoryear, round, sort&compress]{mynatbib} %natbibを使うと引用文献が続きになってしまう。
%\bibliographystyle{mynatbib}
%\usepackage{jecon}
\bibliographystyle{jecon}     %jeconの利用を検討中。\citealtなどの引用文を変更する必要あり
%\setcitestyle{number,close={)}}

%ここから 引用文献レベルをsubsectionに再定義
\makeatletter
\renewenvironment{thebibliography}[1]{%
  %\global\let\presectionname\relax
  %\global\let\postsectionname\relax
  \subsection{\bibname}\@mkboth{\bibname}{}%
  %\addcontentsline{toc}{subsection}{\bibname}%   これをオンにすると目次に2回出てきてしまう
  \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
        \setlength{\itemindent}{-2zw}%      文献リストのインデント
        \setlength{\topsep}{-10zw}%         引用文献」から最初の文献までの空白
        %\leftmargin\labelwidth
        %\advance\leftmargin\labelsep
        %\@openbib@code
        %\usecounter{enumiv}%
        %\let\p@enumiv\@empty
        %\renewcommand\theenumiv{\@arabic\c@enumiv}
        }%
  %\sloppy
  %\clubpenalty4000
  %\@clubpenalty\clubpenalty
  %\widowpenalty4000%
  \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}
\makeatother
%ここまで 引用文献レベルをsubsectionに再定義


%ハイフネーション設定
\hyphenation{Engraulis}
\hyphenation{japonicus}

\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{qtm}
\renewcommand{\baselinestretch}{1}
\renewcommand{\thefootnote}{*\roman{footnote}}
\renewcommand{~}{\phantom{0}}
\makeatletter
   \renewcommand{\thefigure}{\arabic{figure}}%      図番号の体裁
  \@addtoreset{figure}{section}
 \makeatother

 \makeatletter
 \renewcommand{\thetable}{arabic{table}}%       表番号の体裁
  \@addtoreset{table}{section}
\makeatother
%コマンド
\setcounter{secnumdepth}{3}
\newcommand{\fcur}{$F_{current}$}
\newcommand{\fmed}{Fmed}
\newcommand{\要約}{\begin{center}\Large{{\gt 要　　　約}}\end{center}}
\newcommand{\digest}{}
%\newcommand{\}{}

%環境
\newenvironment{OneOfSixFigs}[3]{
\begin{figure}[htp]
    \captionsetup{width=65mm}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=70mm]{#1}
  \end{center}
  \caption{#2}
  \label{#3}
 \end{minipage}
\end{figure}}

\newenvironment{TwoOfSixFigs}[6]{
\begin{figure}[htp]
    \captionsetup{width=65mm}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=70mm]{#1}
  \end{center}
  \caption{#2}
  \label{#3}
 \end{minipage}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=70mm]{#4}
  \end{center}
  \caption{#5}
  \label{#6}
 \end{minipage}
\end{figure}}

\newenvironment{TwoOfEightFigs}[6]{
\begin{figure}[htp]
    \captionsetup{width=60mm}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=60mm]{#1}
  \end{center}
  \caption{#2}
  \label{#3}
 \end{minipage}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=60mm]{#4}
  \end{center}
  \caption{#5}
  \label{#6}
 \end{minipage}
\end{figure}}

%担当機関
\newenvironment{担当機関等}[3]{
\begin{table}[h]
\begin{tabular}{{rp{12.2cm}}}
責任担当水研: &#1 （#2）\\
参画機関: & #3
\end{tabular}
\end{table}
}

%過去5年間の資源量等
\newenvironment{過去五年間の資源量等}[5]{
\begin{center}
\begin{tabular}{cccccc}
\toprule
\multirow{2}{*}{年} & {資源量}  & {親魚量}  & {漁獲量}  & {$F$} & {漁獲割合}\tabularnewline
          &   (千トン)  & (千トン)    & (千トン)&   & （\%）  \tabularnewline
\hline
#1  \tabularnewline
#2  \tabularnewline
#3  \tabularnewline
#4  \tabularnewline
#5  \tabularnewline
\bottomrule
\end{tabular}
\end{center}
}

\begin{document}
\frontmatter
%\layout
%
%
\title{
{\thisyrjp}年度
\\
{\HUGE 我が国周辺水域の漁業資源評価}}
\author{\\
\\
\\
\\
\\
\\
\\
\\
\\
{\Large 水産庁増殖推進部}
\\
}
\date{\today}
%\maketitle
%
%
%
\mainmatter
\chapter*{平成\ThisYrJp（\ThisYr）年度カタクチイワシ対馬暖流系群の資源評価}

\input{files_to_edit/TW_Engraulis-japonicus_sekinintantou}
\input{files_to_edit/TW_Engraulis-japonicus_youyaku}
\subfile{files_to_edit/fish1_maegaki}
\input{controllingfiles/TW_Engraulis-japonicus_seitai}
\input{controllingfiles/TW_Engraulis-japonicus_gyogyou_joukyou}
\input{controllingfiles/TW_Engraulis-japonicus_shigennojoutai}
\input{controllingfiles/TW_Engraulis-japonicus_abc_santei_thisyear}
\input{files_to_edit/TW_Engraulis-japonicus_abc_igai}

\bibliographystyle{jecon}
\bibliography{files_to_edit/TW_Engraulis-japonicus_references}
\clearpage
\input{files_to_edit/TW_Engraulis-japonicus_figures}
%\input{_tables}

\end{document}

#+END_SRC
******* DONE まえがきサンプル1
- State "DONE"       from "TODO"       [2018-06-19 Tue 21:10]
#+BEGIN_SRC tex :tangle ./files_to_edit/fish1_maegaki.tex
\documentclass[../master_plan2]{subfiles}
\begin{document}
\subsection{まえがき}
我が国周辺に分布するカタクチイワシは、太平洋系群、瀬戸内海系群および対馬暖流系群から構成される\cite{Hunter1981}。
本種の漁獲量は、マイワシとは対照的に1990年代に増加した。対馬暖流域においても、1990年代後半にかけて漁獲量が増加したが、
2001年に急減し、その後は増減を繰り返している。しかし、本種の漁獲量の変動幅はマイワシほど大きくない。
これは、マイワシと比較して親魚になるまでの期間が短いことや、ほぼ周年にわたり産卵を行うことなどが要因と考えられる。

東シナ海や日本海に分布するカタクチイワシは、韓国や中国によっても漁獲されているが、これらの主な分布域は韓国と中国の沿岸域であるため、
対馬暖流系群とはみなさず、本資源評価では考慮しなかった。
\end{document}
#+END_SRC
****** DONE 魚種ファイル2
#+BEGIN_SRC tex :tangle ./fish2.tex
\documentclass[A4j, disablejfam, titlepage, openright, twoside, 10.5pt, uplatex]{myjsbook}
\linespread{1.5}
\usepackage[dvipdfmx, hiresbb]{graphicx, xcolor}
\usepackage{draftwatermark}
\usepackage{otf}
\usepackage{array, booktabs}
\usepackage{blindtext}
\usepackage{colortbl}
\usepackage{atbegshi}
\usepackage{amsmath}
\usepackage{url}
\usepackage{fancyhdr}
\usepackage{subfiles}
\usepackage{TW_Engraulis-japonicus}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0.0pt}
\addtolength{\headheight}{20.0pt}

\renewcommand{\chaptermark}[1]{\markright{}}
\renewcommand{\sectionmark}[1]{\markright{}}
\fancyhf{}
\chead{カタクチイワシ太平洋系群 --\thepage--}
\cfoot{}
\ifnum 42146=\euc"A4A2
  \AtBeginShipoutFirst{\special{pdf:tounicode EUC-UCS2}}
\else
  \AtBeginShipoutFirst{\special{pdf:tounicode 90ms-RKSJ-UCS2}}
\fi
%\usepackage{footnpag}
%\makeatletter
%\let\original@@makefntext\@makefntext
%\let\original@footnoterule\footnoterule
%\makeatother
%\usepackage{ftnright}
%\makeatletter
%\let\@makefntext\original@@makefntext
%\let\footnoterule\original@footnoterule
%\makeatother

\makeatletter
\newcommand\footnoteref[1]{\protected@xdef\@thefnmark{\ref{#1}}\@footnotemark}
\makeatother

\usepackage[dvipdfmx,
bookmarks=true,%
bookmarksnumbered=true,%
bookmarksopen=true,%
]{hyperref}
%\setlength{\textwidth}{\fullwidth}
\setlength{\textwidth}{15truecm}
\setlength{\hoffset}{0pt}
\setlength{\voffset}{-1.54truecm}
\setlength{\headsep}{2truecm}
\setlength{\footskip}{2truecm}
\setlength{\textheight}{23truecm}
%\setlength{\textwidth}{35zw}
%\setlength{\textheight}{50zw}
%\setlength{\headwidth}{1truemm}
%\addtolength{\textheight}{\topskip}
%\setlength{\topmargin}{0pt}
%\setlength{\voffset}{-15truemm}
%\setlength{\hoffset}{-5truemm}
\setlength{\marginparsep}{1truecm}
\setlength{\marginparwidth}{0pt}
\setlength{\oddsidemargin}{0.46truecm}
\setlength{\evensidemargin}{\oddsidemargin}
\setlength{\abovecaptionskip}{-3truemm}
\setlength{\belowcaptionskip}{-2truemm}
\SetWatermarkLightness{0.9}
\setcounter{tocdepth}{1} %1だとchapterまで目次に表示される
%\usepackage{ctable, dcolumn}
\usepackage[format=hang, labelsep=period]{caption}
\usepackage[sectionbib]{chapterbib}
\usepackage{float}
\usepackage[T1]{fontenc}
%\usepackage[scaled]{helvet}
\usepackage{layout}
\usepackage{pdflscape}
%\usepackage{myCitation}
\usepackage{multirow}
\usepackage{multicol}
%\usepackage{newtxtext, newtxmath}
\usepackage{otf}
\usepackage{pifont}
%\usepackage{subcaption}
\usepackage{subfig}
\usepackage{tabularx}
\usepackage{textcomp}
\usepackage{threeparttable}
\usepackage{subfiles} % 独立タイプセットを可能にするが、chapterbibと併用できないので使用を停止。併用のためには正規表現などで工夫する必要がある。
\usepackage{tocbibind}
\usepackage[authoryear, round, sort&compress]{mynatbib} %natbibを使うと引用文献が続きになってしまう。
%\bibliographystyle{mynatbib}
%\usepackage{jecon}
\bibliographystyle{jecon}     %jeconの利用を検討中。\citealtなどの引用文を変更する必要あり
%\setcitestyle{number,close={)}}

%ここから 引用文献レベルをsubsectionに再定義
\makeatletter
\renewenvironment{thebibliography}[1]{%
  %\global\let\presectionname\relax
  %\global\let\postsectionname\relax
  \subsection{\bibname}\@mkboth{\bibname}{}%
  %\addcontentsline{toc}{subsection}{\bibname}%   これをオンにすると目次に2回出てきてしまう
  \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
        \setlength{\itemindent}{-2zw}%      文献リストのインデント
        \setlength{\topsep}{-10zw}%         引用文献」から最初の文献までの空白
        %\leftmargin\labelwidth
        %\advance\leftmargin\labelsep
        %\@openbib@code
        %\usecounter{enumiv}%
        %\let\p@enumiv\@empty
        %\renewcommand\theenumiv{\@arabic\c@enumiv}
        }%
  %\sloppy
  %\clubpenalty4000
  %\@clubpenalty\clubpenalty
  %\widowpenalty4000%
  \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}
\makeatother
%ここまで 引用文献レベルをsubsectionに再定義


%ハイフネーション設定
\hyphenation{Engraulis}
\hyphenation{japonicus}

\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{qtm}
\renewcommand{\baselinestretch}{1}
\renewcommand{\thefootnote}{*\roman{footnote}}
\renewcommand{~}{\phantom{0}}
\makeatletter
   \renewcommand{\thefigure}{\arabic{figure}}%      図番号の体裁
  \@addtoreset{figure}{section}
 \makeatother

 \makeatletter
 \renewcommand{\thetable}{arabic{table}}%       表番号の体裁
  \@addtoreset{table}{section}
\makeatother
%コマンド
\setcounter{secnumdepth}{3}
\newcommand{\fcur}{$F_{current}$}
\newcommand{\fmed}{Fmed}
\newcommand{\要約}{\begin{center}\Large{{\gt 要　　　約}}\end{center}}
\newcommand{\digest}{}
%\newcommand{\}{}

%環境
\newenvironment{OneOfSixFigs}[3]{
\begin{figure}[htp]
    \captionsetup{width=65mm}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=70mm]{#1}
  \end{center}
  \caption{#2}
  \label{#3}
 \end{minipage}
\end{figure}}

\newenvironment{TwoOfSixFigs}[6]{
\begin{figure}[htp]
    \captionsetup{width=65mm}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=70mm]{#1}
  \end{center}
  \caption{#2}
  \label{#3}
 \end{minipage}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=70mm]{#4}
  \end{center}
  \caption{#5}
  \label{#6}
 \end{minipage}
\end{figure}}

\newenvironment{TwoOfEightFigs}[6]{
\begin{figure}[htp]
    \captionsetup{width=60mm}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=60mm]{#1}
  \end{center}
  \caption{#2}
  \label{#3}
 \end{minipage}
 \begin{minipage}{0.5\hsize}
  \begin{center}
   \includegraphics[width=60mm]{#4}
  \end{center}
  \caption{#5}
  \label{#6}
 \end{minipage}
\end{figure}}

%担当機関
\newenvironment{担当機関等}[3]{
\begin{table}[h]
\begin{tabular}{{rp{12.2cm}}}
責任担当水研: &#1 （#2）\\
参画機関: & #3
\end{tabular}
\end{table}
}

%過去5年間の資源量等
\newenvironment{過去五年間の資源量等}[5]{
\begin{center}
\begin{tabular}{cccccc}
\toprule
\multirow{2}{*}{年} & {資源量}  & {親魚量}  & {漁獲量}  & {$F$} & {漁獲割合}\tabularnewline
          &   (千トン)  & (千トン)    & (千トン)&   & （\%）  \tabularnewline
\hline
#1  \tabularnewline
#2  \tabularnewline
#3  \tabularnewline
#4  \tabularnewline
#5  \tabularnewline
\bottomrule
\end{tabular}
\end{center}
}

\begin{document}
\frontmatter
%\layout
%
%
\title{
{\thisyrjp}年度
\\
{\HUGE 我が国周辺水域の漁業資源評価}}
\author{\\
\\
\\
\\
\\
\\
\\
\\
\\
{\Large 水産庁増殖推進部}
\\
}
\date{\today}
%\maketitle
%
%
%
\mainmatter
\chapter{平成\ThisYrJp（\ThisYr）年度カタクチイワシ太平洋系群の資源評価}

\input{files_to_edit/TW_Engraulis-japonicus_sekinintantou}
\subfile{files_to_edit/fish2_maegaki}

\bibliographystyle{jecon}
\bibliography{files_to_edit/PF_Engraulis-japonicus_references}
\clearpage
\input{files_to_edit/TW_Engraulis-japonicus_figures}
%\input{_tables}

\end{document}

#+END_SRC
******* まえがきサンプル2
#+BEGIN_SRC tex :tangle ./files_to_edit/fish2_maegaki.tex
\documentclass[../master_plan2]{subfiles}
\begin{document}
\subsection{まえがき}
ぞうの卵は大きいぞう。\cite{Buckel1995}
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
ぞうの卵は大きいぞう。
\cite{Series}。
\end{document}

#+END_SRC
***** TODO 快適に執筆できるようにする [0%]
****** TODO subfile環境の整備
****** TODO コマンド類の整理を含めたテンプレートの整理

*** 2系（未定）
** digest
** GitHub使っていいか作業部会で確認

** Make cheat sheet
