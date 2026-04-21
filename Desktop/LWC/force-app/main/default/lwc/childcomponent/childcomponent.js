import { LightningElement ,api} from 'lwc';

export default class Childcomponent extends LightningElement {

    handleAddition(event){
        this.dispatchEvent(new CustomEvent('addval'))

    }
    handleDecrease(event){
        this.dispatchEvent(new CustomEvent('subtract') )

    }
    handleMultiply(event){
        this.dispatchEvent(new CustomEvent('multi'))
    }
    


}