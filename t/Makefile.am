SUBDIRS = libtap

TEST_EXTENSIONS = .t

TESTS = \
	0001-start-unifycrd.t \
	sys/open.t \
	unifycr_unmount.t \
	0002-stop-unifycrd.t

check_SCRIPTS = \
	0001-start-unifycrd.t \
	0002-stop-unifycrd.t

EXTRA_DIST = \
	$(check_SCRIPTS) \
	sharness.d \
	sharness.sh \
	$(T)

AM_CFLAGS = -Wall

clean-local:
	rm -fr trash-directory.* test-results *.log

libexec_PROGRAMS = \
	sys/open.t \
	unifycr_unmount.t

test_ldadd = \
	$(top_builddir)/t/libtap/libtap.la \
	$(top_builddir)/client/src/libunifycr_gotcha.la

test_cppflags = \
	-I$(top_srcdir) \
	-D_GNU_SOURCE \
	$(AM_CPPFLAGS)

sys_open_t_SOURCES = sys/open.c
sys_open_t_CPPFLAGS = $(test_cppflags)
sys_open_t_LDADD = $(test_ldadd)
sys_open_t_LDFLAGS = $(AM_LDFLAGS)

unifycr_unmount_t_SOURCES = unifycr_unmount.c
unifycr_unmount_t_CPPFLAGS = $(test_cppflags)
unifycr_unmount_t_LDADD = $(test_ldadd)
unifycr_unmount_t_LDFLAGS = $(AM_LDFLAGS)
