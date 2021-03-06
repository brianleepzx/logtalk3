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
		date is 2013/11/18,
		comment is 'Unit tests for the meta_non_terminal/1 built-in directive.'
	]).

	% test all possible syntaxes for the directive

	:- public(foo//1).
	:- meta_non_terminal(foo(0)).

	test(meta_non_terminal_1_1) :-
		predicate_property(foo(_,_,_), non_terminal(foo//1)),
		predicate_property(foo(_,_,_), meta_predicate(Template)),
		Template == foo(2, *, *).

	% existentially-qualified closures are currently not supported
	% :- public(bar/2).
	% :- meta_predicate(bar(^, *)).

	:- public(baz//3).
	:- meta_non_terminal(baz(2, *, *)).

	test(meta_non_terminal_1_3) :-
		predicate_property(baz(_,_,_,_,_), non_terminal(baz//3)),
		predicate_property(baz(_,_,_,_,_), meta_predicate(Template)),
		Template == baz(4, *, *, *, *).

	:- public(qux//2).
	:- meta_non_terminal(qux(::, *)).

	test(meta_non_terminal_1_4) :-
		predicate_property(qux(_,_,_,_), non_terminal(qux//2)),
		predicate_property(qux(_,_,_,_), meta_predicate(Template)),
		Template == qux(::, *, *, *).

:- end_object.
