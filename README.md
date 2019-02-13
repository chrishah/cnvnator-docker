# cnvnator-docker
Ubuntu 18.04 with full install of CNVnator

The image contains a full install of [CNVnator](https://github.com/abyzovlab/CNVnator) (find the paper [here](https://genome.cshlp.org/content/21/6/974.long)), including all necessary dependencies. I am not part of the CNVnator team - I just made this image.

In detail, the image is set up with:
 - Ubuntu 18.04
 - [ROOT](https://root.cern.ch/)
 - samtools 1.9
 - CNVnator v0.3.3

Note that, since the image contains the full [ROOT](https://root.cern.ch/) package it is rather big, so initial download will take a while.

To run [CNVnator](https://github.com/abyzovlab/CNVnator) you can do the following (this will mount the directory `/home/working` of the container to the current working directory on your local machine, and allow you to access files in this directory and any sub-directories):
```bash
$ docker run --rm -v $(pwd):/home/working -w /home/working chrishah/cnvnator-docker:v0.3.3 cnvnator
```

You can also enter the container environment and work within it. All executables should be in the `PATH`.
```bash
$ docker run -it --rm -v $(pwd):/home/working -w /home/working chrishah/cnvnator-docker:v0.3.3 /bin/bash
```

