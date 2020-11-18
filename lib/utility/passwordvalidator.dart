class Validator{
  
     static String passwordValidation(String pass){
    if(pass.length>5)return null;
    if(pass.isEmpty)return "Password Required";
    if(pass.length<6)return "Password must be at least 6";
    return "";
  }



}