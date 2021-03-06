%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  This file is part of Logtalk <http://logtalk.org/>
%  
%  Logtalk is free software. You can redistribute it and/or modify it under
%  the terms of the FSF GNU General Public License 3  (plus some additional
%  terms per section 7).        Consult the `LICENSE.txt` file for details.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- object(ack).

	:- info([
		version is 1.0,
		author is 'Paulo Moura',
		date is 2008/3/31,
		comment is 'Ackermann function (general recursive function).'
	]).

	:- public(ack/3).
	:- mode(ack(+integer, +integer, -integer), one).
	:- info(ack/3, [
		comment is 'Ackermann function.',
		argnames is ['M', 'N', 'V']
	]).

	ack(0, N, V) :-
		!,
		V is N + 1.
	ack(M, 0, V) :-
		!,
		M2 is M - 1,
		ack(M2, 1, V).
	ack(M, N, V) :-
		M2 is M - 1,
		N2 is N - 1,
		ack(M, N2, V2),
		ack(M2, V2, V).

:- end_object.
