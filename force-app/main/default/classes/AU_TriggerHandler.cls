public class AU_TriggerHandler {
    
    public static void passFilesToBatch(List<AgodiUpdate__c> agodiUpdates) {

        for (AgodiUpdate__c au : agodiUpdates) {

            if (au.filesUploaded__c && !au.UpdateIsRunning__c && !au.Processed__c) {
                List<ContentDocumentLink> contentDocumentLinks = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :au.Id];
                System.debug('### We have ' + contentDocumentLinks.size() + ' ContentDocumentLinks');
                List<Id> contentDocumentIds = new List<Id>();
                for (ContentDocumentLink cdl : contentDocumentLinks) {
                    contentDocumentIds.add(cdl.ContentDocumentId);
                }

                Id batchJobId = Database.executeBatch(new AU_processFiles(contentDocumentIds, au.Id), 1);
            }
        }
    }
}