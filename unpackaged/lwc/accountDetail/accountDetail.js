import { LightningElement ,api} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class AccountDetail extends  NavigationMixin(LightningElement) {
    @api accdetails;

    navigateToDetail(event){
        console.log(event.target.value);
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes:{
                recordId: event.target.value,
                objectApiName:'Account',
                actionName:'view'
            }
        })
    }
}