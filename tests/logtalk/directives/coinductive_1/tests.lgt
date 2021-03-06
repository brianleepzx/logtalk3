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
		date is 2014/11/16,
		comment is 'Unit tests for the coinductive/1 built-in directive.'
	]).

	% test all possible syntaxes for the directive

	:- public(a/1).
	:- coinductive(a/1).

	test(coinductive_1_1) :-
		predicate_property(a(_), coinductive(Template)),
		Template == a(+).

	:- public(b/2).
	:- coinductive(b(+, -)).

	test(coinductive_1_2) :-
		predicate_property(b(_, _), coinductive(Template)),
		Template == b(+, -).

	% calls to predicates declared coinductive but not defined
	% must fail instead of throwing an existence error

	:- coinductive(c/3).

	test(coinductive_1_3) :-
		\+ c(_, _, _).

:- end_object.
