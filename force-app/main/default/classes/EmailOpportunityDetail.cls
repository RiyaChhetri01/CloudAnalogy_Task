public class EmailOpportunityDetail {
    public static void mailOppDetail(){
        List<Messaging.SingleEmailMessage> emailList=new List<Messaging.SingleEmailMessage>();
        List<Opportunity> opp=[SELECT Id,Name,CloseDate,AccountId,Account.Name From Opportunity WHERE CloseDate=:Date.today().addDays(10)];
        
        Set<Id> accountId=new Set<Id>();
        for(Opportunity op:opp){
            if(op.AccountId!=null){
                accountId.add(op.AccountId);
            }
        }
        
        List<Contact> con=[Select Id,AccountId, Email From Contact Where  AccountId IN:accountId AND Email!=null];
        Map<Id,List<Contact>> mappAccToCon=new Map<Id,List<Contact>>();
        for(Contact c:con){
            if(!mappAccToCon.containsKey(c.AccountId)){
                mappAccToCon.put(c.AccountId,new List<Contact>());
                
            }
            mappAccToCon.get(c.AccountId).add(c);
            
        }
        for(Opportunity eachOpp:opp){
            List<Contact> conList=mappAccToCon.get(eachOpp.AccountId);
            If(conList!=null){
                for(Contact cnn:conList){
                    Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
                    mail.setToAddresses(new List<String>{cnn.Email});
                    mail.setSubject('Opportunity closing date in 10 days only');
                    mail.setPlainTextBody(
                       'hello,\n\n'+
                        'Opportunity Name: '+ eachOpp.Name + '\n' +
                        'Opportunity ClosingDate'+ eachOpp.CloseDate+ '\n'+
                        'Account' + eachOpp.Account.Name 
                        
                    
                    );
                     emailList.add(mail);
                    
                }
            }
        }
        if(!emailList.isEmpty()){
            Messaging.sendEmail(emailList);
        }
        System.debug('email send '+emailList.size() );
        
        
        
        
    }

}