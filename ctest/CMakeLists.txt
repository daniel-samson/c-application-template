cmake_minimum_required(VERSION 3.15)

project(app C)

# Test Dependencies
include(FetchContent)
FetchContent_Declare(
        unity
        GIT_REPOSITORY https://github.com/ThrowTheSwitch/Unity.git
        GIT_TAG        cbcd08fa7de711053a3deec6339ee89cad5d2697 # release-2.6.0
)

FetchContent_MakeAvailable(unity)

# Test Binary
add_executable(test_app test_applib.c)
target_link_libraries(test_app LINK_PUBLIC unity)
target_link_libraries(test_app LINK_PUBLIC applib)


# Tests
add_test(NAME test_get_version COMMAND test_app)

