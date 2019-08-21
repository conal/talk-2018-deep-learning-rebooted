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

\title{A Functional Reboot for Deep Learning}
%\title{What is the essence of deep learning?}
\date{August 2019}
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

%if False

\partframe{Original inspiration \\[2ex] October 2016}

\framet{TensorFlow}{
\begin{itemize}\itemsep2ex \parskip1ex
\item Talk \href{https://www.youtube.com/watch?v=EpifLmPM1L0}{\emph{TensorFlow: Learning Functions at Scale}}.
\item Familiar design anti-pattern:
  \begin{itemize}\itemsep1.5ex
  \item Use one language to explicitly construct computations in another.
  \item Explicit graph manipulation.
  \item Poor abstraction support.
  \item Ad hoc and clumsy (syntax, types, parameters).
  \item Ill-defined semantics.
  \item Run-time ``compilation''.
  \item Concreteness \& mutability thwart efficient implementation.
  \item Other examples include retained mode graphics, HTML+JS+DOM.
  \end{itemize}
\item ``Tensors'': awkward, unsafe, and mis-named.
\end{itemize}
}

\framet{General proposal}{
\begin{itemize}\itemsep1.5ex \parskip1.5ex
  \item Build a system that beats TensorFlow in
\begin{itemize}\itemsep1.5ex
\item simplicity,
\item expressiveness,
\item modularity/reuse,
\item safety, and
\item optimizability.
\end{itemize}
  \item Elegant, denotative host language.
  \item Eliminate graphs.
  \item Powerful types and abstraction.
  \item Replace multi-dim arrays with functor algebra / free vector spaces.
\end{itemize}
}

\partframe{Deep learning class \\[2ex] October 2017}

\framet{My takeaway: DL is mostly accidental complexity}{
\begin{itemize}\itemsep1.8ex
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

%endif

\framet{Goal}{
\vspace{2ex}
\begin{itemize}\itemsep3ex \parskip1ex
\item Extract the essence of DL.
\item Shed accidental complexity and artificial limitations, \\
      i.e., simplify \emph{and} generalize.
\end{itemize}
\vspace{6ex}
%if False
\begin{quotation}
``Perfection is achieved not when there is nothing left to add, but when there is nothing left to take away.'' --- Antoine de Saint-Exup\'ery
\end{quotation}
%endif
}

\nc\EssenceSlide{
\framet{Essence}{
\begin{itemize}\itemsep3ex \parskip1ex
\item Optimization: best element of a set (by objective function). \\
  Usually via differentiation and gradient following.
\item For machine learning, sets of \emph{functions}.
\item Objective function is defined via set of input/output pairs\out{ (minimize prediction error)}.
% \item Language: math/function-friendly.
\end{itemize}
}
}

\EssenceSlide

\partframe{Accidental complexity \\[1ex] in deep learning }

\framet{Accidental complexity in DL (overview)}{
\begin{itemize}\itemsep2.3ex
\item Imperative programming
\item Weak typing
\item Graphs (neural \emph{networks})
\item Layers
\item Tensors/arrays
\item Back propagation
\item Linearity bias
\item Hyper-parameters
%% \item Stateful formulations
\item Manual differentiation
\end{itemize}
}

\framet{Imperative programming}{
\begin{itemize}\itemsep2ex \parskip2ex
\item Thwarts correctness/dependability (usually ``not even wrong'').
\item Thwarts efficiency (parallelism).
\item Unnecessary for expressiveness.
\item Poor fit.
      DL is math, so express in a math language.
\end{itemize}
}

\framet{Weak typing}{
\begin{itemize}\itemsep3ex \parskip1ex
\item Requires people to manage detail \& consistency.
  % Not our strength.
\item Run-time errors.
\end{itemize}
}

\framet{Graphs (neural \emph{networks})}{
\begin{itemize}\itemsep2ex \parskip2ex
\item Clutters API, distracting from purpose.
\item Purpose: a representation of functions.
\item We already have a better one: programming language.
\item Can we differentiate?
\begin{itemize}\itemsep2ex \parskip1ex
  \pitem An issue of \emph{implementation}, not language or library definition.
  \item Fix accordingly.
\end{itemize}
\end{itemize}
}

\framet{Layers}{
\begin{itemize}\itemsep3ex \parskip1ex
\item Strong bias toward sequential composition.
\item Neglects equally important forms: parallel \& conditional.
\item Awkward patches: ``skip connections'', ResNet, HighwayNet.
\item Don't patch the problem; eliminate it.
\item Replace with binary sequential, parallel, conditional composition.
\end{itemize}
}

\framet{``Tensors''}{
\begin{itemize}\itemsep2ex \parskip1.5ex
\item Really, multi-dimensional arrays.
\item Awkward: imagine you could program only with arrays (Fortran).\\
  %% (One size fits none.)
\item Unsafe without dependent types.
\item Multiple intents / weakly typed
\item Even as linear maps: meaning of \(m \times n\) array?
\item Limited: missing almost all differentiable types.
\item Missing more natural \& compositional data types, e.g., trees.
      % Consequence of graph API?
\end{itemize}
}

\framet{Back propagation}{
\begin{itemize}\itemsep2ex \parskip2ex
\item Specialization and rediscovery of reverse-mode auto-diff.
\item Described in terms of graphs.
\item Highly complex due to graph formulation.
\item Stateful:
  \begin{itemize}\itemsep2ex \parskip1ex
  %\item More awkward to use.
  \item Hinders parallelism/efficiency.
  \item High memory use, limiting problem size.
        %% Impractical with GD, hence SGD, leading away from minima.
  \end{itemize}
% \item Entangled with GD \& SGD.
\end{itemize}
}

\framet{Linearity bias}{
\begin{itemize}\itemsep4ex \parskip1ex
\item ``Dense'' \& ``fully connected'' mean arbitrary \emph{linear} transformation.
\item Sprinkle in ``activation functions'' as exceptions to linearity.
\item Misses simpler and more efficient architectures.
\end{itemize}
}

\framet{Hyper-parameters}{
\begin{itemize}\itemsep4ex \parskip1ex
\item Same essential purpose as parameters.
\item Different mechanisms for expression and search.
\item Inefficient and ad hoc
%% \item Unify with parameters for consistency and automation.
%% \item Hybrid search/optimization methods.
\end{itemize}
}

%if False

\framet{Stateful formulations}{
\begin{itemize}\itemsep3ex \parskip2ex
\item Complex and ill-defined.
%if True
\item Thwarts parallelism
%else
\item Stateless alternatives: |map|, |fold|, |unfold|, |scan|.
  \begin{itemize}\itemsep2ex \parskip1ex
  \item Simple, general, effective.
  \item Correct algebraic reasoning.
  \item Parallelism!
  \end{itemize}
%endif
\end{itemize}
}

%endif

\partframe{A functional reboot}

\framet{Values}{
\begin{itemize}\itemsep4ex \parskip1ex
\item \emph{Precision}: meaning, reasoning, correctness.
\item \emph{Simplicity}: practical rigor/dependability.
\item \emph{Generality}: room to grow; design guidance.
\end{itemize}
}

\EssenceSlide

\framet{Optimization}{
\begin{itemize}\itemsep2.5ex \parskip1ex
\item Describe a set of values as range of function: |f :: p -> c|.
\item Objective function: |q :: c -> R|.
\item Find |argMin (q . f) :: p|.
\item When |q . f| is differentiable, gradient descent can help.
\item Otherwise, other methods.
\item Consider also global optimization, e.g., with interval methods.
\end{itemize}
}

\framet{Learning \emph{functions}}{
\begin{itemize}\itemsep3ex \parskip1ex
\item Special case of optimization, where |c = a -> b|, i.e., |f :: p -> (a -> b)|, and |q :: (a -> b) -> R|.
\item Objective function often based on sample set \(S \subseteq a \times b\). \\
      Measure mis-predictions (loss).
\item Additivity enables parallel, log-time learning step.
\end{itemize}
}

%if False
\framet{Program directly in Haskell (etc)}{
\begin{itemize}\itemsep3ex \parskip1ex
\item Why? DL is math, so express in a math language.
\pitem Existing semantics (no graphs/networks/layers).
\item Well-defined semantics.
\item \emph{Higher-order} functions.
\item Rich, static typing.
\item General, principled tools for data ``reshaping''.
\end{itemize}
}
%endif

\framet{Differentiable functional programming}{
\begin{itemize}\itemsep2.3ex \parskip1ex
\item Directly on Haskell (etc) \emph{programs}:
\begin{itemize} \parskip2ex
\item Not a library/DSEL
\item No graphs/networks/layers
\end{itemize}
\pitem Differentiated at compile time
\item Simple, principled, and general\\
      (\href{http://conal.net/papers/essence-of-ad/}{\emph{The simple essence of automatic differentiation}})
\item Generating efficient run-time code
\item Amenable to massively parallel execution (GPU, etc)
\end{itemize}
}

%format Vec (n) = "\Varid{Vec}_{"n"}"
%format Fin (n) = "\Varid{Fin}_{"n"}"

\framet{Beyond ``tensors''}{ % General differentiable types
%\vspace{-2ex}
\begin{itemize}\itemsep1.25ex \parskip0.5ex
\item Most differentiable types are \emph{not} vectors (uniform $n$-tuples), and \\
      most derivatives (linear maps) are not matrices.
\item A more general alternative:
  \begin{itemize}\itemsep1ex \parskip0ex
  \item \emph{Free vector space} over |s|: |i -> s =~ f s| (``|i| indexes |f|'')
  \item Special case: |Fin n -> s =~ Vec n s|
  \item \emph{Algebra of representable functors}: |f :*: g|, |1|, |g :.: f|, |Id|
  \item Your (representable) functor via |deriving Generic|
  \end{itemize}
\item %% Generalized matrix: |g (f s) =~ j -> i -> s =~ i :* j -> s =~ (g :.: f) s|. \\
      Linear map |(f s :-* g s) =~ g (f s) =~ (g :.: f) s| (generalized matrix).\\
      Other representations for \href{http://conal.net/papers/essence-of-ad/}{efficient reverse-mode AD} (w/o tears).
\pause
\item Use with |Functor|, |Foldable|, |Traversable|, |Scannable|, etc. \\
  No need for special/limited array ``reshaping'' operations.
\item Compositional and naturally parallel-friendly \\
      (\href{http://conal.net/papers/generic-parallel-functional/}{\emph{Generic parallel functional programming}})
\end{itemize}
}

%if True

\framet{Modularity}{
\begin{itemize}\itemsep2.5ex \parskip1ex
\item How to build function families from pieces, as in DL?
\item Category of indexed sets of functions.
  %% Automatically combines and routes parameters from separate families.
\item Extract monolithic function after composing.
\item Other uses, including satisfiability.
\item Prototyped, but problem with GHC type-checker.
      % Seeking help.
%if False
\item Violates a cartesian axiom.
      Looking for alternatives.
%endif
\end{itemize}
}

\framet{Progress}{
\begin{itemize}\itemsep2.5ex \parskip2ex
\item Simple \& efficient reverse-mode AD.
\item Some simple regressions, simple DL, and CNN.
\item Some implementation challenges with robustness.
\item Looking for collaborators, including
\begin{itemize}\parskip2.5ex
\item GHC internals (compiling-to-categories plugin)
\item Background in machine learning and statistics
\end{itemize}

%\item Breakthroughs in both, including functor-level operations.
\end{itemize}
}

%endif

\framet{Summary}{
\begin{itemize}\itemsep2.5ex \parskip1ex
\item Generalize \& simplify DL (more for less).
\item Essence of DL: pure FP with |minarg|.
\item Generalize from ``tensors'' (for composition \& safety).
\item Collaboration welcome!
\end{itemize}
}

\end{document}
