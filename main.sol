    
    pragma solidity >=0.7.0 <0.8.0 ;
    
    contract NBA_gembller{
       User [] public users;
       User [] public userWhoWantToGambller;
      mapping(string => UserGamble)  userGambles;
       
      mapping(string => bool) userExists;
        
 struct User{
         string firtsName;
         string username;
         string password;
         //address userAddress;
    }
    
 struct BPlayer{
      string name;
      uint rebounds;
      uint asists;
      uint pointes;
      uint blocks;
      uint steals;
      uint rank;
    }
    
    
  struct UserGamble{
        User user;
        BPlayer []  players;
        uint gambleSum; 
    }
    
    struct GamblingBattle{
        UserGamble [] userGambles;
        //DATE;
        //uint daysPassed; 
     }
       
        
          
      function login(string memory username,string  memory password) public  {
         require(userExists[username],"user not exsits need to create one ");
         //just send message to client that user exsist.
         //retrun the user
        }
       
      function register(string memory firtsName,string  memory username,string  memory password) public  {
        User memory _user=User(firtsName,username,password);
        require(!userExists[_user.username],"user allready exsist");
        users.push(_user);
        userExists[_user.username] = true;  
        }
     
    function addUserGambling() public  {        
          BPlayer memory _player1=BPlayer("wade1",1,1,1,1,1,1);
          BPlayer memory _player2=BPlayer("wade2",1,1,1,1,1,1);
          BPlayer memory _player3=BPlayer("wade3",1,1,1,1,1,1);
          BPlayer memory _player4=BPlayer("wade4",5,1,1,1,1,1);
          BPlayer memory _player5=BPlayer("wade5",1,1,1,1,1,1);
          
          User memory _user=users[0];
          uint _gambleSum=6;
          
          userGambles[_user.username].user=_user;
          userGambles[_user.username].players.push(_player1);
          userGambles[_user.username].players.push(_player2);
          userGambles[_user.username].players.push(_player3);
          userGambles[_user.username].players.push(_player4);
          userGambles[_user.username].players.push(_player5);
          
          userGambles[_user.username].gambleSum=_gambleSum;
      
        //  require(userGambles[_user.username].gambleSum==6,"user have value of 6");
         // require(userGambles[_user.username].players[3].rebounds==1,"not good ");

          
         
          
        }
        
        
     function addGambligTeam(string memory firtsName,string  memory lastName) public
     {
          /*
           
           
          */
     }
     
    
      function createBattle()public  {
          /*
          inititae battle and retrun his id 
          */
      }
      function addUserToWhoWantToGambller() public {
          /*add to userWhoWantToGambller the users that are online*/
      }
    }
    
    
