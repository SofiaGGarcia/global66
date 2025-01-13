
# Manage Contacts LWC

## Project Description

The **Manage Contacts** Lightning Web Component (LWC) provides an intuitive interface for managing Salesforce Contacts. Users can:

- Create new contacts.
- Edit existing contacts with inline editing.
- Delete contacts individually using row actions.
- Search contacts by first or last name.

This component interacts with a custom Apex controller to perform server-side operations like retrieving, creating, updating, and deleting records. It is designed to follow Salesforce best practices for performance, reusability, and maintainability.

---

## Installation and Configuration

### Prerequisites

1. Ensure you have the following installed:
   - **Salesforce CLI**
   - **VS Code** with Salesforce Extension Pack
   - **A Developer Org or Scratch Org**

2. Verify that the `Contact` object is available in your Salesforce instance and contains standard fields like `FirstName`, `LastName`, `Email`, and `Phone`.

### Steps to Set Up

1. **Clone the Repository**
   ```bash
   git clone <[repository-url](https://github.com/SofiaGGarcia/global66.git)>
   ```

2. **Authorize Your Org**
   ```bash
   sfdx auth:web:login -d -a <alias-name>
   ```

3. **Push the Code to Your Org**
   ```bash
   sfdx force:source:push
   ```

4. **Deploy Apex Classes**
   - The Apex controller (`ContactManagementSystemController`) is included in the project.
   - Ensure it deploys correctly and matches the metadata configuration for your org.

5. **Add the Component to a Lightning Page**
   - Navigate to **App Builder** in Salesforce.
   - Drag and drop the `ManageContacts` component onto the desired page.
   - Save and activate the page.

---

## Usage Instructions

### Create Contacts
1. Fill in the required fields: `Email` is mandatory.
2. Click **Add Contact** to create a new record.
3. The contact will appear in the list below.

### Edit Contacts
1. Use inline editing in the datatable to update fields directly.
2. Click **Save** to persist the changes.

### Delete Contacts
1. Use the action menu in the row to delete individual contacts.
2. Confirm the deletion action.

### Search Contacts
1. Enter a name or partial name in the **Search Contacts** field.
2. The list dynamically updates to show matching records.

---

## Design Decisions

1. **Apex Controller:**
   - Operations (CRUD) are centralized in the `ContactManagementSystemController` to enforce data integrity and provide server-side validation.
   - A `searchContacts` method is included to enable dynamic filtering of records.

2. **Lightning Datatable:**
   - Provides inline editing for a seamless user experience.
   - Includes a row action menu for intuitive deletion of records.

3. **Dynamic Search:**
   - Implemented via an input field that dynamically filters records using the `searchContacts` Apex method.

4. **Cacheable Apex Methods:**
   - The `retrieveContacts` and `searchContacts` methods use `@AuraEnabled(cacheable=true)` to improve performance for read-only operations.

5. **Validation Logic:**
   - Centralized in the Apex controller to ensure that required fields like `Email` are present before performing any operation.

6. **Responsive Design:**
   - The layout is optimized using Salesforce Lightning Design System (SLDS) classes to ensure a clean and consistent appearance across devices.

## Test Class Coverage

- **Test Class Name:** `ContactManagementSystemControllerTest`
- **Coverage Achieved:** 83%

---

