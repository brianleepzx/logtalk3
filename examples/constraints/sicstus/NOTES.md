________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


To load this example and for sample queries, please see the `SCRIPT.txt` file.

This folder contains a set of experimental examples illustrating how to use
the CLP(FD) library distributed with SICStus Prolog 4.x with Logtalk.

The CLP(FD) library is loaded from the "loader.lgt" auxiliary loader file.
This library must always be loaded prior to compilation of the individual 
example files.

In most cases, objects and categories containing CLP(FD) code must be
compiled using the hook file ("sicstus_clpfd_hook.lgt") provided in this
directory (see the "loader.lgt" file for an example). This hook file
provides support for compilation of indexicals and overrides the meta-
predicate directives of the CLP(FD) meta-predicates. When using the CLP(FD)
labeling/2 enumeration predicate, the value/1 and variable/1 options are
currently not supported.

Within objects and categories, is strongly recommended that you use the
use_module/2 directive for the CLP(FD) module.
