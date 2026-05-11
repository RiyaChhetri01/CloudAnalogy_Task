import { LightningElement, track, api } from 'lwc';
import getCases from '@salesforce/apex/GettingCaseHandler.getCaseData';
import { NavigationMixin } from 'lightning/navigation';
const columns = [
    { label: 'Case Subject', fieldName: 'Subject',    type: 'text' },
    { label: 'Case Status',  fieldName: 'Status',     type: 'text' },
    {
        label: 'Case Number',
        fieldName: 'caseLink',
        type: 'url',
        typeAttributes: {
            label: { fieldName: 'CaseNumber' },
            target: '_self'
        }
    },
    { label: 'Case Origin',  fieldName: 'Origin',     type: 'text' },
];

export default class LwcGridForCases extends NavigationMixin(LightningElement){
    columns = columns;
    @track data = [];
    @api recordId; 
    


    connectedCallback() {
        getCases({ caseId: this.recordId || null })
            .then(result => {
                this.data = this.caseTree(result);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    caseTree(caseList) {
        const map = {};
        const tree = [];

        caseList.forEach(c => {
            map[c.Id] = { ...c, caseLink: '/' + c.Id, _children: [] };
        });

        caseList.forEach(c => {
            if (c.ParentId && map[c.ParentId]) {
                map[c.ParentId]._children.push(map[c.Id]);
            } else if (!c.ParentId) {
                tree.push(map[c.Id]);
            }
        });

        Object.values(map).forEach(c => {
            if (c._children.length === 0) delete c._children;
        });

        return tree;
    }
    
}