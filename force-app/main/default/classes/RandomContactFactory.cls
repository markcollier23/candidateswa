public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer n,String surName){
        List<Contact> contacts = new List<Contact>();
        for(Integer i=0;i<n;i++){
            contacts.add(new Contact(firstName='Test '+i,lastName = surName));
        }
        return contacts;
    }
}