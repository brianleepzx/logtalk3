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
		date is 2014/11/06,
		comment is 'Unit tests for the ISO Prolog standard set_input/1 built-in predicate.'
	]).

	% tests from the ISO/IEC 13211-1:1995(E) standard, section 8.11.3

	% tests from the Prolog ISO conformance testing framework written by Péter Szabó and Péter Szeredi

	succeeds(sics_set_input_1_1) :-
		{current_input(S),
		 set_input(S)}.

	throws(sics_set_input_1_2, error(instantiation_error,_)) :-
		{set_input(_S)}.

	:- if(current_logtalk_flag(prolog_conformance, iso_strict)).
		throws(sics_set_input_1_3, error(domain_error(stream_or_alias,foo),_)) :-
			{set_input(foo)}.
	:- else.
		throws(sics_set_input_1_3, [error(domain_error(stream_or_alias,foo),_), error(existence_error(stream,foo),_)]) :-
			% the second exception term is a common but not conforming alternative
			{set_input(foo)}.
	:- endif.

	throws(sics_set_input_1_4, error(existence_error(stream,S),_)) :-
		^^closed_input_stream(S, []),
		{set_input(S)}.

	throws(sics_set_input_1_5, error(permission_error(input,stream,S),_)) :-
		{current_output(S),
		 set_input(S)}.		

:- end_object.
