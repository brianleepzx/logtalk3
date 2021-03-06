________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


To load this example and for sample queries, please see the `SCRIPT.txt`
file.

This folder contains a Logtalk implementation of the classical "dining 
philosophers" multi-threading problem.

For more information, consult e.g. the following URL:

	http://en.wikipedia.org/wiki/Dining_philosophers_problem

Two different implementations are provided, both using the same solution for 
avoiding deadlock (which is having one philosopher picking its chopsticks 
in a different order from the other philosophers; see the URL above for 
details): one implementations uses a category and five philosopher objects 
while the second implementation uses a parametric object.
