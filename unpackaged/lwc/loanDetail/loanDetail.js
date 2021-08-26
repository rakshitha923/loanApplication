import { api, LightningElement,wire} from 'lwc';
import {MessageContext, APPLICATION_SCOPE, publish} from 'lightning/messageService';
import PAYDETAIL from "@salesforce/messageChannel/PaymentMessageChannel__c";
const COLS = [{fieldName: 'name',label: 'Name'},
              {fieldName: 'recordTypeName', label: 'Loan Type'},
              {fieldName: 'tenure', label: 'Tenure',type:'number'},
              {fieldName: 'status', label: 'Loan status'},
              {fieldName: 'loanAmount', label: 'Loan Amount', type:'currency'},
              {label: '', type: 'button',
               typeAttributes: { label: 'Payment Detasils', name: 'view_payment_details', title: 'Click to View Payment Details'}},
              {label: '', type: 'button',
              typeAttributes: { label: 'View Details', name: 'view_details', title: 'Click to View Details'}}
            ]
export default class LoanDetail extends LightningElement {
    @api loanApp;
    data;
    @api accName
    columns=COLS;
    @wire(MessageContext)
    messageContext;

    connectedCallback(){
        var loanAppData= JSON.parse(JSON.stringify(this.loanApp));
        this.data =  loanAppData;
    }
    
    
    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'view_payment_details':
                console.log('view');
                let payload = {
                    paymentDetails:JSON.parse(JSON.stringify(row))['payDetail'],
                    loanDetails:row.name,
                    accName:this.accName
                }
                publish(this.messageContext, PAYDETAIL, payload);
            
            case 'view_detail':
            
            default:
        }
    }
}