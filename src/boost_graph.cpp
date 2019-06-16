/**
 * @author - Ajai V George
 * @file - boost_graph.cpp
 * @created_on - 15/06/19
 * @project - example_cpp
 *
 * @brief -
 *
 */

#include <example-cpp/boost_graph.hpp>

namespace examplecpp {

template<typename Vertex, typename Edge>
Vertex BoostGraph<Vertex, Edge>::add_vertex() {
  return boost::add_vertex(m_adj_list);
}

template<typename Vertex, typename Edge>
void BoostGraph<Vertex, Edge>::add_edge(const Vertex &source, const Vertex &destination) {
  boost::add_edge(source, destination, m_adj_list);
}

template class BoostGraph<boost::adjacency_list<>::vertex_descriptor, boost::adjacency_list<>::edge_descriptor>;

} // namespace examplecpp
