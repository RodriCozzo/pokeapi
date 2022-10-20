@isTest
public class CallOutPokemonsTest {
    @isTest static void testCallOutPokemonsClass(){
        
        Test.setMock(HttpCalloutMock.class, new BatchSyncMockTest());
        
        CallOutPokemons bs = new CallOutPokemons();

        Test.startTest();
        	database.executeBatch(bs,1);
        Test.stopTest();
        
        Pokemon__c poke = [SELECT Id, Name, ExtId__c, Numero_de_Pokemon__c, Altura__c, Peso__c,
                            Imagen__c, Vida__c, Ataque__c, Defensa__c, Velocidad__c, Tipos__c 
                            FROM Pokemon__c 
                            WHERE ExtId__c = 1
                            ];
        
        System.assertEquals('bulbasaur', poke.Name,'Error, el Nombre es: ' + poke.Name);
        System.assertEquals(1, poke.ExtId__c,'Error, el External Id es: ' + poke.ExtId__c);
        System.assertEquals(1, poke.Numero_de_Pokemon__c,'Error, el Numero de Pokemon es: ' 
                            + poke.Numero_de_Pokemon__c);
        System.assertEquals(7, poke.Altura__c,'Error, la Altura es: ' + poke.Altura__c);
        System.assertEquals(69, poke.Peso__c,'Error, el Peso es: ' + poke.Peso__c);
        System.assertEquals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
                            poke.Imagen__c,'Error, la URL de la imagen es: ' + poke.Imagen__c);

        System.assertEquals(45, poke.Vida__c,'Error, la Vida es: ' + poke.Vida__c);
        System.assertEquals(49, poke.Ataque__c,'Error, el Ataque es: ' + poke.Ataque__c);
        System.assertEquals(49, poke.Defensa__c,'Error, la Defensa es: ' + poke.Defensa__c);
        System.assertEquals(45, poke.Velocidad__c,'Error, la Velocidad es: ' + poke.Velocidad__c);
        System.assertEquals('Grass;Poison', poke.Tipos__c,'Error, el/los Tipo/s son: ' + poke.Tipos__c);
        
    }
}