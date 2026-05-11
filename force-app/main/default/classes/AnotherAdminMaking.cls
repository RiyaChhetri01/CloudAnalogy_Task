public class AnotherAdminMaking {
    public static void anotherAdmin(){
        Profile GetAdmi=[SELECT Id FROM Profile Where Name='System Administrator' LIMIT 1];
        
        User newProfile=new User(
          FirstName='New User',
            Lastname='Maade',
            Email='x1213@gmail.com',
            Username='sentoc121@gmail.com',
            Alias='ab121',
            TimeZoneSidKey = 'Asia/Kolkata',
    		LocaleSidKey = 'en_US',
   			 EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
            ProfileId = GetAdmi.Id
            
        );
        try{
            insert newProfile;
            System.debug('new profile created '+newProfile.Id);
        }
        catch(DMLException e){
            System.debug('error creating the user'+e.getMessage());
        }
    }

}