@isTest
public class ParkLocatorTest {
    @isTest static void testCallout(){
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
    	String[] countryList = ParkLocator.country('Germany');
        System.assertEquals(countryList,new String[]{'Germany'});    
    }
}