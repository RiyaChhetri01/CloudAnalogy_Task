public class AccountToOpportunityAttachment {

    public static void getRecord() {
        List<Account> accList = [
            SELECT Id, Name, 
                   (SELECT Id, Name FROM Opportunities) 
            FROM Account 
            WHERE Id IN (SELECT AccountId FROM Opportunity)
        ];

        Set<Id> accIds = new Set<Id>();
        for(Account a : accList) accIds.add(a.Id);

        List<ContentDocumentLink> fileLinks = [
            SELECT ContentDocumentId, LinkedEntityId
            FROM ContentDocumentLink
            WHERE LinkedEntityId IN :accIds
        ];

        Set<Id> contentDocIds = new Set<Id>();
        for(ContentDocumentLink link : fileLinks){
            contentDocIds.add(link.ContentDocumentId);
        }

        List<ContentVersion> files = [
            SELECT Id, Title, VersionData, FileType, ContentDocumentId
FROM ContentVersion
WHERE ContentDocumentId IN :contentDocIds
AND IsLatest = true
        ];

        Map<Id, List<ContentVersion>> accFileMap = new Map<Id, List<ContentVersion>>();
        for(ContentDocumentLink link : fileLinks){
            accFileMap.put(link.LinkedEntityId, new List<ContentVersion>());
        }
        for(ContentVersion file : files){
            if(accFileMap.containsKey(file.ContentDocumentId)) {
                accFileMap.get(file.ContentDocumentId).add(file);
            }
        }

        List<Opportunity> updateOpportunity = new List<Opportunity>();
        List<ContentDocumentLink> newLinks = new List<ContentDocumentLink>();

        for(Account acc : accList){
            List<ContentVersion> attachedFiles = accFileMap.get(acc.Id);
            Boolean hasFiles = attachedFiles != null && attachedFiles.size() > 0;

            for(Opportunity opp : acc.Opportunities){
           
                if(hasFiles){
                    opp.StageName = 'Closed Won';
                } else{
                    opp.StageName = 'Closed Lost';
                }
                updateOpportunity.add(opp);

           
                if(hasFiles){
                    for(ContentVersion file : attachedFiles){
                        ContentDocumentLink newLink = new ContentDocumentLink();
                        newLink.ContentDocumentId = file.ContentDocumentId;
                        newLink.LinkedEntityId = opp.Id;
                        newLink.ShareType = 'V';       // Viewer
                        newLink.Visibility = 'AllUsers';
                        newLinks.add(newLink);
                    }
                }
            }
        }

       
        if(!updateOpportunity.isEmpty()){
            update updateOpportunity;
        }

        if(!newLinks.isEmpty()){
            insert newLinks;
        }

        System.debug('Opportunities updated: ' + updateOpportunity.size());
        System.debug('Files linked to Opportunities: ' + newLinks.size());
    }
}