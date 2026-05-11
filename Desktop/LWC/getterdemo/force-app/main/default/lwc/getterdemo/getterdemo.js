
import { LightningElement } from 'lwc';

export default class GetterDemo extends LightningElement {
    upperCaseText = '';

    handleInputChange(event) {
       
        this.upperCaseText = event.target.value;
    }

 
    get Message() {
        return this.upperCaseText ? `Helo: ${this.upperCaseText.toUpperCase()}` : '';
    }
}