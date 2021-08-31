# not using spack, but Debian system tools to build OOMMF
oommf-native:
	docker build -f Dockerfile-without-spack -t oommf-native .
run-native:
	docker run -ti oommf-native


# Install oomm via spack. Using most recent spack version
oommf-spack:
	docker build -f Dockerfile -t oommf-spack --build-arg SPACK_VERSION=develop \
  --build-arg EXTRA_PACKAGES=tk-dev .

# Install oomm via spack. Using most recent spack version
build-which-package:
	@# create two list of packages
	docker build -m 32g -f Dockerfile-which -t oommf-spack-which --build-arg SPACK_VERSION=v0.16.2 \
  --build-arg EXTRA_PACKAGES=tk-dev .
	@#sh get-files-from-container.sh
	@# which are new?
	@#/home/fangohr/.pyenv/versions/anaconda3-2020.11/bin/python extract_new_packages.py
	@#/home/fangohr/.pyenv/versions/anaconda3-2020.11/bin/python extract_new_packages.py > new_packages_with_x.txt

run-spack:
	docker run --rm -ti oommf-spack bash

# use particular versions of spack
oommf-spack-v0.16.2:
	docker build -f Dockerfile --build-arg SPACK_VERSION=v0.16.2 \
  --build-arg EXTRA_PACKAGES=tk-dev -t oommf-spack-v0.16.2 .

oommf-spack-v0.16.1:
	docker build -f Dockerfile --build-arg SPACK_VERSION=v0.16.1 \
  --build-arg EXTRA_PACKAGES=tk-dev . -t oommf-spack-v0.16.1 .

.PHONY: oommf-spack-v0.16.1 oommf-spack-v0.16.2 oommf-spack run-spack 
