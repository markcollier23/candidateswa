public class StringArrayTest {
    public static List<String> generateStringArray(Integer numberOfStrings){
        List<String> stringArray = new List<String>();
        for(Integer i=0;i<numberOfStrings;i++){
            stringArray.add('Test '+i);
        }
    return stringArray;
    }
}