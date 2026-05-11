
import { LightningElement ,track} from 'lwc';

export default class trackDemo extends LightningElement{
    @track fullName={firstName:"",lastName:""}
    handleChange(event){
        try{
            const field=event.target.name;
        //window.alert(field);
        if(field==="firstName"){
            this.fullName.firstName=event.target.value;

        }
        else if (field=="lastName"){
            this.fullName.lastName=event.target.value;
        }
        }catch(err){
            consol.log(err.message);

        }
        
    }
}
