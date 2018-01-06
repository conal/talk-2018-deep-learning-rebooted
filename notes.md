
[*TensorFlow: Learning Functions at Scale*]: https://www.youtube.com/watch?v=EpifLmPM1L0&list=PLnqUlCo055hV-Yb_88YYUC2ucaBKCWCsa "Talk by Martín Abadi (2016)"

*   Original inspiration in Oct 2016: [*TensorFlow: Learning Functions at Scale*], a talk by Martín Abadi.
    *   Familiar design anti-pattern:
        *   Use one language to explicitly construct computations in another language.
        *   Explicit graph manipulation.
        *   Poor abstraction support.
        *   Ad hoc and clumsy (syntax, types, parameters).
        *   Ill-defined semantics.
        *   Concreteness & mutability thwart efficient implementation.
        *   Other examples include retained mode graphics, HTML+JS+DOM.
    *   "Tensors": awkward and unsafe.
        Replace with functor algebra / free vector spaces.
    *   General proposal:
        *   Build a system that beats TensorFlow in simplicity, expressiveness, modularity/reuse, safety, and optimizability.
        *   Eliminate gap between host PL and execution graph.
        *   Elegant, denotative host language.
        *   Powerful types and abstraction.
*   Goals:
    *   Extract the essence of DL while shedding accidental complexity.
    *   Support that essence very well.
    *   "Perfection is achieved not when there is nothing left to add, but when there is nothing left to take away." - Antoine de Saint-Exupéry
*   Essence:
    *   Optimization: find the "best" element of a set according to an objective function.
    *   For DL, we have sets of *functions*.
    *   Objective function is derived via a collection of input/output pairs (minimize prediction error).
    *   Math/function-friendly language.
*   Accidental complexity (historical baggage):
    *   Imperative programming
    *   Weak typing
    *   Graphs / networks
    *   Layers
    *   Tensors / arrays
    *   Back propagation
    *   Linearity bias
    *   Hyper-parameters
    *   Stateful formulations
    *   Manual differentiation
*   Some detail on accidental complexity:
    *   Imperative programming:
        *   Unnecessary for expressiveness
        *   Thwarts efficiency (parallelism)
        *   Thwarts correctness/dependable (usually "not even wrong")
        *   DL is math, so pick a math language.
    *   Weak typing:
        *   Requires people to manage detail & consistency. Not our strength.
        *   Errors at run-time.
    *   Graphs:
        *   Clutters API, distracting from purpose.
        *   Purpose: a representation of functions.
        *   We already have one: programming language.
        *   But we can't differentiate.
            An issue of *implementation*, not language or library definition.
            Fix accordingly.
    *   Layers:
        *   Strong bias toward sequential composition.
        *   Neglects other forms: parallel & conditional.
        *   Leads to awkward hacks, such as "skip connections", ResNet, HighwayNet.
        *   Don't patch the problem; eliminate it.
    *   Tensors:
        *   Really, multi-dim arrays.
        *   Awkward: imagine you could program only with arrays (Fortran).
            "One size fits none."
        *   Meaningless operations, e.g., element-wise array multiplication.
        *   Even as linear maps: meaning of $m \times n$ array?
        *   More natural (for programming) data types, e.g., various tree types.
    *   Back propagation:
        *   Specialization and re-discovery of reverse-mode automatic differentiation (RAD).
        *   Stateful:
            *   More awkward to use.
            *   Thwarts parallelism/efficiency.
            *   Impractical to use with GD, hence SGD, which leads away from minima.
        *   Entangled with GD & SGD, hindering progress.
    *   Linearity bias:
        *   "Dense" and "fully connected" really means arbitrary *linear* transformation.
        *   Sprinkle in "activation functions" as exceptions to linearity.
        *   More balanced (less biased) approach may yield simpler and more efficient alternatives.
    *   Hyper-parameters:
        *   Unify with parameters for consistency and automation.
        *   Hybrid search/optimization methods.
    *   Stateful formulations:
        *   Complex and ill-defined.
        *   Stateless alternatives: fold, unfold, scan.
            *   Simple, general, effective.
            *   Correct algebraic reasoning.
            *   Parallelism!
*   A functional reboot:
    *   Values:
        *   *Precision*: reasoning, correctness.
        *   *Simplicity*: *practical* dependability.
        *   *Generality*: design guidance, and room to grow.
    *   Write directly in Haskell:
        *   Existing semantics (no graphs/networks/layers)
        *   *Higher-order* functions
        *   Rich, static typing
    *   Genuinely automatic differentiation:
        *   Directly on Haskell *programs*.
        *   At compile time,
        *   Efficient run-time code,
        *   Amenable to massively parallel execution (GPU, etc).
        *   Specify and implement via category theory.
            Supports variation and experimentation.
    *   Optimization:
        *   Describe a set of values as range of function: `f :: p -> c`.
        *   Objective function: `o :: c -> R`.
        *   Find `argMin (o . f) :: c`.
        *   When `o . f` is differentiable, use GD.
        *   Otherwise, other methods.
        *   Consider also global optimization, e.g., with interval methods.
    *   Learning *functions*:
        *   Special case of optimization, where `c = a -> b`, i.e., `f :: p -> (a -> b)`, and `o :: (a -> b) -> R`.
        *   Objective function often based on sample set $S \subseteq a \times b$.
        *   Additivity enables parallel, log-time learning step.
    *   Modularity:
        *   How to build function families from pieces, as in DL?
        *   Idea: another category, `Choice`.
            Automatically combines and routes parameters from separate families.
        *   Extract monolithic function after composing.
        *   Prototyped, but problem with GHC type-checker.
            Getting help.
        *   Violates a cartesian axiom.
            Looking for alternatives.
*   Progress:
    *   Formulated some regressions, standard DL, and CNN.
    *   Revealed problems with scaling and robustness.
    *   Scaling: functor-level operations.
        Exploring design space.
        Getting there!
    *   Simple & efficient RAD.
