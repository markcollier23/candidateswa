trigger LakeKingTrigger on LakeKing__c (before insert) {
	String grex = 'GREX'+DateTime.now();
    insert new Grex__c(Name=grex);
    Id grexId = [SELECT Id FROM Grex__c WHERE Name = : grex].Id;
    List<LakeKing__c> lakes = new List<LakeKing__c>();
    for(LakeKing__c king:Trigger.New){
        king.Grex__c = grexId;
        lakes.add(king);
    }
}