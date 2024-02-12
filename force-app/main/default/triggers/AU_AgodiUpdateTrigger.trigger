trigger AU_AgodiUpdateTrigger on AgodiUpdate__c (after update) {

    if (trigger.isAfter) {
        if (trigger.isUpdate) {
            AU_TriggerHandler.passFilesToBatch(trigger.new);
        }
    }

}