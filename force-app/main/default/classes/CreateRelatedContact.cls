public class CreateRelatedContact {
    public static void createRelatedContacts(List<Contact> conList){
        List<Contact_Relationship__c> rellist=new List<Contact_Relationship__c>();
        for(Contact cnn:conList){
            if(cnn.Contact_Relationship__c==true){
                Contact_Relationship__c rel=new Contact_Relationship__c();
                rel.Contact__c=cnn.Id;
                rellist.add(rel);
              
                
            }
        }
      
        if(rellist.size()>0){
            insert rellist;
        }
        
    }

}