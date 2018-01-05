#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <mpi.h>
#include <linux/limits.h>
#include "t/libtap/tap.h"

int main (int argc, char *argv[])
{
    int rank_num;
    int rank;
    char path[PATH_MAX];
    int fd;
    int mode;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &rank_num);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    ok (unifycr_mount(P_tmpdir, rank, rank_num, 0, 1) == 0,
        "unifycr_mount succeeds");

    snprintf(path, sizeof(path), "%s/open_test_1", P_tmpdir);

    mode = 0600;
    errno = 0;
    fd = open(path, O_CREAT|O_EXCL, mode);
    ok (fd >= 0, "open %s with mode %o flags O_CREAT|O_EXCL: %s",
        path, mode, strerror(errno));
    errno = 0;
    ok (close(fd) == 0, "close %s: %s", path, strerror(errno));

    errno = 0;
    fd = open(path, O_CREAT|O_EXCL, mode);
    ok (fd < 0 && errno == EEXIST,
        "open existing file %s O_CREAT|O_EXCL fails: %s",
        path, strerror(errno));

    errno = 0;
    fd = open(path, O_RDWR, O_RDWR);
    ok (fd < 0 && errno == EEXIST,
        "open existing file %s O_RDWR succeeds: %s", path, strerror(errno));
    errno = 0;
    ok (close(fd) == 0, "close %s: %s", path, strerror(errno));

    MPI_Finalize();

    done_testing();
    return (0);
}

/*
 * vi:tabstop=4 shiftwidth=4 expandtab
 */
