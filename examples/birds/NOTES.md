________________________________________________________________________

This file is part of Logtalk <http://logtalk.org/>  

Logtalk is free software. You can redistribute it and/or modify it under
the terms of the FSF GNU General Public License 3  (plus some additional
terms per section 7).        Consult the `LICENSE.txt` file for details.
________________________________________________________________________


To load this example and for sample queries, please see the `SCRIPT.txt`
file.

This folder contains an example of a bird identification expert system 
adapted with permission from the book "Adventure in Prolog" by Amzi! inc. 
The book is available on-line in HTML format at the URL:

	http://www.amzi.com

Please refer to the book for more information on the original example.


The bird identification hierarchy is organized as a prototype hierarchy
as follows:

	<order>
		<family>
			<bird>

	order
		falconiforms
			falcon
				peregrine_falcon
				sparrow_hawk
			vulture
				california_condor
				turkey_vulture
		passerformes
			flycatcher
				ash_throated_flycatcher
				great_crested_flycatcher
			swallow
				barn_swallow
				cliff_swallow
				purple_martin
		tubenose
			fulmar
			albatross
				black_footed_albatross
				laysan_albatross
		waterfowl
			duck
				female_mallard
				male_mallard
				pintail
			goose
				canada_goose
				snow_goose
			swan
				trumpeter_swan
				whistling_swan
