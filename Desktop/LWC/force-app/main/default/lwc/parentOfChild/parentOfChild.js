import { LightningElement } from 'lwc';

export default class ParentOfChild extends LightningElement {
    counter=0
    handleadd(event){
        this.counter++;

    }
    handleSubtract(event){
        this.counter--;
    }
    handleMulti(event){
        this.counter*=2;
    }
}