const express = require("express");
const bodyParser = require("body-parser");
const path = require("path");

const app = express();
const user = require("./routes/user");
const ai = require("./routes/ai");

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

app.listen(1200, () => {
  console.log("Server running at http://localhost:1200");
});