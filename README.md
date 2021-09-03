# oommf-in-spack

Support repository for getting the [OOMMF](https://math.nist.gov/oommf/) package into [Spack](http://spack.readthedocs.io).

## Status

![compile-oommf-in-debian](https://github.com/fangohr/oommf-in-spack/actions/workflows/native-debian-latest.yml/badge.svg)

![spack-develop-builds-oommf](https://github.com/fangohr/oommf-in-spack/actions/workflows/spack-develop.yml/badge.svg)

![spack-v0.16.2-builds-oommf](https://github.com/fangohr/oommf-in-spack/actions/workflows/spack-v0.16.2.yaml/badge.svg)

[![debian-compile-oommf-natively](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-compile-oommf-natively.yml/badge.svg)](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-compile-oommf-natively.yml)
[![debian-spack-develop](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-spack-develop.yml/badge.svg)](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-spack-develop.yml)
[![debian-spack-v0.16.2](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-spack-v0.16.2.yml/badge.svg)](https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-spack-v0.16.2.yml)
[![osx-spack-v0.16.1](https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-v0.16.1.yml/badge.svg)](https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-v0.16.1.yml)
[![osx-spack-develop](https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-develop.yml/badge.svg)](https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-develop.yml)


# Required commands

## Compilation of OOMMF

At the moment, this is under development, and we need two lines:

- get spack: `git clone https://github.com/fangohr/spack`
- checkout the right branch: `git checkout add-oommf`

Then activate spack:

- `source spack/share/spack/setup-env.sh`

The compile oommf (this could take some time)

- `spack install oommf`

Ideally, there are no errors.

## Additional tests

We can run some additional checks with these commands:

- `spack test run --alias oommftest oommf`

To see the results, use
- `spack test results -l oommftest`

## To use OOMMF after installation

1. Activate spack:

- `source spack/share/spack/setup-env.sh`

2. Load oommf

- `spack load oommf`

3. Use oommf

Now `oommf.tcl` should be in the path and can be used as usual.




