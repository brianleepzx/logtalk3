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
		date is 2015/01/23,
		comment is 'Unit tests for the object_property/2 built-in predicate.'
	]).

	:- discontiguous(succeeds/1).
	:- discontiguous(fails/1).
	:- discontiguous(throws/2).

	throws(object_property_2_1, error(type_error(object_identifier, 1), logtalk(object_property(1, static), _))) :-
		object_property(1, static).

	throws(object_property_2_2, error(type_error(callable, 1), logtalk(object_property(logtalk, 1), _))) :-
		object_property(logtalk, 1).

	throws(object_property_2_3, error(domain_error(object_property, foo), logtalk(object_property(logtalk, foo), _))) :-
		object_property(logtalk, foo).

	fails(object_property_2_4) :-
		object_property(non_exisiting_object, _).

	fails(object_property_2_5) :-
		object_property(logtalk, (dynamic)).

	succeeds(object_property_2_6) :-
		findall(Prop, object_property(logtalk, Prop), _).

	% entity info
	succeeds(object_property_2_7) :-
		object_property(test_object, static),
		object_property(test_object, dynamic_declarations),
		object_property(test_object, complements(allow)),
		object_property(test_object, complements),
		object_property(test_object, events),
		object_property(test_object, source_data),
		object_property(test_object, file(Basename, Directory)), ground(Basename), ground(Directory),
		object_property(test_object, lines(Start, End)), integer(Start), integer(End),
		object_property(test_object, number_of_clauses(N)), N == 10,
		object_property(test_object, number_of_user_clauses(NUC)), NUC == 10,
		object_property(test_object, info(Info)),
		member(version(_), Info),
		member(author(_), Info),
		member(date(_), Info),
		member(comment(_), Info).

	% entity interface
	succeeds(object_property_2_8) :-
		object_property(test_object, public(Public)), Public == [a/1],
		object_property(test_object, protected(Protected)), Protected == [b/2],
		object_property(test_object, private(Private)), Private == [c/3, e/5].

	% interface predicate declaration properties
	succeeds(object_property_2_9) :-
		object_property(test_object, declares(a/1, Properties1)),
		member((public), Properties1),
		member(scope(Scope1), Properties1), Scope1 == (public),
		member(static, Properties1),
		(	current_logtalk_flag(coinduction, supported) ->
			member(coinductive(Template), Properties1), Template == a((+))
		;	true
		),
		member(line_count(LC1), Properties1), integer(LC1),
		object_property(test_object, declares(b/2, Properties2)),
		member(protected, Properties2),
		member(scope(Scope2), Properties2), Scope2 == protected,
		member(static, Properties2),
		(	current_logtalk_flag(threads, supported) ->
			member(synchronized, Properties2)
		;	true
		),
		member(line_count(LC2), Properties2), integer(LC2),
		object_property(test_object, declares(c/3, Properties3)),
		member(private, Properties3),
		member(scope(Scope3), Properties3), Scope3 == private,
		member((dynamic), Properties3),
		member(line_count(LC3), Properties3), integer(LC3),
		\+ object_property(test_object, declares(d/4, _Properties4)),
		object_property(test_object, declares(e/5, Properties5)),
		member(private, Properties5),
		member(scope(Scope3), Properties5), Scope3 == private,
		member(static, Properties5),
		member(line_count(LC5), Properties5), integer(LC5).

	% interface predicate definition properties
	succeeds(object_property_2_10) :-
		object_property(test_object, defines(a/1, Properties1)),
		member(line_count(LC1), Properties1), integer(LC1),
		member(number_of_clauses(NC1), Properties1), integer(NC1),
		object_property(test_object, defines(b/2, Properties2)),
		member(line_count(LC2), Properties2), integer(LC2),
		member(number_of_clauses(NC2), Properties2), NC2 == 2,
		object_property(test_object, defines(c/3, Properties3)),
		member(line_count(LC3), Properties3), integer(LC3),
		member(number_of_clauses(NC3), Properties3), NC3 == 3,
		object_property(test_object, defines(d/4, Properties4)),
		member(line_count(LC4), Properties4), integer(LC4),
		member(number_of_clauses(NC4), Properties4), NC4 == 4,
		object_property(test_object, defines(e/5, Properties5)),
		\+ member(line_count(_LC5), Properties5),
		member(number_of_clauses(NC5), Properties5), NC5 == 0.		

	member(H, [H| _]) :-
		!.
	member(H, [_| T]) :-
		member(H, T).

:- end_object.
