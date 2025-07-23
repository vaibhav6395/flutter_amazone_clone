const express = require("express");
const userrouter = express.Router();
const authware = require("../middelware/authware");
const User = require("../model/userschema");
const { Product } = require("../model/productmodel");
const Order=require('../model/order');

userrouter.post("/api/addToCart", authware, async (req, res) => {
  try {
    let isProductfound = false;

    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (!product) {
      return res.status(404).json({ error: "Product not found" });
    }
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(id)) {
          isProductfound = true;
        }
      }
      if (isProductfound) {
        let producttt = user.cart.find((productt) =>
          productt.product._id.equals(product._id)
        );
        if (
          typeof producttt.quantity !== "number" ||
          isNaN(producttt.quantity)
        ) {
          producttt.quantity = 0;
        }
        producttt.quantity = producttt.quantity + 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }
    user = await user.save();
    console.log(user);
    res.status(200).json({ cart: user.cart });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

userrouter.delete("/api/removeFromCart/:id", authware, async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (!product) {
      return res.status(404).json({ error: "Product not found" });
    }
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
          break;
        } else {
          user.cart[i].quantity -= 1;
          break;
        }
      }
    }
    user = await user.save();
    console.log(user);
    res.status(200).json({ cart: user.cart });
    console.log(user)
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});



//save user address
userrouter.post('/api/saveUserAddress',authware,async (req,res)=>{

try {
const {address}=req.body;
let user=await User.findById(req.user)
user.address=address;
user=await user.save();
res.status(200).json(user);


} catch (err) {
    res.status(500).json({ error: err.message });
}
})
 // order product 


userrouter.post('/api/order',authware,async (req,res)=>{

try {
const {cart,totalprice,address}=req.body;
let products=[]
for (let i=0;i<cart.length;i++){
let product=await Product.findById(cart[i].product._id);
if(product.quantity>=cart[i].quantity){
product.quantity-=cart[i].quantity;
products.push({product,quantity:cart[i].quantity});
await product.save();




}else{
  return res.status(400).json({msg:`${product.name} is out of stock! `})
}
}
let user=await User.findById(req.user);
user.cart=[];
user=await user.save();

let order=new Order({
products,
totalprice,
address,
userId:req.user,
Orderat:new Date().getMilliseconds(),

})
order=await order.save();
res.json(order)



} catch (err) {
    res.status(500).json({ error: err.message });
}
})


userrouter.get('/api/order/me',authware,async (req,res)=>{

try {
  const order=await Order.find({userId:req.user});
  res.json(order);
  
console.log(order)
  
} catch (err) {
    res.status(500).json({ error: err.message });

}


})







module.exports = userrouter;
