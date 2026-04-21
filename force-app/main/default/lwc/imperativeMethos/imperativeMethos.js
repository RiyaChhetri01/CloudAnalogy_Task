import { LightningElement ,track} from 'lwc';
import getAcc from '@salesforce/apex/handlingClassMaing.getAcc';
const columns=[{label:'id of aaccount',fieldName:'Id'},{
    label:'name of account' ,fieldName:'Name'
},]


export default class ImperativeMethos extends LightningElement {
    @track columns=columns;
    @track data=[];

    connectedCallback(){
         getAcc()
         .then(result=>{
            this.data=result;
         })
         .catch(error=>{
            console.log('error occur');
         })
    }}