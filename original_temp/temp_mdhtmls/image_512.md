To draw a chessboard in LaTeX using the FEN notation, you can use the following code:
\documentclass{article}
\usepackage{tikz}
\usetikzlibrary{positioning}
\newcommand{\chessboard}[1]{
  \begin{tikzpicture}[x=1cm,y=1cm]
    \foreach \x in {0,1,...,7} {
      \foreach \y in {0,1,...,7} {
        \pgfmathtruncatemacro{\pos}{8*\y+\x}
        \pgfmathtruncatemacro{\piece}{mod(#1,64)}
        \pgfmathtruncatemacro{\next}{mod(#1+1,64)}
        \pgfmathtruncatemacro{\prev}{mod(#1-1,64)}
        \ifnum\piece=0
          \node[draw,minimum size=1cm] (c\x\y) at (\x,\y) {};
        \else
          \ifnum\piece=1
            \node[draw,minimum size=1cm,fill=black] (c\x\y) at (\x,\y) {};
          \else
            \ifnum\piece=2
              \node[draw,minimum size=1cm,fill=white] (c\x\y) at (\x,\y) {};
            \else
              \ifnum\piece=3
                \node[draw,minimum size=1cm,fill=black] (c\x\y) at (\x,\y) {};
                \node[draw,minimum size=1cm,fill=white] (c\x\y) at (\x,\y) {};
              \fi
            \fi
          \fi
        \fi
        \ifnum\piece=1
          \draw[thick] (c\x\y.north west) -- (c\x\y.south east);
        \else
          \ifnum\piece=2
            \draw[thick] (c\x\y.south west) -- (c\x\y.north east);
          \else
            \ifnum\piece=3
              \draw[thick] (c\x\y.north west) -- (c\x\y.south east);
              \draw[thick] (c\x\y.south west) -- (c\x\y.north east);
            \fi
          \fi
        \fi
      }
    }
  \end{tikzpicture}
}
\begin{document}
\chessboard{rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR}
\end{document}
In this code, the \chessboard command takes one argument, which is the FEN notation of the chessboard. The code uses the TikZ package to draw the board, and the positioning library to position the pieces correctly. The code loops through each square on the board, checks the corresponding piece in the FEN notation, and draws the appropriate square and piece. The code also draws the lines between the squares for the black and white pieces.