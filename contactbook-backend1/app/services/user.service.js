const {ObjectId} = require('mongodb');

class ContactService{

    constructor(client){
        this.User = client.db().collection("user");

    }
            async login(data) {
                 console.log(data)
                return await this.User.find({
                    
                    username: data.user,password:data.pass
                }).toArray();
            }
            async createUser(payload) {
                    var a=  await this.User.find({
                    
                    username: payload.username
                }).toArray();

                if(a.length){
                    console.log('aa')
                    console.log(a)
                    return '0';
                }else{
                const contact = payload
                contact.avatar ='anonymous.jpg'
                contact.id=''

                const result = await this.User.insertOne(contact);
                // const result = await this.User.findOneAndUpdate(
                //     contact,
                //     { $set: {} },
                //     { returnDocument: "after", upsert: true }
                // );
                        
                        var a = result.insertedId
                console.log('value ' + a);

                        await this.User.findOneAndUpdate({_id: new ObjectId(result.insertedId)},
                            { $set: {
                                    id:a.toString()
                             } }
                            
                        
                        )
            // return result.value;
            return '1';
                }

        
            }
            // async testUser(data) {
            //     // console.log(data)
            //     return await this.User.find({
                    
            //         username: data
            //     }).toArray();
            // }
    
    async update(id, img){
                console.log(' service:'+img)
                console.log(' service:'+id)

       const  result = await this.User.updateOne(
            {id:id},
            {  $set:{
                'avatar':img
            }
        }    
           
        );
        return 1;
    }
    async updateName(id, name){
        console.log(' service:'+name)
        console.log(' service:'+id)

const  result = await this.User.updateOne(
    {id:id},
    {  $set:{
        'name':name
    }
}    
   
);
return 1;
}
}

module.exports = ContactService