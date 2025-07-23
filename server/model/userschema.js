const mongoose = require('mongoose');
const {productschema}=require('./productmodel')
const userschema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,

    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const regex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;

            return value.match(regex)

            },
            message:"Enter a valid email Adress"
        }
    },
    password:{
        required:true,
        type:String,
        validate:{validator:(value)=>{
           if(value.length>=8){
        return value

           }
             
        },
message: "Password must be min. 8 digit character"
        }}
    ,
    adress:{
        type:String,
        default:''
    },
    type:{
        type:String,
default:'user'

    }
    ,
    cart:[
        {
            product:productschema,
            quantity:{
                type:Number,
                reqired:true,
            }
        }
    ]
})

const User=mongoose.model("User",userschema)
module.exports=User;