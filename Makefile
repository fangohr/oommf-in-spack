# Most targets below will checkout spack, then use the ~spack/package.py~ file
# to build the package based on this file.

# Install oomm via spack. Using most recent spack version
spack-develop:
	docker build -f Dockerfile -t spack-develop --build-arg SPACK_VERSION=develop  .

spack-develop-run:
	docker run --rm -ti spack-develop 

# use particular versions of spack
spack-latest:
	docker build -f Dockerfile --build-arg SPACK_VERSION=releases/latest -t spack-latest .


# not using spack, but Debian system tools to build OOMMF
native:
	docker build -f Dockerfile-without-spack -t oommf-native .

native-run:
	docker run -ti oommf-native

# tools to make comparison with upstream package file easier

diff:
	@echo "Compare (diff) spack/package.py with current package.py from spack develop"
	wget --output-document=spack/package-upstream.py https://raw.githubusercontent.com/spack/spack/develop/var/spack/repos/builtin/packages/oommf/package.py
	diff spack/package-upstream.py spack/package.py || true


.PHONY: native native-run spack-develop spack-develop-run spack-latest diff

