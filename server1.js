const express = require("express");
const mysql = require("mysql2");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
app.use(bodyParser.json());
app.use(cors());
app.use(express.static("public"));
app.use(express.json());
// MySQL Connection
const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "22H71A05D1",
    database: "KCP_CRK_APP"
});

db.connect(err => {
    if(err){
        console.log(err);
        return;
    }
    console.log("MySQL Connected!");
});


// ================= USERS =================

app.post("/register", (req,res)=>{
    const {username,password} = req.body;

    db.query(
        "INSERT INTO users(username,password) VALUES(?,?)",
        [username,password],
        (err,result)=>{
            if(err) return res.status(500).send(err);
            res.send({message:"Registered Successfully"});
        }
    );
});

app.post("/addTeams",(req,res)=>{

const team_name = req.body.team_name;

const sql = "INSERT INTO teams(team_name) VALUES(?)";

db.query(sql,[team_name],(err,result)=>{
if(err){
console.log(err);
res.send(err);
}else{
res.send("Team Added");
}
});

});

// ================= TEAMS =================

// get teams
app.get("/teams",(req,res)=>{
    db.query("SELECT * FROM teams",(err,result)=>{
        if(err) return res.status(500).send(err);
        res.send(result);
    });
});

// add team
app.post("/teams",(req,res)=>{

const name = req.body.name;

const sql = "INSERT INTO teams(team_name) VALUES(?)";

db.query(sql,[name],(err,result)=>{
if(err){
console.log(err);
res.send("Error");
}else{
res.send("Team Added Successfully");
}
});

});

// ================= PLAYERS =================

// get players of team
app.get("/players/:team",(req,res)=>{

let sql="SELECT * FROM players WHERE team_name=?";

db.query(sql,[req.params.team],(err,result)=>{

if(err) throw err;

res.json(result);

});

});

// add player
app.post("/players",(req,res)=>{

let team=req.body.team_name;
let player=req.body.player_name;

let sql="INSERT INTO players (team_name,player_name) VALUES (?,?)";

db.query(sql,[team,player],(err,result)=>{

if(err){
console.log(err);
res.send("Error");
}else{
res.send("Player Added");
}

});

});



// ================= SERVER =================

app.listen(3000, ()=>{
    console.log("Server running on http://localhost:3000");
});
app.delete("/teams/:id",(req,res)=>{

const id = req.params.id;

db.query("DELETE FROM teams WHERE id=?",[id],(err,result)=>{

if(err){
console.log(err);
return res.status(500).send(err);
}

res.send({message:"Team Deleted"});

});

});