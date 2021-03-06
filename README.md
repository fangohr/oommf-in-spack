# oommf-in-spack

Support repository for getting the [OOMMF](https://math.nist.gov/oommf/) package into [Spack](http://spack.readthedocs.io).

## Status

Compile OOMMF in Debian (without spack):

[![debian-compile-oommf-natively](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-compile-oommf-natively.yml/badge.svg)](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-compile-oommf-natively.yml)

Compile OOMMF on (Debian) Linux with spack:

[![debian-spack-v0.16.2](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-spack-v0.16.2.yml/badge.svg)](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-spack-v0.16.2.yml)

[![debian-spack-v0.16.3](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-spack-v0.16.3.yml/badge.svg)](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-spack-v0.16.3.yml)


More experimental are the following (and done in separate branches):

1. Compile OOMMF on OSX with Spack, see `osx` branch at see https://github.com/fangohr/oommf-in-spack/tree/osx.

   [![osx-spack-v0.16.2-plus-epsilon](https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-v0.16.2.yml/badge.svg?branch=osx)](https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-v0.16.2.yml)
   [![osx-spack-v0.16.3](https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-v0.16.3.yml/badge.svg?branch=osx)](https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-v0.16.3.yml)

2. Compile OOMMF on Debian and OSX, using Spack's `develop` branch, see https://github.com/fangohr/oommf-in-spack/tree/spack-develop.

   [![debian-spack-develop](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-spack-develop.yml/badge.svg?branch=spack-develop)](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-spack-develop.yml)
   [![osx-spack-develop](https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-develop.yml/badge.svg?branch=spack-develop)](https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-develop.yml)



# Required commands to compile OOMMF with Spack

## Compilation of OOMMF

At the moment, this is under development, and we need three lines

- get spack: `git clone https://github.com/fangohr/spack`
- go into spack directory `cd spack`
- checkout the right branch: `git checkout new-package-oommf`

Then activate spack

- `source share/spack/setup-env.sh`

Then compile oommf (this could take some time)

- `spack install oommf`

Ideally, there are no errors.

## Additional tests

We can run some additional checks with these commands

- `spack test run --alias oommftest oommf`

To see the results, use
- `spack test results -l oommftest`

## To use OOMMF after installation

1. Activate spack (adjust the path below if not inside spack directory)

- `source share/spack/setup-env.sh`

2. Load oommf

- `spack load oommf`

3. Use oommf

Now `oommf.tcl` should be in the path and can be used as usual.




