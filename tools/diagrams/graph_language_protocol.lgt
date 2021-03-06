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


:- protocol(graph_language_protocol).

	:- info([
		version is 2.0,
		author is 'Paulo Moura',
		date is 2014/12/30,
		comment is 'Predicates for generating graph files.'
	]).

	:- public(output_file_name/2).
	:- mode(output_file_name(+atom, -atom), one).
	:- info(output_file_name/2, [
		comment is 'Constructs the diagram file basename by adding a graph language dependent extension to the given name.',
		argnames is ['Name', 'Basename']
	]).

	:- public(file_header/3).
	:- mode(file_header(+stream_or_alias, +atom, +list(compound)), one).
	:- info(file_header/3, [
		comment is 'Writes the output file header using the specified options.',
		argnames is ['Stream', 'Identifier', 'Options']
	]).

	:- public(file_footer/3).
	:- mode(file_footer(+stream_or_alias, +atom, +list(compound)), one).
	:- info(file_footer/3, [
		comment is 'Writes the output file footer using the specified options.',
		argnames is ['Stream', 'Identifier', 'Options']
	]).

	:- public(graph_header/5).
	:- mode(graph_header(+stream_or_alias, +atom, +atom, +atom, +list(compound)), one).
	:- info(graph_header/5, [
		comment is 'Writes a graph header using the specified options.',
		argnames is ['Stream', 'Identifier', 'Label', 'Kind', 'Options']
	]).

	:- public(graph_footer/5).
	:- mode(graph_footer(+stream_or_alias, +atom, +atom, +atom, +list(compound)), one).
	:- info(graph_footer/5, [
		comment is 'Writes a graph footer using the specified options.',
		argnames is ['Stream', 'Identifier', 'Label', 'Kind', 'Options']
	]).

	:- public(node/7).
	:- mode(node(+stream_or_alias, +nonvar, +nonvar, +nonvar, +list(nonvar), +atom, +list(compound)), one).
	:- info(node/7, [
		comment is 'Writes a node using the specified options.',
		argnames is ['Stream', 'Identifier', 'Label', 'Caption', 'Lines', 'Kind', 'Options']
	]).

	:- public(edge/6).
	:- mode(edge(+stream_or_alias, +nonvar, +nonvar, +list(nonvar), +atom, +list(compound)), one).
	:- info(edge/6, [
		comment is 'Writes an edge between two nodes using the specified options.',
		argnames is ['Stream', 'Start', 'End', 'Labels', 'Kind', 'Options']
	]).

:- end_protocol.
