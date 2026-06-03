const express = require("express");
const router = express.Router();
const dijkstra = require("../dijkstra");
const { Pool } = require("pg");

// 🔗 DATABASE CONNECTION
const pool = new Pool({

  user: "postgres",
  host: "localhost",
  database: "coordinates",
  password: "1234",
  port: 5432,
  
});



router.get("/map", (req, res) => {
  res.render("home");
});



//PLACES_INFO

router.get("/map/info", async (req, res) => {
  const place = req.query.place; // ✅ get from query param not body

  try {
    const result = await pool.query(
      "SELECT * FROM places WHERE LOWER(place_name) = $1",
      [place.toLowerCase()]
    );

    if (result.rows.length === 0) {
      return res.status(404).send("Place not found");
    }

    res.render("get_info", { place: result.rows[0] }); // ✅ pass as 'place'
  } catch (err) {
    console.error("INFO ERROR:", err);
    res.status(500).send("Server error");
  }
});











// ➤ ADD NODE
router.post("/add-node", async (req, res) => {
  const { place_name, lat, lng, remark } = req.body;

  try {
    await pool.query(
      "INSERT INTO places (place_name, lat, lng, remark) VALUES ($1, $2, $3, $4)",
      [place_name.toLowerCase(), lat, lng, remark]
    );

    res.json({ message: "Node added successfully" });
  } catch (err) {
    console.error("ADD NODE ERROR:", err);
    res.status(500).json({ message: "Error adding node" });
  }
});

// ➤ ADD EDGE (BIDIRECTIONAL)
router.post("/add-edge", async (req, res) => {
  let { from, to, distance } = req.body;

  try {
    from = from.toLowerCase();
    to = to.toLowerCase();

    const fromNode = await pool.query(
      "SELECT place_id FROM places WHERE place_name = $1",
      [from]
    );

    const toNode = await pool.query(
      "SELECT place_id FROM places WHERE place_name = $1",
      [to]
    );

    if (fromNode.rows.length === 0 || toNode.rows.length === 0) {
      return res.status(400).json({ message: "Node not found" });
    }

    const fromId = fromNode.rows[0].place_id;
    const toId = toNode.rows[0].place_id;

    await pool.query(
      `INSERT INTO edges (from_node, to_node, distance)
       VALUES ($1, $2, $3), ($2, $1, $3)
       ON CONFLICT DO NOTHING`,
      [fromId, toId, distance]
    );

    res.json({ message: "Edge added successfully" });

  } catch (err) {
    console.error("ADD EDGE ERROR:", err);
    res.status(500).json({ message: "Server error" });
  }
});

// ➤ GET ALL NODES (USED BY MAP)
router.get("/nodes", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM places");
    res.json(result.rows);
  } catch (err) {
    console.error("GET NODES ERROR:", err);
    res.status(500).json({ message: "Error fetching nodes" });
  }
});

// ➤ BUILD GRAPH (WITH ROAD PRIORITY)
async function buildGraph() {
  const graph = {};

  const result = await pool.query(`
    SELECT 
      p1.place_name AS from,
      p2.place_name AS to,
      p2.remark AS type,
      e.distance
    FROM edges e
    JOIN places p1 ON e.from_node = p1.place_id
    JOIN places p2 ON e.to_node = p2.place_id
  `);

  result.rows.forEach(row => {
    if (!graph[row.from]) graph[row.from] = [];

    let weight = row.distance;

    // ROAD PRIORITY LOGIC
    if (row.type === "main road") {
      weight *= 0.6;
    } else if (row.type === "road") {
      weight *= 1;
    } else {
      weight *= 2.5;
    }

    graph[row.from].push({
      node: row.to,
      distance: weight
    });
  });

  return graph;
}

// ➤ GET SHORTEST ROUTE
router.post("/route", async (req, res) => {
  let { start, end } = req.body;

  try {
    if (!start || !end) {
      return res.status(400).json({ message: "Start and end required" });
    }

    start = start.toLowerCase();
    end = end.toLowerCase();

    const graph = await buildGraph();

    if (!graph[start]) {
      return res.status(400).json({ message: "Invalid start node" });
    }

    const path = dijkstra(graph, start, end);

    if (!path || path.length === 0) {
      return res.status(404).json({ message: "No path found" });
    }

    res.json({ path });

  } catch (err) {
    console.error("ROUTE ERROR:", err);
    res.status(500).json({ message: "Route error" });
  }
});

// ➤ HOME PAGE
router.get("/", (req, res) => {
  res.render("home");
});

   

//get all the events 
router.get("/events", async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT 
        e.id,
        e.title,
        e.description,
        e.event_time,
        p.lat,
        p.lng,
        p.place_name,
        s.name AS society_name
      FROM events e
      JOIN places p ON e.place_id = p.place_id
      JOIN societies s ON e.society_id = s.id
      ORDER BY e.event_time ASC
    `);

    res.render("events", {
      events: result.rows
    });

  } catch (err) {
    console.error(err);
    res.status(500).send("Server Error");
  }
});



module.exports = router;