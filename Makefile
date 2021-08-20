# not using spack, but Debian system tools to build OOMMF
oommf-native:
	docker build -f Dockerfile-without-spack -t oommf-native .
run-native:
	docker run -ti oommf-native


# Install oomm via spack. Using most recent spack version
oommf-spack:
	docker build -f Dockerfile -t oommf-spack .

run-spack:
	docker run --rm -ti oommf-spack bash

# use particular versions of spack
Dockerfile-spack-v0.16.0:
	docker build -f Dockerfile-spack-v0.16.0  -t oommf-spack-v0.16.0 .

Dockerfile-spack-v0.16.1:
	docker build -f Dockerfile-spack-v0.16.1  -t oommf-spack-v0.16.1 .


.PHONY: Dockerfile-spack-v0.16.1 Dockerfile-spack-v0.16.0 oommf-spack run-spack
