# 
# Copyright 2009 Mark Fiers, Plant & Food Research
# 
# This file is part of Moa - http://github.com/mfiers/Moa
# 
# Moa is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your
# option) any later version.
# 
# Moa is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
# License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with Moa.  If not, see <http://www.gnu.org/licenses/>.
# 
moa_id = vmatch

#variables

ifndef dont_include_moabase
	include $(shell echo $$MOABASE)/template/moa/core.mk
endif

##### Derived variables for this run

#prepare for gbrowse updload
#gup_gff_dir=.
#gup_upload_gff?=T
#gup_upload_fasta?=F
#gup_gffsource?=vmatch.$(vmatch_dbname)

.PHONY: vmatch_prepare
vmatch_prepare:

.PHONY: vmatch_post
vmatch_post:

.PHONY: vmatch
vmatch: output.gff

output.gff: output.raw
	cat output.raw \
		| sed "s/$(vmatch_dbname)/vmatch.$(vmatch_dbname)/" \
		| sed "s/cDNA_match/match/" \
		| sed "s/^\([^\t]*\)\(.*\)ID=/\1\2ID=vmatch.$(vmatch_dbname)_\1_/" \
		| sed "s/Target=/Target=Sequence:/" \
		> output.gff
#	if [ "$(vmatch_invert_gff)" == "T" ]; then \
#		invertGff output.gff > output.invert.gff ;\
#	fi

output.raw: $(vmatch_input_file)
	vmatch										\
		-q $<									\
		-showdesc 0								\
		-v										\
		$(vmatch_extra_parameters)				\
		$(vmatch_db)							\
		> $@

vmatch_clean:
	-rm -f output.gff
	-rm -f output.raw

