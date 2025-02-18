public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String postCode){
        List<Contact> contacts = new List<Contact>();
        Contact[] contakt = [SELECT ID, Name FROM Contact WHERE LastName=:lastName AND MailingPostalCode=:postCode];
        for(Integer i=0;i<contakt.size();i++){
            contacts.add(contakt[i]);
        }
		return contacts;        
    }
}