%% -*- latex -*-

% Presentation
%\documentclass[aspectratio=1610]{beamer} % Macbook Pro screen 16:10
\documentclass{beamer} % default aspect ratio 4:3
%% \documentclass[handout]{beamer}

% \setbeameroption{show notes} % un-comment to see the notes

\input{macros}

%include polycode.fmt
%include forall.fmt
%include greek.fmt
%include formatting.fmt

\title{A functional reboot for deep learning}
\date{January 2018}
% \date{\today{} (draft)}
\institute[]{Target}

\setlength{\itemsep}{2ex}
\setlength{\parskip}{1ex}
\setlength{\blanklineskip}{1.5ex}
\setlength\mathindent{4ex}

\nc\wow\emph

%% \usepackage{scalerel}

\begin{document}

\frame{\titlepage}
% \institute{Target}
% \date{Jan 2018}

\partframe{Original inspiration \\[2ex] October 2016}

\framet{TensorFlow}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Talk \href{https://www.youtube.com/watch?v=EpifLmPM1L0}{TensorFlow: Learning Functions at Scale}.
\item Familiar design anti-pattern:
  \begin{itemize}\itemsep2ex
  \item Use one language to explicitly construct computations in another.
  \item Explicit graph manipulation.
  \item Poor abstraction support.
  \item Ad hoc and clumsy (syntax, types, parameters).
  \item Ill-defined semantics.
  \item Concreteness \& mutability thwart efficient implementation.
  \item Other examples include retained mode graphics, HTML+JS+DOM.
  \end{itemize}
\item ``Tensors'': awkward, unsafe, and mis-named.
\end{itemize}
}

\framet{General proposal}{
\begin{itemize}\itemsep1.5ex \parskip1ex
  \item Build a system that beats TensorFlow in
\begin{itemize}\itemsep1ex
\item simplicity
\item expressiveness
\item modularity/reuse
\item safety
\item optimizability
\end{itemize}
  \item Elegant, denotative host language.
  \item Drop graphs.
  \item Powerful types and abstraction.
  \item Replace multi-dim arrays with functor algebra / free vector spaces.
\end{itemize}
}

\partframe{Deep learning class \\[2ex] October 2017}

\framet{Goals}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Extract the essence of DL while shedding accidental complexity.
\item Support that essence very well.
\end{itemize}

\vspace{3ex}
\begin{quotation}
``Perfection is achieved not when there is nothing left to add, but when there is nothing left to take away.'' --- Antoine de Saint-Exup\'ery
\end{quotation}
}

\framet{Essence}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Optimization: find the best element of a set (objective function).
\item For machine learning, we have sets of \emph{functions}.
\item Objective function is derived via a collection of input/output pairs\out{ (minimize prediction error)}.
\item Math/function-friendly language.
\end{itemize}
}

\framet{Accidental complexity (historical baggage)}{
\begin{itemize}\itemsep2ex
\item Imperative programming
\item Weak typing
\item Graphs/networks
\item Layers
\item Tensors/arrays
\item Back propagation
\item Linearity bias
\item Hyper-parameters
\item Stateful formulations
\item Manual differentiation
\end{itemize}
}

\partframe{Accidental complexity details}

\framet{Imperative programming}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Unnecessary for expressiveness
\item Thwarts efficiency (parallelism)
\item Thwarts correctness/dependable (usually ``not even wrong'')
\item DL is math, so pick a math language.
\end{itemize}
}

\framet{Weak typing}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Requires people to manage detail \& consistency.
  % Not our strength.
\item Run-time errors.
\end{itemize}
}

\framet{Graphs}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Clutters API, distracting from purpose.
\item Purpose: a representation of functions.
\item We already have a better one: programming language.
\item But we can't differentiate.
\begin{itemize}\itemsep2ex
  \item An issue of \emph{implementation}, not language or library definition.
  \item Fix accordingly.
\end{itemize}
\end{itemize}
}

