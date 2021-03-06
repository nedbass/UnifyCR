========================
Build & I/O Interception
========================

In this section, we describe how to build UnifyCR with I/O interception.

---------------------------
How to build UnifyCR
---------------------------

Download the latest UnifyCR release from the `Releases
<https://github.com/LLNL/UnifyCR/releases>`_ page. UnifyCR requires MPI,
LevelDB, and GOTCHA.

**Building with Spack**
***************************

To install leveldb and gotcha and set up your build environment, we recommend
using the `Spack package manager <https://github.com/spack/spack>`_. For example,
the following commands will build and install leveldb and gotcha using Spack and
configure your environment so UnifyCR can find the libraries and headers it needs:

.. code-block:: Bash

	$ git clone https://github.com/spack/spack
	$ . spack/share/spack/setup-env.sh
	$ spack install leveldb
	$ spack install gotcha
	$ spack install environment-modules
	$ spack load environment-modules
	$ source <(spack module loads gotcha leveldb)

Then to build UnifyCR:

.. code-block:: Bash

	$ ./configure --prefix=/path/to/install --enable-debug
	$ make
	$ make install

**Building without Spack**
***************************

For users who cannot use Spack, you may fetch the latest release of
`GOTCHA <https://github.com/LLNL/GOTCHA>`_

Then to build with UnifyCR:

.. code-block:: Bash

	$ ./configure --prefix=/path/to/install --with-gotcha=/path/to/gotcha --enable-debug
	$ make
	$ make install

.. note::

	You may need to add the following to your configure line if it is not in
	your default path on a linux machine:

	``--with-numa=$PATH_TO_NUMA``

	This is needed to enable NUMA-aware memory allocation on Linux machines. Set the
	NUMA policy at runtime with ``UNIFYCR_NUMA_POLICY = local | interleaved``, or set
	NUMA nodes explicitly with ``UNIFYCR_USE_NUMA_BANK = <node no.>``)

---------------------------
I/O Interception
---------------------------

POSIX calls can be intercepted via the methods described below.

Statically
**************

Steps for static linking using --wrap:

To intercept I/O calls using a static link, you must add flags to your link
line. UnifyCR installs a unifycr-config script that returns those flags, e.g.,

.. code-block:: Bash

	$ mpicc -o test_write \
		  `<unifycr>/bin/unifycr-config --pre-ld-flags` \
		  test_write.c \
		  `<unifycr>/bin/unifycr-config --post-ld-flags`

Dynamically
**************

Steps for dynamic linking using gotcha:

To intercept I/O calls using gotcha, use the following syntax to link an
application.

.. code-block:: Bash

	$ mpicc -o test_write test_write.c \
		-I<unifycr>/include -L<unifycy>/lib -lunifycr_gotcha \
		-L<gotcha>/lib64 -lgotcha
