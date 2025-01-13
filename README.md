Manage Contacts LWC

Project Description

The Manage Contacts Lightning Web Component (LWC) provides an intuitive interface for managing Salesforce Contacts. Users can:

Create new contacts.

Edit existing contacts with inline editing.

Delete contacts individually using row actions.

Search contacts by first or last name.

This component interacts with a custom Apex controller to perform server-side operations like retrieving, creating, updating, and deleting records. It is designed to follow Salesforce best practices for performance, reusability, and maintainability.

Installation and Configuration

Prerequisites

Ensure you have the following installed:

Salesforce CLI

VS Code with Salesforce Extension Pack

A Developer Org or Scratch Org

Verify that the Contact object is available in your Salesforce instance and contains standard fields like FirstName, LastName, Email, and Phone.

Steps to Set Up

Clone the Repository

git clone <https://github.com/SofiaGGarcia/global66.git>

Authorize Your Org

sfdx auth:web:login -d -a <alias-name>

Push the Code to Your Org

sfdx force:source:push



Deploy Apex Classes

The Apex controller (ContactManagementSystemController) is included in the project.

Ensure it deploys correctly and matches the metadata configuration for your org.

Add the Component to a Lightning Page

Navigate to App Builder in Salesforce.

Drag and drop the ManageContacts component onto the desired page.

Save and activate the page.

Usage Instructions

Create Contacts

Fill in the required fields: Email is mandatory.

Click Add Contact to create a new record.

The contact will appear in the list below.

Edit Contacts

Use inline editing in the datatable to update fields directly.

Click Save to persist the changes.

Delete Contacts

Use the action menu in the row to delete individual contacts.

Confirm the deletion action.

Search Contacts

Enter a name or partial name in the Search Contacts field.

The list dynamically updates to show matching records.

Design Decisions

Apex Controller:

Operations (CRUD) are centralized in the ContactManagementSystemController to enforce data integrity and provide server-side validation.

A searchContacts method is included to enable dynamic filtering of records.

Lightning Datatable:

Provides inline editing for a seamless user experience.

Includes a row action menu for intuitive deletion of records.

Dynamic Search:

Implemented via an input field that dynamically filters records using the searchContacts Apex method.

Cacheable Apex Methods:

The retrieveContacts and searchContacts methods use @AuraEnabled(cacheable=true) to improve performance for read-only operations.

Validation Logic:

Centralized in the Apex controller to ensure that required fields like Email are present before performing any operation.

Responsive Design:

The layout is optimized using Salesforce Lightning Design System (SLDS) classes to ensure a clean and consistent appearance across devices.

