public class SalesRepresentative {
    public static void SalesRepMaking(List<Account> accList,Map<Id,Account>oldMap){
        Set<Id> accountid=new Set<Id>();
        
        For(Account acc:accList){
            if(acc.OwnerId!=null){
                 accountid.Add(acc.OwnerId);
            }
        }
        Map<Id,User> userMap=new Map<Id,User>([Select Id,Name From User Where Id IN:accountid]);
        
        //insert 
        for(Account acc:accList){
            if(oldMap==null){
                User u=userMap.get(acc.OwnerId);
                if(u!=null){
                    acc.Sales_Rep__c=u.Name;
                }
                
            }
            //update
            else if(acc.ownerId!=oldMap.get(acc.Id).OwnerId){
                
                	User u=userMap.get(acc.OwnerId);
                	if(u!=null){
                   		 acc.Sales_Rep__c=u.Name;
	                }
                    
                }
            }
        }
        
        
        
        
    }