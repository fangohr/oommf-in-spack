# not using spack, but Debian system tools to build OOMMF
oommf-native:
	docker build -f Dockerfile-without-spack -t oommf-native .

# Install compiler, tcl and tk via spack, and build OOMMF
oommf-spack:
	docker build -f Dockerfile -t oommf-spack .


run-native:
	docker run -ti oommf-native

run-spack:
	docker run -ti oommf-spack
