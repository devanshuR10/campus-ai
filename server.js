const express = require("express");
require('dotenv').config({ path: './api.env' });
const bodyParser = require("body-parser");
const path = require("path");
const session = require("express-session");
const https = require("https");
const fs = require("fs");

const app = express();
const user = require("./routes/user");
const ai = require("./routes/ai");
const events=require("./routes/event_routs");

app.use(session({
  secret: "secret123",
  resave: false,
  saveUninitialized: true
}));
app.use((req, res, next) => {
  console.log(`${req.method} request for '${req.url}'`);
  next();
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

app.use(express.static(path.join(__dirname, "public")));
app.use(express.static(path.join(__dirname, "../client")));

app.use("/api", ai);
app.use("/", user);
app.use("/events",events)
app.get('/config', (req, res) => {
    res.json({ googleMapsApiKey: process.env.GOOGLE_MAPS_API_KEY });
});

const options = {
  key: fs.readFileSync("key.pem"),
  cert: fs.readFileSync("cert.pem"),
};

https.createServer(options, app).listen(1200, () => {
  console.log("HTTPS Server running at https://localhost:1200");
});