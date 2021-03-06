%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  This file is part of Logtalk <http://logtalk.org/>
%  
%  Logtalk is free software. You can redistribute it and/or modify it under
%  the terms of the FSF GNU General Public License 3  (plus some additional
%  terms per section 7).        Consult the `LICENSE.txt` file for details.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% tests from the ISO/IEC 13211-1:1995(E) standard, section 7.8.9.4

foo(X) :-
	Y is X * 2, throw(test(Y)).

bar(X) :-
	X = Y, throw(Y).

coo(X) :-
	throw(X).

car(X) :-
	X = 1, throw(X).

g :-
	catch(p, _B, write(h2)),
	coo(c).

p.
p :-
	throw(b).


:- object(tests,
	extends(lgtunit)).

	:- info([
		version is 1.0,
		author is 'Paulo Moura',
		date is 2014/10/14,
		comment is 'Unit tests for the ISO Prolog standard catch/3 built-in predicate.'
	]).

	:- discontiguous([
		succeeds/1, fails/1, throws/2
	]).

	% tests from the ISO/IEC 13211-1:1995(E) standard, section 7.8.9.4

	succeeds(iso_catch_3_01) :-
		{catch(foo(5), test(Y), true)},
		Y == 10.

	succeeds(iso_catch_3_02) :-
		{catch(bar(3), Z, true)},
		Z == 3.

	succeeds(iso_catch_3_03) :-
		{catch(true, _, 3)}.

	throws(iso_catch_3_04, bla) :-
		% ISO wants a system_error instead but all tested systems disagree!
		{catch(true, _C, write(demoen)), throw(bla)}.

	succeeds(iso_catch_3_05) :-
		{catch(car(_X), Y, true)},
		Y == 1.

	fails(iso_catch_3_06) :-
		{catch(number_chars(_X,['1',a,'0']), error(syntax_error(_),_), fail)}.

	succeeds(iso_catch_3_07) :-
		{catch(g, C, write(h1)), nl},
		C == c.

	succeeds(iso_catch_3_08) :-
		{catch(coo(_X), Y, true)},
		Y = error(instantiation_error,_).

:- end_object.
