const express=require("express");
const mongoose=require("mongoose");
const adminRouter = require("./routes/admin");
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
const PORT= process.env.PORT || 3000;  
const app=express();
const DB="mongodb+srv://pratik:pratik321@cluster0.e2h4t.mongodb.net/?retryWrites=true&w=majority";
app.use(express.json());

// const authRouter=require("./routes/auth");
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

mongoose.connect(DB).then(()=>{
    console.log("Connection Successful");
}).catch((e)=>{
    console.log(e);
});





app.listen(PORT,()=>{
    console.log(`Connected at port ${PORT}` );
});