import { api, LightningElement } from 'lwc';
const COLS = [{fieldName: 'CaseNumber',label: 'Case Number'},
              {fieldName: 'Status', label: 'Status'},
              {fieldName: 'Owner.Name', label: 'Owner'},
              {label: '', type: 'button',
              typeAttributes: { label: 'View Details', name: 'view_details', title: 'Click to View Details'}}
            ]
export default class CaseDetails extends LightningElement {
   @api casedetails;
   columns=COLS
}