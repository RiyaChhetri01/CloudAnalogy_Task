import { LightningElement ,wire,track} from 'lwc';
import getAccOrg from '@salesforce/apex/handlingClassMaing.getAccOrg'
const col=[{label:'Id',fieldName:'Id'},
    {label:'Account Name',fieldName:'Name'},
    {label:'Industry',fieldName:'Industry'},
    {label:'PhonenNunber',fieldName:'Phone'}]
export default class GetAccountWithinOrg extends LightningElement {
    @track columns=col;
    @track data=[]
    @wire(getAccOrg)
    wireData({error,data}){
        if(data){
            this.data=data
        }else if(error){
            console.log(error);
        }
    }
}