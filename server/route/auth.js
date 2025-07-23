const express=require('express');
const User = require('../model/userschema');
const bcryptjs=require('bcryptjs')
const jwt=require('jsonwebtoken');
const authware=require('../middelware/authware')
const auth=express.Router();


auth.post("/api/signup",async (req,res)=>{
    try {
const{name,email,password}=req.body

const exist =await User.findOne({email});
if (exist) {
    return res.status(400).json({msg:"user Already exist ! With Email Address"});
}  
const hashpassword=await bcryptjs.hash(password,5)
var user =new User({
        email,
        password:hashpassword,
        name
    })
    userschema=await user.save();
    res.json({msg:"Account created sucessflly !Please Sign-in with same Credentials"});
} catch (e) {
        res.status(500).json({error:e.message})
    }
})



auth.post("/api/signin",async (req,res)=>{

try {
    const {email,password}=req.body;
    const user =await User.findOne({email});
if (!user) {
    return res.status(500).json({error:"user doesn't  Exist!"});
}   
const matchedpassword=await bcryptjs.compare(password,user.password)
if(!matchedpassword){
    return res.status(400).json({msg:"Incorrect password"});
}
//Jsonweb tokens
const token=jwt.sign({id:user._id,},"passwordwebtoken");
res.json({token,...user._doc})  // add toekn value in response json 

//Token creation
//Token transmission
//toekn usageke
//Token verification
//Acess control



} catch (error) {
    res.status(500).json({error:error.message});
}



});


auth.post("/validatetoken",async (req,res)=>{
    try {
const token=req.header('token')
if (!token) return res.json(false)
const isvalid=jwt.verify(token,"passwordwebtoken")
if (!isvalid) return res.json(false)
const user=await User.findById(isvalid.id);
if(!user)return res.json(false)
res.json(true)
} 
catch (err) {
        res.status(500).json({error:err.message});
    }
});



auth.get("/",authware,async (req,res) => {
    const user=await User.findById(req.user);

    res.json({...user._doc,token:req.token});

    
})
module.exports=auth
