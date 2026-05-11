import { LightningElement } from 'lwc';

export default class Addingtwonumber extends LightningElement {
    num1=0;
    num2=0;
    result=0;

handleNum1(event){
    this.num1=parseFloat(event.target.value)||0;
}
handleNum2(event){
    this.num2=parseFloat(event.target.value)||0;
}
addValue( ){
    this.result=this.num1+this.num2;
}
subtractVal(){
    this.result=this.num1 - this.num2;
}
multiplyVal()
{
    this.result=this.num1*this.num2;
}


}