@isTest

private with sharing class PokeControllerTest {
    @isTest
    static void getPokemonsListTest(){
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
        listaPokemons.add(pokemon1);

        List<Pokemon__c> listaFiltros = new List<Pokemon__c>();
        Pokemon__c pokemon2 = new Pokemon__c();
            pokemon2.Name = 'pikachu';
            pokemon2.ExtId__c = 2;
            pokemon2.Altura__c = 15;
            pokemon2.Peso__c= 15; 
            pokemon2.Imagen__c = 'Texto2'; 
            pokemon2.Vida__c= 15; 
            pokemon2.Velocidad__c= 15; 
            pokemon2.Defensa__c= 15; 
            pokemon2.Ataque__c = 15; 
            pokemon2.Tipos__c = 'electric'; 
            pokemon2.Generacion__c = '1'; 
        listaPokemons.add(pokemon2);

        insert listaFiltros;

        test.startTest();
            listaPokemons = PokeController.getPokemonsList();    
            listaFiltros = PokeController.getPokemonsGen('pikachu', '1', 'electric');    
        test.stopTest();
        
        System.assertEquals(2, listaPokemons.size(),'lista completa de pokemons');
        System.assertEquals(1, listaPokemons.size(),'lista de filtros');
        // String resupuestaObtenida = PokeController.getMovimientoList;
        // System.assertEquals(expected, actual,'');


        // String resupuestaObtenida = PokeController.getPokemonsFilter;
        // System.assertEquals(expected, actual,'');


        // String resupuestaObtenida = PokeController.getPokemonsGen;
        // System.assertEquals(expected, actual,'');
    }

}
