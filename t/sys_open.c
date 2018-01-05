#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <getopt.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <mpi.h>
#include <sys/stat.h>

static void usage(FILE *file, int status)
{
    fprintf(file, "Usage: %s [OPTION]... PATH FLAGS\n"
        "Open file.\n"
        "\n"
        "  -c, --close\n"
        "  -h, --help\n"
        "  -m, --mode=MODE\n"
        "  -u, --ucrmount=PATH\n"
        ,
        program_invocation_short_name);
    exit(status);
}

int main(int argc, char *argv[])
{
    const char *path;
    char *s;
    const char *ucrmount = NULL;
    mode_t mode = 0666;
    int close_file = 0;
    int rank;
    int rank_num;
    int flags = 0;
    int o_read = 0;
    int o_write = 0;
    int fd;
    int c;

    struct option opts[] = {
        { "close", 0, NULL, 'c' },
        { "help", 0, NULL, 'h' },
        { "mode", 1, NULL, 'm' },
        { "ucrmount", 1, NULL, 'u' },
        { NULL }
    };

    while ((c = getopt_long(argc, argv, "chm:ps:u:", opts, 0)) != -1) {
        switch (c) {
        case 'c':
            close_file = 1;
            break;
        case 'h':
            usage(stdout, EXIT_SUCCESS);
            break;
        case 'm':
            mode = strtol(optarg, NULL, 0);
            break;
        case 'u':
            ucrmount = optarg;
            break;
        case '?':
            fprintf(stderr, "Try '%s --help' for more information\n",
                    program_invocation_short_name);
            exit(EXIT_FAILURE);
        }
    }

    if (ucrmount == NULL) {
        fprintf(stderr, "Missing required option --ucrmount\n");
        usage(stderr, EXIT_FAILURE);
    }

    if (argc - optind < 2)
        usage(stderr, EXIT_FAILURE);

    path = argv[optind];
    s = argv[optind + 1];

    for (; *s != '\0'; s++) {
        switch (*s) {
        case 'a':
            flags |= O_APPEND;
            break;
        case 'c':
            flags |= O_CREAT;
            break;
        case 'd':
            flags |= O_DIRECT;
            break;
        case 'D':
            flags |= O_DIRECTORY;
            break;
        case 'e':
            flags |= O_EXCL;
            break;
        case 'r':
            o_read = 1;
            break;
        case 's':
            flags |= O_SYNC;
            break;
        case 't':
            flags |= O_TRUNC;
            break;
        case 'w':
            o_write = 1;
            break;
        }
    }

    if (o_read && o_write)
        flags |= O_RDWR;

    if (o_read && !o_write)
        flags |= O_RDONLY;

    if (!o_read && o_write)
        flags |= O_WRONLY;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &rank_num);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    if (unifycr_mount(ucrmount, rank, rank_num, 0, 1) != 0) {
        fprintf(stderr, "cannot unifycr_mount '%s': %s\n",
                ucrmount, strerror(errno));
        exit(EXIT_FAILURE);
    }
    fd = open(path, flags, mode);
    if (fd < 0) {
        fprintf(stderr, "cannot open '%s' with flags %d, mode %04o: %m: %s\n",
                path, flags, mode, strerror(errno));
        exit(EXIT_FAILURE);
    }
    if (close_file != 0 && close(fd) < 0) {
        fprintf(stderr, "cannot close '%s': %s\n",
                path, strerror(errno));
        exit(EXIT_FAILURE);
    }
    MPI_Finalize();

    return 0;
}
