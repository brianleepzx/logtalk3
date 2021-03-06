________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  
Copyright (c) 1998-2015 Paulo Moura <pmoura@logtalk.org>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Additional licensing terms apply per Section 7 of the GNU General
Public License 3. Consult the `LICENSE.txt` file for details.
________________________________________________________________________


This directory contains files that provide syntax highlighting and 
other text editing services for writing Logtalk source files (`*.lgt`
or `*.logtalk`) with common text editors. By default, Logtalk syntax
highlighting may also be applied to the Prolog adapter files (`*.pl`).
Support for some syntax highlighters (used in e.g in wikis, source code
browsers, and bug trackers) is also provided.

The files in this directory can be regarded as contributions to
third-party text editors and syntax highlighters. Thus, as a general
rule, these files are dual-licensed under the Logtalk license and the
license used by the third-party software.

Some text editors already include support for Logtalk. If that is the 
case of your favorite editor, you may want to check if the supporting 
files provided in this directory are newer than the editor ones.

Logtalk source files (including the library entities and the programming
examples) are formatted using tabs (the recommended setting is a tab width
equivalent to 4 spaces); you may set the tab width on the editor preference
panel.

You may notice that support for some text editors, notably for Windows-only 
editors, is rather poor. Depending on the text editor, proper syntax
highlighting support for Prolog and Logtalk may require support for
regular expressions with zero-width look-ahead and look-behind assertions,
which some editors lack.

Some text editors supporting regular expressions contain bugs and/or 
hard-coded limitations that prevent full optimization of the syntax 
coloring patterns.

As Logtalk can be viewed as a superset of ISO Prolog, you may also use
the resources in this directory for editing Prolog source files.
