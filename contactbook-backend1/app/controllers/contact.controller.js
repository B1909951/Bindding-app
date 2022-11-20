const ApiError = require('../api-error');
const ContactService = require('../services/contact.service');
const MongoDB = require('../utils/mongodb.util')
// const _ = require('lodash');

const path = require('path')
const jwt =require('jsonwebtoken');


 exports.uploadFile = async (req,res,next)=>{
        const file = req.files
           console.log('thang ngay buon')
        try {
        if (!file) {
            return next(new ApiError(400,'Contact not found'));
        }else{
            await file.file.mv(path.join('public/image/') + file.file.name)
                 return res.send('1');
          
            }
        }catch (err) {
            res.status(500).send(err);
        }
        
 }
    
exports.create = async ( req , res, next ) => {
            console.log('aaaa')
            const a = req.header('Authorization')
            console.log(a)
            const dcode  = jwt.verify(a,'phuong')        
            console.log(dcode._id)  
            data = {"id_user":dcode._id,...req.body}

    if(!req.body?.title){
        return next(new ApiError(400,"Nam can not be empty"))
    }
    try {
        const contactService = new ContactService(MongoDB.client);
        const document = await contactService.create(data);
        return res.send(document)
    } catch (error) {
        return next(
            new ApiError(500, "An error occurred while creating the contact")
        )
    };





} ;

 
// exports.login = async ( req , res, next ) => {
 
// // if(!req.body?.username){
// // return next(new ApiError(400,"Nam can not be empty"))
// // }
// // try {
// // const contactService = new ContactService(MongoDB.client);
// // const document = await contactService.login(req.body);
// // return res.send(document)
// // } catch (error) {
// // return next(
// //     new ApiError(500, "An error occurred while creating the contact")
// // )
// // };

// console.log('aaaa')



// } ;


exports.findAll = async ( req , res, next ) => {
           let page= req.params.page
        try {
                const contactService = new ContactService(MongoDB.client)
                const {name} = req.query
                if(name){
                    documents = await contactService.findByName(name);
                }else{
                    
                    documents = await contactService.find({},page);
                }


        } catch (error) {
            return next(
                new ApiError(500, "An error occurred while retrieving contacts")
            )
        }
        return res.send(documents);
   
} ;


exports.findPostFriend = async ( req , res, next ) => {
           let page= req.params.page

           console.log('id_user la ' +req.query.id_user)
           let id  =req.query.id_user
        try {
                const contactService = new ContactService(MongoDB.client)
               
                    documents = await contactService.find2({id_user:id},page);
                


        } catch (error) {
            return next(
                new ApiError(500, "An error occurred while retrieving contacts")
            )
        }
        return res.send(documents);
   
} ;



exports.findAllAll = async ( req , res, next ) => {
    let page= req.params.page
    console.log('hashahaahahahah ');
//  try {
         const contactService = new ContactService(MongoDB.client)
         const {name} = req.query
         if(name){
             documents = await contactService.findByName(name);
         }else{
             
             documents = await contactService.find2({},page);
         }


//  } catch (error) {
//      return next(
//          new ApiError(500, "An error occurred while retrieving contacts")
//      )
//  }
 return res.send(documents);

} ;

exports.findAllSingle = async ( req , res, next ) => {

    let page= req.params.page

    let documents =[]
    const a = req.header('Authorization')
    
      console.log("gia tri:" +a)
     const dcode  = jwt.verify(a,'phuong')        
     id=dcode._id
     console.log(id)
     
                const contactService = new ContactService(MongoDB.client)
                const {name} = req.query
                if(name){
                    documents = await contactService.findByName(name);
                }else{
                    
                    documents = await contactService.find2({id_user:id},page);
                }


      
        console.log(documents)
        return res.send(documents);
   
} ;





exports.findOne = async ( req , res,next ) => {
  
    try {
            const contactService = new ContactService(MongoDB.client)
            const document = await contactService.findById(req.params.id)
            if(!document){
                return next (new ApiError(404,"Contact not found"))
            }
            return res.send(document);


    } catch (error) {
        return next(
            new ApiError(
                500,
                `Error retrieving contact with id=${req.params.id}` 
            )
        )
    }


} ;
exports.update = async ( req , res , next) => {
    let documents =[]
//     console.log('hahahahahahahahahahahha')
    const a = req.body.id_user
        console.log(a)
//       console.log("gia tri:" +a)

     const dcode  = jwt.verify(a,'phuong')        
     id=dcode._id
  

     console.log('hahahahhaahhahahaha'+id)
    
        if(Object.keys(req.body).length===0){
            return next(new ApiError(400,"Data to update can not be empty"))
        }

    try {
        const contactService = new ContactService(MongoDB.client)
        const document = await contactService.update(req.params.id,id)
        // if(!document){
        //     return next(new ApiError(400,'Contact not found'));
        // }
        return res.send({'like':document})
    
    } catch (error) {
        return next(
            new ApiError(500, `Error updating contact with id=${req.params.id}`)
        )
    }   
 


} ;

exports.delete = async ( req , res, next ) => {
        console.log('hahahahhahahahaha')
    console.log(req.body.id_post)
    try {
            

        const contactService = new ContactService(MongoDB.client)
        const document = await contactService.delete(req.body.id_post)
        console.log(document)
        if(!document){
            return next(new ApiError(404, "Contact not found"));
        }
        return res.send({message: "Contact was deleted successfully"});

    } catch (error) {
        return next(
            new ApiError(
                500,
                 `Could not delete contact with id=${req.params.id}`)
        )
    }

   

} ;
exports.deleteAll = async ( req , res , next ) => {

    try {
        const contactService = new ContactService(MongoDB.client)
        const deleteCount = await contactService.deleteAll()
        return res.send({
            message:`${deleteCount} contacts were deleted successfully`
        })
    } catch (error) {
        return next(
            new ApiError(
                500,
                 "An error occurred while removing all contacts")
        )
    }
 



} ;
exports.findAllFavorite = async ( req , res, next ) => {
    try {
            const contactService = new ContactService(MongoDB.client)
            const documents = await contactService.findFavorite();
        return res.send(documents)

    } catch (error) {
        return next(
            new ApiError(
                500,
                 "An error occurred while retrieving favorite contacts")
        )
    }




} ;