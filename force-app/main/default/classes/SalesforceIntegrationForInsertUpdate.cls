public class SalesforceIntegrationForInsertUpdate {
    public static void gatherId(List<Account> accList,Map<Id,Account>oldMap){
        Set<Id> accId=new Set<Id>();
        
        for(Account acc:accList){
            if(Trigger.isInsert){
                accId.add(acc.Id);
            }
            else{
                Account oldVal=oldMap.get(acc.Id);
                if(acc.Name!=oldVal.Name||acc.Phone!=oldVal.Phone||acc.Website!=oldVal.Website||acc.Industry!=oldVal.Industry||acc.BillingCity!=oldVal.BillingCity){
                    accId.add(acc.Id);
                    
                }
            }
        }
        if(!accId.isEmpty()){
            SalesforceIntegrationForInsertUpdate.postDetails(accId);
        }
    }
    @future(callout=true)
    public static void postDetails(Set<Id>accountIds){
        List<Account>accList=[SELECT Id,Name,Phone,Website,Industry,BillingCity,BillingCountry,Target_Account_Id__c from Account Where Id IN:accountIds];
        List<Account> AccountToUpdate=new List<Account>();
        for(Account acc:accList){
            HttpRequest req=new HttpRequest();
            req.setEndpoint('callout:SalesforceIntegration/services/apexrest/accountSendSync');
             req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            
            Map<String, Object> mapAccount = new Map<String, Object>();
            mapAccount.put('sourceId', acc.Id);
            mapAccount.put('name', acc.Name);
            mapAccount.put('phone', acc.Phone);
            mapAccount.put('website', acc.Website);
            mapAccount.put('industry', acc.Industry);
            mapAccount.put('billingCity', acc.BillingCity);
            mapAccount.put('billingCountry', acc.BillingCountry);

            req.setBody(JSON.serialize(mapAccount));
            Http http = new Http();
            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                acc.Target_Account_Id__c = res.getBody();
                 AccountToUpdate.add(acc);
            }
            }
        if (!AccountToUpdate.isEmpty()) {
            update  AccountToUpdate;
        }
            

                
        }
        
    }