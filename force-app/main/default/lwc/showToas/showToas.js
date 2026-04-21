import { LightningElement } from 'lwc';
import {ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ShowToas extends LightningElement {
    handleChange(event){
        this.dispatchEvent(new ShowToastEvent({
            title:'Show toast event',
            message:'how this is your show toast',
            variant:'Success'
        }));

    }
}