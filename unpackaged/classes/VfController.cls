public with sharing class VfController {
    private ApexPages.StandardSetController standardController;

    public VfController(ApexPages.StandardSetController standardController)
    {
        this.standardController = standardController;
    }

    public PageReference bumpCases()
    {       
        // Get the selected records (optional, you can use getSelected to obtain ID's and do your own SOQL)
        List<Account> selectedAccount = (List<Account>) standardController.getSelected();
        List<String> recordId = new List<String>();
        // Update records       
        for(Account acc : selectedAccount)
        {
            recordId.add(acc.Id);
        }       

        return null;        
    }



}