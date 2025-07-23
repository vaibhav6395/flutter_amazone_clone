const jwt=require('jsonwebtoken');
const User=require('../model/userschema');

const adminware=async(req,res,next)=>{

    try 
    {   
        const token=req.header('token');
    if(!token)return res.status(401).json({msg:"No valid token ,access denied "});
const verifytoken=jwt.verify(token,"passwordwebtoken")
if(!verifytoken)return res.status(401).json({msg:"token verification failed  ,unauthorised user 401"});

 const  user=await User.findById(verifytoken.id);
 if(user.type=='user' || user.type!="admin"){
return res.status(401).json({msg:"You aren't  an admin!401 "});
 }
    req.user=verifytoken.id;
    req.token=token;        

    next();
        
    } catch (err) {
        res.status(500).json({error:err.message})
    }
 



}
module.exports =adminware