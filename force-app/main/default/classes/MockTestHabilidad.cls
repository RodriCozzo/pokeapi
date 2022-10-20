@isTest
global class MockTestHabilidad implements HttpCalloutMock{
    // First implements HttpCalloutMock in the class
    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response.
        HttpResponse res = new HttpResponse();
        // Set response values, and return response.
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody('{"effect_changes":[],"effect_entries":[{"effect":"Attacken die Schaden verursachen haben mit jedem Treffer eine 10% Chance das Ziel zurückschrecken zu lassen, wenn die Attacke dies nicht bereits als Nebeneffekt hat.Der Effekt stapelt nicht mit dem von getragenen Items.Außerhalb vom Kampf: Wenn ein Pokémon mit dieser Fähigkeit an erster Stelle im Team steht, tauchen wilde Pokémon nur halb so oft auf.","language":{"name":"de","url":"https://pokeapi.co/api/v2/language/6/"},"short_effect":"Mit jedem Treffer besteht eine 10% Chance das Ziel zurückschrecken zu lassen."},{"effect":"This Pokémons damaging moves have a 10% chance to make the target flinch with each hit if they do not already cause flinching as a secondary effect.This ability does not stack with a held item.Overworld: The wild encounter rate is halved while this Pokémon is first in the party.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Has a 10% chance of making target Pokémon flinch with each hit."}],"flavor_text_entries":[],"generation":{},"id":1,"is_main_series":true,"name":"stench","names":[],"pokemon":[]}');
        return res;

        //Optionally, only send a mock response for a specific endpoint and method.
        //System.assertEquals('https://pokeapi.co/api/v2/pokemon/1', req.getEndpoint());
        //System.assertEquals('GET', req.getMethod());
    }
}