/**
 * @author - Ajai V George
 * @file - boost_graph.hpp
 * @created_on - 15/06/19
 * @project - example_cpp
 *
 * @brief -
 *
 */

#ifndef EXAMPLE_CPP_INCLUDE_BOOST_GRAPH_HPP_
#define EXAMPLE_CPP_INCLUDE_BOOST_GRAPH_HPP_

#include <example-cpp/graph.hpp>

#include <boost/graph/adjacency_list.hpp>
#include <boost/graph/dijkstra_shortest_paths.hpp>

namespace examplecpp {

template<typename Vertex, typename Edge>
class BoostGraph : public Graph<Vertex, Edge> {
 public:
  BoostGraph() = default;
  Vertex add_vertex() override;
  void add_edge(const Vertex &source, const Vertex &destination) override;

 private:
  boost::adjacency_list<> m_adj_list{};
};

extern template
class BoostGraph<boost::adjacency_list<>::vertex_descriptor, boost::adjacency_list<>::edge_descriptor>;

using BoostGraphDefault = BoostGraph<boost::adjacency_list<>::vertex_descriptor,
                                     boost::adjacency_list<>::edge_descriptor>;

}

#endif //EXAMPLE_CPP_INCLUDE_BOOST_GRAPH_HPP_
