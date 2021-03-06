%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This file is part of Logtalk <http://logtalk.org/>  
%  Copyright (c) 1998-2015 Paulo Moura <pmoura@logtalk.org>
%
%  Integration file for Qu-Prolog
%  Last updated on April 29, 2014
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


% load Logtalk core files
:-	os(system('ln -sf $LOGTALKHOME/adapters/qp.pl $LOGTALKUSER/.qp.pl')),
	fcompile('$LOGTALKUSER/.qp.pl', [assemble_only(true), object_file('$LOGTALKUSER/.qp.qo')]),
	load('$LOGTALKUSER/.qp.qo'),
	os(system('ln -sf $LOGTALKHOME/paths/paths.pl $LOGTALKUSER/.paths.pl')),
	fcompile('$LOGTALKUSER/.paths.pl', [assemble_only(true), object_file('$LOGTALKUSER/.paths.qo')]),
	load('$LOGTALKUSER/.paths.qo'),
	os(system('ln -sf $LOGTALKHOME/core/core.pl $LOGTALKUSER/.core.pl')),
	fcompile('$LOGTALKUSER/.core.pl', [assemble_only(true), object_file('$LOGTALKUSER/.core.qo'), compiler_heap(2048), string_table(256)]),
	load('$LOGTALKUSER/.core.qo').

% workaround the lack of support for static multifile predicates
:- multifile('$logtalk#0.debug_handler_provider#1'/2).
:- dynamic('$logtalk#0.debug_handler_provider#1'/2).

:- multifile('$logtalk#0.debug_handler#2'/3).
:- dynamic('$logtalk#0.debug_handler#2'/3).
