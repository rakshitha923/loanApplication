public with sharing class AccountStandardController {
    public List<Account> selAccLst;
    public String accIds{get;set;}
    public AccountStandardController(ApexPages.StandardSetController  cntlr)
    {
        selAccLst = cntlr.getSelected(); 
        accIds = '';  
           for(Account acc : selAccLst){
               accIds += acc.Id + ','; //build list of ids string concatenated with comma                         
            }
           accIds = accIds.removeEnd(','); 
    }

   

}