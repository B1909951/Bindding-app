const ApiError = require('../api-error');
const UserService = require('../services/user.service');
const MongoDB = require('../utils/mongodb.util')
// const _ = require('lodash');
const path = require('path')
const jwt =require('jsonwebtoken')


 
exports.login = async ( req , res, next ) => {
    console.log('heeeeeeeeeeeeeeeeeeee')
if(!req.body?.user){

return next(new ApiError(400,"Nam can not be empty"))

}
try {
const userService = new UserService(MongoDB.client);
const document = await userService.login(req.body);
    // console.log(document)
if(document.length==1){
        let id = document[0]._id.toString()
       let name = document[0].name
       let avatar = document[0].avatar

        //  console.log(id.slice(1,3))
    var token = jwt.sign({ _id: id }, 'phuong');
        console.log(id)    
        
        // console.log(a)
        return res.send({token,id,name,avatar})


}
    return res.send('')
} catch (error) {
return next(
    new ApiError(500, "An error occurred while creating the contact")
)
};





} ;


exports.createUser = async ( req , res, next ) => {

if(!req.body?.username){
return next(new ApiError(400,"Nam can not be empty"))
}
try {

    console.log(req.body);
const userService = new UserService(MongoDB.client);

const document = await userService.createUser(req.body);
// console.log('aaaaaaaaaabbbbbbb')
console.log(document)
return res.send(document)
} catch (error) {
return next(
    new ApiError(500, "An error occurred while creating the contact")
)
};




} ;
exports.updateAvatar = async ( req , res, next ) => {
    console.log('change avatar')
    const a = req.header('Authorization')
    console.log(a)
    const dcode  = jwt.verify(a,'phuong')        
    console.log(dcode._id)  
    const id = dcode._id
    const img = req.body.imgUrl
    // data = {"id_user":dcode._id,...req.body}
    console.log(img)

// try {
    console.log(img)

const userService = new UserService(MongoDB.client);
const document = await userService.update(id,img);

return res.send(img)

// } catch (error) {


// return next(
//     new ApiError(500, "An error occurred while creating the contact")
// )


// };





} ;


exports.updateName = async ( req , res, next ) => {
    console.log('change avatar')
    const a = req.header('Authorization')
    console.log(a)
    const dcode  = jwt.verify(a,'phuong')        
    console.log(dcode._id)  
    const id = dcode._id
    const name = req.body.name
    // data = {"id_user":dcode._id,...req.body}
    console.log(name)

// try {
    console.log(name)

const userService = new UserService(MongoDB.client);
const document = await userService.updateName(id,name);

return res.send(name)

// } catch (error) {


// return next(
//     new ApiError(500, "An error occurred while creating the contact")
// )


// };





} ;
// exports.testUser = async ( req , res, next ) => {
//         console.log(req.body)
//     // if(!req.body?.username){
//     // return next(new ApiError(400,"Nam can not be empty"))
//     // }
//     // try {
//     // const userService = new UserService(MongoDB.client);
    
//     // const document = await userService.testUser(req.body.username);
//     // // console.log('aaaaaaaaaabbbbbbb')
//     // return res.send(document)
//     // } catch (error) {
//     // return next(
//     //     new ApiError(500, "An error occurred while creating the contact")
//     // )
//     // };
    
    
    
    
//     } ;

