public class DataFactory {
    
    private AccountFactory af;
    private CaseFactory cf;
    private OpportunityFactory opf;

    class DataFactoryException extends Exception {}
    
    public DataFactory() {
        af = new AccountFactory();
        cf = new CaseFactory();
        opf = new OpportunityFactory();
    }

    public Id generateData() {
        // Check for concurrent BatchRecordCreator jobs
        Id runningJobId = BatchRecordCreator.getRunningJobId();
        if (runningJobId != null) {
            throw new DataFactoryException('Can only run one BatchRecordCreator job at time. Found existing job: '+ runningJobId);
        }
        
        // Clean previously generated data if any
        af.deleteGeneratedAccountsAndRelatedRecords();

        // Generate accounts
        List<Account> accounts = af.generate();
        insert accounts;

        List<Case> cases = new List<Case>();
        List<Opportunity> opportunities = new List<Opportunity>();

        for (Account account : accounts) {
            // Generate cases
            cases.addAll(cf.generate(account));

            // Generate opportunities
            opportunities.addAll(opf.generate(account));
        }
        insert cases;
        insert opportunities;

        // Skip batch operations when running tests
        if (Test.isRunningTest()) {
            return null;
        }
    }

}