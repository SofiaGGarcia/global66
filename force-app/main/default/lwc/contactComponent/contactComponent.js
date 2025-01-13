import { LightningElement, track, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import retrieveContacts from '@salesforce/apex/ContactManagementSystemController.rContacts';
import updateContacts from '@salesforce/apex/ContactManagementSystemController.uContacts';
import deleteContacts from '@salesforce/apex/ContactManagementSystemController.dContacts';
import createContacts from '@salesforce/apex/ContactManagementSystemController.cContacts';
import searchContacts from '@salesforce/apex/ContactManagementSystemController.searchContacts';

export default class ContactInlineEdit extends LightningElement {
    @track contacts = [];
    @track draftValues = [];
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track phone = '';
    @track searchTerm = ''; 
    @track error;
    @track columns = [
        { label: 'First Name', fieldName: 'FirstName', editable: true },
        { label: 'Last Name', fieldName: 'LastName', editable: true },
        { label: 'Email', fieldName: 'Email', editable: true, type: 'email' },
        { label: 'Phone', fieldName: 'Phone', editable: true, type: 'phone' },
        {
            type: 'action',
            typeAttributes: {
                rowActions: this.getRowActions
            }
        }
    ];

    wiredContactsResult;

    @wire(retrieveContacts)
    wiredContacts(result) {
        this.wiredContactsResult = result;
        const { data, error } = result;
        if (data) {
            this.contacts = data;
        } else if (error) {
            console.error('Error retrieving contacts:', error);
        }
    }

    handleInputChange(event) {
        const field = event.target.name;
        if (field === 'firstName') {
            this.firstName = event.target.value;
        } else if (field === 'lastName') {
            this.lastName = event.target.value;
        } else if (field === 'email') {
            this.email = event.target.value;
        } else if (field === 'phone') {
            this.phone = event.target.value;
        }
    }

    handleAddContact() {
        if (!this.firstName || !this.lastName || !this.email) {
            alert('First Name, Last Name, and Email are required fields.');
            return;
        }

        const newContact = {
            FirstName: this.firstName,
            LastName: this.lastName,
            Email: this.email,
            Phone: this.phone
        };

        createContacts({ contacts: [newContact] })
            .then(() => {
                console.log('Contact added successfully');
                this.clearForm();
                return refreshApex(this.wiredContactsResult);
            })
            .catch(error => {
                console.error('Error adding contact:', error);
            });
    }

    clearForm() {
        this.firstName = '';
        this.lastName = '';
        this.email = '';
        this.phone = '';
    }

    handleSearchChange(event) {
        this.searchTerm = event.target.value;
        searchContacts({ searchTerm: this.searchTerm })
            .then(result => {
                this.contacts = result;
            })
            .catch(error => {
                this.error = error;
                console.error('Error fetching contacts:', error);
            });
    }

    handleSave(event) {
        const updatedFields = event.detail.draftValues;
        const contactsToUpdate = updatedFields.map(draft => {
            const original = this.contacts.find(contact => contact.Id === draft.Id);
            return { ...original, ...draft }; 
        });
    

        updateContacts({ contacts: contactsToUpdate })
            .then(() => {
                console.log('Contacts updated successfully');
                this.draftValues = [];
                return refreshApex(this.wiredContactsResult); 
            })
            .catch(error => {
                console.error('Error updating contacts:', error);
                alert('Error updating contacts: ' + (error.body.message || 'Unknown error'));
            });
    }
    

    saveInlineEdits() {
        if (this.draftValues.length > 0) {
            this.handleSave({ detail: { draftValues: this.draftValues } });
        }
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        switch (actionName) {
            case 'delete':
                this.deleteContact(row);
                break;
            default:
                break;
        }
    }

    deleteContact(row) {
        deleteContacts({ contacts: [row] })
            .then(() => {
                console.log('Contact deleted successfully');
                return refreshApex(this.wiredContactsResult);
            })
            .catch(error => {
                console.error('Error deleting contact:', error);
                alert('Error deleting contact: ' + (error.body.message || 'Unknown error'));
            });
    }

    getRowActions(row, doneCallback) {
        const actions = [
            { label: 'Delete', name: 'delete', iconName: 'utility:delete' }
        ];
        doneCallback(actions);
    }
}


