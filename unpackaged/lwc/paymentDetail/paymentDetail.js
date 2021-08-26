import { LightningElement,track } from 'lwc';
const COLS = [{
    fieldName: 'duedate',
    label: 'Due date'
},
{
    fieldName: 'recordTypeName',
    label: 'Loan Type',
    cellAttributes : {
        iconName: { fieldName : 'iconName'}
    }
}]
import {createMessageContext, releaseMessageContext, APPLICATION_SCOPE, subscribe, unsubscribe} from 'lightning/messageService';
import PAYDETAIL from "@salesforce/messageChannel/PaymentMessageChannel__c";
export default class PaymentDetail extends LightningElement {
    accName;
    @track paydet=[];
    loanName;
    context = createMessageContext();
    @track subscription = subscribe(this.context, PAYDETAIL, (message) => {
        this.handleMessage(message);
    }, {scope: APPLICATION_SCOPE});
    columns= COLS;
 
    handleMessage(event) {
        if (event) {
            console.log('paydet')
            this.paydet = event.paymentDetails;
            this.loanName = event.loanDetails;
            this.accName = event.accName;
            const activeEvent = new CustomEvent('active', { detail: this.accName});
           this.dispatchEvent(activeEvent);
        }
          
           
    }
    get title(){
        if(!this.loanName){
            return "Payment Details" 
        }
        return "Payment Details of "+this.loanName
    }
    
}