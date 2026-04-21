import { LightningElement,track,wire } from 'lwc';
import Accountrec from '@salesforce/apex/HandlerforLWc.Accountrec';
import RelatedOpportunities from '@salesforce/apex/HandlerforLWc.RelatedOpportunities';
col1=[{label:'Account Name',fieldName:'Name'},{label:'Account Id',fieldName:'Id'}]
col2=[{label:'Opportunity Name',fieldName:'Name'},{label:'Opportunity Id',fieldName:'Id'}]
export default class AccountOpportunityRecord extends LightningElement {
    @track columns1=col1;
    @track columnns2=col2;
    accounts=[];
    opportunity=[];
    @wire(Accountrec)
    wireAccount({error,data}){
        if(data){
            this.data1=data;
        }else if(error){
            this.error1=error;
        }
    }
    @wire(RelatedOpportunities)
    wireOpp({error,data}){
        if(data){
            this.data2=data;
        }else if(error){
            this.error2
        }}


}

    

