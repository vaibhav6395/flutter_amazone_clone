 express =require('express')
const mongoose=require('mongoose')
const dash=require('./route/dash')
const auth=require('./route/auth')
const adminroute = require('./route/admin')
const productroute = require('./route/product')
const userrouter = require('./route/user')
const DB="mongodb+srv://Vaibhavnath:mongotiwari@amazonecluster.pclzb1s.mongodb.net/?retryWrites=true&w=majority&appName=Amazonecluster"
app=express();

app.listen(3000,function(){
    console.log("server started and changed ")
});
app.use(dash)
app.use(express.json());
app.use(auth)
app.use(adminroute)
app.use(productroute)
app.use(userrouter)
mongoose.connect(DB).then(()=>{
    console.log("Connection sucessfull");
}).catch((e)=>{
console.log(e);
});

