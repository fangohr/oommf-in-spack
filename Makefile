# Most targets below will checkout spack, then use the ~oommf/package.py~ file
# to build the package based on this file.

# not using spack, but Debian system tools to build OOMMF
oommf-native:
	docker build -f Dockerfile-without-spack -t oommf-native .
run-native:
	docker run -ti oommf-native


# Install oomm via spack. Using most recent spack version
oommf-spack:
	docker build -f Dockerfile -t oommf-spack --build-arg SPACK_VERSION=develop  .

run-spack:
	docker run --rm -ti oommf-spack 

# use particular versions of spack
spack-v0.18.1:
	docker build -f Dockerfile --build-arg SPACK_VERSION=v0.18.1 \
   -t spack-v0.18.1 .

spack-v0.18.0:
	docker build -f Dockerfile --build-arg SPACK_VERSION=v0.18.0 \
   -t spack-v0.18.0 .

run-spack-v0.18.1:
	docker run --rm -ti spack-v0.18.1 

builtin-oommf-from-latest-spack: 
	docker build -f Dockerfile-builtin-oommf-from-latest-spack --build-arg SPACK_VERSION=releases/latest \
   -t builtin-oommf-from-latest-spack-latest .

.PHONY: oommf-native run-native spack-v0.18.1 oommf-spack run-spack run-spack-v0.18.1  builtin-oommf-from-latest-spack 

