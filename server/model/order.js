const mongoose=require('mongoose');
const { productschema } = require('./productmodel');
const orderschema=mongoose.Schema({
products:[{
    product:productschema,
    quantity:{
        type:Number,
        required:true,
        
    }
}],
totalprice:{
    type :Number,
    required:true,

},
address:{
    type:String,
    required:true

},
userId:{
    required:true,
    type:String
},
Orderat:{
    type:Number,
    required:true
},
status:{
    type:Number,
    default:0,

}




})
const Order =mongoose.model('Order',orderschema)
module.exports=Order;