@isTest
public class CallOutPokemonsMock {
    @TestSetup
    static void makeData(){
        List<Pokemon__c> listaPokemons = new List<Pokemon__c>();
        Pokemon__c pokemon1 = new Pokemon__c();
            pokemon1.Name = 'Pokemon1';
            pokemon1.ExtId__c = 1;
            pokemon1.Altura__c = 10;
            pokemon1.Peso__c= 10; 
            pokemon1.Imagen__c = 'Texto'; 
            pokemon1.Vida__c= 10; 
            pokemon1.Velocidad__c= 10; 
            pokemon1.Defensa__c= 10; 
            pokemon1.Ataque__c = 10; 
            pokemon1.Tipos__c = 'electric'; 
            // pokemon1.Generacion__c = 1;

            
        listaPokemons.add(pokemon1);

        Pokemon__c pokemon2 = new Pokemon__c(
            Name = 'Pokemon2',
            ExtId__c = 2, 
            Altura__c = 15, 
            Peso__c= 15, 
            Imagen__c = 'Texto2', 
            Vida__c= 15, 
            Velocidad__c= 15, 
            Defensa__c= 15, 
            Ataque__c = 15, 
            Tipos__c = 'normal'
            //Generacion__c = 1
            );
        listaPokemons.add(pokemon2);

        insert listaPokemons;
    }

    
    @isTest static void shouldInsertAllPokemons(){
        //VER Y MEJORAR EL CODE COVERAGE
        
        
        Test.setMock(HttpCalloutMock.class, new BatchSyncMockTest());
        // HttpResponse res = CallOutPokemons.execute(bc, listaPokemons);
        CallOutPokemons batch = new CallOutPokemons();
        // Class CallOutPokemonsMock must implement the method: System.HttpResponse System.HttpCalloutMock.respond(System.HttpRequest) 
        
        Test.startTest();
        	database.executeBatch(batch,200);
        Test.stopTest();
 		
        // List<Pokemon__c> pokemonsEnLaBD = [
        //     SELECT Name, ExtId__c, Altura__c, Peso__c, Imagen__c, Vida__c, Velocidad__c, Defensa__c, Ataque__c, Tipos__c, Generacion__c
		// 	FROM Pokemon__c
        // ];
        // System.assertEquals(2, pokemonsEnLaBD.size(), 'la cantidad de pokemons no es la correspondiente ::' + pokemonsEnLaBD.size());
    }
}
