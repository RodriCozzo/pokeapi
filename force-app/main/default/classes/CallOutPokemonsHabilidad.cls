public class CallOutPokemonsHabilidad implements Database.Batchable<Habilidad__c>,Database.AllowsCallouts{
   
    //Database.executeBatch(new CallOutPokemonsHabilidad(),1);
    public static List<Habilidad__c> start(Database.BatchableContext bc){
        
        List<Habilidad__c> habilidades = new List<Habilidad__c>();
        for (Integer i=1; i<=267; i++) {
            Habilidad__c habilidad = new Habilidad__c(ExtId__c=i);
            habilidades.add(habilidad);
        }

        insert habilidades;
        System.debug('Pase por el start' + habilidades);

        return habilidades;
    }
    
    public static void execute(Database.BatchableContext bc, List<Habilidad__c> habilidades){
        system.debug('Pase por el execute');
        // 1 a 1 llamar a pokemon
        
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/ability/'+habilidades[0].ExtId__c); 
        request.setMethod('GET');        
        HttpResponse response = http.send(request);
        
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        System.debug(results);

        Habilidad__c pokemonHabilidad = new Habilidad__c();
        pokemonHabilidad.ExtId__c = (Integer)results.get('id');
        
        ////////////Con esto fuerzo la lista//////////
        List<Map<String, Object>> effectEntries = new List<Map<String, Object>>();            
        for (Object instance : (List<Object>)results.get('effect_entries')){
            effectEntries.add((Map<String, Object>)instance);
        }
        System.debug(effectEntries);        
        for (Map<String, Object> element : effectEntries) {           
            pokemonHabilidad.Efecto__c = (String)element.get('short_effect'); 
        }
            
        //update fuera del for para guardar datos de cada pokemon
        try {
            upsert pokemonHabilidad ExtId__c;  
        } catch (Exception e) {
            system.debug('Error: ' + e.getMessage());
        } 
        
    }
    public static void finish(Database.BatchableContext bc){
        system.debug('Pase por el finish');
    }
}
