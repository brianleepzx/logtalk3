________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


To load this example and for sample queries, please see the `SCRIPT.txt`
file.

This folder contains examples of using some of the built-in database 
handling methods with object and categories. Two object hierarchies are
provided, one prototype-based, and the other class-based, in order to
illustrate the differences between asserting predicates in a class and
in a prototype:

The following objects are defined:

- `root`  
	root of the prototype hierarchy; declares and defines a public,
	dynamic predicate
- `descendant`  
	simple prototype extending the root prototype

- `class`  
	root of the class hierarchy; declares and defines a public predicate
- `metaclass`  
	class metaclass
- `instance`  
	simple instance of class class

- `prototype`  
	simple prototype used to illustrate how the scope of asserted 
	predicates depends on the target object (this, self, or an explicit 
	object)

In addition, the file `categories.lgt` illustrates how to define category
predicates that handle dynamic predicates in the context of "this" and in
the context of "self".
