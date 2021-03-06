________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


To load this example and for sample queries, please see the `SCRIPT.txt`
file.

Some of the code in this folder is adapted, with permission, from the book 
"Prolog Programming for Artificial Intelligence" by Ivan Bratko.

For a description of the search problems, please see a classical AI book 
(such as the one above) or visit <http://www.plastelina.net/games>.

This example defines two hierarchies of objects, one for representing 
state-spaces and another for representing search methods:

	state_space
		farmer
		water_jug
		salt(Quantity, Measure1, Measure2)
		heuristic_state_space
			bridge
			eight_puzzle
			miss_cann

	search_strategy
		blind_search(Bound)
			breadth_first(Bound)
			depth_first(Bound)
		heuristic_search(Threshold)
			best_first(Threshold)
			hill_climbing(Threshold)

Taken together, these two hierarchies implement a framework for solving 
state-space search problems in Logtalk. There is also a monitor object, 
`performance`, which tries to measure the time taken to find a solution, 
the branching factor while searching for a solution, and the number of 
transitions made to find a solution.
