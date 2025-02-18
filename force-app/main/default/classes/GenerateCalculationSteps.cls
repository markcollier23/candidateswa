public class GenerateCalculationSteps{
    public Map<String,Formula> mapOfSteps;
    public List<String> steps;
    public SuperannuationCalculator__c calculator;
    public GenerateCalculationSteps(SuperannuationCalculator__c calc){
        calculator = calc;
        generateSteps();
        generateMap();
    }
    private void generateSteps(){
        steps = new List<String>{
            calculator.first__c,
            calculator.second__c,
            calculator.third__c,
            calculator.fourth__c,
            calculator.fifth__c
        };
    }
    private void generateMap(){
        mapOfSteps = new Map<String,Formula>();
        mapOfSteps.put('Contribute',new Contribution());
        mapOfSteps.put('Grow',new Grow());
        mapOfSteps.put('Fee',new Fee());
        mapOfSteps.put('Tax',new Tax());
        mapOfSteps.put('ICR',new ICR());
    }
}