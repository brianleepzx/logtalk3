________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


This folder contains some examples of multi-threading programming.
Multi-threading programming is only supported on some Prolog compilers.
Currently this includes SWI-Prolog, YAP CVS, and XSB CVS (make sure that 
you use the multi-threading versions of these Prolog compilers!). Moreover, 
multi-threading may be turned off by default. In order to run the examples, 
you may need to first turn on multi-threading support on the Prolog adapter 
files.

Some of the examples try to benchmark single-threaded and multi-threaded 
solutions. Depending on the Prolog compiler, the operating-system, and the 
computer used, you may need to adjust the size of the problem data in order 
to find the threshold where multi-threading solutions begin to outperform 
the single-threaded solutions.

Some of the examples may imply adjusting the default size of thread data 
areas or, preferably, use of the 64 bits version of the compatible Prolog 
compilers.

There are known Prolog bugs on the multi-threading support found on XSB, 
YAP, and SWI-Prolog. These bugs prevent some examples to run and may lead 
to crashes. Some of the bugs are platform-specific, only occurring on some 
operating-systems.
