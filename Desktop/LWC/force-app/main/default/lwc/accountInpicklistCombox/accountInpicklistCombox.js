import { LightningElement,track} from 'lwc';
import getAccountforCombobox from '@salesforce/apex/handlingClassMaing.getAccountforCombobox';
export default class AccountInpicklistCombox extends LightningElement {
     value='';
     accOption=[];
    get options(){
        return this.accOption;

    }  
    connectedCallback(){
        getAccountforCombobox()
      
        .then(result=>{
            let arr=[];
            for(var i=0;i<result.length;i++){
                arr.push({label:result[i].Name,value:result[i].Id});
            }
            this.accOption=arr;

        })
        .catch(error=>{
            console.log(error);
        })
    } 
    handleChange(event){
        this.value=event.detail.value
    }
}