#include "app/app.h"
#include "unity.h"

void setUp(void) {}

void tearDown(void) {}

void test_get_version(void)
{
    char *actual = get_version();
    TEST_ASSERT_EQUAL_STRING("0.0.1", actual);
}

int main(void)
{
    UNITY_BEGIN();
    RUN_TEST(test_get_version);
    return UNITY_END();
}