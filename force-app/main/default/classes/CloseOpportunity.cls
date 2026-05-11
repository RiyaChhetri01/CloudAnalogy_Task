public class CloseOpportunity {
    public static void updateOpportunity(List<Account> newAccount,Map<Id,Account> AccMap){
        Set<Id> accID=new Set<Id>();
        for(Account acc:newAccount){
            if(acc.Close_All_opportunity__c==true &&  AccMap.get(acc.Id).Close_All_opportunity__c==false){
                accID.add(acc.Id);
            }
        }
        if(accID.isEmpty())
            return;
        
        List<Opportunity> acctoUpdate=[SELECT Id,AccountId,StageName From Opportunity Where AccountId IN:accID AND PROBABILITY >70 and IsClosed=false ];
        for(Opportunity opp:acctoUpdate){
            opp.StageName='Closed Lost';
        }
        if (!acctoUpdate.isEmpty()){
            update acctoUpdate;
            
        }
       
    
    
        
       
    
    
    }}