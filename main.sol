
pragma solidity >=0.7.0 <0.8.0 ;

contract NBA_gembller{
   User [] public users;
   User [] public userWhoWantToGambller;
struct User{
     string firtsName;
     string username;
     address userAddress;
     string password;
     //uint level; 
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
    BPlayer [5] players;
    uint gambleSum; 
}

struct GamblingBattle{
    UserGamble [] userGambles;
    //DATE;
    //uint daysPassed; 
 }
   
   
   
      
  function login(string memory username,string  memory password) public  {
      /*
      check if user exsist in the array. 
      if not return error  massege 
      
      */
      users.push(User(firtsName,lastName));
    }
   
  function register(string memory firtsName,string  memory lastName) public  {
      /*
      add the new user to  array  .
      
      
      */
      users.push(User(firtsName,lastName));
    }
  function addUserGambling(string memory firtsName,string  memory lastName) public  {
      //create usergambling with his own team 
    }
    
    
 function addGambligTeam(string memory firtsName,string  memory lastName) public
 {
      /*
       
       
      */
 }

  function createBattle()
  {
      /*
      inititae battle and retrun his id 
      */
  }
  function addUserToWhoWantToGambller(){
      /*add to userWhoWantToGambller the users that are online*/
  }
