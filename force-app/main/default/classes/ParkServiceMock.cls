@isTest
global class ParkServiceMock implements WebServiceMock {
   global void doInvoke(
       Object stub,
       Object request,
       Map<String, Object> response,
       String endpoint,
       String soapAction,
       String requestName,
       String responseNS,
       String responseName,
       String responseType) {
           ParkService.byCountryResponse return_x = new ParkService.byCountryResponse();
           return_x.return_x = new String[]{'Germany'};
           response.put('response_x',return_x);
   }
}