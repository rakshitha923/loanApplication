global class GmailRegistrationHandler implements Auth.RegistrationHandler{

    global User createUser(Id portalId, Auth.UserData data){
        
        
        String userName = data.email.subStringBefore('@') + 'loan@gmail.com';        
        List<User> userList = [Select Id, Name, Email, UserName From User 
                                      Where ( UserName =: userName)
                                      AND isActive = true
                                      ];
        User user = new User();
        
        
        
        if(userList != null && userList.size() > 0){
            user = userList.get(0);
        } else {
            if(data.attributeMap.containsKey('sfdc_networkid')) {
                User = RegistrationHandler.createUser(data);
            } 
        }
        return user;
    }


    global void updateUser(Id userId, Id portalId, Auth.UserData data){
        
        List<User> userList = [Select Id, Name, Email, UserName From User Where Id =: userId AND isActive = true];
        User u = new User();
        if(userList != null && userList.size() > 0){
            u = userList.get(0);
        }
    }

}