cmake_minimum_required(VERSION 3.16)

list(APPEND CMAKE_PREFIX_PATH "C:/msys64/mingw64")

find_package(Qt6 REQUIRED Core)
find_package(Catch2 CONFIG REQUIRED)

add_executable(test_sorting
    test_sorting.cpp
    ../src/BubbleSort.cpp
    ../src/QuickSort.cpp
    ../src/MergeSort.cpp
    ../src/SortingController.cpp
    ../src/ArrayModel.cpp
)

target_link_libraries(test_sorting PRIVATE
    Catch2::Catch2WithMain
    Qt6::Core
)

target_include_directories(test_sorting PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/..
    ${CMAKE_CURRENT_SOURCE_DIR}/../src
)

set_target_properties(test_sorting PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
)
