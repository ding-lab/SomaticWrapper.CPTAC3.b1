# Initialize configuration for StrelkaDemo
#
# This is optional and specific for running StrelkaDemo.  It is run from host computer. 
# * Create directory structure according to definitions in sw.config.sh
#   * DATAD_H IMAGED_H IMPORTD_H_EXPLICIT
# * Copy StrelkaDemo-specific reference, database, and sequence data to appropriate directories
# * Paths must be consistent with those defined in 3_make_config.sh

# Initialization here is similar to that in SomaticWrapper.workflow/somaticwrapper/image.setup/S_StrelkaDemoSetup/2_setup_strelka_demo.sh
# Difference is that data is not created here, and staging takes place outside of docker (using _H paths)

source sw.config.sh

# check that IMPORTD_H_EXPLICIT defined
if [ -z $IMPORTD_H_EXPLICIT ]; then
    >&2 echo IMPORTD_H_EXPLICIT not defined in configuration file sw.config.sh  Quitting.
    exit 1
fi

echo Making directories $DATAD_H $IMAGED_H $IMPORTD_H_EXPLICIT
# Make the principal staging directories
mkdir -p $DATAD_H
mkdir -p $IMAGED_H
mkdir -p $IMPORTD_H_EXPLICIT

# Copy example reference, sequence, and database data from ./StrelkaDemo.dat/ 
# Sequence data to $IMPORTD_H.  
>&2 echo Staging sequence data to $IMPORTD_H_EXPLICIT
cp StrelkaDemo.dat/*.{bam,bai} $IMPORTD_H_EXPLICIT

# Database and reference data to IMAGED_H
>&2 echo Staging database and reference data to $IMAGED_H
mkdir -p $IMAGED_H/A_Reference
cp StrelkaDemo.dat/*.{dict,fa,fai} $IMAGED_H/A_Reference
mkdir -p $IMAGED_H/B_Filter
cp StrelkaDemo.dat/*.{gz,tbi} $IMAGED_H/B_Filter


