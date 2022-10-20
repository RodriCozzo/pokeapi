@isTest
global class PokeControllerTest {
    @isTest static void getPokemonsListTest1(){
        List<Pokemon__c> listaPokemons = new List<Pokemon__c>();
        Pokemon__c pokemon1 = new Pokemon__c();
            pokemon1.Name = 'bulbasaur';
            pokemon1.ExtId__c = 1;
            pokemon1.Altura__c = 7;
            pokemon1.Peso__c= 	69; 
            pokemon1.Imagen__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png'; 
            pokemon1.Vida__c= 45; 
            pokemon1.Velocidad__c= 45; 
            pokemon1.Defensa__c= 49; 
            pokemon1.Ataque__c = 49; 
            pokemon1.Tipos__c = 'Grass;Poison'; 
        listaPokemons.add(pokemon1);

        
        Pokemon__c pokemon2 = new Pokemon__c();
            pokemon2.Name = 'ivysaur';
            pokemon2.ExtId__c = 2;
            pokemon2.Altura__c = 10;
            pokemon2.Peso__c= 130; 
            pokemon2.Imagen__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png	'; 
            pokemon2.Vida__c= 60; 
            pokemon2.Velocidad__c= 60; 
            pokemon2.Defensa__c= 63; 
            pokemon2.Ataque__c = 62; 
            pokemon2.Tipos__c = 'Grass;Poison'; 
            
        listaPokemons.add(pokemon2);

        insert listaPokemons;
        
        test.startTest();
        //Database.countQuery(query)
        PokeController testController = new PokeController();
        listaPokemons = testController.getPokemonsList();
        test.stopTest();
        
        // System.assert( poke  != null);
        System.assertEquals(2, listaPokemons.size(),'Error, lista incompleta de pokemons a retornar');
        
        
    }
    @isTest static void getPokemonsListTest2(){
        List<Pokemon__c> listaFiltros = new List<Pokemon__c>();
        Pokemon__c pokemon1 = new Pokemon__c();
            pokemon1.Name = 'bulbasaur';
            pokemon1.ExtId__c = 1;
            pokemon1.Altura__c = 7;
            pokemon1.Peso__c= 	69; 
            pokemon1.Imagen__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png'; 
            pokemon1.Vida__c= 45; 
            pokemon1.Velocidad__c= 45; 
            pokemon1.Defensa__c= 49; 
            pokemon1.Ataque__c = 49; 
            pokemon1.Tipos__c = 'Grass;Poison'; 
            listaFiltros.add(pokemon1);

        Pokemon__c pokemon2 = new Pokemon__c();
            pokemon2.Name = 'ivysaur';
            pokemon2.ExtId__c = 2;
            pokemon2.Altura__c = 10;
            pokemon2.Peso__c= 130; 
            pokemon2.Imagen__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png	'; 
            pokemon2.Vida__c= 60; 
            pokemon2.Velocidad__c= 60; 
            pokemon2.Defensa__c= 63; 
            pokemon2.Ataque__c = 62; 
            pokemon2.Tipos__c = 'Grass;Poison'; 
            
            listaFiltros.add(pokemon2);

        insert listaFiltros;
        
        test.startTest();
        //Database.countQuery(query)
        PokeController testController = new PokeController();
        //listaPokemons = testController.getPokemonsList();
        listaFiltros = PokeController.getPokemonsGen('ivysaur', '1', 'Grass;Poison');
        test.stopTest();
        
        // System.assert( poke  != null);
        System.assertEquals(1, listaFiltros.size(),
        'Error, debería devolver Pokemon: ivysaur, Generacion: 1, Tipo: Grass;Poison');
        
        
    }
    
}

//System.assertEquals(2, listaPokemons.size(),'Lista completa de pokemons');
// listaFiltros = PokeController.getPokemonsGen('ivysaur', '1', 'Grass;Poison'); 
// LoanProspectsController  testCont = new LoanProspectsController ();
// List<Prospect__c> lstProspect = testCont.getProspects();   