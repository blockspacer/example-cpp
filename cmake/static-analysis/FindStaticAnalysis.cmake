option(USE_CLANG_TIDY "Use clang-tidy for static analysis" ON)
if(USE_CLANG_TIDY)
  # Enable clang-tidy static analysis
  include(cmake/static-analysis/clang-tidy.cmake)
endif()

option(USE_CODE_COVERAGE "Use code-coverage for static analysis" OFF)
if(USE_CODE_COVERAGE)
  # Enable code-coverage static analysis
  include(cmake/static-analysis/code-coverage.cmake)
  append_coverage_compiler_flags()
  setup_target_for_coverage(NAME
      coverage
      EXECUTABLE
      ctest
      --verbose)
endif()

option(USE_IWYU "Use include-what-you-use to find unnecessary includes" OFF)
if(USE_IWYU)
  # Enable include-what-you-use
  find_program(IWYU_COMMAND
      NAMES iwyu include-what-you-use
      DOC "Path to iwyu executable")
  if(NOT IWYU_COMMAND)
    message(FATAL_ERROR "IWYU executable is not found.")
  else()
    message(STATUS "IWYU: found ${IWYU_COMMAND}")
    set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE "${IWYU_COMMAND}")
  endif()
endif()

option(USE_LWYU "Use link-what-you-use to find unused linking targets" ON)
if(USE_LWYU)
  set(CMAKE_LINK_WHAT_YOU_USE TRUE)
endif()
