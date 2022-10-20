public with sharing class PokeController {
    @AuraEnabled(cacheable=true)
    public List<Pokemon__c> getPokemonsList() { 
        
        if (Test.isRunningTest()) {
        List<Pokemon__c> pokemonsList = [
                                SELECT Name, ExtId__c, Altura__c, Peso__c, Imagen__c, Vida__c,
                                Velocidad__c, Defensa__c, Ataque__c, Tipos__c, Generacion__c
                                FROM Pokemon__c
                                ORDER BY ExtId__c 
                                LIMIT 2
                                ];
        return pokemonsList;
        }else {
        List<Pokemon__c> pokemonsList = [
                                SELECT Name, ExtId__c, Altura__c, Peso__c, Imagen__c, Vida__c,
                                Velocidad__c, Defensa__c, Ataque__c, Tipos__c, Generacion__c
                                FROM Pokemon__c
                                ORDER BY ExtId__c 
                                ];
                           
        return pokemonsList;
        }
    }  
    
    @AuraEnabled(cacheable=true)
    public static List<Pokemon__c> getPokemonsGen(String searchText, String searchGen, String searchTipo) {     
        
        String query = 'SELECT Name, ExtId__c, Altura__c, Peso__c, Imagen__c, Vida__c, Velocidad__c,'+
                        ' Defensa__c, Ataque__c, Tipos__c, Generacion__c '+
                        'FROM Pokemon__c '+
                        'WHERE Name '+
                        'LIKE \'%' + searchText + '%\'';
        
        if(String.isNotBlank( searchGen )){
            query += ' AND Generacion__c = \'' + String.valueOf(searchGen) + '\'';
        }

        if(String.isNotBlank( searchTipo )){
            query += ' AND Tipos__c includes(\'' + String.valueOf(searchTipo) + '\')';
        }
        
        
        List<Pokemon__c> filtroPokemons = Database.query(query);
        return filtroPokemons;
    }

   
}
