function dijkstra(graph, start, end) {
  let distances = {};
  let visited = {};
  let prev = {};

  // ✅ Initialize ALL nodes including neighbors
  for (let node in graph) {
    distances[node] = Infinity;
    for (let neighbor of graph[node]) {
      if (!(neighbor.node in distances)) {
        distances[neighbor.node] = Infinity;
      }
    }
  }

  distances[start] = 0;

  while (true) {
    let closest = null;

    for (let node in distances) {
      if (!visited[node] &&
          (closest === null || distances[node] < distances[closest])) {
        closest = node;
      }
    }

    if (closest === null || closest === end) break;

    visited[closest] = true;

    for (let neighbor of graph[closest]) {
      let newDist = distances[closest] + neighbor.distance;

      if (newDist < distances[neighbor.node]) {
        distances[neighbor.node] = newDist;
        prev[neighbor.node] = closest;
      }
    }
  }

  // ✅ Check if end was actually reached
  if (distances[end] === Infinity) {
    console.log("No path found from", start, "to", end);
    return [];
  }

  let path = [];
  let current = end;

  while (current) {
    path.unshift(current);
    current = prev[current];
  }

  console.log("Response:", path);
  return path;
}

module.exports = dijkstra;