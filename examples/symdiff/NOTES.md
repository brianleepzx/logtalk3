________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


To load this example and for sample queries, please see the `SCRIPT.txt`
file.

This folder contains an example of using parametric objects to implement
symbolic expression differentiation and simplification.

Current limitations:

- the expression that we intend to differentiate or simplify must be a
compound term. Accepted functors are `*`, `+`, `-`, `**`, and `log`.

- use as a variable the atom `x`.

- only integers can be used as constants.

This example is still incomplete. For example, using sum distribution 
property to simplify expressions is not yet implemented. 
