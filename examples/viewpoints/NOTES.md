________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


To load this example and for sample queries, please see the `SCRIPT.txt`
file.

Example adapted from the chapter "Classifying Prototype-Based Programming
Languages" by Christophe Dony, Jacques Malenfant, and Daniel Bardou, found 
on the book "Prototype-Based Programming - Concepts, Languages, and 
Applications" published by Springer.


This prototype programming example illustrates how we can do both property 
sharing and value sharing in Logtalk by calling the built-in predicate 
modification methods `asserta/1`, `assertz/1`, and `retract/1` either in
the context of "this" or in the context of "self".

In this example we have a prototype, `joe_person`, containing general data
on Joe such as its age, name, or address, and four descendant prototypes
or viewpoints, `joe_sportsman`, `joe_employee`, `joe_chess_player`, and
`joe_film_enthusiast`. Each descendant contains data related to a particular
viewpoint about Joe.
