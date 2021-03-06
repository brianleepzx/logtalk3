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


:- initialization((
	logtalk_load(library(os_loader)),
	logtalk_load(library(basic_types_loader)),
	logtalk_load(library(pairs), [optimize(on)]),
	logtalk_load(modules_diagram_support, [optimize(on)]),
	logtalk_load([
		graph_language_registry,
		graph_language_protocol,
		dot_graph_language
		], [optimize(on)]),
	logtalk_load([
		diagram,
		entity_diagram,
		xref_diagram,
		inheritance_diagram,
		uses_diagram,
		file_diagram,
		file_load_diagram,
		file_dependency_diagram,
		diagrams
		], [optimize(on)])
)).
