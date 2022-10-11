public class CallOutPokemons implements Database.Batchable<Pokemon__c>,Database.AllowsCallouts{
    
    
    //Database.executeBatch(new CallOutPokemons(),100);
    public static List<Pokemon__c> start(Database.BatchableContext bc){
        System.debug('Pase por el start');
        
        // Llamada a la Api
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon?offset=0&limit=898'); 
        request.setMethod('GET');        
        HttpResponse response = http.send(request);


        List<Object> listResponse = new List<Object>(); 
        
        //LISTA DE RESPUESTA DONDE GUARDO MI PRIMER MAPEO RESULT
        Map<String, Object> results = new Map<String, Object>();
        
        //GUARDAMOS POKEMONS EN ESTA LISTA
        List<Pokemon__c> pokemons = new List<Pokemon__c>();
        
        //SOLO ENTRA EN FASE DE TEST
        if(Test.isRunningTest()){
            String dataJSON = '"results":[{"name": "bulbasaur","url": "https://pokeapi.co/api/v2/pokemon/1/"}]';    
            results = (Map<String, Object>) JSON.deserializeUntyped(dataJson);
            listResponse = (List<Object>) results.get('results'); 
        
        } else {
            if(response.getStatusCode() == 200) {            
                results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());            
                listResponse = (List<Object>) results.get('results');                   
            }
        }
        
        if (!listResponse.isEmpty()) {
            for (Object pokeNamesss : listResponse) {
                Pokemon__c pokemon = new Pokemon__c();
                Map<String,Object> pokeName = (Map<String, Object>)pokeNamesss;
                pokemon.Name = (String)pokeName.get('name');
                pokemons.add(pokemon);                
            }
        }

        try {
            insert pokemons;
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        } 

        
        return pokemons;
        // Retornar la lista de pokemons
    }


    public static void execute(Database.BatchableContext bc, List<Pokemon__c> pokemons){
        
        // Llamar 1 a 1  a mi lista de pokemons - Para deserializar el JSON de pokemons 
        
        for (Pokemon__c poke : pokemons) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+poke.Name); 
            request.setMethod('GET');   
            HttpResponse response = http.send(request);
            
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            System.debug(results.get('id'));
            poke.ExtId__c = (Integer)results.get('id');
            poke.Altura__c = (Integer)results.get('height');  
            poke.Peso__c = (Integer)results.get('weight');          
            poke.Imagen__c = (String)((Map<String, Object>)((Map<String, Object>)((Map<String, Object>)results.get('sprites')).get('other')).get('dream_world')).get('front_default');                       
            
            ////////////Con esto fuerzo la lista//////////
            List<Map<String, Object>> listStats = new List<Map<String, Object>>();
            for (Object instance : (List<Object>)results.get('stats')){
                listStats.add((Map<String, Object>)instance);
            }
            System.debug(listStats);
            //////////Con esto la recorro//////////
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
            

           ////////////Con esto fuerzo la lista//////////

           List<Map<String, Object>> types = new List<Map<String, Object>>();
            for (Object inst : (List<Object>)results.get('types')){
                types.add((Map<String, Object>)inst);    
            }
            ////////////Con esto la recorro//////////

            String tipoAux;
            for (Map<String, Object> element : types) {
                Map<String, Object> type = (Map<String, Object>)element.get('type');
                tipoAux = (String)type.get('name') + ';';
            }
            poke.Tipos__c = tipoAux;  

            }






        //    List<Map<String, Object>> listTypes = new List<Map<String, Object>>();
        //    for (Object inst : (List<Object>)results.get('types')){
        //     listTypes.add((Map<String, Object>)inst);
        //    }
           //////////Con esto la recorro//////////
        //    String tipoAux1='';
        //    String tipoAux2='';
        //    for (Map<String, Object> element : listTypes) {
        //        Map<String, Object> type = (Map<String, Object>)element.get('type');
        //         //    tipoAux = (String)type.get('name') + ';';
        //         If(1 == (Integer)type.get('slot')){
        //             tipoAux1= (String)element.get('name');
        //         }

        //         If(2 == (Integer)type.get('slot')){
        //             tipoAux2= (String)element.get('name');
        //         }
        //         // if(String.isNotBlank( searchTipo )){
                    
        //         // }
        //    }
        //    poke.Tipos__c = tipoAux1 + '\';\'' + tipoAux2;

        //update fuera del for para guardar datos de cada pokemon
        update pokemons;        
        system.debug('Pase por el execute');
    }
    public static void finish(Database.BatchableContext bc){
        system.debug('Pase por el finish');
    }
}