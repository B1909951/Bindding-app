const express = require ("express") ;
const cors = require ("cors") ;
const app = express () ;
const fileUpload = require('express-fileupload');
const contactsRouter = require("./app/routes/contact.route");
const ApiError = require("./app/api-error");

app.use(cors());
app.use(express.json ( ) ) ;

app.use(express.static('public'));

app.use(fileUpload({
    createParentPath: true,
    limits: { 
        fileSize: 3 * 1024 * 1024 * 1024 //2MB max file(s) size
    },
}));
app.get("/", (req,res) => {
    res.json( { message : " Welcome to contact book application . " } ) ;
});


app.use("/api/post", contactsRouter);

// handle 404 response
app.use((req, res, next) => {
    
         return next(new ApiError(404, "Resource not found"));
    });
app.use((error, req, res, next) => {

    return res.status(error.statusCode || 500).json({
        message: error.message || "Internal Server Error",
    });
});



module.exports = app;