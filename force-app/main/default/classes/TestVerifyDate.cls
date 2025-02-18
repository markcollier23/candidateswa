@isTest
private class TestVerifyDate {
    public static Date sep = Date.newInstance(2019,09,23);
    public static Date oct = Date.newInstance(2019,10,3);
    public static Date jan = Date.newInstance(2019,1,22);
    public static Date esep = Date.newInstance(2019,09,30);
    public static Date ejan = Date.newInstance(2019,1,31);
    
    @isTest static void testCheckDates(){
        System.assertEquals(VerifyDate.CheckDates(sep,oct),oct);
        System.assertEquals(VerifyDate.CheckDates(jan,oct), ejan);
    }

}