%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  This file is part of Logtalk <http://logtalk.org/>
%  
%  Logtalk is free software. You can redistribute it and/or modify it under
%  the terms of the FSF GNU General Public License 3  (plus some additional
%  terms per section 7).        Consult the `LICENSE.txt` file for details.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% setup the object "employee" as a monitor for any message sent to itself:

:- initialization((
	define_events(before, employee, _, _, employee),
	set_logtalk_flag(events, allow)
)).


% define a category that adds new functionality to the "employee" object:

:- category(add_on,
	implements(monitoring),		% built-in protocol for the event handler methods
	complements(employee)).		% add the category predicates to the employee object

	% define a "before" event handler for the complemented object:
	before(This, Message, Sender) :-
		this(This),
		write('Received message '), writeq(Message), write(' from '), writeq(Sender), nl.

	% add a new method to the complemented object:
	:- public(predicates/1).

	predicates(Predicates) :-
		setof(Predicate, ::current_predicate(Predicate), Predicates). 

	% define an alias for a predicate of the complemented object:
	:- alias(employee, [salary/1 as income/1]).

:- end_category.
