public without sharing class KnowledgeController {
     @AuraEnabled(cacheable=true)
		public static List<Knowledge__kav> getFAQs() {
    		return [ SELECT Id, Title, Summary, UrlName  FROM Knowledge__kav WHERE PublishStatus = 'Online' AND Language = 'en_US'];
}

}