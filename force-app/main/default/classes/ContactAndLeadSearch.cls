public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String name){
        List<List<SObject>> contactsAndLeads = [FIND :name IN NAME FIELDS RETURNING Contact(Name), Lead(Name)];
        return contactsAndLeads;
    }
}