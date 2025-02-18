public class DateList{
    public Map<String,Integer> allMonthsMap;
    public List<String> allMonthsList;
    public Map<String,DateHandler> mapOfDates;
    public String TRAVERSE_THROUGH_YEARS = 'None';
    public DateList(){
        generateMonths();
        generateMap();
    }
    private void generateMap(){
        mapOfDates = new Map<String,DateHandler>();
        mapOfDates.put(TRAVERSE_THROUGH_YEARS,new YearHandler());
        for(String mmmm:allMonthsList)mapOfDates.put(mmmm,new MonthHandler());
    }
    private void generateMonths(){ 
        allMonthsMap = new Map<String,Integer>();
        allMonthsMap.put('January',1);
        allMonthsMap.put('February',2);
        allMonthsMap.put('March',3);
        allMonthsMap.put('April',4);
        allMonthsMap.put('May',5);
        allMonthsMap.put('June',6);
        allMonthsMap.put('July',7);
        allMonthsMap.put('August',8);
        allMonthsMap.put('September',9);
        allMonthsMap.put('October',10);
        allMonthsMap.put('November',11);
        allMonthsMap.put('December',12);
        allMonthsList = new List<String>(allMonthsMap.keySet());
    }
}