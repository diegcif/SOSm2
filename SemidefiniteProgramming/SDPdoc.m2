
document {
    Key => SemidefiniteProgramming,
    Headline => "A package for solving semidefinite programs",
    "This is a package for solving semidefinite programming (SDP) problems. ",
    "The main method of this package is ", TO "solveSDP", ". ",
    "See ", TO "Solver", " for a discussion of the available SDP solvers. ",
    "The method ", TO2{"refine(Matrix,Sequence,Matrix,Sequence)","refine"}, " can be used to improve the precision of the solution."
    }

--###################################
-- Methods
--###################################

doc /// --roundPSDmatrix
    Key
        roundPSDmatrix
    Headline
        rational rounding of a PSD matrix
    Usage
        (Qp,ispsd) = roundPSDmatrix(Q,A,b,d)
    Inputs
        Q:Matrix
          a symmetric matrix (real)
        A:Matrix
          (rational)
        b:Matrix
          (rational)
        d:ZZ
          the rounding precision
    Outputs
        Qp:Matrix
          the rounded matrix (rational)
        ispsd:Boolean
          true if Qp is positive semidefinite
    Consequences
    Description
      Text
        Let $S^n$ be the space of symmetric $n\times n$ matrices,
        and let $L \subset S^n$ be a rational affine subspace.
        By @TO2 {smat2vec,"vectorization"}@ we may describe this subspace in the form  $A q = b$ for some matrix $A$ with $n(n+1)/2$ columns.
        Given a real matrix $Q\in S^n$, this method finds a nearby rational matrix $Q_p$ on $L$.
      Code
      Pre
    SeeAlso
        smat2vec
///

doc /// --smat2vec
    Key
        smat2vec
        (smat2vec,Matrix)
        (smat2vec,List)
        vec2smat
        (vec2smat,Matrix)
        (vec2smat,List)
        Scaling
     	[smat2vec,Scaling]
    Headline
        vectorization of a symmetric matrix
    Usage
        v = smat2vec A
        A = vec2smat v
    Inputs
        A:Matrix
          symmetric
        v:Matrix
          a vector
    Outputs
        v:Matrix
        A:Matrix
    Consequences
    Description
      Text
        The method {\tt smat2vec} obtains the vectorization of a symmetric matrix.
        The method {\tt vec2smat} performs the reverse operation.
      Example
        A = matrix(QQ, {{1,2,3,4},{2,5,6,7},{3,6,8,9},{4,7,9,10}})
        v = smat2vec A
        vec2smat v
      Text
        The scaling of the off-diagonal entries can be controlled with the optional parameter.
      Example
        smat2vec(A,Scaling=>2)
      Code
      Pre
    SeeAlso
///

