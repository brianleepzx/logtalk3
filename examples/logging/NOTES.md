________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


To load this example and for sample queries, please see the `SCRIPT.txt`
file.

This folder contains an example of using a category to define a simple 
logging support for objects. This example illustrates how to define in 
a category a set of predicates that handle a dynamic predicate in the 
context of "this". Although the database built-in methods, such as 
`assertz/1` or `retractall/1`, are straightforward to use, calling the 
dynamic predicate must be performed using the message sending `::/2` 
control construct (note that a direct call to the dynamic predicate 
would result in a compilation error as it would be interpreted as a 
call to a local category dynamic predicate: categories cannot contain
clauses for dynamic predicates).
