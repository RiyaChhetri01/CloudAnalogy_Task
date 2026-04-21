import { LightningElement } from 'lwc';

export default class ToDolist extends LightningElement {
    toDoVal='';
    yourItems = [];
    getVal(event){
        this.toDoVal=event.target.value;
    }
    addVal(){
        if(this.toDoVal){
            this.yourItems=[...this.yourItems,this.toDoVal];
            this.toDoVal='';

        }
    }
    delVal(event){
        const index=event.target.dataset.index;
        this.yourItems.splice(index,1);

        this.yourItems=[...this.yourItems];
    }
}