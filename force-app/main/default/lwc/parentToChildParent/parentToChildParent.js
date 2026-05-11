import { LightningElement } from 'lwc';

export default class ParentToChildParent extends LightningElement {
    startCounter=0;
    handleChange(event){
        this.startCounter=event.target.value;
    }
}