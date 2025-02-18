//Author: Mark Collier 
@isTest 
public class AnimalsTest { 
    @isTest static void testGetCallout() { 
        // Create the mock response based on a static resource 
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock(); 
        mock.setStaticResource('Animals'); 
        mock.setStatusCode(200); 
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8'); 
        // Associate the callout with a mock response 
        Test.setMock(HttpCalloutMock.class, mock); 
        // Call method to test 
        JSONObject result = Animals.get('https://th-apex-http-callout.herokuapp.com/animals'); 
        // Verify mock response is not null 
        System.assertNotEquals(null,result,'The callout returned a null response.'); 
    }    
   @isTest static void testPostCallout() { 
		// Set mock callout class  
		Test.setMock(HttpCalloutMock.class, new AnimalsMock());  
		// This causes a fake response to be sent 
		// from the class that implements HttpCalloutMock.  
		JSONObject expected = new JSONObject('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}'); 
		HttpResponse response = Animals.post(expected,'https://th-apex-http-callout.herokuapp.com/animals'); 
		String contentType = response.getHeader('Content-Type'); 
		System.assert(contentType == 'application/json'); 
		String actualValue = response.getBody(); 
		System.debug(response.getBody()); 
		System.assertEquals(actualValue, expected.text); 
		System.assertEquals(200, response.getStatusCode()); 
    }    
}