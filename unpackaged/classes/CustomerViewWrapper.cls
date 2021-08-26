public with sharing class CustomerViewWrapper {

  
	public class Accounts {
        @AuraEnabled public String id;
		@AuraEnabled public String name;
        @AuraEnabled public String creditScore;
        @AuraEnabled public Boolean adharKYC; 
        @AuraEnabled public String accNumber;
		@AuraEnabled public List<LoanApplication> loanAppl;
        @AuraEnabled public List<Case> cases;
        @AuraEnabled public String caseHeader;
        @AuraEnabled public String loanHeader;
        @AuraEnabled public String paymentHeader;
	}

	@AuraEnabled public Accounts accounts;

	public class LoanApplication {
		@AuraEnabled public String  name;
        @AuraEnabled public String  recordTypeName;
		@AuraEnabled public Decimal tenure;
        @AuraEnabled public String status;
        @AuraEnabled public Decimal loanAmount;
		@AuraEnabled public List<PaymentDetails> payDetail;
	}

    
   
    public class PaymentDetails {
		@AuraEnabled public Date duedate;
        @AuraEnabled public String paystatus;
        @AuraEnabled public Decimal eMIAmount;
        @AuraEnabled public Decimal amountpayed;
        @AuraEnabled public Decimal interestAmount;
        @AuraEnabled public Decimal principalAmount;
	}
}