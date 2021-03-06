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
		date is 2014/11/07,
		comment is 'Unit tests for the ISO Prolog standard numbers syntax.'
	]).

	% tests from the ISO/IEC 13211-1:1995(E) standard, section 6.3.1

	succeeds(iso_number_01) :-
		^^set_text_input('123. '),
		{read(T)},
		T == 123.

	succeeds(iso_number_02) :-
		^^set_text_input('-123. '),
		{read(T)},
		T == -123.

	succeeds(iso_number_03) :-
		^^set_text_input('123.45. '),
		{read(T)},
		T == 123.45.

	succeeds(iso_number_04) :-
		^^set_text_input('-123.45. '),
		{read(T)},
		T == -123.45.

	% tests from the ISO/IEC 13211-1:1995(E) standard, section 6.4.4

	succeeds(iso_number_05) :-
		^^set_text_input('83. '),
		{read(T)},
		T == 83.

	succeeds(iso_number_06) :-
		^^set_text_input('0\'S. '),
		{read(T)},
		char_code('S', T).

	succeeds(iso_number_07) :-
		^^set_text_input('0b1010011. '),
		{read(T)},
		T == 83.

	succeeds(iso_number_08) :-
		^^set_text_input('0o123. '),
		{read(T)},
		T == 83.

	succeeds(iso_number_09) :-
		^^set_text_input('0x53. '),
		{read(T)},
		T == 83.

	% tests from the ISO/IEC 13211-1:1995(E) standard, section 6.4.5

	succeeds(iso_number_10) :-
		^^set_text_input('123.45. '),
		{read(T)},
		T == 123.45.

	succeeds(iso_number_11) :-
		^^set_text_input('123.45e+1. '),
		{read(T)},
		T == 1234.5.

	succeeds(iso_number_12) :-
		^^set_text_input('123.45E+1. '),
		{read(T)},
		T == 1234.5.

	succeeds(iso_number_13) :-
		^^set_text_input('123.45e-1. '),
		{read(T)},
		T == 12.345.

	succeeds(iso_number_14) :-
		^^set_text_input('123.45E-1. '),
		{read(T)},
		T == 12.345.

	cleanup :-
		^^clean_text_input.

:- end_object.
