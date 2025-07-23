const express=require('express')
const dash=express.Router();


dash.get("/Dashboard",(req,res)=>{
res.json({Data:"server is running   "})
})

module.exports=dash;