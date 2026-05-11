import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
import makeAcc from '@salesforce/apex/handlingClassMaing.makeAcc';

export default class CreateAccount extends LightningElement {
    name='';
    Phone='';
    Industry='';
    Website='';
    Type='';

    handleChange(event){
        const field=event.target.name;
        this[field]=event.target.value;
     }    
     handleClick(){
        makeAcc({
            name:this.name,
            Phone:this.Phone,
            Industry:this.Industry,
            Website:this.Website,
            Type:this.Type
        })
        .then(()=>{
            this.dispatchEvent(new ShowToastEvent({
                title:'Account Creation',
                message:'created successfuly',
                variant:'success'
            }
                
            ));
        })
        .catch(error=>{
            alert('error');
        });

     }
}