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


This tool generates entity diagrams and file diagrams for source files
and for libraries of source files using the Logtalk reflection features
to collect the relevant information and a graph language for representing
the diagrams. Limited support is also available for generating diagrams
for Prolog module applications.

This tool can be loaded using the query:

	| ?- logtalk_load(diagrams(loader)).

For sample queries, please see the `SCRIPT.txt` file.

Currently only the DOT graph language is supported (tested with version
2.36.0; visit the <http://www.graphviz.org/> website for more information).

The following entity diagrams are supported:

- entity diagrams showing entity public interfaces, entity inheritance
relations and entity predicate call cross-reference relations
- call diagrams showing entity predicate cross-reference calls
- inheritance diagrams showing only entity inheritance relations
- uses diagrams showing only predicate call cross-reference relations

The following file diagrams are supported:

- file loading dependency diagrams showing which files load other files
- file dependency diagrams showing which files contain entities with
references to entities defined in other files

File dependency diagrams are specially useful in revealing dependencies
that are not represented in file loading diagrams due to files being
loaded indirectly by files external to the libraries being documented. 

An utility object, `diagrams`, is provided for generating all supported
diagrams in one step. This object provides an interface common to all
diagrams.

Limitations in both the graph language and UML forces the invention of a
modeling language that can represent all kinds of Logtalk entities and
entity relations. Currently we use the following DOT shapes (entities,
predicates, and files) and arrows (entity, predicate, and file relations):

- objects (classes, instances, and prototypes)  
	`box` (rectangle, yellow for instances/classes and beige for prototypes)
- protocols  
	`note` (aqua marine rectangle with folded right-upper corners)
- categories  
	`component` (light cyan rectangle with two small rectangles intercepting the left side)
- modules  
	`tab` (grey rectangle with small tab at top)

- public predicates  
	`ellipse` (green)
- public, multifile, predicates  
	`ellipse` (blue)
- protected predicates  
	`ellipse` (yellow)
- private predicates  
	`ellipse` (red)
- predicates not locally declared  
	`ellipse` (beige)
- exported module predicates  
	`ellipse` (green)

- files  
	`box` (pale turquoise rectangle)

- specialization relation  
	`onormal` (arrow ending with a white triangle)
- instantiation relation  
	`normal` (arrow ending with a black triangle)
- extends relation  
	`vee` (arrow ending with a "v")
- implements relation  
	`dot` (arrow ending with a black circle)
- imports relation  
	`box` (arrow ending with a black square)
- complements relation  
	`obox` (arrow ending with a white square)

- uses and use module relations  
	`rdiamond` (arrow ending with a black half diamond)

- file loading relations  
	`normal` (arrow ending with a black triangle)
- file dependency relations  
	`rdiamond` (arrow ending with a black half diamond)

The entity, predicate, and file nodes that are not part of the entities, files,
or libraries for which you are generating a diagram use a dashed border.

The diagrams `.dot` files are created on the current directory by default.
These files can be easily converted into a printable format such as SVG, PDF,
or Postscript. For example, using the `dot` command-line executable we can
simply type:

	dot -Tpdf diagram.dot > diagram.pdf

This usually works fine for entity and predicate call cross-referencing
diagrams. For file diagrams, the `circo` command-line executable often
produces better results:

	circo -Tpdf diagram.dot > diagram.pdf

It's also worth to experiment with different layouts to find the one that
produces the best results (see the `layout/1` option described below).

Some output formats such as SVG support tooltips and URL links, which can
be used for showing e.g. entity types, relation types, file paths, and for
navigating to files and directories of files (libraries). See the relevant
diagram options below in order to take advantage of these features.

When generating diagrams for multiple libraries or directories, it's possible
to split a diagram with several disconnected library or directory graphs using
the `ccomps` command-line executable. For example:

	ccomps -x -o subdiagram.dot diagram.dot

For more information on the DOT language and related tools see:

	http://www.graphviz.org/

When using Windows, there are know issues with some Prolog compilers due
to the internal representation of paths. If you encounter problems with a
specific back-end Prolog compiler, try to use another supported back-end
Prolog compiler when generating diagrams.

For printing large diagrams, you will need to either use a tool to slice
the diagram in page-sized pieces or, preferably, use software capable of
tiled printing (e.g. Adobe Reader). You can also hand-edit the generated
`.dot` files and play with settings such as aspect ratio for fine-tuning
the diagrams layout.

A set of options are available to specify the details to include in the
generated diagrams. For entity diagrams the options are:

- `layout(Layout)`  
	diagram layout (one of the atoms `{top_to_bottom,bottom_to_top,left_to_right,right_to_left}`; default depends on the kind of diagram)
- `title(Title)`  
	diagram title (an atom; default is `''`)
- `date(Boolean)`  
	print/omit current date and time (`true` or `false`; default is `true`)
- `interface(Boolean)`  
	print/omit public predicates (default depends on the specific diagram)
- `file_labels(Boolean)`  
	print/omit file labels (`true` or `false`; default is `true`)
- `relation_labels(Boolean)`  
	print/omit entity relation labels (`true` or `false`; default is `true`)
- `node_type_captions(Boolean)`  
	print/omit node type captions (`true` or `false`; default is `false`)
- `inheritance_relations(Boolean)`  
	print/omit inheritance relations (default depends on the specific diagram)
- `provide_relations(Boolean)`  
	print/omit provide relations (default depends on the specific diagram)
- `xref_relations(Boolean)`  
	print/omit predicate call cross reference relations (default depends on the specific diagram)
- `xref_calls(Boolean)`  
	print/omit predicate cross reference calls (default depends on the specific diagram)
- `output_directory(Directory)`  
	directory for the .dot files (an atom; default is `'./'`)
- `exclude_files(Files)`  
	list of source files to exclude (default is `[]`)
- `exclude_libraries(Libraries)`  
	list of sub-libraries to exclude (default is `[]`)
- `exclude_entities(Entities)`  
	list of entities to exclude (default is `[]`)
- `omit_path_prefixes(Prefixes)`  
	omit common path prefixes when printing directory paths (a list of atoms; default is `[]`)
- `url_prefixes(FilePrefix, DocPrefix)`  
	URL file and entity documenting URL prefixes used when generating cluster, file, and entity links (atoms; defaults are `''`)
- `entity_url_suffix_target(Suffix, Target)`  
	extension for entity documenting URLs (an atom; default is `'.html'`) and target separating symbols (an atom; default is `'#'`)

For file diagrams the options are:

- `layout(Layout)`  
	diagram layout (one of the atoms `{top_to_bottom,bottom_to_top,left_to_right,right_to_left}`; default depends on the kind of diagram)
- `title(Title)`  
	diagram title (an atom; default is `''`)
- `date(Boolean)`  
	print/omit current date and time (`true` or `false`; default is `true`)
- `directory_paths(Boolean)`  
	print/omit file directory paths (`true` or `false`; default is `true`)
- `omit_path_prefixes(Prefixes)`  
	omit common path prefixes when printing directory paths (a list of atoms; default is `[]`)
- `url_prefixes(FilePrefix, DocPrefix)`  
	URL file and entity documenting URL prefixes used when generating cluster, file, and entity links (atoms; defaults are `''`)
- `relation_labels(Boolean)`  
	print/omit entity relation labels (`true` or `false`; default is `false`)
- `node_type_captions(Boolean)`  
	print/omit node type captions (`true` or `false`; default is `false`)
- `output_directory(Directory)`  
	directory for the .dot files (an atom; default is `'./'`)
- `exclude_files(Files)`  
	list of source files to exclude (default is `[]`)
- `exclude_libraries(Libraries)`  
	list of sub-libraries to exclude (default is `[]`)

The option `omit_path_prefixes(Prefixes)` with a non-empty list of prefixes
should be used together with the option `directory_paths(true)`, in particular
when generating diagrams for libraries and directories with external files.

Be sure to set the `source_data` flag `on` before compiling the libraries
or files for which you want to generated diagrams.

Support for displaying Prolog modules and Prolog module files in diagrams:

- ECLiPSe  
	file diagrams don't display module files
- SICStus Prolog  
	file diagrams don't display module files
- SWI-Prolog  
	full support (uses the SWI-Prolog `prolog_xref` library)
- YAP  
	full support (uses the YAP `prolog_xref` library)

When using SWI-Prolog or YAP as the backend compilers, diagrams can also be
generated for (loaded) Prolog source files (containing module definitions)
and for (loaded) Prolog modules. However, the diagraming methods that take
a library name as argument are not currently usable.

For more information on this tool, open the `docs/tools.html` file in a
web browser.

All source files are formatted using tabs (the recommended setting is a
tab width equivalent to 4 spaces).
