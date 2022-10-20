@isTest
public with sharing class CallOutPokemonsMovimientosTest {
    @isTest static void CallOutPokemonsMovimientosTest() {
        
        Test.setMock(HttpCalloutMock.class, new MockTestMovimientos());
        
        CallOutPokemonsMovimientos bs = new CallOutPokemonsMovimientos();

        Test.startTest();
        	database.executeBatch(bs,1);
        Test.stopTest();
        
        Movimiento__c move = [
                            SELECT Id, ExtId__c, Punteria__c, Chance_de_Efecto__c, Prioridad__c,
                            Poder__c, Pp__c, Objetivo__c, Tipo__c, Efecto__c 
                            FROM Movimiento__c 
                            WHERE ExtId__c = 1
                            ];

        System.assertEquals(1, move.ExtId__c,'Error, el External Id es: ' + move.ExtId__c);
        System.assertEquals(100, move.Punteria__c,'Error, la Punteria es: ' + move.Punteria__c);
        System.assertEquals(null, move.Chance_de_Efecto__c,'Error, la Chance de Efecto es: ' +
                            move.Chance_de_Efecto__c);
        System.assertEquals(0, move.Prioridad__c,'Error, la Prioridad es: ' + move.Prioridad__c);
        System.assertEquals(40, move.Poder__c,'Error, el Poder es: ' + move.Poder__c);
        System.assertEquals(35, move.Pp__c,'Error, el Pp es: ' + move.Pp__c);
        System.assertEquals('selected-pokemon', move.Objetivo__c,'Error, el Objetivo es: ' + move.Objetivo__c);
        System.assertEquals('Normal', move.Tipo__c,'Error, el Tipo es: ' + move.Tipo__c);
        System.assertEquals('Inflicts regular damage with no additional effect.',
                            move.Efecto__c,'Error, el Efecto es: ' + move.Efecto__c);
    }
}
