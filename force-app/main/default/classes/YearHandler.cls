public class YearHandler implements DateHandler{
    public List<String> getList(Integer startingYear,Integer startingMonth,Integer size){
        List<String> years = new List<String>();
        for(Integer i=startingYear;i<size+startingYear;i++){
            years.add(String.valueOf(i));
        }
        return years;
    }
}