________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


To load this example and for sample queries, please see the `SCRIPT.txt`
file.

This folder contains several examples of using Prolog built-in meta-predicates
and module meta-predicates that take closures as arguments. It is used to help
testing Logtalk support for dealing with closures as it requires generation of
a helper predicate per call to workaround a clash between the way Logtalk
compiles predicates and the way a closure is extended to form a goal.

This example supports using ECLiPSe, GNU Prolog, SICStus Prolog, SWI-Prolog,
and YAP as the backend compilers.
