const express = require("express");
const mysql = require("mysql2");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
app.use(bodyParser.json());
app.use(cors());
app.use(express.static("public"));
app.use(express.json());

const db = mysql.createConnection({
    host: process.env.MYSQLHOST || "localhost",
    user: process.env.MYSQLUSER || "root",
    password: process.env.MYSQLPASSWORD || "22H71A05D1",
    database: process.env.MYSQLDATABASE || "railway",
    port: process.env.MYSQLPORT || 3306
});

db.connect(err => {
    if(err){ console.log(err); return; }
    console.log("MySQL Connected!");

    db.query(`CREATE TABLE IF NOT EXISTS match_results (
        id INT AUTO_INCREMENT PRIMARY KEY,
        winner VARCHAR(255) NOT NULL,
        loser VARCHAR(255) NOT NULL,
        win_type VARCHAR(100) NOT NULL,
        margin VARCHAR(100) NOT NULL,
        played_on VARCHAR(50) NOT NULL
    )`, (err) => {
        if(err) console.log("match_results table error:", err);
    });

    db.query(`CREATE TABLE IF NOT EXISTS upcoming_matches (
        id INT AUTO_INCREMENT PRIMARY KEY,
        team1 VARCHAR(255) NOT NULL,
        team2 VARCHAR(255) NOT NULL,
        match_date DATE NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )`, (err) => {
        if(err) console.log("upcoming_matches table error:", err);
        else console.log("upcoming_matches table ready!");
    });

    db.query(`CREATE TABLE IF NOT EXISTS player_stats (
        id            INT AUTO_INCREMENT PRIMARY KEY,
        player_name   VARCHAR(100) NOT NULL,
        team_name     VARCHAR(100),
        match_date    DATE NOT NULL,
        match_type    ENUM('bat','bowl') NOT NULL,
        runs          INT DEFAULT 0,
        balls_faced   INT DEFAULT 0,
        fours         INT DEFAULT 0,
        sixes         INT DEFAULT 0,
        wickets       INT DEFAULT 0,
        overs_bowled  VARCHAR(10) DEFAULT '0.0',
        runs_conceded INT DEFAULT 0,
        created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )`, (err) => {
        if(err) console.log("player_stats table error:", err);
        else console.log("player_stats table ready!");
    });

    db.query(`SHOW COLUMNS FROM players LIKE 'role'`, (err, result) => {
        if(err){ console.log("column check error:", err.message); return; }
        if(result.length === 0){
            db.query(`ALTER TABLE players ADD COLUMN role VARCHAR(50) NULL`, (err2) => {
                if(err2) console.log("role column error:", err2.message);
                else console.log("role column added!");
            });
        } else {
            db.query(`ALTER TABLE players MODIFY COLUMN role VARCHAR(50) NULL`, (err2) => {
                if(err2) console.log("modify column error:", err2.message);
            });
        }
    });
});

// ================= USERS =================

app.post("/register", (req,res)=>{
    const {username,password} = req.body;
    db.query("SELECT * FROM users WHERE username=?",[username],(err,result)=>{
        if(err) return res.status(500).send(err);
        if(result.length>0){
            res.json({message:"Already Registered"});
        } else {
            db.query(
                "INSERT INTO users(username,password) VALUES(?,?)",
                [username,password],
                (err,result)=>{
                    if(err) return res.status(500).send(err);
                    res.json({message:"Registered Successfully"});
                }
            );
        }
    });
});

app.post("/login",(req,res)=>{
    const {username,password} = req.body;
    db.query(
        "SELECT * FROM users WHERE username=?",
        [username],
        (err,result)=>{
            if(err) return res.status(500).send(err);
            if(result.length===0){
                return res.json({success:false, error:"invalid_username"});
            }
            if(result[0].password !== password){
                return res.json({success:false, error:"invalid_password"});
            }
            res.json({success:true});
        }
    );
});

// ================= TEAMS =================

app.get("/teams",(req,res)=>{
    db.query("SELECT * FROM teams",(err,result)=>{
        if(err) return res.status(500).send(err);
        res.send(result);
    });
});

app.post("/teams",(req,res)=>{
    const name = req.body.name;
    db.query("INSERT INTO teams(team_name) VALUES(?)",[name],(err,result)=>{
        if(err){ console.log(err); res.send("Error"); }
        else{ res.send("Team Added Successfully"); }
    });
});

app.delete("/teams/:id",(req,res)=>{
    const id = req.params.id;
    db.query("DELETE FROM teams WHERE id=?",[id],(err,result)=>{
        if(err){ console.log(err); return res.status(500).send(err); }
        res.send({message:"Team Deleted"});
    });
});

