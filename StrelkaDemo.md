# Strelka Demo: A small test dataset for SomaticWrapper

RunName: TestCase.WXS

TODO:

* Describe how to create StrelkaDemo data.  This involves running scripts in somaticwrapper/image.init.  This should be launched
from here in a docker container

`IMAGED_H=/Users/mwyczalk/Data/SomaticWrapper/data`
`DATAD_H=/Users/mwyczalk/Data/SomaticWrapper/data/data`
`IMPORTD_H` is determined automatically, but will be `/Users/mwyczalk/Data/SomaticWrapper/data/S_StrelkaTestData.

## BAMs
Details of how they were generated: `/Users/mwyczalk/Data/SomaticWrapper/SomaticWrapper.CPTAC3.b1/SomaticWrapper.workflow/somaticwrapper/image.setup/S_StrelkaDemoSetup/2_setup_strelka_demo.sh`.  Created in image.init


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
