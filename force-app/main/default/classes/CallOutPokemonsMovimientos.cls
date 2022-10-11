public class CallOutPokemonsMovimientos implements Database.Batchable<Movimiento__c>,Database.AllowsCallouts{
    
    //Database.executeBatch(new CallOutPokemonsMovimientos(),100);
    public static List<Movimiento__c> start(Database.BatchableContext bc){
        System.debug('Pase por el START');
        // Llamada a la Api
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/move?offset=0&limit=826'); 
        request.setMethod('GET');        
        HttpResponse response = http.send(request);
        List<Object> listResponse = new List<Object>(); 

        Map<String, Object> results = new Map<String, Object>();
        //
        if(response.getStatusCode() == 200) {            
            results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());            
            listResponse = (List<Object>) results.get('results');                         
        }
        //
        List<Movimiento__c> movimientos = new List<Movimiento__c>();
        if (!listResponse.isEmpty()) {
            for (Object pokeMovesss : listResponse) {
                Movimiento__c movimiento = new Movimiento__c();
                Map<String,Object> pokeMove = (Map<String, Object>)pokeMovesss;
                movimiento.Name = (String)pokeMove.get('name');
                movimientos.add(movimiento);                
            }
        }  
        try {
            insert movimientos;
        } catch (Exception e) {
            system.debug('Error: ' + e.getMessage());
        } 
        return movimientos;
        // Guardar los pokemon
        // Retornar la lista insertada
    }
    public static void execute(Database.BatchableContext bc, List<Movimiento__c> movimientos){
        // 1 a 1 llamar a pokemon - Bucle de pokemonsMoves 
        for (Movimiento__c pokeMove : movimientos) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://pokeapi.co/api/v2/move/'+pokeMove.Name); 
            request.setMethod('GET');        
            HttpResponse response = http.send(request);
            
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
            System.debug(results.get('id'));
            pokeMove.ExtId__c = (Integer)results.get('id');
            pokeMove.Punteria__c = (Integer)results.get('accuracy');
            pokeMove.Chance_de_Efecto__c = (Integer)results.get('effect_chance');
            pokeMove.Prioridad__c = (Integer)results.get('priority');
            pokeMove.Poder__c = (Integer)results.get('power');
            pokeMove.Pp__c = (Integer)results.get('pp');
            
            pokeMove.Objetivo__c = (String)((Map<String, Object>)results.get('target')).get('name');
            pokeMove.Tipo__c = (String)((Map<String, Object>)results.get('type')).get('name');
            
            //////Con esto fuerzo la lista//////////
            
            List<Map<String, Object>> effEntries = new List<Map<String, Object>>();            
            for (Object instance : (List<Object>)results.get('effect_entries')){
                effEntries.add((Map<String, Object>)instance);
            }
            
            //////////Con esto la recorro//////////
            for (Map<String, Object> element : effEntries) {                               
                pokeMove.Efecto__c = (String)element.get('short_effect'); 
            }
            
        }
        //upsert fuera del for para guardar datos de cada pokemon
        //Porque ya tenemos el ExtId creado con la lista de Pokemons
        upsert movimientos ExtId__c;        
        system.debug('Pase por el EXECUTE');
    }
    public static void finish(Database.BatchableContext bc){
        system.debug('Pase por el FINISH');
    }
}
