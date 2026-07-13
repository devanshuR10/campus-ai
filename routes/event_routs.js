const express = require("express");
const router = express.Router();
const { Pool } = require("pg");

const pool = new Pool({
    host: process.env.PGHOST,
    port: process.env.PGPORT,
    user: process.env.PGUSER,
    password: process.env.PGPASSWORD,
    database: process.env.PGDATABASE,
    ssl: {
        rejectUnauthorized: false,
    },
});

// 🔐 Auth Middleware
function isloggedin(req, res, next) {
  if (req.session && req.session.user) {
    return next();
  }
  res.redirect("/events/login");
}

// 🟢 LOGIN PAGE
router.get("/login", (req, res) => {
  res.render("login", { error: null });
});

// 🟢 LOGIN LOGIC
router.post("/login", async (req, res) => {
  const { username, password } = req.body;

  try {
    const result = await pool.query(
      "SELECT * FROM societies WHERE username = $1 AND password = $2",
      [username, password]
    );

    if (result.rows.length > 0) {
      // ✅ Success
      req.session.user = result.rows[0];
      return res.redirect("/events/add");
    } else {
      // ❌ Wrong credentials
      return res.render("login", { error: "Wrong username or password" });
    }

  } catch (err) {
    console.error(err);
    res.send("Server error");
  }
});

// 🟢 PROTECTED PAGE
router.get("/add", isloggedin, (req, res) => {
  res.render("addevents.ejs"); // make sure file exists
});

router.post("/add", isloggedin, async (req, res) => {
  const { title, description, event_time, place_id } = req.body;
  const society_id = req.session.user.id;

  try {
    await pool.query(
      `INSERT INTO events (title, description, event_time, place_id, society_id)
       VALUES ($1, $2, $3, $4, $5)`,
      [title, description, event_time, place_id, society_id]
    );

    res.json({ success: true });

  } catch (err) {
    console.error("ADD EVENT ERROR:", err);
    res.status(500).json({ error: "DB error" });
  }
});

router.get("/search-place", async (req, res) => {
  const query = req.query.q;

  try {
    const result = await pool.query(
      "SELECT place_id, place_name FROM places WHERE place_name ILIKE $1 LIMIT 5",
      [`%${query}%`]
    );

    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.json([]);
  }
});


router.get("/search-place", async (req, res) => {
  const query = (req.query.q || "").toLowerCase();

  try {
    const result = await pool.query(
      "SELECT place_id, place_name FROM places WHERE LOWER(place_name) LIKE $1 LIMIT 5",
      [`%${query}%`]
    );

    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.json([]);
  }
});

// 🔴 LOGOUT
router.get("/logout", (req, res) => {
  req.session.destroy(() => {
    res.redirect("/events/login");
  });
});

module.exports = router;
