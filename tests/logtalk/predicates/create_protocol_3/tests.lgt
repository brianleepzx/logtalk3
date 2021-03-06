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
		version is 1.1,
		author is 'Paulo Moura',
		date is 2014/11/14,
		comment is 'Unit tests for the create_protocol/3 built-in predicate.'
	]).

	throws(create_protocol_1_1, error(instantiation_error, logtalk(create_protocol(_, _, _), _))) :-
		create_protocol(_, _, _).

	throws(create_protocol_1_2, error(type_error(protocol_identifier, 1), logtalk(create_protocol(1, [], []), _))) :-
		create_protocol(1, [], []).

	throws(create_protocol_1_3, error(permission_error(modify, protocol, monitoring), logtalk(create_protocol(monitoring, [], []), _))) :-
		create_protocol(monitoring, [], []).

	throws(create_protocol_1_4, error(permission_error(modify, object, logtalk), logtalk(create_protocol(logtalk, [], []), _))) :-
		create_protocol(logtalk, [], []).

	throws(create_protocol_1_5, error(type_error(list, atom), logtalk(create_protocol(_, atom, []), _))) :-
		create_protocol(_, atom, []).

	throws(create_protocol_1_6, error(type_error(list, atom), logtalk(create_protocol(_, [], atom), _))) :-
		create_protocol(_, [], atom).

	throws(create_category_1_7, error(_, logtalk(create_protocol(_, [], [dynamic(foo/1), synchronized(foo/1)]), _))) :-
		create_protocol(_, [], [dynamic(foo/1), synchronized(foo/1)]).

	throws(create_category_1_8, error(_, logtalk(create_protocol(_, [], [synchronized(foo/1), dynamic(foo/1)]), _))) :-
		create_protocol(_, [], [synchronized(foo/1), dynamic(foo/1)]).

:- end_object.
