# Strelka Demo: A small test dataset for SomaticWrapper

To demonstrate the operation of SomaticWrapper and to help with development,
we distribute it with a small test dataset which can be executed quickly on
a personal computer.  The initialization and use of this test dataset, called`StrelkaDemo`,
is described here.  Note that `StrelkaDemo` is named so because the test dataset is borrowed from the Strelka distribution, and
has nothing to do with the algorithms used.

For the StrelkaDemo example, the following paths are assumed
```
RunName: StrelkaDemo.WXS
/import: ~/Data/SomaticWrapper/import
/image: ~/Data/SomaticWrapper/image
/data: ~/Data/SomaticWrapper/data
```

## Initialization

### Image Data

Image data consists of data that all containers use and which needs to be generated just once per system.  Image data
used by SomaticWrapper includes,

* Reference
* DBsnp filter data
* VEP data and other genome map data

Image data is stored in the host `IMAGED_H` directory, which maps to `/image`
on the container.  It is downloaded, generated, and installed by scripts in
`SomaticWrapper.workflow/somaticwrapper/image.data`
([details])(https://github.com/ding-lab/somaticwrapper/blob/docker/image.setup/README.md).  
These data are also included with this distribution, and the script `0_initialize_StrelkaDemo.sh` stages them
from the host machine.


### Image Data - StrelkaDemo

Initialization scripts specific to the StrelkaDemo are in the `SomaticWrapper.workflow/somaticwrapper/image.data/S_StrelkaDemo`
directory.  These need to be executed from the docker container.

1. mkdir ~/Data/SomaticWrapper



```
cd SomaticWrapper.workflow/somaticwrapper/image.data/S_StrelkaDemoSetup
bash 1_download_data.sh
bash 2_setup_strelka_demo.sh
```

Scripts to generate (via download and processing) BAMs for the StrelkaDemo also contained here.

#### Generate StrelkaDemo image data

Start SomaticWrapper container in bash mode, and run scripts in `SomaticWrapper.workflow/somaticwrapper/image.data`.



TODO:

* Describe how to create StrelkaDemo data.  This involves running scripts in somaticwrapper/image.init.  This should be launched
from here in a docker container

`IMAGED_H=/Users/mwyczalk/Data/SomaticWrapper/data`
`DATAD_H=/Users/mwyczalk/Data/SomaticWrapper/data/data`
`IMPORTD_H` is determined automatically, but will be `/Users/mwyczalk/Data/SomaticWrapper/data/S_StrelkaTestData.

## BAMs
Details of how they were generated: `/Users/mwyczalk/Data/SomaticWrapper/SomaticWrapper.CPTAC3.b1/SomaticWrapper.workflow/somaticwrapper/image.setup/S_StrelkaDemoSetup/2_setup_strelka_demo.sh`.  Created in image.init

Tumor/normal BAMs
Details: /Users/mwyczalk/Data/SomaticWrapper/SomaticWrapper.CPTAC3.b1/SomaticWrapper.workflow/somaticwrapper/image.setup/S_StrelkaDemoSetup/2_setup_strelka_demo.sh
originals in /Users/mwyczalk/Data/SomaticWrapper/local/image.data/S_StrelkaTestData
remapped chromosomes (to allow for VEP annotation) /Users/mwyczalk/Data/SomaticWrapper/local/data/SWtest/[SWtest.N.bam SWtest.T.bam]


Paths on Epazote:
```
tumor: /Users/mwyczalk/Data/SomaticWrapper/data/S_StrelkaTestData/NA12891_demo20.bam
normal: /Users/mwyczalk/Data/SomaticWrapper/data/S_StrelkaTestData/NA12892_demo20.bam
reference_fasta = /Users/mwyczalk/Data/SomaticWrapper/data/A_Reference/demo20.fa
reference_dict = /Users/mwyczalk/Data/SomaticWrapper/data/A_Reference/demo20.dict
```



## DBSnp filter
Custom filter for this sample.  Created in image.init

/Users/mwyczalk/Data/SomaticWrapper/local/image.data/B_Filter/dbsnp-demo.noCOSMIC.vcf.gz
    dbsnp_db=/image/B_Filter/dbsnp-demo.noCOSMIC.vcf.gz
