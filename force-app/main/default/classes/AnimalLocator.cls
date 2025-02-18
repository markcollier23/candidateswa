public class AnimalLocator {
    public static String getAnimalNameById(Integer AnimalID){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+AnimalID);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        Map<string,object> animals = (map<string,object>) results.get('animal');
        return String.valueOf(animals.get('name'));
    }
}