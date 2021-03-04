// SPDX-License-Identifier: GPL-3.0  
pragma solidity >=0.7.0 < 0.8.0;
pragma experimental ABIEncoderV2;

contract NBA_gembller{
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
    
    
  struct  UserGamble{
        User user;
        BPlayer []  players;
        uint gambleSum; 
        bool valid;
    }
    
    struct GamblingBattle{
        UserGamble userGamble1;
        UserGamble userGamble2;
        //DATE;
        //uint daysPassed; 
     }
      uint GamblingBattleNum;
      User [] public userWhoWantToGambller;
      mapping(string => UserGamble)  userGambles;
      mapping(string => User) usersMapping;
      mapping(uint => GamblingBattle) gamblingBattles;
      mapping(string => bool) userExists;
      UserGamble userWaits;
        

      constructor() {
        GamblingBattleNum=0;
        userWaits.valid=false;
      } 
      
          
      function login(string memory username) public view returns (bool)  {
         return userExists[username];
         //just send message to client that user exsist.
         //retrun the user
        }
       
      function register(string memory firtsName,string  memory username,string  memory password) public  {
        User memory _user=User(firtsName,username,password);
        require(!userExists[_user.username],"user allready exsist");
        usersMapping[username]=_user;
        userExists[_user.username] = true;  
        }
     
    function addUserGambling(string memory username) public  {        
          BPlayer memory _player1=BPlayer("wade1",1,1,1,1,1,1);
          BPlayer memory _player2=BPlayer("wade2",1,1,1,1,1,1);
          BPlayer memory _player3=BPlayer("wade3",1,1,1,1,1,1);
          BPlayer memory _player4=BPlayer("wade4",5,1,1,1,1,1);
          BPlayer memory _player5=BPlayer("wade5",1,1,1,1,1,1);
          
          User memory _user=usersMapping[username];
          uint _gambleSum=6;
          
          userGambles[username].user=_user;
          userGambles[username].players.push(_player1);
          userGambles[username].players.push(_player2);
          userGambles[username].players.push(_player3);
          userGambles[username].players.push(_player4);
          userGambles[username].players.push(_player5);
          
          userGambles[username].gambleSum=_gambleSum;
          userGambles[username].valid=true;
          if (userWaits.valid==false){
              userWaits=userGambles[_user.username];
          }else{
              createBattle(_user.username);
          }
      
    // //     //  require(userGambles[_user.username].gambleSum==6,"user have value of 6");
    // //      // require(userGambles[_user.username].players[3].rebounds==1,"not good ");
        }
      function createBattle(string memory userName)public  {
        gamblingBattles[GamblingBattleNum].userGamble1= userGambles[userName];
        gamblingBattles[GamblingBattleNum].userGamble2= userWaits;
        userWaits.valid=false;
        GamblingBattleNum+=1;
      }
    //   // function addUserToWhoWantToGambller() public {
    //   //     /*add to userWhoWantToGambller the users that are online*/
    //   // }
      function getGamblingBattle(uint battleNum)public view returns(GamblingBattle memory){
          return gamblingBattles[battleNum];
      }
    }