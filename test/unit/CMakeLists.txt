project_add_test(test_boost_graph test_boost_graph.cpp)

target_link_libraries(test_boost_graph PRIVATE CONAN_PKG::gtest boost_graph)
