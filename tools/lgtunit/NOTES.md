
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


Overview
--------

The `lgtunit.lgt` source file contains a simple framework for defining and
running unit tests in Logtalk. The `lgtunit_messages.lgt` source file defines
the default translations for the messages printed when running unit tests.
These messages can be intercepted to customize output, e.g. to make it less
verbose, or to integrate this tool with e.g. GUI IDEs. For more information
on these entities, open the `docs/tools.html` file in a web browser.

All source files are formatted using tabs (the recommended setting is a tab
width equivalent to 4 spaces).


Compiling and loading unit tests
--------------------------------

To compile and load this framework type:

	| ?- logtalk_load(lgtunit(loader)).

The unit tests framework is inspired by the xUnit frameworks architecture and
by the works of Joachim Schimpf (ECLiPSe library `test_util`) and Jan Wielemaker
(SWI-Prolog `plunit` package).

In order to write your own unit tests, define objects extending the `lgtunit`
object:

	:- object(tests,
		extends(lgtunit)).
	...

The source files defining the test objects must be compiled using the option
`hook(lgtunit)`. For example:

	| ?- logtalk_load(my_tests, [hook(lgtunit)]).

As the term-expansion mechanism applies to all the contents of a source file,
the source files defining the test objects shouldn't contain entities other
than the test objects. Additional code necessary for the tests should go to
separate files. See the `../../tester-sample.lgt` file for an example of a
loader file for compiling and loading the `lgtunit` tool, the source code
under testing, the unit tests, and for automatically run all the tests after
loading. See the `../../tests` directory for examples of unit tests.


Unit test dialects
------------------

Unit tests can be written using any of the following dialects:

	test(Test) :- Goal.

This is the most simple dialect, allowing the specification of tests
that are expected to succeed. However, tests that are expected to throw
an error cannot be specified. A more versatile dialect is:

	succeeds(Test) :- Goal.
	deterministic(Test) :- Goal.
	fails(Test) :- Goal.
	throws(Test, Ball) :- Goal.
	throws(Test, Balls) :- Goal.

This is a straightforward dialect. For `succeeds/1` tests, `Goal` is
expected to succeed. For `deterministic/1` tests, `Goal` is expected to
succeed once without leaving a choice-point. For `fails/1` tests, `Goal`
is expected to fail. For `throws/2` tests, `Goal` is expected to throw
the exception term `Ball` or one of the exception terms in the list
`Balls`. An alternative test dialect that can be used with the same
expressive power is:

	test(Test, Outcome) :- Goal.

The possible values of the outcome argument are:

- `true`  
	the test is expected to succeed
- `true(Test)`  
	the test is expected to succeed and satisfy the goal `Test`
- `deterministic`  
	the test is expected to succeed once without leaving a choice-point
- `deterministic(Test)`  
	the test is expected to succeed once without leaving a choice-point and satisfy the goal `Test`
- `fail`  
	the test is expected to fail
- `error(Error)`  
	the test is expected to throw the exception term `error(Error, _)`
- `errors(Errors)`  
	the test is expected to throw an exception term `error(Error, _)` where `Error` is an element of the list `Errors`
- `ball(Ball)`  
	the test is expected to throw the exception term `Ball`
- `balls(Balls)`  
	the test is expected to throw an exception term `Ball` where `Ball` is an element of the list `Balls`

In all dialects, `Test` is an atom, uniquely identifying a test. An error
message is printed if duplicated identifiers are found. These errors must
be corrected otherwise the test results can be misleading.

Tests that for some reason should be skipped can have the test clause head
prefixed with the `(-)/1` operator. The number of skipped tests is reported
together with the numbers of passed and failed tests. The conditional
compilation directives can also be used in alternative but note that in this
case there will be no report on the number of skipped tests.

A single unit test object my include tests for one or more entities (objects,
protocols, and categories). The entities being tested by an unit test object
for which code coverage information should be collected are declared using
the `cover/1` predicate.

For examples of how to write unit tests, check the `tests` folder or the
`testing` example in the `examples` folder in the Logtalk distribution.
Most of the provided examples also include unit tests.

Parameterized unit tests can be easily defined by using parametric objects.

Note: when using the `(<<)/2` debugging control construct to access and test
an object internal predicates, make sure that the `context_switching_calls`
compiler flag is set to `allow` for those objects.


Testing input/output predicates
-------------------------------

Extensive support for testing input/output predicates is provided, based on
similar support found on the Prolog conformance testing framework written by
Péter Szabó and Péter Szeredi.

Two sets of predicates are provided, one for testing text input/output and
one for testing binary input/output. In both cases, temporary files (possibly
referenced by a user-defined alias) are used. The predicates allow setting,
checking, and cleaning text/binary input/output. There is also a small set of
helper predicates for dealing with stream handles and stream positions.

For practical examples, check the included tests for Prolog conformance of
standard input/output predicates.


Unit tests with timeout limits
------------------------------

There's no portable way to call a goal with a timeout limit. However, some
backend Prolog compilers provide this functionality:

- ECLiPSe: `timeout/3` and `timeout/7` library predicates
- SICStus Prolog: `time_out/3` library predicate
- SWI-Prolog: `call_with_time_limit/2` library predicate
- YAP: `time_out/3` library predicate


Setup and cleanup goals
-----------------------

A unit test object can define `setup/0` and `cleanup/0`. goals. The `setup/0`
predicate is called, when defined, before running the object unit tests. The
`cleanup/0` predicate is called, when defined, after running all the object
unit tests.


Debugging failed unit tests
---------------------------

In order to debug failed unit tests, you can compile the unit test objects
without using the `hook/1` option and use the `(<<)/2` debugging control
construct to call the individual tests. For example, assuming you have a
`test(test_n)` unit test that is failing, you can type:

	| ?- logtalk_load(my_tests).
	...

	| ?- my_tests << test(test_n).
	...

You may also compile the unit test objects in debug mode and use the Logtalk
debugger. For example:

	| ?- logtalk_load(debugger(loader)).
	...

	| ?- logtalk_load(my_tests, [debug(on)]).
	...

	| ?- debugger::trace.
	...

	| ?- my_tests << test(test_n).
	...


Code coverage
-------------

If you want entity predicate clause coverage information to be collected
and printed, you will need to compile the entities that you're testing
using the flags `debug(on)` and `source_data(on)`. Be aware, however,
that compiling in debug mode results in a performance penalty. Your unit
test objects must also define facts for the predicate `cover/1`, whose
argument is the identifier of an entity being tested for which you want
to collect coverage information.

In the printed predicate clause coverage information, you may get a total
number of clauses smaller than the covered clauses. This results from the
use of dynamic predicates with clauses asserted at runtime. You may easily
identify dynamic predicates in the results as their clauses often have a
initial count equal to zero.

The list of indexes of the covered predicate clauses can be quite long.
Some backend Prolog compilers provide a flag or a predicate to control
the depth of printed terms that can be useful:

* CxProlog: `write_depth/2` predicate
* ECLiPSe: `print_depth` flag
* SICStus Prolog: `toplevel_print_options` flag
* SWI-Prolog: `toplevel_print_options` flag
* XSB: `set_file_write_depth/1` predicate
* YAP: `write_depth/2-3` predicates


Automating running unit tests
-----------------------------

You can use the `scripts/logtalk_tester.sh` Bash shell script for automating
running unit tests. See the `scripts/NOTES.md` file for details.


Known issues
------------

Deterministic unit tests are currently not available when using Lean Prolog
or Quintus Prolog as backend compilers.
