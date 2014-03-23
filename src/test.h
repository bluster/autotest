#include <stdio.h>
#include "logging.h"

#ifndef __test_h__
#define __test_h__

#include <stdio.h>
#include <stdlib.h>

#define test_start() log_info("Automated Test Runner:\n");
#define test_run(test) log_info("\n----- %s", " " #test); \
    test(); if (testRun.error) {testFail();} else {testPass();}
#define test_end() {log_info("-----\n"); \
    log_info("Tests Run: %d\n", testRun.total); \
    log_info("Tests Passed: %d\n", testRun.passed); \
    log_info("Tests Failed: %d\n", testRun.failed);}
#define test_assert(B, M) if (!B) {log_error(M); testRun.error = M; test_end();}

typedef struct TestSummary {
    int total;
    int passed;
    int failed;
    char *error;
} TestSummary;

TestSummary testRun;

void testInit();
void testPass();
void testFail();

#endif
