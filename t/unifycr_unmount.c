#include <stdio.h>
#include <mpi.h>
#include "t/libtap/tap.h"

int main (int argc, char *argv[])
{
    int rank_num;
    int rank;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &rank_num);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    ok (unifycr_unmount() == 0, "unifycr_unmount succeeds");

    MPI_Finalize();
    done_testing();
    return (0);
}

/*
 * vi:tabstop=4 shiftwidth=4 expandtab
 */
