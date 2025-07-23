const express=require('express');
const productroute=express.Router();
const authware=require('../middelware/authware');
const {Product} = require('../model/productmodel');


// to fetch all the products 
productroute.get('/api/get-products',authware,async(req,res)=>{
try {
    console.log(req.query.cateogry)
    const product=await Product.find({cateogry:req.query.cateogry})  // get all products
    res.json(product)
    console.log(product)
} catch (err) {
  console.log(err.message)
res.status(500).json({error:err.message})
}
})



// To find the product based on searchquery name

productroute.get('/api/get-products/search/:name',authware,async(req,res)=>{
try {
    console.log(req.params.name)
    const products=await Product.find({
        description:{$regex: req.params.name,$options:"i"}   // options represent case-sensitivity type which is 'i;  means case -Insensitivity
    })
    console.log(products)
    res.json(products)
} catch (err) {
  console.log(err.message)
res.status(500).json({error:err.message})
}
})

// Post request route to rate product
productroute.post('/api/rate-product',authware,async(req,res)=>{
  try {
    const{id,rating}=req.body;
    let product =await Product.findById(id);
    console.log(id,rating)
    console.log(product)
// this code will first find userbyid and  then remove prevous rating and save new rating
    for(i=0;i<product.ratings.length;i++){
      if (product.ratings[i].userId==req.user) {
        product.ratings.splice(i,1);  // use to delete in range
        break;
      }
    }
    const ratingschema={
      userId:req.user,
      rating,
    };
    product.ratings.push(ratingschema)
    product=await product.save();
    res.json(product);
  } catch (err) {
res.status(500).json({error:err.message})
    
  }

})


productroute.get('/api/dealoftheday',authware,async(req,res)=>{

try {
let product=await Product.find({});
product=product.sort((a,b)=>{
let asum=0;
let bsum=0;
for (let i=0;i<a.ratings.length;i++){
  asum+=a.ratings[i].rating;
}
for (let i=0;i<b.ratings.length;i++){
  bsum+=b.ratings[i].rating;
}
return asum<bsum?1:-1
});
res.status(200).json(product[0]);
} catch (err) {
  res.status(500).json({error:err.message})
  
}





})






module.exports=productroute;