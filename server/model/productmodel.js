const mongoose = require('mongoose');
const ratingschema=require('./ratingsSchema')
const productschema=mongoose.Schema({
   

    // name:{
    //     required:true,
    //     trim :true,
    //     type:String
    //     }   ,
    description:{ type:String,
        required:true,
        trim :true,

    },
    images:[{
         type:String,
        required:true,
    }],
    quantity:{
         type:Number,
        required:true,
    },
    price:{
    type:Number,
        required:true,
    },
    cateogry:{
          type:String,
        required:true,
    },
    ratings:[ratingschema],


});
const Product =mongoose.model('product',productschema)
module.exports={Product,productschema}