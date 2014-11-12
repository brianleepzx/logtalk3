%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  This file is part of Logtalk <http://logtalk.org/>
%  
%  Logtalk is free software. You can redistribute it and/or modify it under
%  the terms of the FSF GNU General Public License 3  (plus some additional
%  terms per section 7).        Consult the `LICENSE.txt` file for details.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- object(retract_1_test_object).

	:- public(p/1).
	:- dynamic(p/1).

	:- protected(q/2).
	:- dynamic(q/2).

	:- private(r/3).
	:- dynamic(r/3).

	:- public(s/4).

	:- public(t/1).
	:- dynamic(t/1).
	t(1).
	t(2) :- t(1).
	t(3) :- t(1), t(2).

	:- public(ie/1).

	ie(Object) :-
		Object::retract(foo).

	:- public(te/0).
	te :-
		Object = 1,
		Object::retract(foo).

:- end_object.



:- object(tests,
	extends(lgtunit)).

	:- info([
		version is 1.0,
		author is 'Paulo Moura',
		date is 2014/04/16,
		comment is 'Unit tests for the retract/1 built-in method.'
	]).

	throws(retract_1_1, error(instantiation_error, logtalk(retract_1_test_object::retract(_),user))) :-
		{retract_1_test_object::retract(_)}.

	throws(retract_1_2, error(instantiation_error, logtalk(retract_1_test_object::retract((_:-_)),user))) :-
		{retract_1_test_object::retract((_ :- _))}.

	throws(retract_1_3, error(type_error(callable, 1), logtalk(retract_1_test_object::retract(1),user))) :-
		{retract_1_test_object::retract(1)}.

	throws(retract_1_4, error(type_error(callable, 1), logtalk(retract_1_test_object::retract((1:-_)),user))) :-
		{retract_1_test_object::retract((1 :- _))}.

	throws(retract_1_5, error(permission_error(modify, protected_predicate, q/2), logtalk(retract_1_test_object::retract(q(_,_)),user))) :-
		{retract_1_test_object::retract(q(_,_))}.

	throws(retract_1_6, error(permission_error(modify, private_predicate, r/3), logtalk(retract_1_test_object::retract(r(_,_,_)),user))) :-
		{retract_1_test_object::retract(r(_,_,_))}.

	throws(retract_1_7, error(permission_error(modify, static_predicate, s/4), logtalk(retract_1_test_object::retract(s(_,_,_,_)),user))) :-
		{retract_1_test_object::retract(s(_,_,_,_))}.

	throws(retract_1_8, error(existence_error(predicate_declaration, unknown/1), logtalk(retract_1_test_object::retract(unknown(_)),user))) :-
		{retract_1_test_object::retract(unknown(_))}.

	throws(retract_1_9, error(instantiation_error, logtalk(_::retract(foo),retract_1_test_object))) :-
		{retract_1_test_object::ie(_)}.

	throws(retract_1_10, error(type_error(object_identifier, 1), logtalk(1::retract(foo),retract_1_test_object))) :-
		{retract_1_test_object::te}.

	succeeds(retract_1_11) :-
		retract_1_test_object::retract((t(X) :-true)),
		X == 1,
		retract_1_test_object::retract((t(2) :-Body1)),
		Body1 == t(1),
		retract_1_test_object::retract((t(3) :-Body2)),
		Body2 == (t(1), t(2)).

	succeeds(retract_1_12) :-
		create_object(Object, [], [public(t/1), dynamic(t/1)], [t(1), (t(2) :-t(1)), (t(3) :-t(1),t(2))]),
		Object::retract((t(X) :-true)),
		X == 1,
		Object::retract((t(2) :-Body1)),
		Body1 == t(1),
		Object::retract((t(3) :-Body2)),
		Body2 == (t(1), t(2)),
		abolish_object(Object).

:- end_object.