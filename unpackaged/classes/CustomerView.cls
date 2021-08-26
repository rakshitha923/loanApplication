public with sharing class CustomerView {
    @AuraEnabled(cacheable=true)
    public static List<CustomerViewWrapper> getCustomerDetail(String accountId)
    {
        List<Id> accountIdList = accountId.split(',');
        System.debug(accountIdList);
        List<CustomerViewWrapper> wrapperList = new  List<CustomerViewWrapper>();
        try {
            List<Account> accountList = [SELECT Id,Name,AccountNumber,(SELECT Id,CaseNumber,Status,Owner.Name FROM Cases)  FROM Account Where Id In:accountIdList];
            Map<Id,List<LoanApplication__c>> accountLpMap = new Map<Id,List<LoanApplication__c>>();
            For(LoanApplication__c lp: [SELECT Id,Tenure__c,Name,Status__c,RecordType.Name,LoanAmount__c,FundReleasedDate__c,Customer__c,(SELECT Id,EMIAmount__c,Duedate__c,Amountpayed__c,InterestAmount__c,PrincipalAmount__c FROM Payment_Details__r) FROM LoanApplication__c Where Customer__c In:accountIdList])
            {
                if(!accountLpMap.containsKey(lp.Customer__c)){
                    accountLpMap.put(lp.Customer__c,new List<LoanApplication__c>());
                }
                accountLpMap.get(lp.Customer__c).add(lp);
            }
            
            
            
            For(Account accRec : accountList){
                CustomerViewWrapper wrapper = new  CustomerViewWrapper();
                CustomerViewWrapper.Accounts acc = new CustomerViewWrapper.Accounts();
                acc.name = accRec.Name;
                acc.id = accRec.Id;
                acc.cases = accRec.Cases.size()>0? accRec.Cases:new List<Case>();
                //acc.creditScore = accRec.creditScore__c;
                //acc.adharKYC = accRec.AdharKYC__c;
                acc.accNumber = accRec.AccountNumber;
                acc.caseHeader = accRec.Name+'\''+'s Cases';
                acc.loanHeader = accRec.Name+'\''+'s Loan applications';
                acc.paymentHeader = accRec.Name+'\''+'s Payment Details';
                List<CustomerViewWrapper.LoanApplication> loanAppLst = new List<CustomerViewWrapper.LoanApplication>();
                if(accountLpMap.containsKey(accRec.Id)){
                    For(LoanApplication__c lp: accountLpMap.get(accRec.Id)){
                        CustomerViewWrapper.LoanApplication loanApp = new CustomerViewWrapper.LoanApplication();
                        loanApp.name = lp.Name;
                        loanApp.recordTypeName = lp.RecordType.Name;
                        loanApp.tenure = lp.Tenure__c;
                        loanApp.status = lp.Status__c;
                        loanApp.loanAmount = lp.LoanAmount__c;
                        List<CustomerViewWrapper.PaymentDetails> payLst = new List<CustomerViewWrapper.PaymentDetails>(); 
                        For(PaymentDetail__c payDet: lp.Payment_Details__r){
                            CustomerViewWrapper.PaymentDetails pay = new CustomerViewWrapper.PaymentDetails();
                            pay.duedate = payDet.Duedate__c;
                            pay.eMIAmount = payDet.EMIAmount__c;
                            pay.amountpayed= payDet.Amountpayed__c;
                            pay.interestAmount= payDet.InterestAmount__c;
                            pay.principalAmount = payDet.PrincipalAmount__c;
                            pay.paystatus =  payDet.Amountpayed__c==null?'Not Paid':'Paid';
                            payLst.add(pay);
                        }
                        loanApp.payDetail=payLst;
                        loanAppLst.add(loanApp);
                        
                    }
                }
                acc.loanAppl=loanAppLst;
                wrapper.accounts = acc;
                wrapperList.add(wrapper);
            }
            System.debug(wrapperList);
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return wrapperList;
    }
}