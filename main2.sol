
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
      uint points;
      uint blocks;
      uint steals;
      //uint price;
    }
    
    
  struct  UserGamble{
        User user;
        BPlayer []  players;
        uint gamblerSum; 
        uint initialPrice;
        bool valid;
    }
    
    struct GamblingBattle{
        UserGamble userGamble1;
        UserGamble userGamble2;
        uint scoreUserGamble1;
        uint scoreUserGamble2;

        //DATE;
        //uint daysPassed; 
     }
      uint GamblingBattleNum;
      User [] public userWhoWantToGambller;
      mapping(string => UserGamble)  userGambles;
      mapping(string => User) usersMapping;
      mapping(uint => GamblingBattle) gamblingBattles;
      mapping(string => bool) userExists;
      mapping(string=>uint) userNameToBattle;
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
    uint rebounds,uint asists,uint point ,uint blocks,uint steals) public {
      BPlayer memory _player=BPlayer(playerName,rebounds,asists,point,blocks,steals);
      userGambles[username].players.push(_player);

      }
    function addUserGambling(string memory _username,uint _initalPrice) public  {        
          userGambles[_username].initialPrice=_initalPrice;
          userGambles[_username].valid=true;
          User memory _user=usersMapping[_username];
          userGambles[_username].user=_user;


          userGambles[_username].gamblerSum=calculateGamblePriceWinner(_initalPrice,_username);
          if(userGambles[_username].initialPrice==userWaits_0.initialPrice){
               if (userWaits_0.valid==false){
               userWaits_0=userGambles[_user.username];
          }else{
             createBattle(_user.username);
           }

          }else if(userGambles[_username].initialPrice==userWaits_500.initialPrice){
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
        gamblingBattles[GamblingBattleNum].userGamble1= userGambles[userName];  //get the userGamble1
        if ( gamblingBattles[GamblingBattleNum].userGamble1.initialPrice==0){
        gamblingBattles[GamblingBattleNum].userGamble2= userWaits_0;//get the usergamble2
        userWaits_0.valid=false;
        userNameToBattle[userName]=GamblingBattleNum;
        userNameToBattle[userWaits_0.user.username]=GamblingBattleNum;
        GamblingBattleNum+=1;

        }else if(gamblingBattles[GamblingBattleNum].userGamble1.initialPrice==500){
        gamblingBattles[GamblingBattleNum].userGamble2= userWaits_500;//get the usergamble2   
        userWaits_500.valid=false;
        userNameToBattle[userName]=GamblingBattleNum;
        userNameToBattle[userWaits_500.user.username]=GamblingBattleNum;
        GamblingBattleNum+=1;

        }else{
          gamblingBattles[GamblingBattleNum].userGamble2= userWaits_1000;//get the usergamble2
          userWaits_1000.valid=false;
          userNameToBattle[userName]=GamblingBattleNum;
          userNameToBattle[userWaits_1000.user.username]=GamblingBattleNum;
          GamblingBattleNum+=1;
        } 
      }
    
      function getGamblingBattle(uint battleNum)public view returns(GamblingBattle memory ){
          return gamblingBattles[battleNum];
      }
    

    function calculateGamblePriceWinner(uint _price,string memory _username)public view returns(uint){
      UserGamble storage userGamble=userGambles[_username];
      //check if there is length function of the array
      uint sum=0;
      for (uint i=0;i<5;i++){
       sum=sum+calculataPlayerSum(userGamble.players[i]);
      }
      return sum+_price;
    }
    
    function calculataPlayerSum(BPlayer memory player) public view returns(uint)
    {
       uint priceOfPlayer=player.rebounds*10+player.points*5+player.steals*15+player.blocks*15
       +player.asists*10;
       return priceOfPlayer;
    }
     function getUserGambllerByUserName(string memory username)public view returns(UserGamble memory){
          return userGambles[username];
      }
   
      
      
      function calculateDayStatisticsOfPlayer(uint gambllerNum,uint battleNum,uint rebounds,uint asists,uint point ,
      uint blocks,uint steals) public 
      {
        GamblingBattle storage  battle = gamblingBattles[battleNum];
        uint score= rebounds*5+asists *5 +point *10 +blocks* 7+steals *8;
        if (gambllerNum==1){
          battle.scoreUserGamble1+=score; 
        }else{
           battle.scoreUserGamble2+=score; 
        }
       
      }
      
      function winner(uint battleNum) public view returns(UserGamble memory,bool)
      {
        GamblingBattle storage  battle = gamblingBattles[battleNum];
         if(battle.scoreUserGamble1>battle.scoreUserGamble2){
           return (battle.userGamble1,true);
         }else if(battle.scoreUserGamble1< battle.scoreUserGamble2){
           return (battle.userGamble2,true);
         }
           return (battle.userGamble1,false);
          
    }
}
