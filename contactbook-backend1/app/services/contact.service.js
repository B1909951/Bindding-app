const {ObjectId} = require('mongodb');
const jwt =require('jsonwebtoken')
const MongoDB = require('../utils/mongodb.util');
const { flatMap } = require('lodash');

class ContactService{

    constructor(client){
        this.Contact = client.db().collection("post");

    }

    

        async create(payload) {
         
            const contact = payload
            const result = await this.Contact.findOneAndUpdate(
                contact,
                { $set: { like:{
                    id_user:[],
                    numLike:0
                }} },
                { returnDocument: "after", upsert: true }
            );
        return result.value;
        }

        async find3(filter,page) {
            console.log('find3')
            let numberPage = page*2
            const cursor = await this.Contact.find(filter);
            // .limit(numberPage).sort({"_id":-1})
          
            return await cursor.toArray();
        }
        async find(filter,page) {
            // console.log(page)
            // let numberPage = page*2
            // const cursor = await this.Contact.find(filter).limit(numberPage).sort({"_id":-1});
            // return await cursor.toArray();
            const cursor = await this.Contact.aggregate([
                { $sort : { _id : -1 } },
                { $lookup: {
                    from: 'user',
                    localField: 'id_user',
                    foreignField: 'id',
                    as: 'users'
                }},
           ]);

           return await cursor.toArray();



        }
        
        async find2(filter,page) {
            console.log(filter)
            // let numberPage = page*2
            // const cursor = await this.Contact.find(filter).limit(numberPage).sort({"_id":-1});
            // return await cursor.toArray();
                    console.log(filter)
            const cursor = await this.Contact.aggregate([
               {
                $match:filter
            },
            { $sort : { _id : -1 } }
            ,
                { 
                    
                    $lookup: {
                    from: 'user',
                    localField: 'id_user',
                    foreignField: 'id',
                    as: 'users'
                }},
           ]);

           return await cursor.toArray();
        } 



        
        async findByName(name) {
            return await this.find({

                name: { $regex: new RegExp(name), $options: "i" },
            });
        }
        async findById(id) {
            return await this.Contact.findOne({
                _id: ObjectId.isValid(id) ? new ObjectId(id) : null,
        });
        }
        async update(id, payload) {
            const filter = {
                _id: ObjectId.isValid(id) ? new ObjectId(id) : null,
            };
            const like = await this.Contact.findOne(filter);
            let isLike = 0
            var soLike =0

             console.log(like.like.id_user)

                like.like.id_user.forEach(element => {
                    soLike++;
                            if(element == payload){
                                isLike=1
                              
                            }   
                           

                            console.log('lan ' + soLike)
                });
            
           
            const update = payload;
            let result =0
            if(isLike==0){
                soLike++;

                console.log(' 1Like')
                result = await this.Contact.updateOne(
                    filter,
                    {  $set:{
                        'like.numLike':soLike
                    },
                        $push:{
                        
                        "like.id_user":update
    
                        
    
                    }
                }    
                   
                );
            }else{

                    soLike--;
                    console.log(soLike);
                console.log('0 Like')
                 result = await this.Contact.updateOne(
                    filter,
                    {   $set:{
                        'like.numLike':soLike
                    },
                        $pull:{
                        
                        "like.id_user":update
    
                        
    
                    }
                }    
                   
                );

            }
          
                    
              return soLike;
        }

        async delete(id) {
            const result = await this.Contact.findOneAndDelete({
            _id: ObjectId.isValid(id) ? new ObjectId(id) : null,
            });
            return result.value;
            }

            
            async findFavorite() {
                return await this.find({ favorite: true });
                }
        
            async deleteAll() {
                    const result = await this.Contact.deleteMany({});
                    return result.deletedCount;
            }
            async login(username,password) {
                return await this.find({
                    
                    username: username,password:password
                });
            }

}

module.exports = ContactService