// ================= PLAYERS =================

app.get("/players/:team",(req,res)=>{
    db.query(
        "SELECT * FROM players WHERE team_name=?",
        [req.params.team],
        (err,result)=>{
            if(err) return res.status(500).send(err);
            res.json(result);
        }
    );
});

app.post("/players",(req,res)=>{
    let team = req.body.team_name;
    let player = req.body.player_name;
    let role = req.body.role;
    db.query(
        "INSERT INTO players (team_name, player_name, role) VALUES (?, ?, ?)",
        [team, player, role],
        (err,result)=>{
            if(err){ console.log(err); res.send("Error"); }
            else{ res.send("Player Added"); }
        }
    );
});

app.delete("/players/:id",(req,res)=>{
    db.query(
        "DELETE FROM players WHERE id=?",
        [req.params.id],
        (err,result)=>{
            if(err){ console.log(err); return res.status(500).send(err); }
            res.send({message:"Player Deleted"});
        }
    );
});

// ================= MATCH RESULTS =================

app.get("/match-results",(req,res)=>{
    db.query("SELECT * FROM match_results ORDER BY id DESC",(err,result)=>{
        if(err) return res.status(500).send(err);
        res.json(result);
    });
});

app.post("/match-results",(req,res)=>{
    const {winner, loser, win_type, margin, played_on} = req.body;
    if(!winner || !loser) return res.status(400).send("Missing fields");
    db.query(
        "INSERT INTO match_results (winner, loser, win_type, margin, played_on) VALUES (?,?,?,?,?)",
        [winner, loser, win_type, margin, played_on],
        (err,result)=>{
            if(err){ console.log(err); return res.status(500).send(err); }
            res.json({message:"Result saved", id: result.insertId});
        }
    );
});

// ================= UPCOMING MATCHES =================

app.get("/upcoming-matches", (req, res) => {
    db.query("SELECT * FROM upcoming_matches ORDER BY match_date ASC", (err, result) => {
        if(err) return res.status(500).send(err);
        res.json(result);
    });
});

app.post("/upcoming-matches", (req, res) => {
    const { team1, team2, match_date } = req.body;
    if(!team1 || !team2 || !match_date) return res.status(400).json({ error: "Missing fields" });
    if(team1 === team2) return res.status(400).json({ error: "Same teams" });
    db.query(
        "INSERT INTO upcoming_matches (team1, team2, match_date) VALUES (?, ?, ?)",
        [team1, team2, match_date],
        (err, result) => {
            if(err){ console.log(err); return res.status(500).send(err); }
            res.json({ message: "Match scheduled", id: result.insertId });
        }
    );
});

app.delete("/upcoming-matches/:id", (req, res) => {
    db.query(
        "DELETE FROM upcoming_matches WHERE id = ?",
        [req.params.id],
        (err, result) => {
            if(err){ console.log(err); return res.status(500).send(err); }
            res.json({ message: "Match deleted" });
        }
    );
});

// ================= PLAYER STATS =================

app.post("/player-stats", (req, res) => {
    const { player_name, team_name, match_date, match_type, runs, balls_faced, fours, sixes, wickets, overs_bowled, runs_conceded } = req.body;
    if(!player_name || !match_type) return res.status(400).json({ error: "player_name and match_type required" });
    db.query(
        `INSERT INTO player_stats (player_name, team_name, match_date, match_type, runs, balls_faced, fours, sixes, wickets, overs_bowled, runs_conceded)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        [
            player_name,
            team_name || "",
            match_date || new Date().toISOString().split("T")[0],
            match_type,
            runs || 0,
            balls_faced || 0,
            fours || 0,
            sixes || 0,
            wickets || 0,
            overs_bowled || "0.0",
            runs_conceded || 0
        ],
        (err, result) => {
            if(err){ console.log(err); return res.status(500).json({ error: err.message }); }
            res.json({ success: true, id: result.insertId });
        }
    );
});

app.get("/player-stats/:playerName", (req, res) => {
    db.query(
        "SELECT * FROM player_stats WHERE player_name = ? ORDER BY match_date DESC, id DESC",
        [req.params.playerName],
        (err, result) => {
            if(err){ console.log(err); return res.status(500).json({ error: err.message }); }
            res.json(result);
        }
    );
});

// ================= SERVER =================

app.listen(3000, ()=>{
    console.log("Server running on http://localhost:3000");
});
