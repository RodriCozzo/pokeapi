@isTest
global class BatchSyncMockTest implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        
        res.setBody('Success');
        res.setStatusCode(200);
        return res;
    }
}