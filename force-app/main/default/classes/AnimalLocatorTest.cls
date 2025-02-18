@isTest
public class AnimalLocatorTest {
    @isTest static void test() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String body = AnimalLocator.getAnimalNameById(2); 
        System.assertEquals(body,'chicken');
    }
}