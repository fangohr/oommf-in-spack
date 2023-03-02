# Most targets below will checkout spack, then use the ~spack/package.py~ file
# to build the package based on this file.

# Install oomm via spack. Using most recent spack version
spack-develop:
	docker build -f Dockerfile -t spack-develop --build-arg SPACK_VERSION=develop --build-arg OOMMF1_VERSION=oommf@20b0_20220930-vanilla --build-arg OOMMF2_VERSION=oommf@20a3_20210930 .

spack-develop-run:
	docker run --rm -ti spack-develop 

# use particular versions of spack
spack-latest:
	docker build -f Dockerfile --build-arg SPACK_VERSION=releases/latest -t spack-latest --build-arg OOMMF1_VERSION=oommf@20a3_20210930 --build-arg OOMMF2_VERSION=oommf@20a3_20210930-vanilla .


# not using spack, but Debian system tools to build OOMMF
native:
	docker build -f Dockerfile-without-spack -t oommf-native --build-arg OOMMF_DOWNLOAD_URL=https://math.nist.gov/oommf/dist/oommf20a3_20210930.tar.gz .

native-run:
	docker run -ti oommf-native

# tools to make comparison with upstream package file easier

diff:
	@echo "Compare (diff) spack/package.py with current package.py from spack develop"
	wget --output-document=spack/package-upstream.py https://raw.githubusercontent.com/spack/spack/develop/var/spack/repos/builtin/packages/oommf/package.py
	diff spack/package-upstream.py spack/package.py || true


.PHONY: native native-run spack-develop spack-develop-run spack-latest diff

