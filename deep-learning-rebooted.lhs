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

\framet{Goals}{
\vspace{8ex}
\begin{itemize}\itemsep4ex \parskip1ex
\item Extract the essence of DL while shedding accidental complexity.
\item Generalize and simplify.
\end{itemize}
\vspace{8ex}
\begin{quotation}
``Perfection is achieved not when there is nothing left to add, but when there is nothing left to take away.'' --- Antoine de Saint-Exup\'ery
\end{quotation}
}

\framet{Essence}{
\begin{itemize}\itemsep3ex \parskip1ex
\item Optimization: best element of a set (by objective function).
\item For machine learning, sets of \emph{functions}.
\item Objective function is defined via set of input/output pairs\out{ (minimize prediction error)}.
\item Math/function-friendly language.
\end{itemize}
}

\partframe{Accidental complexity \\[1ex] in deep learning }

\framet{Accidental complexity in DL overview}{
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

\framet{Imperative programming}{
\begin{itemize}\itemsep2ex \parskip2ex
\item Thwarts correctness/dependability (usually ``not even wrong'').
\item Thwarts efficiency (parallelism).
\item Unnecessary for expressiveness.
\item DL is math, so express in a math language.
\end{itemize}
}

\framet{Weak typing}{
\begin{itemize}\itemsep3ex \parskip1ex
\item Requires people to manage detail \& consistency.
  % Not our strength.
\item Run-time errors.
\end{itemize}
}

\framet{Graphs (``networks'')}{
\begin{itemize}\itemsep2ex \parskip2ex
\item Clutters API, distracting from purpose.
\item Purpose: a representation of functions.
\item We already have a better one: programming language.
\item But we can't differentiate.
\begin{itemize}\itemsep2ex \parskip1ex
  \item An issue of \emph{implementation}, not language or library definition.
  \item Fix accordingly.
\end{itemize}
\end{itemize}
}

\framet{Layers}{
\begin{itemize}\itemsep3ex \parskip1ex
\item Strong bias toward sequential composition.
\item Neglects other forms: parallel \& conditional.
\item Awkward patches: ``skip connections'', ResNet, HighwayNet.
\item Don't patch the problem; eliminate it.
\item Replace with binary sequential, parallel, conditional composition.
\end{itemize}
}

\framet{Tensors}{
\begin{itemize}\itemsep2ex \parskip1.5ex
\item Really, multi-dimensional arrays.
\item Awkward: imagine you could program only with arrays (Fortran).\\
  %% (One size fits none.)
\item Unsafe without dependent types.
\item Multiple intents / weakly typed
\item Even as linear maps: meaning of \(m \times n\) array?
\item Limited: missing almost all differentiable types.
\item Missing more natural \& compositional data types, e.g., trees.
      Consequence of graph API?
\end{itemize}
}

\framet{Back propagation}{
\begin{itemize}\itemsep2ex \parskip2ex
\item Specialization and re-discovery of reverse-mode auto-diff.
\item Stateful:
  \begin{itemize}\itemsep2ex \parskip1ex
  \item More awkward to use.
  \item Hinders parallelism/efficiency.
  \item Impractical with GD, hence SGD, leading away from minima.
  \end{itemize}
\item Entangled with GD \& SGD.
\end{itemize}
}

\framet{Linearity bias}{
\begin{itemize}\itemsep3ex \parskip1ex
\item ``Dense'' \& ``fully connected'' mean arbitrary \emph{linear} transformation.
\item Sprinkle in ``activation functions'' as exceptions to linearity.
\item Misses simpler and more efficient architectures.
\end{itemize}
}

%if False

\framet{Hyper-parameters}{
\begin{itemize}\itemsep4ex \parskip1ex
\item Unify with parameters for consistency and automation.
\item Hybrid search/optimization methods.
\end{itemize}
}

%endif

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

\partframe{A functional reboot}

\framet{Values}{
\begin{itemize}\itemsep3ex \parskip1ex
\item \emph{Precision}: reasoning, correctness.
\item \emph{Simplicity}: practical dependability.
\item \emph{Generality}: design guidance, and room to grow.
\end{itemize}
}

\framet{Write directly in Haskell}{
\begin{itemize}\itemsep3ex \parskip1ex
\item Existing semantics (no graphs/networks/layers)
\item \emph{Higher-order} functions
\item Rich, static typing
\end{itemize}
}

\framet{Optimization}{
\begin{itemize}\itemsep2.5ex \parskip1ex
\item Describe a set of values as range of function: |f :: p -> c|.
\item Objective function: |q :: c -> R|.
\item Find |argMin (q . f) :: p|.
\item When |q . f| is differentiable, use GD.
\item Otherwise, other methods.
\item Consider also global optimization, e.g., with interval methods.
\end{itemize}
}

\framet{Learning \emph{functions}}{
\begin{itemize}\itemsep2.5ex \parskip1ex
\item Special case of optimization, where |c = a -> b|, i.e., |f :: p -> (a -> b)|, and |q :: (a -> b) -> R|.
\item Objective function often based on sample set \(S \subseteq a \times b\). \\
      Measure mis-predictions (loss).
\item Additivity enables parallel, log-time learning step.
\end{itemize}
}

\framet{Differentiable functional programming}{
\begin{itemize}\itemsep2.5ex \parskip1ex
\item Directly on Haskell \emph{programs}.
\item At compile time
\item Efficient run-time code
\item Amenable to massively parallel execution (GPU, etc)
\item Simple, principled, and general.\\
      (\href{http://conal.net/papers/essence-of-ad/}{\emph{The simple essence of automatic differentiation}})
\end{itemize}
}

%format Vec (n) = "\Varid{Vec}_{"n"}"
%format Fin (n) = "\Varid{Fin}_{"n"}"

\framet{General differentiable types}{
\begin{itemize}\itemsep2ex \parskip0.5ex
\item Most differentiable types are \emph{not} vectors (uniform $n$-tuples).
\item Most derivatives (linear maps) are not matrices.
\item A more general alternative:
  \begin{itemize}\itemsep1ex \parskip0.5ex
  \item \emph{Free vector spaces}: |forall s. NOP f s =~ i -> s|
  \item Special case: |Vec n s =~ Fin n -> s|
  \item \emph{Algebra of representable functors}: |f :*: g|, |1|, |g :.: f|, |Id|
  \item Your (representable) functor via |deriving Generic|
  \end{itemize}
\item Generalized matrix: |g (f s) =~ j -> i -> s =~ i :* j -> s|. \\
      Other representations give \href{http://conal.net/papers/essence-of-ad/}{efficient reverse-mode AD}.
\item Compositional, naturally parallel-friendly \\
      (\href{http://conal.net/papers/generic-parallel-functional/}{\emph{Generic parallel functional programming}})
\end{itemize}
}

%if False

\framet{Modularity}{
\begin{itemize}\itemsep2.5ex \parskip1ex
\item How to build function families from pieces, as in DL?
\item Category of sets of functions.
  %% Automatically combines and routes parameters from separate families.
\item Extract monolithic function after composing.
\item Other uses, including satisfiability.
\item Prototyped, but problem with GHC type-checker.
      Seeking help.
\item Violates a cartesian axiom.
      Looking for alternatives.
\end{itemize}
}

\framet{Progress}{
\begin{itemize}\itemsep2.5ex \parskip2ex
\item Formulated some regressions, standard DL, and CNN.
\item Identified implementation problems with scaling and robustness.
\item Breakthroughs in both, including functor-level operations.
\item Simple \& efficient reverse-mode AD.
\end{itemize}
}

%endif

\end{document}
