add_library(boost_graph boost_graph.cpp)

target_link_libraries(boost_graph PUBLIC CONAN_PKG::boost)

install(TARGETS boost_graph ${DEFAULT_DESTINATIONS})