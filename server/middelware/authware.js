const jwt=require('jsonwebtoken');

const authware =async (req,res,next) => {
    try {   const token=req.header('token');
    if(!token)return res.status(401).json({msg:"No valid token ,acess denied "});
const verifytoken=jwt.verify(token,"passwordwebtoken")
if(!verifytoken)return res.status(401).json({msg:"token verification failed  ,unauthorised user "});

    req.user=verifytoken.id;
    req.token=token;

    next();
    } catch (err) {
        res.status(500).json({error:err})
    }





}
module.exports=authware;