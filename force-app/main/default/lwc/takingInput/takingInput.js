import { LightningElement } from 'lwc';

export default class TakingInput extends LightningElement {
    firstname=' ';
    lastname=' ';
    UserEmail=' ';
    Mobile=' ';
    
firstName(event){
    this.firstname=event.target.value;
}
lastName(event){
    this.lastname=event.target.value;
}
email(event){
    this.UserEmail=event.target.value;
}
mobileNumber(event)
{
  this.Mobile=event.target.value;
}
saveData(){
    console.log('firstname : ', this.firstName);
    console.log('lastname : ', this.lastname);

    console.log('useremail : ', this.email);

    console.log('mobilenumber : ', this.Mobile);


}
}