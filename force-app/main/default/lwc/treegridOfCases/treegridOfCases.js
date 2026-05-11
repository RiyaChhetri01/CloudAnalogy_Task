import { LightningElement, api, track } from 'lwc';
import getParentCases from '@salesforce/apex/CaseHierarchyController.getParentCases';
import getChildCases from '@salesforce/apex/CaseHierarchyController.getChildCases';

export default class CaseTreeGrid extends LightningElement {

    @api recordId;   
    @track data = [];

    columns = [
        { label: 'Case Number', fieldName: 'CaseNumber', type: 'text' },
        { label: 'Subject', fieldName: 'Subject', type: 'text' },
        { label: 'Origin', fieldName: 'Origin', type: 'text' }
    ];

    connectedCallback() {
        this.loadData();
    }

    loadData() {

        
        if (this.recordId) {

            getChildCases({ parentId: this.recordId })
                .then(children => {

                    this.data = [{
                        Id: this.recordId,
                
                        _children: this.format(children)
                    }];

                })
                .catch(error => {
                    console.error(error);
                });

        }

       
        else {

            getParentCases()
                .then(parents => {
                    let tempData = [];
                    parents.forEach(parent => {
                        getChildCases({ parentId: parent.Id })
                            .then(children => {
                                let newParent = { ...parent };
                                if (children && children.length > 0) {
                                    newParent._children = [];
                                }
                                tempData.push(newParent);
                                this.data = [...tempData];

                            })
                            .catch(error => {
                                console.error(error);
                            });
                    });

                })
                .catch(error => {
                    console.error(error);
                });
        }
    }

    format(records) {
        return (records || []).map(r => ({
            ...r,
            _children: []
        }));
    }

    handleToggle(event) {

        const row = event.detail.row;
        if (row._childrenLoaded) return;
        getChildCases({ parentId: row.Id })
            .then(children => {
                this.data = this.data.map(item => {
                    if (item.Id === row.Id) {
                        return {
                            ...item,
                            _children: this.format(children),
                            _childrenLoaded: true
                        };
                    }

                    return item;
                });

            })
            .catch(error => {
                console.error(error);
            });
    }
}