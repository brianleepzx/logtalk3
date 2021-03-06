%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This file is part of Logtalk <http://logtalk.org/>  
%  Copyright (c) 1998-2015 Paulo Moura <pmoura@logtalk.org>
%
%  This program is free software: you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published by
%  the Free Software Foundation, either version 3 of the License, or
%  (at your option) any later version.
%  
%  This program is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
%  
%  You should have received a copy of the GNU General Public License
%  along with this program.  If not, see <http://www.gnu.org/licenses/>.
%  
%  Additional licensing terms apply per Section 7 of the GNU General
%  Public License 3. Consult the `LICENSE.txt` file for details.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



:- object(term,
	implements(termp)).

	:- info([
		version is 1.7,
		author is 'Paulo Moura',
		date is 2014/04/28,
		comment is 'Prolog term utility predicates.'
	]).

	:- alias(termp, [variables/2 as vars/2]).

	depth(Term, Depth) :-
		depth(Term, 0, 0, Depth).

	depth(Var, Acc, MaxSoFar, Depth) :-
		var(Var),
		!,
		(	Acc > MaxSoFar ->
			Depth = Acc
		;	Depth = MaxSoFar
		).
	depth(Atomic, Acc, MaxSoFar, Depth) :-
		atomic(Atomic),
		!,
		(	Acc > MaxSoFar ->
			Depth = Acc
		;	Depth = MaxSoFar
		).
	depth([Arg| Args], Acc, MaxSoFar, Depth) :-
		!,
		depth(Arg, Acc, MaxSoFar, ArgDepth),
		depth(Args, Acc, ArgDepth, Depth).
	depth(Term, Acc, MaxSoFar, Depth) :-
		Acc2 is Acc + 1,
		Term =.. [_| Args],
		depth(Args, Acc2, MaxSoFar, Depth).

	ground(Term) :-
		{ground(Term)}.

	occurs(Var, Term) :-
		(	var(Term) ->
			Var == Term
		;	functor(Term, _, Arity),
			occurs(Arity, Var, Term)
		).

	occurs(N, Var, Term) :-
		compound(Term),
		arg(N, Term, Arg),
		occurs(Var, Arg),
		!.
	occurs(N, Var, Term) :-
		N > 1,
		N2 is N - 1,
		occurs(N2, Var, Term).

	subsumes(General, Specific) :-
		{subsumes_term(General, Specific)}.

	var_member_chk(Var, [Head| Tail]) :-
		(	Var == Head ->
			true
		;	var_member_chk(Var, Tail)
		).

	subterm(Term, Term).
	subterm(Sub, Term) :-
		nonvar(Term),
		functor(Term, _, N),
		subterm(N, Sub, Term).

	subterm(N, Sub, Term) :-
		compound(Term),
		arg(N, Term, Arg),
		subterm(Sub, Arg).
	subterm(N, Sub, Term) :-
		N > 1,
		M is N-1,
		subterm(M, Sub, Term).

	valid(_).

	check(_).

	variant(Term1, Term2) :-
		\+ \+ {subsumes_term(Term1, Term2)},
		\+ \+ {subsumes_term(Term2, Term1)}.

	vars(Term, Vars) :-			% deprecated
		{term_variables(Term, Vars)}.

	variables(Term, Vars) :-
		{term_variables(Term, Vars)}.

	singletons(Term, Singletons) :-
		term_to_vars(Term, [], Vars),
		vars_to_singletons(Vars, [], [], Singletons).

	term_to_vars(Term, Acc, Vars) :-
		(	var(Term) ->
			Vars = [Term| Acc]
		;	Term =.. [_| Args],
			term_to_vars_list(Args, Acc, Vars)
		).

	term_to_vars_list([], Vars, Vars).
	term_to_vars_list([Term| Terms], Acc, Vars) :-
		term_to_vars(Term, Acc, Acc2),
		term_to_vars_list(Terms, Acc2, Vars).

	vars_to_singletons([], _, Singletons, Singletons).
	vars_to_singletons([Var| Vars], Repeated, Acc, Singletons) :-
		(	var_member_chk(Var, Repeated) ->
			Repeated2 = Repeated,
			Acc2 = Acc
		;	var_member_chk(Var, Vars) ->
			Repeated2 = [Var| Repeated],
			Acc2 = Acc
		;	Repeated = Repeated2,
			Acc2 = [Var| Acc]
		),
		vars_to_singletons(Vars, Repeated2, Acc2, Singletons).

:- end_object.
