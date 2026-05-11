import { LightningElement,wire,track } from 'lwc';
import getAccount from'@salesforce/apex/handlingClassMaing.getAccount';
const columns=[
    {label:'Id',fieldName:'Id'},
    {label:'Name',fieldName:'Name'},
]

export default class WireDemo extends LightningElement {
      
    @track columns=columns;
    @track data=[];
    @wire(getAccount)
    wireData({data,error}){
        if(data){
            this.data=data;
        }
        else if(error){
            console.log('error occured')
        }
    }

    
}