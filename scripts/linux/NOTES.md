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


This directory contains files used when building Linux RPM packages.

The `build_rpm.sh` shell script makes the following assumptions:

(1) The `~/.rpmmacros` configuration file contains the definition:
 
	%_topdir      %(echo $HOME)/rpmbuild

(2) The `~/rpmbuild` directory structure already exists (the command
`rpmdev-setuptree` can be used to create these structure).

The necessary `logtalk.spec` file is generated by the `build_rpm.sh`
shell script by processing the `logtalk.spec.in` file.
