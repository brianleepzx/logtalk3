________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


To load this example and for sample queries, please see the `SCRIPT.txt`
file.

This folder contains a simple multi-threading example illustrating how 
to use the Logtalk built-in `threaded_wait/1` and `threaded_notify/1`
predicates for synchronizing threads writing to and reading from a buffer
that can only contain an item at the same time. 
