#!/bin/sh

test_description="Test system call interfaces through UnifycR"

. ./sharness.sh

tests_dir=$(dirname "$0")

test_expect_success "Start unifycrd" "
	$tests_dir/unifycrd_start.sh
"



test_done
