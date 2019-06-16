/**
 * @author - Ajai V George
 * @file - graph.hpp
 * @created_on - 15/06/19
 * @project - example_cpp
 *
 * @brief -
 *
 */

#ifndef EXAMPLE_CPP_INCLUDE_GRAPH_HPP_
#define EXAMPLE_CPP_INCLUDE_GRAPH_HPP_

#include <vector>

namespace examplecpp {

template<typename Vertex, typename Edge>
class Graph {
 public:
  Graph() = default;
  virtual ~Graph() = default;
  virtual Vertex add_vertex() = 0;
  virtual void add_edge(const Vertex &source, const Vertex &destination) = 0;
};

}

#endif //EXAMPLE_CPP_INCLUDE_GRAPH_HPP_
