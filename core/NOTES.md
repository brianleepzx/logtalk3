________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  
Copyright (c) 1998-2014 Paulo Moura <pmoura@logtalk.org>

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


This folder contains a single Prolog file, `core.pl`, which implements
the Logtalk compiler and the Logtalk runtime. There are also some Logtalk
source files defining built-in protocols, categories, and objects:

- `expanding.lgt` - term- and goal-expansion predicates
- `forwarding.lgt` - message forwarding predicate
- `monitoring.lgt` - event handler predicates
- `logtalk.lgt` - message printing, debugging, and hacking predicates
- `core_messages.lgt` - default translations for compiler messages

Before loading the `core.pl` file into your favorite Prolog compiler,
you must first load the appropriated adapter file for your Prolog
compiler, which you will find in the `adapters` directory, and the
`paths/paths.pl` file, which defines essential library paths for
starting Logtalk.

The source files are formatted using tabs (the recommended setting is
a tab width equivalent to 4 spaces).

The `$LOGTALKUSER/docs` directory includes a XHTML version of the core
entities documentation. To regenerate the documentation of these libraries,
start Logtalk with your favorite back-end Prolog compiler and follow these
steps:

(1) If the `source_data` flag is not `on` by default, type the query:

	| ?- set_logtalk_flag(source_data, on).

(2) Load the `lgtdoc` tool and generate the XML documenting files for all
core entities using the queries:

	| ?- {lgtdoc(loader)}.
	...
	| ?- lgtdoc::library(core, [xmldir('$LOGTALKUSER/docs/tmp')]).

(3) Run the command `lgt2html` on the `$LOGTALKUSER/docs/tmp` directory
to generate (X)HTML documentation or the command `lgt2pdf` to generate PDF
documentation. For example:

	$ cd $LOGTALKUSER/docs/tmp
	$ lgt2html -i core.html -t "Core entities documentation index"

After generating the (X)HTML and/or PDF documentation, you can move the
files to the upper directory, `$LOGTALKUSER/docs`, and delete the temporary
directory.