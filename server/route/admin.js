const express=require('express');
const adminroute=express.Router();
const admin=require('../middelware/adminware');
const {product} = require('../model/productmodel');

adminroute.post('/admin/addproduct',admin,async (req,res)=>{

try {

const{name,description,quantity,cateogry,images,price}=req.body
let newproduct=new product({
name,description,quantity,cateogry,images,price
});

savedproduct=await newproduct.save();
res.status(200).json({msg:"working"})

    } catch (err) {
        res.status(500).json({error:err.message})
    }
}





)


// get -products  for admin

adminroute.get('/admin/get-products',admin,async(req,res)=>{
try {
    const product=await Product.find({})  // get all products
    res.json(product)
} catch (err) {
  console.log(err)
res.status(500).json({error:err})
}
})



//delete products of admin or say's to be a seller 
adminroute.post('/admin/delete-products',admin,async (req,res)=>{
try {
  const{id}=req.body
  let product=await Product.findByIdAndDelete(id);
  res.json(product)


} catch (err) {
res.status(500).json({error:err.message})

}
});

module.exports=adminroute;