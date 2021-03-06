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
		date is 2014/04/16,
		comment is 'Unit tests for the retractall/1 built-in method.'
	]).

	throws(retractall_1_1, error(instantiation_error, logtalk(test_object::retractall(_),user))) :-
		{test_object::retractall(_)}.

	throws(retractall_1_2, error(type_error(callable, 1), logtalk(test_object::retractall(1),user))) :-
		{test_object::retractall(1)}.

	throws(retractall_1_3, error(permission_error(modify, protected_predicate, q/2), logtalk(test_object::retractall(q(_,_)),user))) :-
		{test_object::retractall(q(_,_))}.

	throws(retractall_1_4, error(permission_error(modify, private_predicate, r/3), logtalk(test_object::retractall(r(_,_,_)),user))) :-
		{test_object::retractall(r(_,_,_))}.

	throws(retractall_1_5, error(permission_error(modify, static_predicate, s/4), logtalk(test_object::retractall(s(_,_,_,_)),user))) :-
		{test_object::retractall(s(_,_,_,_))}.

	throws(retractall_1_6, error(existence_error(predicate_declaration, unknown/1), logtalk(test_object::retractall(unknown(_)),user))) :-
		{test_object::retractall(unknown(_))}.

	throws(retractall_1_7, error(instantiation_error, logtalk(_::retractall(foo),test_object))) :-
		{test_object::ie(_)}.

	throws(retractall_1_8, error(type_error(object_identifier, 1), logtalk(1::retractall(foo),test_object))) :-
		{test_object::te}.

	succeeds(retractall_1_9) :-
		test_object::retractall(t(3)),
		test_object::t(1),
		test_object::t(2),
		\+ test_object::t(3),
		test_object::retractall(t(_)),
		\+ test_object::t(_).

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
