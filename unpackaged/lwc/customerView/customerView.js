import { api, LightningElement, wire } from 'lwc';
import getCustomerDetail  from '@salesforce/apex/CustomerView.getCustomerDetail'
import { NavigationMixin } from 'lightning/navigation';
export default class CustomerView extends NavigationMixin(LightningElement) {
    @api recordId;
    @api recordIds;
    accntInfo;
    error;
  
    @wire(getCustomerDetail,{accountId:'$recordIds'})
    accDetail({ error, data }) {
        if (data) {
            console.log(data); 
            this.accntInfo = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
        }
    }
    navigateToback(event){
        console.log(event)
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            }
        });
    }
    activetabHandler(event){
        console.log(event.detail);
        this.template.querySelector('lightning-tabset').activeTabValue = event.detail;
    }
}