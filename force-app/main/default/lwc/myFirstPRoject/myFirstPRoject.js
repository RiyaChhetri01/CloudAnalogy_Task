import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Title from '@salesforce/schema/Contact.Title';

export default class MyFirstPRoject extends LightningElement {

    handleClick(){
        this.showTost();
    }
    showTost(){
        const event=new ShowToastEvent({ title:'hlo hlo',
        message:'this is me ria chhetri',
        variant:'success'
});
this.dispatchEvent(event);
       


    }
}