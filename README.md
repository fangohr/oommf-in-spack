# oommf-in-spack

Support repository for getting the [OOMMF](https://math.nist.gov/oommf/) package into [Spack](http://spack.readthedocs.io).

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




