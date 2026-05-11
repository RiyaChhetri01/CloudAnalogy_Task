import { LightningElement, api, wire, track } from 'lwc';
import getAcc from '@salesforce/apex/handlingClassMaing.getAcc'
const col=[{label:'Name',fieldName:'FirstName'},{label:'LastName',fieldName:'LastName'},
    {label:'Contact Account Id',fieldName:'AccountId'},
    {label:'Phone Number',fieldName:'Phone'}]
export default class ShowRelatedRecord extends LightningElement {
    @api recordId;
   @track columns=col;
    @track data=[];
   @wire(getAcc,{accountId:'$recordId'})
 wireAccDemo({data,error}){
    if(data){
      this.data=data;
    }
    else if(error){
        console.log(error);
    }

    }
 }



