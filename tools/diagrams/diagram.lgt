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


:- category(diagram(_Format)).

	:- info([
		version is 2.0,
		author is 'Paulo Moura',
		date is 2014/12/30,
		comment is 'Common predicates for generating diagrams.',
		parnames is ['Format']
	]).

	:- uses(list, [append/3, member/2, memberchk/2]).
	:- uses(pairs, [keys/2]).

	:- public(libraries/3).
	:- mode(libraries(+atom, +list(atom), +list(compound)), one).
	:- info(libraries/3, [
		comment is 'Creates a diagram for a set of libraries using the specified options.',
		argnames is ['Project', 'Libraries', 'Options']
	]).

	libraries(Project, Libraries, UserOptions) :-
		format_object(Format),
		merge_options(UserOptions, Options),
		::reset,
		::output_file_path(Project, Options, Format, OutputPath),
		open(OutputPath, write, Stream, [alias(output_file)]),
		Format::file_header(output_file, Project, Options),
		atom_concat(libraries_, Project, Identifier),
		Format::graph_header(output_file, Identifier, Project, libraries, [tooltip(Project)| Options]),
		output_libraries(Libraries, Format, Options),
		output_externals(Options),
		::output_edges(Options),
		Format::graph_footer(output_file, Identifier, Project, libraries, [tooltip(Project)| Options]),
		Format::file_footer(output_file, Project, Options),
		close(Stream).

	output_libraries([], _Format, _Options).
	output_libraries([Library| Libraries], Format, Options) :-
		logtalk_library_path(Library, _),
		logtalk::expand_library_path(Library, Directory),
		atom_concat(library_, Library, Identifier),
		add_link_options(Directory, Options, GraphOptions),
		Format::graph_header(output_file, Identifier, Library, library, GraphOptions),
		::output_library(Library, Directory, GraphOptions),
		Format::graph_footer(output_file, Identifier, Library, library, GraphOptions),
		output_libraries(Libraries, Format, Options).

	:- public(libraries/2).
	:- mode(libraries(+atom, +list(atom)), one).
	:- info(libraries/2, [
		comment is 'Creates a diagram for a set of libraries using the default options.',
		argnames is ['Project', 'Libraries']
	]).

	libraries(Project, Libraries) :-
		::libraries(Project, Libraries, []).

	:- public(all_libraries/1).
	:- mode(all_libraries(+list(compound)), one).
	:- info(all_libraries/1, [
		comment is 'Creates a diagram for all loaded libraries using the specified options.',
		argnames is ['Options']
	]).

	all_libraries(UserOptions) :-
		format_object(Format),
		merge_options(UserOptions, Options),
		::output_file_path(all_libraries, Options, Format, OutputPath),
		open(OutputPath, write, Stream, [alias(output_file)]),
		Format::file_header(output_file, libraries, Options),
		output_all_libraries(Options),
		::output_edges(Options),
		Format::file_footer(output_file, libraries, Options),
		close(Stream).

	output_all_libraries(Options) :-
		format_object(Format),
		memberchk(exclude_libraries(ExcludedLibraries), Options),
		logtalk_library_path(Library, _),
		\+ memberchk(Library, ExcludedLibraries),
		logtalk::expand_library_path(Library, Directory),
		\+ \+ logtalk::loaded_file_property(_, directory(Directory)),
		atom_concat(library_, Library, Identifier),
		add_link_options(Directory, Options, GraphOptions),
		Format::graph_header(output_file, Identifier, Library, library, GraphOptions),
		::output_library(Library, Directory, GraphOptions),
		Format::graph_footer(output_file, Identifier, Library, library, GraphOptions),
		fail.
	output_all_libraries(_).

	:- public(all_libraries/0).
	:- mode(all_libraries, one).
	:- info(all_libraries/0, [
		comment is 'Creates a diagram for all loaded libraries using default options.'
	]).

	all_libraries :-
		::all_libraries([]).

	:- public(rlibrary/2).
	:- mode(rlibrary(+atom, +list(compound)), one).
	:- info(rlibrary/2, [
		comment is 'Creates a diagram for a library and its sub-libraries using the specified options.',
		argnames is ['Library', 'Options']
	]).

	rlibrary(Library, UserOptions) :-
		format_object(Format),
		merge_options(UserOptions, Options),
		::reset,
		logtalk::expand_library_path(Library, Path),
		::output_file_path(Library, Options, Format, OutputPath),
		open(OutputPath, write, Stream, [alias(output_file)]),
		Format::file_header(output_file, Library, Options),
		atom_concat(rlibrary_, Library, Identifier),
		add_link_options(Path, Options, GraphOptions),
		Format::graph_header(output_file, Identifier, Library, rlibrary, GraphOptions),
		::output_rlibrary(Library, Path, GraphOptions),
		output_externals(Options),
		::output_edges(Options),
		Format::graph_footer(output_file, Identifier, Library, rlibrary, GraphOptions),
		Format::file_footer(output_file, Library, Options),
		close(Stream).

	:- public(rlibrary/1).
	:- mode(rlibrary(+atom), one).
	:- info(rlibrary/1, [
		comment is 'Creates a diagram for a library and its sub-libraries using default options.',
		argnames is ['Library']
	]).

	rlibrary(Library) :-
		::rlibrary(Library, []).

	:- public(library/2).
	:- mode(library(+atom, +list(compound)), one).
	:- info(library/2, [
		comment is 'Creates a diagram for a library using the specified options.',
		argnames is ['Library', 'Options']
	]).

	library(Library, UserOptions) :-
		format_object(Format),
		merge_options(UserOptions, Options),
		::reset,
		logtalk::expand_library_path(Library, Path),
		::output_file_path(Library, Options, Format, OutputPath),
		open(OutputPath, write, Stream, [alias(output_file)]),
		Format::file_header(output_file, Library, Options),
		atom_concat(library_, Library, Identifier),
		add_link_options(Path, Options, GraphOptions),
		Format::graph_header(output_file, Identifier, Library, library, GraphOptions),
		::output_library(Library, Path, GraphOptions),
		output_externals(Options),
		::output_edges(Options),
		Format::graph_footer(output_file, Identifier, Library, library, GraphOptions),
		Format::file_footer(output_file, Library, Options),
		close(Stream).

	output_library(_Library, Directory, Options) :-
		memberchk(exclude_files(ExcludedFiles), Options),
		logtalk::loaded_file_property(Path, directory(Directory)),
		logtalk::loaded_file_property(Path, basename(Basename)),
		::not_excluded_file(ExcludedFiles, Path, Basename),
		::output_file(Path, Basename, Directory, Options),
		fail.
	output_library(_Library, Directory, Options) :-
		memberchk(exclude_files(ExcludedFiles), Options),
		modules_diagram_support::loaded_file_property(Path, directory(Directory)),
		modules_diagram_support::loaded_file_property(Path, basename(Basename)),
		::not_excluded_file(ExcludedFiles, Path, Basename),
		::output_file(Path, Basename, Directory, Options),
		fail.
	output_library(_, _, _).

	:- public(library/1).
	:- mode(library(+atom), one).
	:- info(library/1, [
		comment is 'Creates a diagram for a library using default options.',
		argnames is ['Library']
	]).

	library(Library) :-
		::library(Library, []).

	:- public(directories/3).
	:- mode(directories(+atom, +list(atom), +list(compound)), one).
	:- info(directories/3, [
		comment is 'Creates a diagram for a set of directories using the specified options.',
		argnames is ['Project', 'Directories', 'Options']
	]).

	directories(Project, Directories, UserOptions) :-
		format_object(Format),
		merge_options(UserOptions, Options),
		::reset,
		::output_file_path(Project, Options, Format, OutputPath),
		open(OutputPath, write, Stream, [alias(output_file)]),
		Format::file_header(output_file, Project, Options),
		atom_concat(directories_, Project, Identifier),
		Format::graph_header(output_file, Identifier, Project, directories, [tooltip(Project)| Options]),
		normalize_directory_paths(Directories, NormalizedDirectories),
		output_directories(NormalizedDirectories, Format, Options),
		output_externals(Options),
		::output_edges(Options),
		Format::graph_footer(output_file, Identifier, Project, directories, [tooltip(Project)| Options]),
		Format::file_footer(output_file, Project, Options),
		close(Stream).

	normalize_directory_paths([], []).
	normalize_directory_paths([Directory| Directories], [NormalizedDirectory| NormalizedDirectories]) :-
		os::expand_path(Directory, NormalizedDirectory0),
		(	sub_atom(NormalizedDirectory0, _, _, 0, '/') ->
			NormalizedDirectory = NormalizedDirectory0
		;	atom_concat(NormalizedDirectory0, '/', NormalizedDirectory)
		),
		normalize_directory_paths(Directories, NormalizedDirectories).

	output_directories([], _Format, _Options).
	output_directories([Directory| Directories], Format, Options) :-
		atom_concat(directory_, Directory, Identifier),
		add_link_options(Directory, Options, GraphOptions),
		Format::graph_header(output_file, Identifier, Directory, directory, GraphOptions),
		::output_library(Directory, Directory, GraphOptions),
		Format::graph_footer(output_file, Identifier, Directory, directory, GraphOptions),
		output_directories(Directories, Format, Options).

	:- public(directories/2).
	:- mode(directories(+atom, +list(atom)), one).
	:- info(directories/2, [
		comment is 'Creates a diagram for a set of directories using the default options.',
		argnames is ['Project', 'Directories']
	]).

	directories(Project, Directories) :-
		::directories(Project, Directories, []).

	:- public(directory/3).
	:- mode(directory(+atom, +atom, +list(compound)), one).
	:- info(directory/3, [
		comment is 'Creates a diagram for a directory using the specified options.',
		argnames is ['Project', 'Directory', 'Options']
	]).

	directory(Project, Directory, UserOptions) :-
		format_object(Format),
		merge_options(UserOptions, Options),
		::reset,
		::output_file_path(Project, Options, Format, OutputPath),
		open(OutputPath, write, Stream, [alias(output_file)]),
		Format::file_header(output_file, Project, Options),
		atom_concat(directory_, Project, Identifier),
		add_link_options(Directory, Options, GraphOptions),
		Format::graph_header(output_file, Identifier, Project, directory, GraphOptions),
		normalize_directory_paths([Directory], [NormalizedDirectory]),
		::output_library(Project, NormalizedDirectory, GraphOptions),
		output_externals(Options),
		::output_edges(Options),
		Format::graph_footer(output_file, Identifier, Project, directory, GraphOptions),
		Format::file_footer(output_file, Project, Options),
		close(Stream).

	:- public(directory/2).
	:- mode(directory(+atom, +atom), one).
	:- info(directory/2, [
		comment is 'Creates a diagram for a directory using default options.',
		argnames is ['Project', 'Directory']
	]).

	directory(Project, Directory) :-
		::directory(Project, Directory, []).

	:- public(files/3).
	:- mode(files(+atom, +list(atom), +list(compound)), one).
	:- info(files/3, [
		comment is 'Creates a diagram for a set of files using the specified options. The file can be specified by name, basename, full path, or using library notation.',
		argnames is ['Project', 'Files', 'Options']
	]).

	files(Project, Files, UserOptions) :-
		format_object(Format),
		merge_options(UserOptions, Options),
		::reset,
		::output_file_path(Project, Options, Format, OutputPath),
		open(OutputPath, write, Stream, [alias(output_file)]),
		Format::file_header(output_file, Project, Options),
		atom_concat(files_, Project, Identifier),
		Format::graph_header(output_file, Identifier, Project, files, [tooltip(Project)| Options]),
		::output_files(Files, Options),
		output_externals(Options),
		::output_edges(Options),
		Format::graph_footer(output_file, Identifier, Project, files, [tooltip(Project)| Options]),
		Format::file_footer(output_file, Project, Options),
		close(Stream).

	output_files([], _Options).
	output_files([File| Files], Options) :-
		locate_file(File, Basename, _, Directory, Path),
		add_link_options(Path, Options, FileOptions),
		::output_file(Path, Basename, Directory, FileOptions),
		output_files(Files, Options).

	:- public(files/2).
	:- mode(files(+atom, +list(atom)), one).
	:- info(files/2, [
		comment is 'Creates a diagram for a set of files using the default options. The file can be specified by name, basename, full path, or using library notation.',
		argnames is ['Project', 'Files']
	]).

	files(Project, Files) :-
		::files(Project, Files, []).

	:- public(all_files/1).
	:- mode(all_files(+list(compound)), one).
	:- info(all_files/1, [
		comment is 'Creates a diagram for all loaded files using the specified options.',
		argnames is ['Options']
	]).

	all_files(UserOptions) :-
		format_object(Format),
		merge_options(UserOptions, Options),
		::output_file_path(all_files, Options, Format, OutputPath),
		open(OutputPath, write, Stream, [alias(output_file)]),
		Format::file_header(output_file, files, Options),
		output_all_files(Options),
		output_externals(Options),
		::output_edges(Options),
		Format::file_footer(output_file, files, Options),
		close(Stream).

	output_all_files(Options) :-
		logtalk::loaded_file(Path),
		logtalk::loaded_file_property(Path, basename(Basename)),
		logtalk::loaded_file_property(Path, directory(Directory)),
		::output_file(Path, Basename, Directory, Options),
		fail.
	output_all_files(_).

	:- public(all_files/0).
	:- mode(all_files, one).
	:- info(all_files/0, [
		comment is 'Creates a diagram for all loaded files using default options.'
	]).

	all_files :-
		::all_files([]).

	:- public(format_object/1).
	:- mode(format_object(-object_identifier), zero_or_one).
	:- info(format_object/1, [
		comment is 'Returns the identifier of the object implementing the graph language currently being used. Fails if none is specified.',
		argnames is ['Object']
	]).

	format_object(Object) :-
		parameter(1, Format),
		nonvar(Format),
		graph_language_registry::language_object(Format, Object).

	:- public(default_option/1).
	:- mode(default_option(?compound), zero_or_more).
	:- info(default_option/1, [
		comment is 'Enumerates by backtracking the default options used when generating a diagram.',
		argnames is ['DefaultOption']
	]).

	:- public(default_options/1).
	:- mode(default_options(-list(compound)), one).
	:- info(default_options/1, [
		comment is 'Returns a list of the default options used when generating a diagram.',
		argnames is ['DefaultOptions']
	]).

	default_options(DefaultOptions) :-
		findall(DefaultOption, ::default_option(DefaultOption), DefaultOptions).

	:- protected(merge_options/2).
	:- mode(merge_options(+list(compound), -list(compound)), one).
	:- info(merge_options/2, [
		comment is 'Merges the user options with the default options, returning the list of options used when generating a diagram. Path arguments in options are expanded to full paths. Also ensures that all directory paths end with a slash.',
		argnames is ['UserOptions', 'Options']
	]).

	merge_options(UserOptions, Options) :-
		findall(
			DefaultOption,
			(	::default_option(DefaultOption),
				functor(DefaultOption, OptionName, Arity),
				functor(UserOption, OptionName, Arity),
				\+ member(UserOption, UserOptions)
			),
			DefaultOptions
		),
		append(UserOptions, DefaultOptions, Options0),
		fix_options(Options0, Options).

	fix_options([], []).
	fix_options([Option| Options], [FixedOption| FixedOptions]) :-
		(	fix_option(Option, FixedOption) ->
			true
		;	FixedOption = Option
		),
		fix_options(Options, FixedOptions).

	fix_option(omit_path_prefixes(Prefixes), omit_path_prefixes(NormalizedPrefixes)) :-
		normalize_directory_paths(Prefixes, NormalizedPrefixes).
	fix_option(output_directory(Directory), output_directory(NormalizedDirectory)) :-
		normalize_directory_paths([Directory], [NormalizedDirectory]).

	:- protected(output_rlibrary/3).
	:- mode(output_rlibrary(+atom, +atom, +list(compound)), one).
	:- info(output_rlibrary/3, [
		comment is 'Generates diagram output for a library and its sub-libraries using the specified options.',
		argnames is ['Library', 'Path', 'Options']
	]).

	output_rlibrary(TopLibrary, TopPath, Options) :-
		format_object(Format),
		memberchk(exclude_libraries(ExcludedLibraries), Options),
		atom_concat(library_, TopLibrary, TopIdentifier),
		add_link_options(TopPath, Options, TopGraphOptions),
		Format::graph_header(output_file, TopIdentifier, TopLibrary, library, TopGraphOptions),
		::output_library(TopLibrary, TopPath, TopGraphOptions),
		Format::graph_footer(output_file, TopIdentifier, TopLibrary, library, TopGraphOptions),
		forall(
			sub_library(TopLibrary, TopPath, ExcludedLibraries, Library, Path),
			(	atom_concat(library_, Library, Identifier),
				add_link_options(Path, Options, GraphOptions),
				Format::graph_header(output_file, Identifier, Library, library, GraphOptions),
				::output_library(Library, Path, GraphOptions),
				Format::graph_footer(output_file, Identifier, Library, library, GraphOptions)
			)
		).

	sub_library(TopLibrary, TopPath, ExcludedLibraries, Library, Path) :-
		logtalk_library_path(Library, _),
		Library \== TopLibrary,
		\+ memberchk(Library, ExcludedLibraries),
		logtalk::expand_library_path(Library, Path),
		atom_concat(TopPath, _RelativePath, Path).

	:- protected(output_library/3).
	:- mode(output_library(+atom, +atom, +list(compound)), one).
	:- info(output_library/3, [
		comment is 'Generates diagram output for a library using the specified options.',
		argnames is ['Library', 'Path', 'Options']
	]).

	:- protected(output_files/2).
	:- mode(output_files(+list, +list(compound)), one).
	:- info(output_files/2, [
		comment is 'Generates diagram output for a list of files using the specified options.',
		argnames is ['Files', 'Options']
	]).

	:- protected(output_file/4).
	:- mode(output_file(+atom, +atom, +atom, +list(compound)), one).
	:- info(output_file/4, [
		comment is 'Generates diagram output for a file using the specified options.',
		argnames is ['Path', 'Basename', 'Directory', 'Options']
	]).

	:- protected(output_externals/1).
	:- mode(output_externals(+list(compound)), one).
	:- info(output_externals/1, [
		comment is 'Outputs external entities using the specified options.',
		argnames is ['Options']
	]).

	output_externals(Options) :-
		% as externals can be defined in several places, use the file
		% prefix, if defined, for file URL links
		(	memberchk(url_prefixes(FilePrefix, DocPrefix), Options) ->
			ExternalsOptions = [urls(FilePrefix,DocPrefix)| Options]
		;	ExternalsOptions = Options
		),
		::output_externals(ExternalsOptions).

	:- protected(reset/0).
	:- mode(reset, one).
	:- info(reset/0, [
		comment is 'Resets all temporary information used when generating a diagram.'
	]).

	reset :-
		::retractall(edge_(_, _, _, _, _)).

	:- protected(output_node/6).
	:- mode(output_node(+nonvar, +nonvar, +nonvar, +list(nonvar), +atom, +list(compound)), one).
	:- info(output_node/6, [
		comment is 'Outputs a graph node.',
		argnames is ['Identifier', 'Label', 'Caption', 'Contents', 'Kind', 'Options']
	]).

	output_node(Identifier, Label, Caption, Lines, Kind, Options) :-
		format_object(Format),
		Format::node(output_file, Identifier, Label, Caption, Lines, Kind, Options).

	:- protected(edge/5).
	:- mode(edge(?nonvar, ?nonvar, ?list(nonvar), ?atom, ?list(compound)), zero_or_more).
	:- info(edge/5, [
		comment is 'Enumerates, by backtracking, all saved edges.',
		argnames is ['From', 'To', 'Labels', 'Kind', 'Options']
	]).

	edge(From, To, Labels, Kind, Options) :-
		::edge_(From, To, Labels, Kind, Options).

	:- private(edge_/5).
	:- dynamic(edge_/5).
	:- mode(edge_(?nonvar, ?nonvar, ?list(nonvar), ?atom, ?list(compound)), zero_or_more).
	:- info(edge_/5, [
		comment is 'Table of saved edges.',
		argnames is ['From', 'To', 'Labels', 'Kind', 'Options']
	]).

	:- protected(output_edges/1).
	:- mode(output_edges(+list(compound)), one).
	:- info(output_edges/1, [
		comment is 'Outputs all edges.',
		argnames is ['Options']
	]).

	output_edges(_Options) :-
		format_object(Format),
		::retract(edge_(From, To, Labels, Kind, EdgeOptions)),
		Format::edge(output_file, From, To, Labels, Kind, EdgeOptions),
		fail.
	output_edges(_).

	:- protected(save_edge/5).
	:- mode(save_edge(+nonvar, +nonvar, +list(nonvar), +atom, +list(compound)), one).
	:- info(save_edge/5, [
		comment is 'Saves a graph edge.',
		argnames is ['From', 'To', 'Labels', 'Kind', 'Options']
	]).

	save_edge(From, To, Labels, Kind, Options) :-
		(	memberchk(relation_labels(true), Options) ->
			::assertz(edge_(From, To, Labels, Kind, Options))
		;	::assertz(edge_(From, To, [], Kind, Options))
		).

	:- protected(not_excluded_file/3).
	:- mode(not_excluded_file(+list(atom), +atom, +atom), zero_or_one).
	:- info(not_excluded_file/3, [
		comment is 'True when the given file is not excluded from the generated output. Excluded files may be specified by full path or by basename and with or without extension.',
		argnames is ['ExcludedFiles', 'Path', 'Basename']
	]).

	not_excluded_file([], _, _).
	not_excluded_file([ExcludedFile| ExcludedFiles], Path, Basename) :-
		% files in the exclusion list may be given by full path or by basename
		\+ member(Path, [ExcludedFile| ExcludedFiles]),
		\+ member(Basename, [ExcludedFile| ExcludedFiles]),
		% files in the exclusion list may be given with or without extension
		\+ (	source_file_extension(Extension),
				atom_concat(Source, Extension, Path),
				member(Source, [ExcludedFile| ExcludedFiles])
		),
		\+ (	source_file_extension(Extension),
				atom_concat(Source, Extension, Basename),
				member(Source, [ExcludedFile| ExcludedFiles])
		),
		\+ (	modules_diagram_support::source_file_extension(Extension),
				atom_concat(Source, Extension, Path),
				member(Source, [ExcludedFile| ExcludedFiles])
		),
		\+ (	modules_diagram_support::source_file_extension(Extension),
				atom_concat(Source, Extension, Basename),
				member(Source, [ExcludedFile| ExcludedFiles])
		).

	:- protected(diagram_name_suffix/1).
	:- mode(diagram_name_suffix(-atom), one).
	:- info(diagram_name_suffix/1, [
		comment is 'Returns the diagram name suffix.',
		argnames is ['Suffix']
	]).

	% default value
	diagram_name_suffix('_diagram').

	:- protected(output_file_path/4).
	:- mode(output_file_path(+atom, +list(atom), +object_identifier, -atom), one).
	:- info(output_file_path/4, [
		comment is 'Returns the output file path.',
		argnames is ['Name', 'Options', 'Format', 'Path']
	]).

	output_file_path(Name0, Options, Format, Path) :-
		::diagram_name_suffix(Suffix),
		atom_concat(Name0, Suffix, Name),
		Format::output_file_name(Name, Basename),
		memberchk(output_directory(Directory), Options),
		os::make_directory(Directory),
		atom_concat(Directory, Basename, Path).

	:- protected(locate_file/5).
	:- mode(locate_file(+atom, +atom, +atom, +atom, -atom), one).
	:- info(locate_file/5, [
		comment is 'Locates a file given its name, basename, full path, or library notation representation.',
		argnames is ['File', 'Basename', 'Extension', 'Directory', 'Path']
	]).

	% Logtalk file given in library notation
	locate_file(LibraryNotation, Basename, Extension, Directory, Path) :-
		compound(LibraryNotation),
		!,
		LibraryNotation =.. [Library, Name],
		logtalk::expand_library_path(Library, LibraryPath),
		atom_concat(LibraryPath, Name, Source),
		locate_file(Source, Basename, Extension, Directory, Path).
	% Logtalk file given using its name or basename
	locate_file(Source, Basename, Extension, Directory, Path) :-
		add_extension(logtalk, Source, Basename, Extension),
		logtalk::loaded_file_property(Path, basename(Basename)),
		logtalk::loaded_file_property(Path, directory(Directory)),
		% check that there isn't another file with the same basename
		% from a different directory
		\+ (
			logtalk::loaded_file_property(OtherPath, basename(Basename)),
			Path \== OtherPath
		),
		!.
	% Prolog file given using its name or basename
	locate_file(Source, Basename, Extension, Directory, Path) :-
		add_extension(prolog, Source, Basename, Extension),
		modules_diagram_support::loaded_file_property(Path, basename(Basename)),
		modules_diagram_support::loaded_file_property(Path, directory(Directory)),
		% check that there isn't another file with the same basename
		% from a different directory
		\+ (
			modules_diagram_support::loaded_file_property(OtherPath, basename(Basename)),
			Path \== OtherPath
		),
		!.
	% Logtalk file given using a full path
	locate_file(Source0, Basename, Extension, Directory, Path) :-
		os::expand_path(Source0, Source),
		add_extension(logtalk, Source, Path, Extension),
		logtalk::loaded_file_property(Path, basename(Basename)),
		logtalk::loaded_file_property(Path, directory(Directory)),
		!.
	% Prolog file given using a full path
	locate_file(Source0, Basename, Extension, Directory, Path) :-
		os::expand_path(Source0, Source),
		add_extension(prolog, Source, Path, Extension),
		modules_diagram_support::loaded_file_property(Source, basename(Basename)),
		modules_diagram_support::loaded_file_property(Source, directory(Directory)),
		!.

	add_extension(logtalk, Source, SourceWithExtension, Extension) :-
		atom(Source),
		\+ (
			modules_diagram_support::source_file_extension(PrologExtension),
			sub_atom(Source, _, _, 0, PrologExtension)
		),
		(	source_file_extension(Extension),
			sub_atom(Source, _, _, 0, Extension) ->
			SourceWithExtension = Source
		;	% no recognized extension in use
			source_file_extension(Extension),
			atom_concat(Source, Extension, SourceWithExtension)
		).

	add_extension(prolog, Source, SourceWithExtension, Extension) :-
		atom(Source),
		\+ (
			source_file_extension(Extension),
			sub_atom(Source, _, _, 0, Extension)
		),
		(	modules_diagram_support::source_file_extension(Extension),
			sub_atom(Source, _, _, 0, Extension) ->
			SourceWithExtension = Source
		;	% no recognized extension in use
			modules_diagram_support::source_file_extension(Extension),
			atom_concat(Source, Extension, SourceWithExtension)
		).

	source_file_extension('.lgt').
	source_file_extension('.logtalk').

	:- protected(ground_entity_identifier/3).
	:- mode(ground_entity_identifier(+atom, +callable, -callable), one).
	:- info(ground_entity_identifier/3, [
		comment is 'Converts an entity identifier to a ground term.',
		argnames is ['Kind', 'Identifier', 'GroundIdentifier']
	]).

	ground_entity_identifier(object, Object, ObjectName) :-
		(	atom(Object) ->
			ObjectName = Object
		;	(	object_property(Object, info(Info)) ->
				parameter_names(Object, Info, Names)
			;	parameter_names(Object, [], Names)
			),
			Object =.. [Functor| _],
			ObjectName =.. [Functor| Names]
		).
	ground_entity_identifier(protocol, Protocol, Protocol).
	ground_entity_identifier(category, Category, CategoryName) :-
		(	atom(Category) ->
			CategoryName = Category
		;	(	category_property(Category, info(Info)) ->
				parameter_names(Category, Info, Names)
			;	parameter_names(Category, [], Names)
			),
			Category =.. [Functor| _],
			CategoryName =.. [Functor| Names]
		).
	ground_entity_identifier(module, Module, Module).
	ground_entity_identifier(unknown, Entity, EntityName) :-
		(	atom(Entity) ->
			EntityName = Entity
		;	functor(Entity, Functor, Arity),
			functor(EntityName, Functor, Arity),
			EntityName =.. [Functor| Arguments],
			variables_to_underscore(Arguments)
		).

	parameter_names(Entity, Info, Names) :-
		(	member(parnames(Names), Info) ->
			true
		;	member(parameters(Parameters), Info) ->
			keys(Parameters, Names)
		;	Entity =.. [_| Names],
			variables_to_underscore(Names)
		).

	variables_to_underscore([]).
	variables_to_underscore([Arg| Args]) :-
		(	var(Arg) ->
			Arg = '_'
		;	true
		),
		variables_to_underscore(Args).

	:- protected(add_link_options/3).
	:- mode(add_link_options(+atom, +list(compound), -list(compound)), one).
	:- info(add_link_options/3, [
		comment is 'Adds urls/2 and tooltip/1 link options (for use by the graph language) based on the specified path to the list of options.',
		argnames is ['Path', 'Options', 'GraphOptions']
	]).

	add_link_options(Path, Options, LinkingOptions) :-
		memberchk(omit_path_prefixes(Prefixes), Options),
		memberchk(url_prefixes(FilePrefix, DocPrefix), Options),
		(	member(Prefix, Prefixes),
			atom_concat(Prefix, Suffix, Path) ->
			atom_concat(FilePrefix, Suffix, FileURL)
		;	FileURL = FilePrefix
		),
		LinkingOptions = [urls(FileURL,DocPrefix), tooltip(Suffix)| Options].

:- end_category.
