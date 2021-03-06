%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  This file is part of Logtalk <http://logtalk.org/>
%  
%  Logtalk is free software. You can redistribute it and/or modify it under
%  the terms of the FSF GNU General Public License 3  (plus some additional
%  terms per section 7).        Consult the `LICENSE.txt` file for details.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- object(tests,
	extends(lgtunit)).

	:- info([
		version is 1.0,
		author is 'Paulo Moura',
		date is 2014/05/07,
		comment is 'Unit tests for the public/1 built-in directive.'
	]).

	% test all possible syntaxes for the directive
	:- public(a/0).
	:- public((b/1, c/2)).
	:- public([d/3, e/4]).

	test(public_1_1) :-
		predicate_property(a, (public)),
		predicate_property(a, static).

	test(public_1_2) :-
		predicate_property(b(_), (public)),
		predicate_property(b(_), static),
		predicate_property(c(_,_), (public)),
		predicate_property(c(_,_), static).

	test(public_1_3) :-
		predicate_property(d(_,_,_), (public)),
		predicate_property(d(_,_,_), static),
		predicate_property(e(_,_,_,_), (public)),
		predicate_property(e(_,_,_,_), static).

:- end_object.
