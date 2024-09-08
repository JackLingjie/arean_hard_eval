Here's an example of how a table of contents can be generated automatically in a LATEX document:
```
\documentclass{article}
\usepackage{tocloft} % for customizing the table of contents
\begin{document}
\tableofcontents % generates the table of contents
\section{Introduction}
This is the introduction section.
\section{Methods}
This is the methods section.
\section{Results}
This is the results section.
\section{Discussion}
This is the discussion section.
\end{document}
```
In this example, the `\tableofcontents` command generates the table of contents automatically based on the section headings in the document. The `tocloft` package can be used to customize the appearance of the table of contents, such as changing the font size or spacing between entries.