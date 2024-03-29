cmake_minimum_required(VERSION 3.10)
project(example_cpp VERSION 0.0.1 LANGUAGES CXX)

# Let CMake paths to easily find our custom CMake modules
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/sanitizers)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/static-analysis)

include(cmake/macros.cmake)
include(cmake/compiler-config.cmake)

default_build_type("Release")
common_output_dirs()

# Conan package manager List of packages used by the project is container in
# conanfile.py
option(CONAN_AUTO_INSTALL "Let CMake call conan install automatically" ON)
if (CONAN_AUTO_INSTALL)
  set(CONAN_PROFILE
      "default"
      CACHE STRING "Conan profile to use during installation")
  include(cmake/conan-auto-install.cmake)
  conan_auto_install(${CONAN_PROFILE})
endif ()

# Setup conan targets
if (EXISTS ${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
  include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
  conan_basic_setup(TARGETS)
else ()
  message(
      FATAL_ERROR
      "
        Missing conanbuildinfo.cmake file in your build folder \"${CMAKE_BINARY_DIR}\".
        Please, configure with -DCONAN_PROFILE=<conan_profile>, if you use a profile different from 'default'."
  )
endif ()

# Include Address, Memory, Thread, and Undefined Behavior sanitizers support
# Switch on any of the following options when running cmake SANITIZE_ADDRESS,
# SANITIZE_MEMORY, SANITIZE_THREAD, SANITIZE_UNDEFINED
#
# Example: cmake -DSANITIZE_MEMORY=ON will enable memory sanitizer for all
# targets marked for sanitization
find_package(Sanitizers)

# Enable static analysis tools to find bugs and inefficiences in the code.
# Avaliable flags include: USE_CLANG_TIDY - assumes clang-tidy-6.0 is installed
# USE_CPPCHECK   - runs cppcheck on all targets
find_package(StaticAnalysis)

include_directories(include)

option(BUILD_SHARED_LIBS "Build using shared libraries" ON)
option(BUILD_DOCS "Build Doxygen documentation" OFF)
option(BUILD_EXAMPLE_CPP "Build Example CPP" ON)
option(BUILD_TESTS "Build Unit Tests" ON)

if (BUILD_DOCS)
  include(doxygen)
  enable_doxygen()
endif ()

message(STATUS "\n\n========= Build Options ===========")
message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")
build_optional(BUILD_EXAMPLE_CPP src)
build_optional(BUILD_TESTS test)
message(STATUS "\n\n-----------------------------------")

install(DIRECTORY include DESTINATION include)
