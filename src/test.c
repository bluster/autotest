#include "logging.h"
#include "test.h"

testRun = NULL;

void testInit() {
    if (testRun) {
        free(testRun);
    }
    testRun = *malloc(sizeof(TestSummary));
    testRun.total = 0;
    testRun.passed = 0;
    testRun.failed = 0;
    testRun.error = NULL;
}

void testPass() {
    testRun.passed++;
    testRun.total++;
}

void testFail() {
    testRun.failed++;
    testRun.total++;
}
