public class HandlerForPdfMaker {
   

    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getAccountHierarchy(Id accountId) {
        Map<String,Object> relatedData=new Map<String,Object>();
        relatedData.put('account',[SELECT Id,Name,Phone,Website,Industry from Account Where Id =:accountId]);

		relatedData.put('contacts', [SELECT Id, Name, Email, Phone FROM Contact WHERE AccountId = :accountId]);        
        relatedData.put('opportunities',[Select AccountId,Id,Name,StageName ,Amount,CloseDate from Opportunity Where AccountId =:accountId]);
        return relatedData;
      
    
}


}