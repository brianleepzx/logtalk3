%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  This file is part of Logtalk <http://logtalk.org/>
%  
%  Logtalk is free software. You can redistribute it and/or modify it under
%  the terms of the FSF GNU General Public License 3  (plus some additional
%  terms per section 7).        Consult the `LICENSE.txt` file for details.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- object(retractall_1_test_object).

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
		Object::retractall(foo).

	:- public(te/0).
	te :-
		Object = 1,
		Object::retractall(foo).

:- end_object.



:- object(tests,
	extends(lgtunit)).

	:- info([
		version is 1.0,
		author is 'Paulo Moura',
		date is 2014/04/16,
		comment is 'Unit tests for the retractall/1 built-in method.'
	]).

	throws(retractall_1_1, error(instantiation_error, logtalk(retractall_1_test_object::retractall(_),user))) :-
		{retractall_1_test_object::retractall(_)}.

	throws(retractall_1_2, error(type_error(callable, 1), logtalk(retractall_1_test_object::retractall(1),user))) :-
		{retractall_1_test_object::retractall(1)}.

	throws(retractall_1_3, error(permission_error(modify, protected_predicate, q/2), logtalk(retractall_1_test_object::retractall(q(_,_)),user))) :-
		{retractall_1_test_object::retractall(q(_,_))}.

	throws(retractall_1_4, error(permission_error(modify, private_predicate, r/3), logtalk(retractall_1_test_object::retractall(r(_,_,_)),user))) :-
		{retractall_1_test_object::retractall(r(_,_,_))}.

	throws(retractall_1_5, error(permission_error(modify, static_predicate, s/4), logtalk(retractall_1_test_object::retractall(s(_,_,_,_)),user))) :-
		{retractall_1_test_object::retractall(s(_,_,_,_))}.

	throws(retractall_1_6, error(existence_error(predicate_declaration, unknown/1), logtalk(retractall_1_test_object::retractall(unknown(_)),user))) :-
		{retractall_1_test_object::retractall(unknown(_))}.

	throws(retractall_1_7, error(instantiation_error, logtalk(_::retractall(foo),retractall_1_test_object))) :-
		{retractall_1_test_object::ie(_)}.

	throws(retractall_1_8, error(type_error(object_identifier, 1), logtalk(1::retractall(foo),retractall_1_test_object))) :-
		{retractall_1_test_object::te}.

	succeeds(retractall_1_9) :-
		retractall_1_test_object::retractall(t(3)),
		retractall_1_test_object::t(1),
		retractall_1_test_object::t(2),
		\+ retractall_1_test_object::t(3),
		retractall_1_test_object::retractall(t(_)),
		\+ retractall_1_test_object::t(_).

	succeeds(retractall_1_10) :-
		create_object(Object, [], [public(t/1), dynamic(t/1)], [t(1), (t(2) :-t(1)), (t(3) :-t(1),t(2))]),
		Object::retractall(t(3)),
		Object::t(1),
		Object::t(2),
		\+ Object::t(3),
		Object::retractall(t(_)),
		\+ Object::t(_),
		abolish_object(Object).

:- end_object.