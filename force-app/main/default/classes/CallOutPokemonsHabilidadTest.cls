@isTest
public class CallOutPokemonsHabilidadTest {
    @isTest static void CallOutPokemonsHabilidadTest() {

        //Seteo el mock y le paso el tipo de interfaz & la instacia de mi respuesta falsa
        Test.setMock(HttpCalloutMock.class, new MockTestHabilidad());
        //Instancia de mi clase a testear
        CallOutPokemonsHabilidad bs = new CallOutPokemonsHabilidad();

        Test.startTest();
            //"bs" nombre del paso de parametro de mi execute en el batch
        	database.executeBatch(bs,1);
        Test.stopTest();

        //Query con lo que voy a retornar de mi db
        Habilidad__c habilidad = [
                                SELECT Id, ExtId__c, Efecto__c 
                                FROM Habilidad__c 
                                WHERE ExtId__c = 1
                                ];
        
        //Comparo --> (expected, actual, msg)
        System.assertEquals(1, habilidad.ExtId__c,'Error, el External Id es: ' + habilidad.ExtId__c);
        System.assertEquals('Has a 10% chance of making target Pokémon flinch with each hit.',
        habilidad.Efecto__c,'Error, el efecto es: ' + habilidad.Efecto__c);
    }
}