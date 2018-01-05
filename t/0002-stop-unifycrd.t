#!/bin/bash

test_description="Shut down unifycrd"

. $(dirname $0)/sharness.sh

test_expect_success "unifycrd still running" 'process_is_running unifycrd 2'

test_expect_success "Stop unifycrd" 'killall unifycrd'

test_done
