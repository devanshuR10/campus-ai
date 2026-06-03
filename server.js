const express = require("express");
require("dotenv").config({ path: "./api.env" });

const bodyParser = require("body-parser");
const path = require("path");
const session = require("express-session");

const app = express();

process.on("uncaughtException", (err) => {
  console.error("UNCAUGHT EXCEPTION:", err);
});

process.on("unhandledRejection", (err) => {
  console.error("UNHANDLED REJECTION:", err);
});

const user = require("./routes/user");
const ai = require("./routes/ai");
const events = require("./routes/event_routs");

// Trust Railway proxy
app.set("trust proxy", 1);

app.use(
session({
secret: "secret123",
resave: false,
saveUninitialized: true,
})
);

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
app.use("/events", events);


app.get("/config", (req, res) => {
res.json({
googleMapsApiKey: process.env.GOOGLE_MAPS_API_KEY,
});
});

// Health check route
app.get("/health", (req, res) => {
res.status(200).send("Server is healthy");
});

const PORT = process.env.PORT || 8080;

app.listen(PORT, () => {
console.log(`Server running on port ${PORT}`);
});
