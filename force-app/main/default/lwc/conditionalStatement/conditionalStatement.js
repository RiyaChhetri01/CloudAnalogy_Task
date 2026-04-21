import { LightningElement,track } from 'lwc';

export default class ConditionalStatement extends LightningElement {
    @track onclickedButton = 'Show';
    handleclick(event){
        const label=event.target.label;

    }}