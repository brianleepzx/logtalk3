________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


To load this example and for sample queries, please see the `SCRIPT.txt` file.

This folder contains a set of simple examples illustrating how to use B-Prolog
constraint support with Logtalk. These examples are adapted with permission 
from the original author, Neng-Fa Zhou.

The B-Prolog `::/2` finite-domain built-in predicate clashes with the Logtalk 
`::/2` message sending operator. The solution is to use instead the alternative
B-Prolog `in/2` built-in predicate.

The built-in `predicate_property/2` predicate fails to report some of the 
constraint predicates as built-in predicates. One workaround is to encapsulate
calls to these predicates using the `{}/1` Logtalk control construct.