doc /// --PSDdecomposition
    Key
        PSDdecomposition
    Headline
        factorization of a positive semidefinite matrix
    Usage
        (L,D,P) = PSDdecomposition A
    Inputs
        A:Matrix
    Outputs
        L:Matrix
          nonsingular
        D:Matrix
          diagonal
        P:Matrix
          permutation matrix
    Consequences
    Description
      Text
        Given a positive semidefinite matrix $A$, this method factorizes it in the form $P' A P = L D L'$,
        where $P$ is a permutation matrix,
        $L$ is nonsingular,
        $D$ is diagonal.
        If $A$ is a real matrix, this factorization is obtained from its eigenvalue decomposition.
        For rational matrices we use the LDL decomposition [Golub-vanLoan'89].
        The method returns null if $A$ is not positive semidefinite.
      Example
        A = matrix(QQ, {{5,3,5},{3,2,4},{5,4,10}})
        (L,D,P) = PSDdecomposition(A)
        L*D*transpose(L) == transpose(P)*A*P
      Text
        {\bf References:}
        {\it Matrix Computations}, Gene Golub and Charles van Loan. Johns Hopkins
        series in the Mathematical Science (1989), 2 ed., pp. 133-148.
      Code
      Pre
    SeeAlso
///

doc /// --solveSDP
    Key
        solveSDP
        (solveSDP,Matrix,Matrix,Matrix)
        (solveSDP,Matrix,Matrix,Matrix,Matrix)
        (solveSDP,Matrix,Sequence,Matrix)
        (solveSDP,Matrix,Sequence,Matrix,Matrix)
    Headline
        solve a semidefinite program
    Usage
        (X,y,Q) = solveSDP(C,A,b)
        (X,y,Q) = solveSDP(C,A,b,y0)
    Inputs
        C:Matrix
          a symmetric $n\times n$ matrix
        A:Sequence
          consisting of $m$ symmetric $n\times n$ matrices
        b:Matrix
          a $m\times 1$ matrix
        y0:Matrix
          a dual feasible $m\times 1$ matrix (optional)
    Outputs
        X:
          an $n\times n$ matrix, primal variable (not available if Solver=>"M2")
        y:
          an $m\times 1$ matrix, dual variable
        Q:
          an $n\times n$ matrix, dual variable
    Consequences
    Description
      Text
        This method solves a primal/dual pair of semidefinite programs.
        Given symmetric matrices $C, A_i$ and a vector $b$, the primal problem is

        $$min_{X} \, C \bullet X \,\,\, s.t. \,\,\, A_i \bullet X = b_i \, and \, X \geq 0$$

        and the dual problem is

        $$max_{y,Q} \, \sum_i b_i y_i \,\,\, s.t. \,\,\, Q = C - \sum_i y_i A_i \, and \, Q \geq 0$$

        The default algorithm is a dual interior point method implemented in M2. 
        A strictly feasible initial point $y_0$ may be provided by the user.
        Alternatively, there is an interface to the @TO2 {[solveSDP,Solver],"solvers"}@ CSDP, SDPA and MOSEK.
      Example
        C = matrix {{1,0},{0,2}};
        A = matrix {{0,1},{1,0}};
        b = matrix {{-1}};
        (X,y,Q) = solveSDP(C,A,b);
        y
      Text
        {\bf References:}
        {\it Convex Optimization}, Boyd, Vandenberghe, Cambridge University Press (2004), pp. 618-619, pp. 463-466
      Code
      Pre
    Caveat
        $\bullet$ The "M2" solver does not return the primal solution.

        $\bullet$ The "M2" solver might fail if the dual problem is not strictly feasible.
    SeeAlso
///

doc /// --sdpIdeal
    Key
        sdpIdeal
        (sdpIdeal,Matrix,Sequence,Matrix)
        Square
        [sdpIdeal,Square]
        Rank
        [sdpIdeal,Rank]
    Headline
        ideal of critical equations of a semidefinite program
    Usage
        (I,X,y,Z) = sdpIdeal(C,A,b)
    Inputs
        C:Matrix
          a symmetric $n\times n$ matrix
        A:Sequence
          consisting of $m$ symmetric $n\times n$ matrices
        b:Matrix
          a $m\times 1$ matrix
    Outputs
        I:Ideal
          of critical equations
        X:
          an $n\times n$ matrix, primal variable
        y:
          an $m\times 1$ matrix, dual variable
        Q:
          an $n\times n$ matrix, dual variable
    Consequences
    Description
      Text
        This method computes the ideal of critical equations of an SDP.
        This ideal can be used to solve the SDP symbolically.
      Example
        C = matrix{{1/1,0,3},{0,5,0},{3,0,9}};
        A1 = -matrix{{0,1,0},{1,0,0},{0,0,1}};
        A2 = -matrix{{0,0,-1},{0,0,0},{-1,0,0}};
        A3 = -matrix{{0,0,0},{0,0,1},{0,1,0}};
        b = -matrix{{1},{1},{1}};
        A = (A1,A2,A3);
        (I,X,y,Z) = sdpIdeal(C,A,b);
        degree I
      Text
        We can restrict the rank of the primal matrix X.
      Example
        (J,X,y,Z) = sdpIdeal(C,A,b,Rank=>1);
        degree J
      Text
        The option Square can be used to produce a square polynomial system, with possibly larger variety.
      Code
      Pre
    SeeAlso
///

doc /// --refine
    Key
        (refine,Matrix,Sequence,Matrix,Sequence)
    Headline
        refine an SDP solution
    Usage
        (X1,y1) = refineSolution(C,A,b,(X0,y0))
    Inputs
        C:Matrix
          a symmetric $n\times n$ matrix
        A:Sequence
          consisting of $m$ symmetric $n\times n$ matrices
        b:Matrix
          a $m\times 1$ matrix
        X0y0:
          primal and dual solutions
    Outputs
        X1y1:
          refined primal and dual solutions
    Consequences
    Description
      Text
        This function uses Newton's method to improve the precision of an optimal primal/dual pair.
        The refined solution has relative error bounded by min(@TO ErrorTolerance@,2(-@TO Bits@)). 
        The number of iterations made is at most @TO Iterations@.
      Example
        C = matrix {{1,0},{0,2}};
        A1 = matrix {{0,1},{1,0}};
        A = sequence(A1);
        b = matrix {{-1}};
        X0 = matrix {{.706989, -.5}, {-.5, .353612}}
        y0 = matrix {{-1.41421}}
        (X1,y1) = refine(C,A,b,(X0,y0))
      Code
      Pre
    SeeAlso
        refine
        sdpIdeal
///

--###################################
-- Unexported methods (for developers)
--###################################

doc /// --project2linspace
    Key
        project2linspace
    Headline
        project a rational point onto affine subspace
    Usage
        xp = project2linspace(A,b,x0)
    Inputs
        A:Matrix
        b:Matrix
          a vector
        x0:Matrix
          a rational vector
    Outputs
        xp:Matrix
          the projection of x0
    Consequences
    Description
      Text
        Projects a rational point $x_0$ onto the affine subspace given by $A x = b$
      Code
      Pre
    SeeAlso
///

--###################################
-- Symbols
--###################################
doc /// -- Verbose
     Key
        [solveSDP,Verbose]
     Headline
        non-essential but informative output
     Description
        Text
           Setting this option to true enables additional informative output. The default is @TO false@.
///

document { --Solver
    Key => {
        Solver,
        [solveSDP,Solver],
        },
    Headline => "picking a semidefinite programming solver",
    "This package interfaces semidefinite programming solvers in Macaulay2. ",
    "There is also a rudimentary implementation of such a solver in the Macaulay2 language. ",
    "It is called the M2 solver but for most applications it will be insufficient. ",
    "For this reason Macaulay2 also ships the CSDP solver. ",
    "The package supports the following solvers: ",
    UL{
      {"\"M2\"", " -- a simple dual interior point method implemented in Macaulay2"},
       {"\"CSDP\"", " -- this is an open source solver, available at ", TT "https://projects.coin-or.org/Csdp/" },
       {"\"SDPA\"", " -- this is an open source solver, available at ", TT "http://sdpa.sourceforge.net/" },
       {"\"MOSEK\"", " -- this is a commercial solver, free for academic use, available at ", TT "https://www.mosek.com/" },
      },
    "The CSDP solver is shipped with Macaulay2 and configured as the default solver. ",
    "In our experience CSDP and MOSEK give the best results. ",
    "An easy way to make an additional solver available to Macaulay2 is to add the executable to the PATH environment variable. ",
    "Another way is to explicitly specify the location of the executable in the package configuration:",
    EXAMPLE lines ///
       needsPackage ("SemidefiniteProgramming", Configuration=>{"CSDPexec"=>"/some/path/csdp"});
       needsPackage ("SemidefiniteProgramming", Configuration=>{"SDPAexec"=>"/some/path/sdpa"});
       needsPackage ("SemidefiniteProgramming", Configuration=>{"MOSEKexec"=>"/some/path/mosek"});
    ///,
    "A third method is to use the function ", TO changeSolver, ". ",
    "After configuring, the method ", TO "checkSolver", " can be used to check if a solver works.",
    BR{},
    BR{},

    "The default solver can also be specified when loading the package:",
    EXAMPLE lines ///
       needsPackage ("SemidefiniteProgramming", Configuration=>{"DefaultSolver"=>"CSDP"});
    ///,
    "If no default solver is specified, the package tries to use, in this order,
    CSDP, MOSEK, SDPA, M2.",

    HEADER2 "Saving the configuration",
    "The configuration options \"CSDPexec\", \"SDPAexec\", \"MOSEKexec\", \"DefaultSolver\" can be saved by editing the file \"init-SemidefiniteProgramming.m2\", which is located in the application directory:",
    EXAMPLE lines ///
        applicationDirectory()
    ///,
    }


doc ///
    Key
      changeSolver
    Headline
      change the SDP solver
    Usage
      changeSolver (solver, path)
    Inputs
        Solver:String
	  the name of the solver to configure: CSDP, MOSEK, or SDPA
	path:String
	  the full path to the executable of the solver
    Description
      Text
        The path can be specified as an absolute or relative path of the executable and must include the name of the executable.        
      Example
        changeSolver ("CSDP", "/path/to/csdp")
    Caveat
      The function does not check if the specified executable exists or is functional.  To find out try @TO checkSolveSDP@.
    SeeAlso
      Solver
///

doc ///
    Key
      checkSolveSDP
    Headline
      check an SDP solver
    Usage
      checkSolveSDP (solver, applyTest)
    Inputs
        Solver:String
	  the name of the solver to configure: CSDP, MOSEK, M2, or SDPA
	applyTest:Function
	  A boolean function that specifies for each integer i if the ith test should be run.
    Description
      Text
        Use this function to run some basic checks with an SDP solver
      Example
        checkSolveSDP ("CSDP", i->true)
    Caveat
    SeeAlso
      Solver
///

doc ///
    Key
      "mosekexec"
      "csdpexec"
      "sdpaexec"
    Headline
      Locations of executables
    Description
      Text
        The package uses these mutable variables to store the paths of the executables.
	They can be edited by the user.  The prefered way to do this is @TO changeSolver@, though.
///