\framet{Layers}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Strong bias toward sequential composition.
\item Neglects other forms: parallel \& conditional.
\item Awkward patches: ``skip connections'', ResNet, HighwayNet.
\item Don't patch the problem; eliminate it.
\end{itemize}
}

\framet{Tensors}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Really, multi-dimensional arrays.
\item Awkward: imagine you could program only with arrays (Fortran).\\
  (One size fits none.)
\item Meaningless operations, e.g., element-wise array multiplication.
\item Even as linear maps: meaning of \(m \times n\) array?
\item More natural (for programming) data types, e.g., trees.
\end{itemize}
}

\framet{Back propagation}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Specialization and re-discovery of reverse-mode auto-diff (RAD).
\item Stateful:
  \begin{itemize}\itemsep2ex \parskip1ex
    \item More awkward to use.
  \item Thwarts parallelism/efficiency.
  \item Impractical with GD, hence SGD, leading away from minima.
  \end{itemize}
\item Entangled with GD \& SGD, hindering progress.
\end{itemize}
}

\framet{Linearity bias}{
\begin{itemize}\itemsep2ex \parskip1ex
\item ``Dense'' \& ``fully connected'' mean arbitrary \emph{linear} transformation.
\item Sprinkle in ``activation functions'' as exceptions to linearity.
\item Unbiased basis may yield simpler and more efficient alternatives.
\end{itemize}
}

\framet{Hyper-parameters}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Unify with parameters for consistency and automation.
\item Hybrid search/optimization methods.
\end{itemize}
}

\framet{Stateful formulations}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Complex and ill-defined.
\item Stateless alternatives: fold, unfold, scan.
  \begin{itemize}\itemsep2ex \parskip1ex
    \item Simple, general, effective.
  \item Correct algebraic reasoning.
  \item Parallelism!
  \end{itemize}
\end{itemize}
}

\partframe{A functional reboot}

\framet{Values}{
\begin{itemize}\itemsep2ex \parskip1ex
\item \emph{Precision}: reasoning, correctness.
\item \emph{Simplicity}: \emph{practical} dependability.
\item \emph{Generality}: design guidance, and room to grow.
\end{itemize}
}

\framet{Write directly in Haskell}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Existing semantics (no graphs/networks/layers)
\item \emph{Higher-order} functions
\item Rich, static typing
\end{itemize}
}

\framet{Genuinely automatic differentiation}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Directly on Haskell \emph{programs}.
\item At compile time
\item Efficient run-time code
\item Amenable to massively parallel execution (GPU, etc)
\item Based on category theory.
  Principled and flexible.
\end{itemize}
}

\framet{Optimization}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Describe a set of values as range of function: |f :: p -> c|.
\item Objective function: |o :: c -> R|.
\item Find |argMin (o . f) :: c|.
\item When |o . f| is differentiable, use GD.
\item Otherwise, other methods.
\item Consider also global optimization, e.g., with interval methods.
\end{itemize}
}

\framet{Learning \emph{functions}}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Special case of optimization, where |c = a -> b|, i.e., |f :: p -> (a -> b)|, and |o :: (a -> b) -> R|..
\item Objective function often based on sample set \(S \subseteq a \times b\).
\item Additivity enables parallel, log-time learning step.
\end{itemize}
}

\framet{Modularity}{
\begin{itemize}\itemsep2ex \parskip1ex
\item How to build function families from pieces, as in DL?
\item Category of sets of functions.
  %% Automatically combines and routes parameters from separate families.
\item Extract monolithic function after composing.
\item Other uses, including satisfiability.
\item Prototyped, but problem with GHC type-checker.
  Getting help.
\item Violates a cartesian axiom.
  Looking for alternatives.
\end{itemize}
}

\framet{Progress}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Formulated some regressions, standard DL, and CNN.
\item Revealed problems with scaling and robustness.
\item Scaling: functor-level operations.
  Exploring design space. Close.
\item Simple \& efficient RAD.
\end{itemize}
}


\end{document}
