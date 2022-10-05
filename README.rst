oommf-in-spack
==============

Support repository for getting the
`OOMMF <https://math.nist.gov/oommf/>`__ package into
`Spack <http://spack.readthedocs.io>`__.

Mostly aimed for maintainers of the OOMMF package in spack: to test
changes to the
`oommf/spack.py <https://raw.githubusercontent.com/spack/spack/develop/var/spack/repos/builtin/packages/oommf/package.py>`__
file before request merges in spack upstream.

There is a related effort to run some tests on the OOMMF package in
spack for older versions of spack at
https://github.com/fangohr/spack-ci-oommf .

Status
------

Compile OOMMF in Debian (without spack, just for reference):

|native|

Compile OOMMF on (Debian) Linux with spack using the
`oommf/package.py <oommf/package.py>`__ file in this repository:

|spack-latest-release|

|spack-develop|

Required commands to compile OOMMF with Spack
=============================================

Compilation of OOMMF
--------------------

At the moment, this is under development, and we need three lines

1. install spack as `described
   here <https://spack.readthedocs.io/en/latest/getting_started.html#installation>`__:

   ``git clone -c feature.manyFiles=true https://github.com/spack/spack.git ~/spack``

2. cd into spack directory with: ``cd ~/spack``

3. activate spack with ``source share/spack/setup-env.sh``

4. Then compile oommf (this could take some time):

``spack install oommf``

Ideally, there are no errors.

Additional tests
----------------

We can run some additional checks with these commands

-  ``spack test run --alias oommftest oommf``

To see the results, use - ``spack test results -l oommftest``

To use OOMMF after installation
-------------------------------

1. Activate spack (adjust the path below if not inside spack directory)

-  ``source share/spack/setup-env.sh``

2. Load oommf

-  ``spack load oommf``

3. Use oommf

Now ``oommf.tcl`` should be in the path and can be used as usual.

Experimental work in progress (OSX)
-----------------------------------

More experimental are the following (and done in separate branches):

1. Compile OOMMF on OSX with Spack, see ``osx`` branch at
   https://github.com/fangohr/oommf-in-spack/tree/osx.

   |osx-spack-v0.18.1-plus-epsilon| |osx-spack-v0.16.3|

2. Compile OOMMF on Debian and OSX, using Spack’s ``develop`` branch,
   see https://github.com/fangohr/oommf-in-spack/tree/spack-develop.

   |debian-spack-develop| |osx-spack-develop|

.. |native| image:: https://github.com/fangohr/oommf-in-spack/actions/workflows/native.yml/badge.svg
   :target: https://github.com/fangohr/oommf-in-spack/actions/workflows/native.yml
.. |spack-latest-release| image:: https://github.com/fangohr/oommf-in-spack/actions/workflows/spack-latest-release.yml/badge.svg
   :target: https://github.com/fangohr/oommf-in-spack/actions/workflows/spack-latest-release.yml
.. |spack-develop| image:: https://github.com/fangohr/oommf-in-spack/actions/workflows/spack-develop.yml/badge.svg
   :target: https://github.com/fangohr/oommf-in-spack/actions/workflows/spack-develop.yml
.. |osx-spack-v0.18.1-plus-epsilon| image:: https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-v0.18.1.yml/badge.svg?branch=osx
   :target: https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-v0.18.1.yml
.. |osx-spack-v0.16.3| image:: https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-v0.16.3.yml/badge.svg?branch=osx
   :target: https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-v0.16.3.yml
.. |debian-spack-develop| image:: https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-spack-develop.yml/badge.svg?branch=spack-develop
   :target: https://github.com/fangohr/oommf-in-spack/actions/workflows/debian-spack-develop.yml
.. |osx-spack-develop| image:: https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-develop.yml/badge.svg?branch=spack-develop
   :target: https://github.com/fangohr/oommf-in-spack/actions/workflows/osx-spack-develop.yml
