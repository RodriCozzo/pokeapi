public class CallOutPokemons implements Database.Batchable<Pokemon__c>,Database.AllowsCallouts{
    
    //Database.executeBatch(new CallOutPokemons(),1);
    
    public static List<Pokemon__c> start(Database.BatchableContext bc){
        List<Pokemon__c> pokemons = new List<Pokemon__c>();
        
        if (Test.isRunningTest()) {
            for (Integer i=1; i<=1; i++) {
                Pokemon__c pokemon = new Pokemon__c(ExtId__c=i);
                pokemons.add(pokemon);
            }
        }else {
            for (Integer i=1; i<=898; i++) {
                Pokemon__c pokemon = new Pokemon__c(ExtId__c=i);
                pokemons.add(pokemon);
            }
        }
        
        insert pokemons;
        System.debug('Pase por el START' + pokemons);

        return pokemons;

    }

    public static void execute(Database.BatchableContext bc, List<Pokemon__c> pokemons){
        system.debug('Pase por el EXECUTE');
        // Llamar 1 a 1  a mi lista de pokemons - Para deserializar el JSON de pokemons
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+pokemons[0].ExtId__c);         
        request.setMethod('GET'); 
        HttpResponse response = http.send(request);
        
        
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        System.debug(results);


        Pokemon__c poke = new Pokemon__c(); 
        poke.Name = (String)results.get('name');
        poke.ExtId__c = (Integer)results.get('id');
        poke.Numero_de_Pokemon__c = (Integer)results.get('order');
        poke.Altura__c = (Integer)results.get('height');  
        poke.Peso__c = (Integer)results.get('weight');          
        poke.Imagen__c = (String)((Map<String, Object>)((Map<String, Object>)((Map<String, Object>)results.get('sprites')).get('other')).get('official-artwork')).get('front_default');                       
        
        
        List<Map<String, Object>> listStats = new List<Map<String, Object>>();
        for (Object instance : (List<Object>)results.get('stats')){
            listStats.add((Map<String, Object>)instance);
        }
        System.debug(listStats);
        
        for (Map<String, Object> element : listStats) {
            Map<String, Object> statsData = (Map<String, Object>)element.get('stat');
            If('hp' == (String)statsData.get('name')){
                poke.Vida__c = (Integer)element.get('base_stat');
            }
            
            If('attack' == (String)statsData.get('name')){
                poke.Ataque__c = (Integer)element.get('base_stat');
            }

            If('defense' == (String)statsData.get('name')){
                poke.Defensa__c = (Integer)element.get('base_stat');
            }

            If('speed' == (String)statsData.get('name')){
                poke.Velocidad__c = (Integer)element.get('base_stat');
            }
        }        
        //////////////Lista de TIPOS//////////
        List<Map<String, Object>> types = new List<Map<String, Object>>();
        for (Object inst : (List<Object>)results.get('types')){
            types.add((Map<String, Object>)inst);
        }
        String tipoAux='';
        for (Map<String, Object> element : types) {
            Map<String, Object> type = (Map<String, Object>)element.get('type');
            tipoAux += ((String)type.get('name')) + ';';
        }            
        poke.Tipos__c = tipoAux;        

        ////////////////////EJECUTO O MODIFICO/////////////////////////
        try {
            upsert poke ExtId__c; 
        } catch (Exception e) {
            system.debug('Error: ' + e.getMessage());
        }      
        
    }
    public static void finish(Database.BatchableContext bc){
        system.debug('Pase por el finish');
    }
}