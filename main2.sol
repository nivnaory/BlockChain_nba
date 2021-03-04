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
      uint price;
    }
    
    
  struct  UserGamble{
        User user;
        BPlayer []  players;
        uint gambleSum; 
        uint initialPrice;
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
      UserGamble userWaits_0;
      UserGamble userWaits_500;
      UserGamble userWaits_1000;

        

      constructor() {
        GamblingBattleNum=0;
        userWaits_0.valid=false;
        userWaits_500.valid=false;
        userWaits_1000.valid=false;
        userWaits_0.initialPrice=0;
        userWaits_500.initialPrice=0;
        userWaits_1000.initialPrice=0;
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

    function addPlayerToUser(string memory username, string memory playerName,
    uint rebounds,uint asists,uint point ,uint blocks,uint steals,uint price) public 
      {
      BPlayer memory _player=BPlayer(playerName,rebounds,asists,point,blocks,steals,price);
      userGambles[username].players.push(_player);

      }
    function addUserGambling(string memory username,uint _initalPrice) public  {        
          userGambles[username].initialPrice=_initalPrice;
          userGambles[username].valid=true;
          User memory _user=usersMapping[username];
          //userGambles[username].gambleSum=calculateGamblePriceWinner();
          if(userGambles[username].initialPrice==userWaits_0.initialPrice){
               if (userWaits_0.valid==false){
               userWaits_0=userGambles[_user.username];
          }else{
             createBattle(_user.username);
           }

          }else if(userGambles[username].initialPrice==userWaits_500.initialPrice){
            if (userWaits_500.valid==false){
               userWaits_500=userGambles[_user.username];
          }else{
             createBattle(_user.username);
           }
          
          
          }else{
            if (userWaits_1000.valid==false){
               userWaits_1000=userGambles[_user.username];
          }else{
             createBattle(_user.username);
          }
        }
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