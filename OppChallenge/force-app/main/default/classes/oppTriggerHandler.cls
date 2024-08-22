public with sharing class oppTriggerHandler {
    List<Opportunity> trgNew, trgOld;
    Map<Id, Opportunity> trgNewMap, trgOldMap;
    
    public oppTriggerHandler() {
        trgNew = (List<Opportunity>) Trigger.new;
        trgOld = (List<Opportunity>) Trigger.old;
        trgNewMap = (Map<Id, Opportunity>) Trigger.newMap;
        trgOldMap = (Map<Id, Opportunity>) Trigger.oldMap;
    }

    public void run() {
        if (Trigger.isBefore) {
            if (Trigger.isInsert) beforeInsert();
            if (Trigger.isUpdate) beforeUpdate();
        }
        if (Trigger.isAfter) {
            if (Trigger.isInsert) afterInsert();
            if (Trigger.isUpdate) afterUpdate();
        }
    }

    public void beforeInsert() {
        oppBO.validateDuplicationRule(trgNew, new Map<Id, Opportunity>());
    }

    public void beforeUpdate() {
        oppBO.validateDuplicationRule(trgNew, trgOldMap);
    }

    public void afterInsert() {}

    public void afterUpdate() {}
}
