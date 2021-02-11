
pragma solidity >=0.7.0 <0.8.0 ;

contract NBA_gembller{

struct User{
 string name;
 string username;//address
 string password;
 uint level; 
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
    string username;
    BPlayer [5] players;
    uint gambleSum; 
}

struct GamblingTeam{
 UserGamble [] userGambles;
 //DATE;
 uint daysPassed; 
   }

   
 }
