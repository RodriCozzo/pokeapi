public class CallOutPokemonsMovimientos implements Database.Batchable<Movimiento__c>,Database.AllowsCallouts{
    
    //Database.executeBatch(new CallOutPokemonsMovimientos(),1);
    public static List<Movimiento__c> start(Database.BatchableContext bc){
        
        List<Movimiento__c> movimientos = new List<Movimiento__c>();
        for (Integer i=1; i<=826; i++) {
            Movimiento__c movimiento = new Movimiento__c(ExtId__c=i);
            movimientos.add(movimiento);
        }

        insert movimientos;
        System.debug('Pase por el start' + movimientos);

        return movimientos;

    }
    public static void execute(Database.BatchableContext bc, List<Movimiento__c> movimientos){
        system.debug('Pase por el EXECUTE');
        // 1 a 1 llamar a movimiento - Bucle de pokemonsMoves 

        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/move/'+movimientos[0].ExtId__c); 
        request.setMethod('GET');        
        HttpResponse response = http.send(request);
        

        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        System.debug(results);

        Movimiento__c move = new Movimiento__c();
        move.ExtId__c = (Integer)results.get('id');
        move.Punteria__c = (Integer)results.get('accuracy');
        move.Chance_de_Efecto__c = (Integer)results.get('effect_chance');
        move.Prioridad__c = (Integer)results.get('priority');
        move.Poder__c = (Integer)results.get('power');
        move.Pp__c = (Integer)results.get('pp');
        
        move.Objetivo__c = (String)((Map<String, Object>)results.get('target')).get('name');
        move.Tipo__c = (String)((Map<String, Object>)results.get('type')).get('name');
        System.debug((String)((Map<String, Object>)results.get('type')).get('name'));

        
        //////Con esto fuerzo la lista de EFECTO//////////
        List<Map<String, Object>> effEntries = new List<Map<String, Object>>();            
        for (Object instance : (List<Object>)results.get('effect_entries')){
            effEntries.add((Map<String, Object>)instance);
        }
        //////////Con esto la recorro//////////
        for (Map<String, Object> element : effEntries) {                               
            move.Efecto__c = (String)element.get('short_effect'); 
        }
        
        ////////////////////EJECUTO O MODIFICO/////////////////////////
        try {
            upsert move ExtId__c;   
        } catch (Exception e) {
            system.debug('Error: ' + e.getMessage());
        } 
        
        
    }
    public static void finish(Database.BatchableContext bc){
        system.debug('Pase por el FINISH');
    }
}
