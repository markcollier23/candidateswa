public class ParkLocator {
    public static String[] country(String name){
        ParkService.ParksImplPort park = new ParkService.ParksImplPort();
        List<String> state = new List<String>();
        for(Object nation:park.byCountry(name)){
            state.add(nation.toString());
        }
        return state;
    }
}