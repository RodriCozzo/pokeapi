public with sharing class CallOutPokeApi {
    public static final String URL = 'https://pokeapi.co/api/v2/pokemon';

    public static void getAllPokemons() {
        
        //Instancio HTTP, HTTPRequest, HTTPResponse
        Http http = new Http();
        HttpRequest request = new HttpRequest();
            request.setEndpoint(URL);
            request.setMethod('GET');
        
            HttpResponse response = http.send(request);
        Map<String, Object> results = new Map<String, Object>();
        List<Object> listResponse = new List<Object>();

        Integer counter = 0;
        Map<String, Object> pokeName = new Map<String, Object>();
        List<String> name = new List<String>();
        
            if(response.getStatusCode() == 200) {            
            results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());            
            listResponse = (List<Object>) results.get('results');            
            }
            if (!listResponse.isEmpty()) {
                for (Object pokeNamesss : listResponse) {
                    pokeName = (Map<String, Object>)pokeNamesss;
                    if (counter<10) {
                        name.add((String)pokeName.get('name')); //Casteado para pasarlo a string
                    }
                }
            }    
    }
}
