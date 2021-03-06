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
		date is 2014/11/18,
		comment is 'Unit tests for the ISO Prolog standard atan/1 built-in function.'
	]).

	:- uses(lgtunit, [
		op(700, xfx, '=~='), '=~='/2
	]).

	:- discontiguous([
		succeeds/1, throws/2
	]).

	% tests from the ISO/IEC 13211-1:1995(E) standard, section 9.3.4.4

	succeeds(iso_atan_1_01) :-
		{X is atan(0.0)},
		X == 0.0.

	succeeds(iso_atan_1_02) :-
		{PI is atan(1.0)*4},
		PI =~= 3.14159.

	throws(iso_atan_1_03, error(instantiation_error,_)) :-
		% try to delay the error to runtime
		variable(N),
		{_X is atan(N)}.

	succeeds(iso_atan_1_04) :-
		{X is atan(0)},
		X == 0.0.

	throws(iso_atan_1_05, error(type_error(evaluable,foo/0),_)) :-
		% try to delay the error to runtime
		foo(Foo),
		{_X is atan(Foo)}.

	variable(_).

	foo(foo).

:- end_object.
