public class HandlerClass {
    public static void CaserecordCreation(List<Case> caseList){
        for(Case caseCreated:caseList){
            if(caseCreated.Origin=='Email'){
                caseCreated.Status='New';
                caseCreated.Priority='Medium';
            }
        }
        
        
    }
    public static void LeadSource(List<Lead> LeadList){
        for(Lead ld:LeadList){
            if(ld.LeadSource=='Web'){
                ld.Rating='Cold';
            }
            else{
                ld.Rating='Hot';
            }
        }
    }
    public static void AccountContactUpdate(List<Account> accList,Map<Id,Account>oldMap){
        Map<Id,String> AccMap=new Map<Id,String>();
        for(Account acc:accList){
            if(acc.Phone!=oldMap.get(acc.Id).Phone){
                AccMap.put(acc.Id,acc.Phone);
            }  
            }
        List<Contact> cnn=[SELECT AccountId,Phone FROM CONTACT WHERE AccountId IN:AccMap.keySet()];
        for(Contact con:cnn){
            con.Phone=AccMap.get(con.AccountId);
        }
        Database.SaveResult[] sr=Database.update(cnn,false);
        for(Database.SaveResult srList:sr){
            if(srList.isSuccess()){
                System.debug('success'+ srList.getId());
            }else{
                for(Database.Error er:srList.getErrors()){
                    System.debug('error'+ er.getMessage());
                }
            }
        }
        }
    
       
    }