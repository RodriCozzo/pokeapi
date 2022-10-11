public class CallOutPokemonsHabilidad implements Database.Batchable<Habilidad__c>,Database.AllowsCallouts{
   
    //Database.executeBatch(new CallOutPokemonsHabilidad(),100);
    public static List<Habilidad__c> start(Database.BatchableContext bc){
        system.debug('Pase por el start');
        // Llamada a la Api
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/ability?offset=0&limit=267'); 
        request.setMethod('GET');        
        HttpResponse respon = http.send(request);
        List<Object> listRespon = new List<Object>(); 

        Map<String, Object> results = new Map<String, Object>();
        if(respon.getStatusCode() == 200) {            
            results = (Map<String, Object>) JSON.deserializeUntyped(respon.getBody());            
            listRespon = (List<Object>) results.get('results');                         
        }
        List<Habilidad__c> habilidades = new List<Habilidad__c>();
        if (!listRespon.isEmpty()) {
            for (Object pokeHabil : listRespon) {
                Habilidad__c habilidad = new Habilidad__c();
                Map<String,Object> pokeHab = (Map<String, Object>)pokeHabil;
                habilidad.Name = (String)pokeHab.get('name');
                habilidades.add(habilidad);                
            }
        }  
        try {
            insert habilidades;
        } catch (Exception e) {
            system.debug('Error: ' + e.getMessage());
        } 
        return habilidades;
        // Guardar los pokemon
        // Retornar la lista insertada
    }
    public static void execute(Database.BatchableContext bc, List<Habilidad__c> habilidades){
        // 1 a 1 llamar a pokemon
        // Bucle de pokemons 
        for (Habilidad__c pokeHabil : habilidades) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://pokeapi.co/api/v2/ability/'+pokeHabil.Name); 
            request.setMethod('GET');        
            HttpResponse response = http.send(request);
            
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug(results.get('id'));
            pokeHabil.ExtId__c = (Integer)results.get('id');
            
            ////////////Con esto fuerzo la lista//////////
            List<Map<String, Object>> effectEntries = new List<Map<String, Object>>();            
            for (Object instance : (List<Object>)results.get('effect_entries')){
                effectEntries.add((Map<String, Object>)instance);
            }
            System.debug(effectEntries);
            //////////Con esto la recorro//////////
            for (Map<String, Object> element : effectEntries) {           
                pokeHabil.Efecto__c = (String)element.get('short_effect'); 
            }
            
            
        }
        //update fuera del for para guardar datos de cada pokemon
        
        update habilidades;        
        system.debug('Pase por el execute');
    }
    public static void finish(Database.BatchableContext bc){
        system.debug('Pase por el finish');
    }
}
