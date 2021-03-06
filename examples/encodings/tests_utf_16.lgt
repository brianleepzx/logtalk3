:- encoding('UTF-16').		% this directive, when present, must be the first
							% term, in the first line, of a source file

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  This file is part of Logtalk <http://logtalk.org/>
%  
%  Logtalk is free software. You can redistribute it and/or modify it under
%  the terms of the FSF GNU General Public License 3  (plus some additional
%  terms per section 7).        Consult the `LICENSE.txt` file for details.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- object(tests_utf_16,
	extends(lgtunit)).

	:- info([
		version is 1.1,
		author is 'Parker Jones and Paulo Moura',
		date is 2012/08/06,
		comment is 'Unit tests for the "encodings" example.'
	]).

	cover(asian).

	test(encodings_utf_16_1) :-
		findall(Name-Capital-Country, asian::country(Country, Name, Capital), Solutions),
		Solutions == ['中国'-'北京'-china, '日本'-'東京'-japan, 'Монгол Улс'-'Улаанбатаар'-mongolia, '臺灣'-'臺北'-taiwan, 'Тоҷикистон'-'Душанбе'-tajikistan].

:- end_object.
