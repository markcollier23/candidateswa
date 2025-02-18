//Author: Mark Collier 
public class Animals{ 
    public static JSONObject get(String url) { 
        Http http = new Http(); 
        HttpRequest request = new HttpRequest(); 
        request.setEndpoint(url); 
        request.setMethod('GET'); 
        HttpResponse response = http.send(request); 
        return new JSONObject(response.getBody()); 
    } 
    public static HttpResponse post(JSONObject output,String url) { 
        Http http = new Http(); 
        HttpRequest request = new HttpRequest(); 
        request.setEndpoint(url); 
        request.setMethod('POST'); 
        request.setHeader('Content-Type', 'application/json;charset=UTF-8'); 
        request.setBody(output.text); 
        return http.send(request); 
    } 
}