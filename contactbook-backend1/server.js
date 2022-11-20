const app = require("./app") ;
const config = require("./app/config") ;
const MongoDB = require("./app/utils/mongodb.util")



// start server

async function startServer(){
    const PORT = config.app.port ;
    const URI = config.db.uri;
        try {
            MongoDB.connect(URI);
            console.log("Connected to the database!") ;
               
            app.listen(PORT,'192.168.1.13',() => {
                console.log( `Server is running on port ${PORT} .` ) ;
            }) ;    


        } catch (error) {
            console.log("Cannot connect to the database!",error)
            process.exit();
        }



} 
    startServer()

