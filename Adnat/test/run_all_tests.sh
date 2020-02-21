#!/usr/bin/env bash

function run_tests () {
    echo "========== Running ${1^^} tests ========="
    echo
    for test_file in $1/*
    do
        echo "Running test: $test_file"
        echo ">> ruby -Itest -W0 $test_file"
        ruby -Itest -W0 $test_file > test_output/${test_file##*/}.out
        tail -n 2 test_output/${test_file##*/}.out
        echo "Full output in: test_output/${test_file##*/}.out"
        echo
    done
}

mkdir -p test_output
run_tests models
run_tests controllers
run_tests integration
