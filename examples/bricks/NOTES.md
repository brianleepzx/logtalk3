________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


To load this example and for sample queries, please see the `SCRIPT.txt` file.

This folder contains an example of representation and handling of relations
using events. We have instances of class `brick` and a binary `brick_stack`
relation between the bricks. Every time we move a brick, we want the bricks
on top of it to move along. If we break the stack by moving a middle brick,
we want to automatically destroy the corresponding relation tuple.

It's instructive to use the event debugger in the Logtalk library (loader 
file `debugging_loader.lgt`) to better understand this example. Set spy
points in all brick instances and then activate the debugger.
