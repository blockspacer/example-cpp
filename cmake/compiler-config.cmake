set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS NO) # use -std=c++17 instead of -std=gnu++17
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set_property(GLOBAL PROPERTY GLOBAL_DEPENDS_NO_CYCLES 1)

# Reference: https://github.com/lefticus/cppbestpractices/blob/master/02-Use_the
# _Tools_Available.md#gcc--clang GCC all versions, Clang all versions
add_compile_options(-Wall
    -Wall
    -Werror # treat all warnings as errors
    -Wextra # reasonable and standard
    -Wshadow # warn the user if a variable declaration shadows one from a parent context
    -Wnon-virtual-dtor # warn the user if a class with virtual functions has a non-virtual destructor
    -Wold-style-cast # warn for c-style casts
    -Wcast-align # warn for potential performance problem casts
    -Wunused # warn on anything being unused
    -Woverloaded-virtual # warn if you overload (not override) a virtual function
    -pedantic
    -Wpedantic # warn if non-standard C++ is used
    -Wconversion # warn on type conversions that may lose data
    -Wsign-conversion # warn on sign conversions
    -Wnull-dereference # warn if a null dereference is detected
    -Wdouble-promotion # warn if float is implicit promoted to double
    -Wformat=2 # warn on security issues around functions that format output (ie printf)
    -Werror
    -fstack-protector-all
    -D_GLIBCXX_ASSERTIONS
    -pipe)

# Add fortify source if we have specified to enable it. This is an option so we
# can check it against sanitizers which it conflicts with. Supported in both gcc
# and clang.
option(COMPILER_FORTIFY_SOURCE "Enable the fortify source option" OFF)
if (COMPILER_FORTIFY_SOURCE)
  add_compile_options(-D_FORTIFY_SOURCE=2)
endif ()

# This allows colored output and error highlighting when building from command -
# line, for both
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  add_compile_options(-fdiagnostics-color=always)
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  add_compile_options(-fcolor-diagnostics)
endif ()
