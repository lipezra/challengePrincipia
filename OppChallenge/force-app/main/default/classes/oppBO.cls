public with sharing class oppBO {

    public static void validateDuplicationRule(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        Map<String, Opportunity> uniqueKeys = new Map<String, Opportunity>();

        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : newList) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        
        List<Opportunity> existingOpps = [
            SELECT Id, Type, AccountId
            FROM Opportunity
            WHERE AccountId IN :accountIds
            AND StageName != 'Encerrado'
            AND Id NOT IN :oldMap.keySet()
        ];
        
        for (Opportunity opp : existingOpps) {
            String key = opp.AccountId + ':' + opp.Type;
            uniqueKeys.put(key, opp);
        }

        for (Opportunity newOpp : newList) {
            String newKey = newOpp.AccountId + ':' + newOpp.Type;
            if (uniqueKeys.containsKey(newKey)) {
                newOpp.addError('Não é possível criar uma oportunidade enquanto houver outra do mesmo tipo em andamento para esta conta.');
            }
        }
    }
}
