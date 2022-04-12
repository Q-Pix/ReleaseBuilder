# ReleaseBuilder
One stop shop for Marley, Q_PIX_GEANT4, Q_PIX_RTD, and qpixar



## Dependencies
The 4 packages that will be built by ReleaseBuilder will require the following dependencies
* ROOT 6.18/04+
* Geant4 10.6+ (but Geant4 11 has a breaking change, so don't use it)

* cmake 3.15.5+
* make 3.81+
* Python 3.7.5+
* numpy 1.18.1+
* matplotlib 3.1.3+
* uproot 3.11.3+

ReleaseBuilder will check that the versions of ROOT and Geant4 are compatible, however, it will not check the others. It is your responsibility to set up the environment before using ReleaseBuilder



## How to use
ReleaseBuilder will create marley, qpixg4, qpixrtd, and qpixar clones in the same directory in which its repository is located. In order to build the release,

```
$ cd <path to desired directory>
$ git clone git@github.com:q-pix/ReleaseBuilder.git
$ cd ReleaseBuilder
$ ./buildRelease
```
