trigger Grex on Grex__c (before delete) {
    Map<Id,Grex__c> g = Trigger.oldMap;
    System.debug(g);
	delete [SELECT Id FROM LakeKing__c WHERE Grex__c IN : g.keySet()];
}