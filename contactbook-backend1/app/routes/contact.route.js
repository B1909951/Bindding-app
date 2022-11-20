const express = require ("express") ;
const contacts = require ("../controllers/contact.controller") ;
const user = require("../controllers/user.controller")
const router = express.Router() ;
router.route("/login").post(user.login)
// router.route("/testUser").post(user.testUser)

router.route("/update/avatar").put(user.updateAvatar
)

router.route("/update/name").put(user.updateName
    )
router.route("/single/:page").get(contacts.findAllSingle)

router.route("/createUser")
.post(user.createUser) 

 router.route('/all').get(contacts.findAllAll)

router.route("/")
    .post(contacts.create)
    .delete(contacts.deleteAll) ;

router.route("/favorite")
    .get(contacts.findAllFavorite) ;
    
router.route("/:page")
.get(contacts.findAll)
    // .get(contacts.findOne)
    .put(contacts.update)

    router.route("/friend/:page").get(contacts.findPostFriend)

    router.route('/delete').delete(contacts.delete) ;

    router.route("/update/:id")
    
        // .get(contacts.findOne)
        .put(contacts.update)


      
    
        // .get(contacts.findOne)
       
        
router.route("/uploadfile").post(contacts.uploadFile)
module.exports = router;