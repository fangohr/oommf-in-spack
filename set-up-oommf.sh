#!/usr/bin/env bash

source spack/share/spack/setup-env.sh
spack env create oommf
spack env activate oommf
spack install oommf
