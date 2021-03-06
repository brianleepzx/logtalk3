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


:- category(core_messages).

	:- info([
		version is 1.2,
		author is 'Paulo Moura',
		date is 2015/02/09,
		comment is 'Logtalk core (compiler and runtime) default message translations.'
	]).

	:- built_in.

	:- multifile(logtalk::message_prefix_stream/4).
	:- dynamic(logtalk::message_prefix_stream/4).

	% Quintus Prolog based prefixes (also used in SICStus Prolog):
	logtalk::message_prefix_stream(banner, core, '', user_output).
	logtalk::message_prefix_stream(help, _, '', user_output).
	logtalk::message_prefix_stream(information, core, '', user_output).
	logtalk::message_prefix_stream(information(_), core, '', user_output).
	logtalk::message_prefix_stream(comment, core, '% ', user_output).
	logtalk::message_prefix_stream(comment(_), core, '% ', user_output).
	logtalk::message_prefix_stream(warning, core, '*     ', user_error).
	logtalk::message_prefix_stream(warning(_), core, '*     ', user_error).
	logtalk::message_prefix_stream(error, core, '!     ', user_error).
	logtalk::message_prefix_stream(error(_), core, '!     ', user_error).

	:- multifile(logtalk::message_tokens//2).
	:- dynamic(logtalk::message_tokens//2).

	% file compilation and loading messages

	logtalk::message_tokens(loading_file(File, _Flags), core) -->
		['[ loading ~w ...  ]'-[File], nl].

	logtalk::message_tokens(loaded_file(File, _Flags), core) -->
		['[ ~w loaded ]'-[File], nl].

	logtalk::message_tokens(skipping_reloading_file(File, _Flags), core) -->
		['[ ~w already loaded; skipping ]'-[File], nl].

	logtalk::message_tokens(reloading_file(File, _Flags), core) -->
		['[ reloading ~w ... ]'-[File], nl].

	logtalk::message_tokens(reloaded_file(File, _Flags), core) -->
		['[ ~w reloaded ]'-[File], nl].

	logtalk::message_tokens(compiling_file(File, _Flags), core) -->
		['[ compiling ~w'-[File]],
		(	{current_logtalk_flag(debug, on)} ->
			(	{current_logtalk_flag(hook, Hook)} ->
				[' in debug mode using the hook object ~q ... ]'-[Hook], nl]
			;	[' in debug mode ... ]'-[], nl]
			)
		;	(	{current_logtalk_flag(hook, Hook)} ->
				[' using the hook object ~q ... ]'-[Hook], nl]
			;	[' ... ]'-[], nl]
			)
		).

	logtalk::message_tokens(compiled_file(File, _Flags), core) -->
		['[ ~w compiled ]'-[File], nl].

	logtalk::message_tokens(up_to_date_file(File, _Flags), core) -->
		['[ compiling ~w ... up-to-date ]'-[File], nl].

	% entity compilation messages

	logtalk::message_tokens(compiling_entity(Type, Entity), core) -->
		{ground_term_copy(Entity, GroundEntity)},
		(	{current_logtalk_flag(debug, on)} ->
			['- compiling ~w ~q in debug mode ... '-[Type, GroundEntity], nl]
		;	['- compiling ~w ~q ... '-[Type, GroundEntity], nl]
		).
	logtalk::message_tokens(compiled_entity(_Type, _Entity), core) -->
		['compiled'-[], nl].

	logtalk::message_tokens(redefining_entity(Type, Entity), core) -->
		{ground_term_copy(Entity, GroundEntity)},
		['Redefining ~w ~q'-[Type, GroundEntity], nl].

	logtalk::message_tokens(redefining_entity_from_file(File, Lines, Type, Entity, OldFile), core) -->
		{ground_term_copy(Entity, GroundEntity)},
		['Redefining ~w ~q (loaded from file ~w)'-[Type, GroundEntity, OldFile], nl],
		message_context(File, Lines).

	% make messages

	logtalk::message_tokens(no_make_target_specified, core) -->
		['No make target specified'-[], nl].

	logtalk::message_tokens(invalid_make_target(Target), core) -->
		['Invalid make target: ~w'-[Target], nl].

	logtalk::message_tokens(modified_files_reloaded, core) -->
		['Reloaded all modified Logtalk source files'-[], nl].

	logtalk::message_tokens(intermediate_files_deleted, core) -->
		['Deleted all intermediate files for the loaded Logtalk source files'-[], nl].

	% startup messages

	logtalk::message_tokens(possibly_incompatible_prolog_version(Current, Compatible), core) -->
		['Possibly incompatible backend Prolog compiler version detected!'-[], nl,
		 'Running Prolog compiler version: ~w'-[Current], nl,
		 'Advised Prolog compiler version: ~w'-[Compatible], nl
		].

	logtalk::message_tokens(banner, core) -->
		{current_logtalk_flag(version_data, logtalk(Major, Minor, Patch, Status))},
		(	{Status == stable} ->
			[nl, 'Logtalk ~d.~d.~d'-[Major, Minor, Patch], nl, 'Copyright (c) 1998-2015 Paulo Moura'-[], nl, nl]
		;	[nl, 'Logtalk ~d.~d.~d-~w'-[Major, Minor, Patch, Status], nl, 'Copyright (c) 1998-2015 Paulo Moura'-[], nl, nl]
		).

	logtalk::message_tokens(default_flags, core) -->
		{current_logtalk_flag(unknown_entities, UnknownEntities),
		 current_logtalk_flag(unknown_predicates, UnknownPredicates),
		 current_logtalk_flag(undefined_predicates, UndefinedPredicates),
		 current_logtalk_flag(portability, Portability),
		 current_logtalk_flag(redefined_built_ins, Redefined),
		 current_logtalk_flag(missing_directives, Missing),
		 current_logtalk_flag(singleton_variables, Singletons),
		 current_logtalk_flag(underscore_variables, Underscore),
		 current_logtalk_flag(complements, Complements),
		 current_logtalk_flag(dynamic_declarations, DynamicDeclarations),
		 current_logtalk_flag(context_switching_calls, ContextCalls),
		 current_logtalk_flag(events, Events),
		 current_logtalk_flag(report, Report),
		 current_logtalk_flag(scratch_directory, ScratchDirectory),
		 current_logtalk_flag(code_prefix, Code),
		 (current_logtalk_flag(hook, Hook) -> true; Hook = '(none defined)'),
		 current_logtalk_flag(optimize, Optimize),
		 current_logtalk_flag(source_data, SourceData),
		 current_logtalk_flag(clean, Clean),
		 current_logtalk_flag(debug, Debug),
		 current_logtalk_flag(reload, Reload),
		 current_logtalk_flag(prolog_compiler, PrologCompiler),
		 current_logtalk_flag(prolog_loader, PrologLoader),
		 current_logtalk_flag(prolog_dialect, PrologDialect),
		 current_logtalk_flag(modules, Modules),
		 current_logtalk_flag(threads, Threads),
		 current_logtalk_flag(encoding_directive, Encodings),
		 current_logtalk_flag(tabling, Tabling),
		 current_logtalk_flag(coinduction, Coinduction)},
		[
			'Default lint compilation flags: '-[], nl,
			'  unknown_predicates: ~w, undefined_predicates: ~w'-[UnknownPredicates, UndefinedPredicates], nl,
			'  portability: ~w, unknown_entities: ~w'-[Portability, UnknownEntities], nl,
			'  missing_directives: ~w, redefined_built_ins: ~w'-[Missing, Redefined], nl,
			'  singleton_variables: ~w, underscore_variables: ~w'-[Singletons, Underscore], nl,
			'Default optional features compiler flags:'-[], nl,
			'  complements: ~w, dynamic_declarations: ~w'-[Complements, DynamicDeclarations], nl,
			'  context_switching_calls: ~w, events: ~w'-[ContextCalls, Events], nl,
			'Other default compilation flags:'-[], nl,
			'  report: ~w, scratch_directory: ~w'-[Report, ScratchDirectory], nl,
			'  code_prefix: ~q, hook: ~w'-[Code, Hook], nl,
			'  optimize: ~w, source_data: ~w, clean: ~w'-[Optimize, SourceData, Clean], nl,
			'  debug: ~w, reload: ~w'-[Debug, Reload], nl,
			'Backend Prolog compiler flags:'-[], nl,
			'  prolog_compiler: ~w'-[PrologCompiler], nl,
			'  prolog_loader:   ~w'-[PrologLoader], nl,
			'Read-only compilation flags (backend Prolog compiler features):'-[], nl,
			'  prolog_dialect: ~w, modules: ~w, threads: ~w'-[PrologDialect, Modules, Threads], nl,
			'  encoding_directive: ~w, tabling: ~w, coinduction: ~w'-[Encodings, Tabling, Coinduction], nl, nl
		].

	% settings files messages

	logtalk::message_tokens(loaded_settings_file(Path), core) -->
		['Loaded settings file found on directory ~w'-[Path], nl, nl].
	logtalk::message_tokens(settings_file_disabled, core) -->
		['Loading of settings file disabled in the backend Prolog compiler adapter file.'-[], nl, nl].
	logtalk::message_tokens(error_loading_settings_file(Path, Error), core) -->
		['Errors found while loading settings file from directory ~w: ~w'-[Path, Error], nl, nl].
	logtalk::message_tokens(no_settings_file_found(allow), core) -->
		['No settings file found in the startup or Logtalk user directories.'-[], nl,
		 'Using default flag values set in the backend Prolog compiler adapter file.'-[], nl, nl
		].
	logtalk::message_tokens(no_settings_file_found(restrict), core) -->
		['No settings file found in the Logtalk user directory.'-[], nl,
		 'Using default flag values set in the backend Prolog compiler adapter file.'-[], nl, nl
		].

	% debugging messages

	logtalk::message_tokens(logtalk_debugger_aborted, core) -->
		['Debugging session aborted by user. Debugger still on.'-[], nl].

	logtalk::message_tokens(debug_handler_provider_already_exists(File, Lines, Type, Entity, Provider), core) -->
		['A definition for the debug handler predicate already exists in: ~q'-[Provider], nl],
		message_context(File, Lines, Type, Entity).

	% compiler error and warning messages

	logtalk::message_tokens(loading_failure(File), core) -->
		['Unexpected failure while loading the code generated for the file:'-[], nl,
		 '  ~w'-[File], nl,
		 'Likely bug in the backend Prolog compiler. Please file a bug report.'-[], nl
		].

	logtalk::message_tokens(loading_error(File, Error), core) -->
		['Unexpected error while loading the code generated for the file:'-[], nl,
		 '  ~w'-[File], nl,
		 '  '-[]
		],
		error_term_tokens(Error),
		['Likely bug in the backend Prolog compiler. Please file a bug report.'-[], nl
		].

	logtalk::message_tokens(compiler_error(File, Lines, Error), core) -->
		error_term_tokens(Error),
		message_context(File, Lines).

	logtalk::message_tokens(compiler_stream_error(Error), core) -->
		error_term_tokens(Error).

	logtalk::message_tokens(term_expansion_error(File, Lines, Type, Entity, HookEntity, Term, Error), core) -->
		['Error found when term-expanding ~w using hook entity ~w: '-[Term, HookEntity]],
		error_term_tokens(Error),
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(term_expansion_error(File, Lines, HookEntity, Term, Error), core) -->
		['Error found when term-expanding ~w using hook entity ~w: '-[Term, HookEntity]],
		error_term_tokens(Error),
		message_context(File, Lines).

	logtalk::message_tokens(goal_expansion_error(File, Lines, Type, Entity, HookEntity, Goal, Error), core) -->
		['Error found when goal-expanding ~w using hook entity ~w: '-[Goal, HookEntity]],
		error_term_tokens(Error),
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(goal_expansion_error(File, Lines, HookEntity, Goal, Error), core) -->
		['Error found when goal-expanding ~w using hook entity ~w: '-[Goal, HookEntity]],
		error_term_tokens(Error),
		message_context(File, Lines).

	logtalk::message_tokens(redefined_logtalk_built_in_predicate(File, Lines, Type, Entity, Predicate), core) -->
		['Redefining a Logtalk built-in predicate: ~q'-[Predicate], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(redefined_prolog_built_in_predicate(File, Lines, Type, Entity, Predicate), core) -->
		['Redefining a Prolog built-in predicate: ~q'-[Predicate], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(reference_to_unknown_object(File, Lines, Type, Entity, Object), core) -->
		['Reference to unknown object: ~q'-[Object], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(reference_to_unknown_protocol(File, Lines, Type, Entity, Protocol), core) -->
		['Reference to unknown protocol: ~q'-[Protocol], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(reference_to_unknown_category(File, Lines, Type, Entity, Category), core) -->
		['Reference to unknown category: ~q'-[Category], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(reference_to_unknown_module(File, Lines, Type, Entity, Module), core) -->
		['Reference to unknown module: ~q'-[Module], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(missing_predicate_directive(File, Lines, Type, Entity, Directive, Predicate), core) -->
		['Missing ~w directive for the predicate: ~q'-[Directive, Predicate], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(non_standard_predicate_call(File, Lines, Type, Entity, Predicate), core) -->
		['Call to non-standard Prolog built-in predicate: ~q'-[Predicate], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(non_standard_arithmetic_function_call(File, Lines, Type, Entity, Function), core) -->
		['Call to non-standard Prolog built-in arithmetic function: ~q'-[Function], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(non_standard_prolog_flag(File, Lines, Type, Entity, Flag), core) -->
		['Use of non-standard Prolog flag: ~q'-[Flag], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(non_standard_prolog_flag(File, Lines, Flag), core) -->
		['Use of non-standard Prolog flag: ~q'-[Flag], nl],
		message_context(File, Lines).

	logtalk::message_tokens(non_standard_prolog_flag_value(File, Lines, Type, Entity, Flag, Value), core) -->
		['Use of non-standard Prolog flag value: ~q:~q'-[Flag, Value], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(non_standard_prolog_flag_value(File, Lines, Flag, Value), core) -->
		['Use of non-standard Prolog flag: ~q:~q'-[Flag, Value], nl],
		message_context(File, Lines).

	logtalk::message_tokens(non_standard_file_directive(File, Lines, Directive), core) -->
		['Use of non-standard file directive: ~q'-[Directive], nl],
		message_context(File, Lines).

	logtalk::message_tokens(unclassified_variables_in_lambda_expression(File, Lines, Type, Entity, UnqualifiedVars, LambdaExpression), core) -->
		{ground_term_copy(UnqualifiedVars-LambdaExpression, UnqualifiedVarsCopy-LambdaExpressionCopy)},
		(	{UnqualifiedVarsCopy = [UnqualifiedVarCopy]} ->
			['Unclassified variable ~q in lambda expression: ~q'-[UnqualifiedVarCopy, LambdaExpressionCopy], nl]
		;	['Unclassified variables ~q in lambda expression: ~q'-[UnqualifiedVarsCopy, LambdaExpressionCopy], nl]
		),
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(variables_with_dual_role_in_lambda_expression(File, Lines, Type, Entity, MixedUpVars, LambdaExpression), core) -->
		{ground_term_copy(MixedUpVars-LambdaExpression, MixedUpVarsCopy-LambdaExpressionCopy)},
		(	{MixedUpVarsCopy = [MixedUpVarCopy]} ->
			['Variable ~q have dual role in lambda expression: ~q'-[MixedUpVarCopy, LambdaExpressionCopy], nl]
		;	['Variables ~q have dual role in lambda expression: ~q'-[MixedUpVarsCopy, LambdaExpressionCopy], nl]
		),
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(complementing_category_ignored(File, Lines, Category, Object), core) -->
		['Complementing category will be ignored: ~q'-[Category], nl,
		 'Complemented object, ~q, compiled with complementing categories support turned off'-[Object], nl],
		message_context(File, Lines).

	logtalk::message_tokens(prolog_dialect_goal_expansion(File, Lines, Type, Entity, Goal, ExpandedGoal), core) -->
		['Prolog dialect rewrite of goal ~q as ~q'-[Goal, ExpandedGoal], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(prolog_dialect_goal_expansion(File, Lines, Goal, ExpandedGoal), core) -->
		['Prolog dialect rewrite of goal ~q as ~q'-[Goal, ExpandedGoal], nl],
		message_context(File, Lines).

	logtalk::message_tokens(prolog_dialect_term_expansion(File, Lines, Type, Entity, Term, ExpandedTerms), core) -->
		['Prolog dialect rewrite of term ~q as ~q'-[Term, ExpandedTerms], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(prolog_dialect_term_expansion(File, Lines, Term, ExpandedTerms), core) -->
		['Prolog dialect rewrite of term ~q as ~q'-[Term, ExpandedTerms], nl],
		message_context(File, Lines).

	logtalk::message_tokens(declared_static_predicate_called_but_not_defined(File, Lines, Type, Entity, Predicate), core) -->
		['Declared static predicate called but not defined: ~q'-[Predicate], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(declared_static_non_terminal_called_but_not_defined(File, Lines, Type, Entity, NonTerminal), core) -->
		['Declared static non terminal called but not defined: ~q'-[NonTerminal], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(unknown_predicate_called_but_not_defined(File, Lines, Type, Entity, Predicate), core) -->
		['Unknown predicate called but not defined: ~q'-[Predicate], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(unknown_non_terminal_called_but_not_defined(File, Lines, Type, Entity, NonTerminal), core) -->
		['Unknown non-terminal called but not defined: ~q'-[NonTerminal], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(missing_reference_to_built_in_protocol(File, Type, Entity, Protocol), core) -->
		['Missing reference to the built-in protocol: ~q'-[Protocol], nl],
		message_context(File, Type, Entity).

	logtalk::message_tokens(compiling_proprietary_prolog_directive(File, Lines, Type, Entity, Directive), core) -->
		['Compiling proprietary Prolog directive: ~q'-[Directive], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(compiling_query_as_initialization_goal(File, Lines, Type, Entity, Directive), core) -->
		['Compiling query as an initialization goal: ~q'-[Directive], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(singleton_variables(File, Lines, Type, Entity, Names, Term), core) -->
		(	{Names = [Name]} ->
			['Singleton variable: ~w'-[Name], nl]
		;	['Singleton variables: ~w'-[Names], nl]
		),
		term_type_tokens(Term),
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(singleton_variables(File, Lines, Names, Term), core) -->
		(	{Names = [Name]} ->
			['Singleton variable: ~w'-[Name], nl]
		;	['Singleton variables: ~w'-[Names], nl]
		),
		term_type_tokens(Term),
		message_context(File, Lines).

	logtalk::message_tokens(compilation_and_loading_warnings(CCounter, LCounter), core) -->
		(	{CCounter + LCounter =:= 0} ->
			% no warnings
			['(0 warnings)'-[], nl]
		;	{CCounter =:= 0} ->
			% no compilation warnings
			loading_warnings(LCounter), [nl]
		;	{LCounter =:= 0} ->
			% no loading warnings
			compilation_warnings(CCounter), [nl]
		;	% both compilation and loading warnings
			loading_warnings(LCounter), [' and '-[]], compilation_warnings(CCounter), [nl]
		).

	logtalk::message_tokens(renamed_compiler_flag(File, Lines, Type, Entity, Flag, NewFlag), core) -->
		['The compiler flag ~w have been renamed to ~w'-[Flag, NewFlag], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(renamed_compiler_flag(File, Lines, Flag, NewFlag), core) -->
		['The compiler flag ~w have been renamed to ~w'-[Flag, NewFlag], nl],
		message_context(File, Lines).

	logtalk::message_tokens(deprecated_control_construct(File, Lines, Type, Entity, Term), core) -->
		['The ~w control construct is deprecated'-[Term], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(deprecated_directive(File, Lines, Type, Entity, Directive), core) -->
		['The ~w directive is deprecated'-[Directive], nl],
		message_context(File, Lines, Type, Entity).

	logtalk::message_tokens(ignored_directive(File, Lines, Directive), core) -->
		['The ~w directive is ignored'-[Directive], nl],
		message_context(File, Lines).

	logtalk::message_tokens(misplaced_encoding_directive(File, Lines), core) -->
		['The encoding/1 directive is misplaced'-[], nl],
		message_context(File, Lines).

	% auxiliary grammar rules

	loading_warnings(LCounter) -->
		(	{LCounter =:= 1} ->
			['~d loading warning'-[LCounter]]
		;	['~d loading warnings'-[LCounter]]
		).

	compilation_warnings(CCounter) -->
		(	{CCounter =:= 1} ->
			['~d compilation warning'-[CCounter]]
		;	['~d compilation warnings'-[CCounter]]
		).

	error_term_tokens(error(Error, Term)) -->
		error_tokens(Error),
		term_tokens(Term).
	error_term_tokens(Error) -->
		error_tokens(Error).

	% based on the ISO Prolog Core standard
	error_tokens(instantiation_error) -->
		['Instantiation error'-[], nl].
	error_tokens(type_error(ValidType, Culprit)) -->
		['Type error: expected ~q but got ~q'-[ValidType, Culprit], nl].
	error_tokens(domain_error(ValidDomain, Culprit)) -->
		['Domain error: value ~q is not in domain ~q'-[Culprit, ValidDomain], nl].
	error_tokens(permission_error(Operation, PermissionType, Culprit)) -->
		['Permission error: ~q ~q ~q'-[Operation, PermissionType, Culprit], nl].
	error_tokens(existence_error(ObjectType, Culprit)) -->
		['Existence error: ~q ~q does not exist'-[ObjectType, Culprit], nl].
	error_tokens(representation_error(Flag)) -->
		['Representation error: ~q'-[Flag], nl].
	error_tokens(evaluation_error(Error)) -->
		['Evaluation error: ~q'-[Error], nl].
	error_tokens(resource_error(Resource)) -->
		['Resource error: ~q'-[Resource], nl].
	error_tokens(syntax_error(Error)) -->
		['Syntax error: ~w'-[Error], nl].
	error_tokens(system_error) -->
		['System error'-[], nl].
	% catchall clause
	error_tokens(Error) -->
		['~q'-[Error], nl].

	term_tokens(entity(Type, Entity)) -->
		['  in ~w ~q'-[Type, Entity], nl].
	term_tokens(directive(Directive)) -->
		['  in directive :- ~q'-[Directive], nl].
	term_tokens(clause(Clause)) -->
		['  in clause ~q'-[Clause], nl].
	term_tokens(grammar_rule(Rule)) -->
		['  in grammar rule ~q'-[Rule], nl].
	term_tokens(term(Term)) -->
		['  in term ~q'-[Term], nl].
	term_tokens(Term) -->
		['  in ~q'-[Term], nl].

	term_type_tokens((:- Term)) -->
		(	{var(Term)} ->
			[]
		;	['  in directive '-[]], predicate_indicator_tokens(Term), [nl]
		).
	term_type_tokens((Term :- _)) -->
		(	{var(Term)} ->
			[]
		;	['  in clause for predicate '-[]], predicate_indicator_tokens(Term), [nl]
		).
	term_type_tokens((Term, _ --> _)) -->
		(	{var(Term)} ->
			[]
		;	['  in grammar rule for non-terminal '-[]], non_terminal_indicator_tokens(Term), [nl]
		).
	term_type_tokens((Term --> _)) -->
		(	{var(Term)} ->
			[]
		;	['  in grammar rule for non-terminal '-[]], non_terminal_indicator_tokens(Term), [nl]
		).
	term_type_tokens(Term) -->		% facts
		(	{var(Term)} ->
			[]
		;	['  in clause for predicate '-[]], predicate_indicator_tokens(Term), [nl]
		).

	predicate_indicator_tokens(Entity::Term) -->
		(	{var(Term)} ->
			['~q'-[Entity::Term]]
		;	{functor(Term, Functor, Arity)},
			['~q'-[Entity::Functor/Arity]]
		).
	predicate_indicator_tokens(Term) -->
		{functor(Term, Functor, Arity)},
		['~q'-[Functor/Arity]].

	non_terminal_indicator_tokens(Entity::Term) -->
		(	{var(Term)} ->
			['~q'-[Entity::Term]]
		;	{functor(Term, Functor, Arity)},
			['~q'-[Entity::Functor//Arity]]
		).
	non_terminal_indicator_tokens(Term) -->
		{functor(Term, Functor, Arity)},
		['~q'-[Functor//Arity]].

	message_context(File, Type, Entity) -->
		{ground_term_copy(Entity, GroundEntity)},
		['  in file ~w'-[File], nl, '  while compiling ~w ~q'-[Type, GroundEntity], nl].

	message_context(File, Lines, Type, Entity) -->
		{ground_term_copy(Entity, GroundEntity)},
		(	{Lines = Line-Line} ->
			['  in file ~w above line ~d'-[File, Line], nl, '  while compiling ~w ~q'-[Type, GroundEntity], nl]
		;	['  in file ~w between lines ~w'-[File, Lines], nl, '  while compiling ~w ~q'-[Type, GroundEntity], nl]
		).

	message_context(File, Lines) -->
		(	{Lines = Line-Line} ->
			['  in file ~w above line ~d'-[File, Line], nl]
		;	['  in file ~w between lines ~w'-[File, Lines], nl]
		).

	message_context(File) -->
		['  in file ~w'-[File], nl].

	ground_term_copy(Term, GroundTerm) :-
		copy_term(Term, GroundTerm),
		numbervars(GroundTerm, 0, _).

:- end_category.
