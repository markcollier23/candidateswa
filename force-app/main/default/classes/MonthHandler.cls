public class MonthHandler implements DateHandler{
    public List<String> getList(Integer startingYear,Integer startingMonth,Integer size){
        DateList dates = new DateList();
        List<String> months = new List<String>();
        Integer i=startingMonth-1;
        for(Integer m=startingMonth;m<size+startingMonth;m++){
            if(i>=dates.allMonthsList.size()){
                i=0;
                startingYear++;
            }
            months.add(dates.allMonthsList[i++]+' '+startingYear);
        }
        return months;
    }
}