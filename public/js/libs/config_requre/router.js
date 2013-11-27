define([
    // Application.
    "app",
    "modules/navbar",
    "modules/users",
    "modules/campaigns",
    "modules/signup",
    "modules/login",
    "modules/home",
    "modules/footer",
    

],

    function (app, Navbar, Users, Campaigns, Signup, Login, Home, Footer) {
        

//        var authMiddleware = function (func) {
//            
//            return function (a) {   
//                app.navigation = a;
//                if (!app.user.isAuthorized()) {
////                    app.user._id = '_login';
//                    this.navigate('/', true)
//                    
//                } else {
//                                    
//                    return func.call(this);
//                }
//            }      
//                          
//        }


        //var pageViews = {};
        // Defining the application router, you can attach sub routers here.
        var Router = Backbone.Router.extend({
        
            routes: {
                "" : "index",
                "users/:id":"users/:id",
                "users": "users",
                "campaigns/:id" : "campaigns/:id",
                "campaigns":"campaigns",
                "campaigns/":"campaigns",
//                "signup" : "signup",
//                "signup/" : "signup",
                "signup/step:step" : "signup/:step",
                "login" : "login",
                "campaigns_Id":"campaigns_Id",
            },
            
            
            index : function (){
                console.log("indexxxxxxxxxx");
                window.debug = {
                    User: Signup.Models.Model,
                    Campaigns: Campaigns.Models.Collection
 //                   Users: Users.Models.Collection
                }
                
                  Home.Routes.home();
            
             //   app.useLayout("landing-page").render();
                
               // this.navigate('/login')
            },


            //User Routes Section
            "users" : Users.Routes.users,

            "users/:id": Users.Routes["users/:id"],

            "users_signup" : Users.Routes.signup,


//            Campaign Routes Section
//            "campaigns" : authMiddleware(Campaigns.Routes.campaigns),
            "campaigns" : Campaigns.Routes.campaigns,

//            "campaigns/:id": authMiddleware(Campaigns.Routes["campaigns/:id"]),
            "campaigns/:id": Campaigns.Routes["campaigns/:id"],
            
            
//            "campaigns_Id": Campaigns.Routes.Campaigns_Id,
            
            //Signup
            "signup": Signup.Routes["signup"],
            "signup/:step": Signup.Routes["signup/:step"],
            
            //Login
            "login": Login.Routes.login,
            
//            login:function () {       
//                Login.Routes.login()
//            },

//            
            initialize: function () {
               // app.footer = new Footer.Views.Footer;;
                app.navbar = new Navbar.Views.TopNavbar();
                app.footer = new Footer.Views.Footer();
//                var userid = window.userId//localStorage.getItem('_userid');
                app.loginModel = new Login.Models.Model();                
                // TODO: only for registered user
                app.signup = new Signup.Views.PageStep({model: app.user});                
//                app.signupData = new Signup.Models.Model({
//                app.signupData = new Users.Models.Model({
//                    _id: window.userId//((userid && userid != 'null' && userid != 'undefined') ? userid : undefined)
//                });

                
            
//                
////                app.modelProjectCampaigns = new Campaigns.Models.ModelProjectCampaigns();
////                app.modelCompanyCampaigns = new Campaigns.Models.ModelCompanyCampaigns();
////                app.modelTeamCampaigns = new Campaigns.Models.ModelTeamCampaigns();
//                
//                
//                
//                             //test
////                  app.detailListCampaigns =new Campaigns.Models.DetailListCampaigns()
////                console.log("app.model",app.modelProjectCampaigns.toJSON());  
////                app.detailListCampaigns =new Campaigns.Models.DetailListCampaigns()
////                $.get('/rrr', {detailList:app.detailListCampaigns.toJSON()}, function (err, res) {
////                   console.log('errrrrrrrrr',err);
////                });
//                //test end


            }
        });
        return Router;
    });
