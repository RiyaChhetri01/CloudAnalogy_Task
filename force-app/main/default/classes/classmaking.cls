public class classmaking {
    public static void main(){
        Product2 prod=new Product2(Name='Test Product',isActive=true);
        insert prod;
        Id PricebookId=[SELECT ID FROM Pricebook2 WHERE isStandard=true Limit 1 ].Id;
        PricebookEntry pbe=new PricebookEntry(
      	    Pricebook2Id=PricebookId,
            Product2Id=prod.Id,
            UnitPrice=100,
            IsActive=true 
        );
        insert pbe;
        
        List<Account> accList=new List<Account>();
        accList.add(new Account(Name='Test1script'));
        accList.add(new Account(Name='Test2script'));
        insert accList;
        List<Opportunity> oppList=new List<Opportunity>();
        for(Integer i=0;i<3;i++){
            oppList.add(new Opportunity(Name='Testscript'+i ,AccountId=accList[0].Id , StageName='Closed Won',CloseDate=Date.Today()));
            oppList.add(new Opportunity(Name ='Testscript'+i,AccountId=accList[1].Id,StageName='Closed Won',CloseDate=Date.Today()));
        }
        insert oppList;
        Set<Id> accIds=new Set<Id>();
        List<AggregateResult> agr=[select AccountId from opportunity where stagename ='Closed Won' group by accountid having count(id)>2];
        for(AggregateResult ar:agr){
             accIds.add((Id)ar.get('AccountId'));
        }
        List<Account> oppAcc=[select Id,Name from Account where id IN:accIds];
        for(Account A:oppAcc){
            System.debug(A.name);
        }

        
        
    }
    public static void leadProduct(){
        List<Lead> leadslis=new List<Lead>();
        for(Integer i=0;i<3;i++){
            leadslis.add(new Lead(FirstName='Test'+i,LastName='Testinglcass',Company='Cloud Analogy',Status='Open-Not Contacted'));
        }
        insert leadslis;
        List<Product2> prod=new List<Product2>();
        prod.add(new Product2(Name='Test',Lead__c=leadslis[0].Id,isActive=true));
        prod.add(new Product2(Name='Test',Lead__c=leadslis[0].Id,isActive=true));

        prod.add(new Product2(Name='Test',Lead__c=leadslis[1].Id,isActive=true));
        prod.add(new Product2(Name='Test',Lead__c=leadslis[1].Id,isActive=true));

        prod.add(new Product2(Name='Test',Lead__c=leadslis[2].Id,isActive=true));

        insert prod;
        System.debug(prod.size());
        
    }
    public static void oli(){
        Set<Id> oliid=new Set<Id>();
        for(AggregateResult oli :[SELECT OPPORTUNITYID,COUNT(ID) acId FROM OPPORTUNITYLINEITEM  GROUP BY OPPORTUNITYID HAVING COUNT(ID)>2])
        {
            oliid.add((Id)oli.get('OPPORTUNITYID'));
                }
       
        list<Account> acclist=[SELECT ID ,NAME FROM ACCOUNT WHERE ID IN (SELECT ACCOUNTID FROM OPPORTUNITY WHERE ID IN :oliid)];
        for(Account acc:acclist){
            System.debug(acc.Id);
        }
    }
    public static void prodQuantity(){
        Set<Id> accid=new Set<Id>();
        for(AggregateResult oli:[select opportunityid ,Sum(quantity) from OpportunityLineItem group by Opportunityid ]){
            accid.add((Id)oli.get('opportunityid'));
        }
        List<Account>acc=[select id,name from account where working_in__c ='ASIA' AND id IN(Select AccountId from Opportunity where id In:accid)];
        for(Account ac:acc){
            System.debug(ac.Id);
        }
    }
    public static void userWithLead(){
        List<AggregateResult> Leadacc=[Select Owner.Name,OwnerId from lead where LastModifiedDate >= Last_N_Days:20 group by Owner.Name,OwnerId having count(Id)>2];
        for(AggregateResult agr:Leadacc){
            Id ownerId=((Id)agr.get('OwnerId'));
            System.debug(ownerId);
            
        }
        
        
        
    }
    public static void accWithOpp(){
        set<Id>oppID=new Set<Id>();
        for(AggregateResult agr:[SELECT ACCOUNTID,ACCOUNT.NAME  FROM OPPORTUNITY WHERE STAGENAME ='Closed Won' AND CLOSEDATE=NEXT_N_DAYS:4 GROUP BY ACCOUNTID,ACCOUNT.NAME HAVING COUNT(ID)>=2]){
            oppID.add((Id)agr.get('ACCOUNTID'));
        }
        List<Account> accId=[SELECT ID,NAME FROM ACCOUNT WHERE ID IN:oppID];
        FOR(ACCOUNT AA:accId){
            System.debug(AA.Name);
        }

    }
    public static void accCon(){
        Set<Id> acSet=new Set<Id>();
        for(AggregateResult agr:[SELECT ACCOUNTID,ACCOUNT.NAME FROM CONTACT WHERE EMAIL!=NULL GROUP BY ACCOUNTID,ACCOUNT.NAME HAVING COUNT(ID)>2]){
            acSet.add((ID)agr.get('ACCOUNTID'));
            
        }
        Set<Id>ownId=new Set<Id>();
        LIST<AggregateResult>ACC=[SELECT COUNT(ID),OWNERID FROM ACCOUNT WHERE PHONE!=NULL  AND ID IN :acSet GROUP BY OWNERID HAVING COUNT(ID)>10];
        for(AggregateResult acr:ACC){
            ownId.add((ID)acr.get('OWNERID'));
        }
        if(!ownId.isEmpty()){
            List<User>AccUSer=[SELECT EMAIL,Name FROM User WHERE ID IN:ownId];
            List<Messaging.SingleEmailMessage> emailList=new List<Messaging.SingleEmailMessage>();
            for(User u:AccUSer){
                Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[]{u.Email});
                mail.setSubject('to Account');
                mail.setPlainTextBody('this is the email');
                emailList.add(mail);
            }
            if(!emailList.isEmpty()){
                Messaging.sendEmail(emailList);

            }
            
        }
        else{
            System.debug('no match found');
        }
        
    }
    
    

}