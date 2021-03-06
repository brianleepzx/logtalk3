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
		date is 2014/04/18,
		comment is 'Unit tests for the current_op/3 built-in directive.'
	]).

	throws(current_op_3_1, error(type_error(integer,a), logtalk(This::current_op(a,_,_),user))) :-
		this(This),
		{This::current_op(a, _, _)}.

	throws(current_op_3_2, error(domain_error(operator_priority,3000), logtalk(This::current_op(3000,_,_),user))) :-
		this(This),
		{This::current_op(3000, _, _)}.

	throws(current_op_3_3, error(type_error(atom,1), logtalk(This::current_op(_,1,_),user))) :-
		this(This),
		{This::current_op(_, 1, _)}.

	throws(current_op_3_4, error(domain_error(operator_specifier,a), logtalk(This::current_op(_,a,_),user))) :-
		this(This),
		{This::current_op(_, a, _)}.

	throws(current_op_3_5, error(type_error(atom,1), logtalk(This::current_op(_,_,1),user))) :-
		this(This),
		{This::current_op(_, _, 1)}.

	throws(current_op_3_6, error(instantiation_error, logtalk(_::current_op(_,_,_),test_object_1))) :-
		{test_object_1::ie(_)}.

	throws(current_op_3_7, error(type_error(object_identifier, 1), logtalk(1::current_op(_,_,_),test_object_1))) :-
		{test_object_1::te}.

	succeeds(current_op_3_8) :-
		setof(Operator, test_object_1<<current_op(501, xfx, Operator), Operators),
		Operators == [abc, def, ghi].

	succeeds(current_op_3_9) :-
		setof(Operator, test_object_1::current_op(501, xfx, Operator), Operators),
		Operators == [abc].

	succeeds(current_op_3_10) :-
		test_object_1::current_op(600, xfx, (:)),
		\+ test_object_1::current_op(600, xfy, (:)).

	succeeds(current_op_3_11) :-
		\+ test_object_2::current_op(600, xfx, (:)).

	succeeds(current_op_3_12) :-
		test_object_1::operators(Operators),
		Operators == [abc, def, ghi].

	succeeds(current_op_3_13) :-
		test_object_2::operators(Operators),
		Operators == [opq, rst].

:- end_object.
