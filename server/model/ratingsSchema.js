const mongoose=require('mongoose')
const ratingschema=mongoose.Schema({
    userId:{
        type:String,
        required:true
    },
    rating:{
        required:true,
        type:Number
    }
    
})
module.exports=ratingschema