# Software Requirements Specification (SRS)

## 1. Project Title

Construction Site Hazard Reporting and Corrective Action Management System.

## 2. Project Overview

The system is a web-based application designed to support hazard reporting, risk assessment, corrective-action management, progress monitoring, and verification in building and road construction projects.

The application will provide a centralized and traceable workflow for managing reported construction hazards.

## 3. Project Scope

The first version will support multiple construction sites managed by one organization.

Supported construction types:
- Building construction
- Road construction

The system will have four main user roles:
- Worker
- Safety Officer
- Site Manager
- Administrator

The application will be developed as a responsive web application.

## 4. Functional Requirements

### 4.1 Authentication and User Management

- FR-01: Users shall be able to log in and log out.
- FR-02: Administrators shall be able to create and manage user accounts.
- FR-03: Administrators shall assign roles and construction-site access to users.
- FR-04: The system shall enforce role-based and site-based access permissions.

### 4.2 Construction Site Management

- FR-05: Administrators shall be able to register construction sites.
- FR-06: Each site shall have a name, location, construction type and status.
- FR-07: A construction site shall be classified as building or road construction.
- FR-08: Users shall only access sites and records permitted by their assignments.

### 4.3 Hazard Reporting

- FR-09: Workers shall be able to submit hazard reports for assigned sites.
- FR-10: A hazard report shall contain a description, category, location and reporting date.
- FR-11: Hazard reports shall be associated with a construction site.
- FR-12: The system shall record the user who submitted each report.

### 4.4 Risk Assessment

- FR-13: Authorized safety officers shall assess reported hazards.
- FR-14: Risk assessment shall use likelihood and severity ratings.
- FR-15: The system shall calculate a risk score.
- FR-16: The system shall assign a priority level according to the approved risk-rating rules.

### 4.5 Corrective-Action Management

- FR-17: Safety officers shall assign corrective actions to responsible users.
- FR-18: Each corrective action shall have a description and due date.
- FR-19: Assigned users shall be able to update action progress.
- FR-20: The system shall record progress and status changes.

### 4.6 Verification and Closure

- FR-21: Authorized safety officers shall verify completed corrective actions.
- FR-22: A user shall not verify their own corrective action.
- FR-23: A corrective action that fails verification shall be returned for further work.
- FR-24: A hazard shall not be closed until its required corrective actions have passed verification.

### 4.7 Monitoring and Reporting

- FR-25: Site managers shall view summaries for their assigned sites.
- FR-26: Authorized users shall be able to view overdue corrective actions.
- FR-27: The system shall maintain a history of important hazard and corrective-action activities.

## 5. Non-Functional Requirements

- NFR-01 Security: Authentication, authorization and input validation shall be enforced by the backend.
- NFR-02 Data Integrity: Database constraints shall protect relationships and required records.
- NFR-03 Usability: The interface shall support desktop and mobile screen sizes.
- NFR-04 Maintainability: The frontend, backend and database responsibilities shall be separated.
- NFR-05 Reliability: Invalid operations shall be rejected with meaningful responses.
- NFR-06 Performance: Common operations shall respond reasonably quickly under the expected prototype workload.

## 6. User Roles and Responsibilities

### Worker
- Submit hazard reports.
- View permitted reports.
- Update assigned corrective actions where authorized.

### Safety Officer
- Review and assess hazards.
- Assign corrective actions.
- Monitor corrective-action progress.
- Verify completed corrective actions.

### Site Manager
- Monitor assigned construction sites.
- View hazard summaries and overdue actions.
- Review site activity and reports.

### Administrator
- Manage users and roles.
- Register construction sites.
- Assign users to sites.
- Manage system configuration.

## 7. Core System Workflow

1. A worker reports a construction-site hazard.
2. A safety officer reviews and assesses the risk.
3. A corrective action is assigned to a responsible user.
4. The responsible user records progress and completion evidence.
5. A safety officer independently verifies the correction.
6. The hazard is closed after successful verification.
7. The system preserves the activity history.

## 8. Project Limitations

The initial version will not include:
- AI-based hazard prediction.
- Real-time chat.
- SMS notifications.
- Native mobile applications.
- Advanced analytics.
- Integration with external construction-management platforms.

## 9. Evaluation

The prototype will be evaluated through:
- Functional testing.
- Role and site-access permission testing.
- Risk-score calculation testing.
- Corrective-action workflow testing.
- Verification and closure testing.
- Usability evaluation.

Simulated construction scenarios may be used for testing and will be identified as simulated data.
## 10. Business Rules

### 10.1 Construction Site Rules

- BR-01: Every hazard report must be associated with one registered construction site.
- BR-02: A construction site must be classified as either building or road construction.
- BR-03: Users may only access construction sites assigned to them, except administrators who have system-wide access.

### 10.2 Hazard Reporting Rules

- BR-04: Every hazard report must have a description, category, location and reporting user.
- BR-05: A hazard report must be reviewed by an authorized safety officer before risk assessment is completed.
- BR-06: One hazard report may contain multiple corrective actions.

### 10.3 Risk Assessment Rules

- BR-07: Risk assessment must use a likelihood rating from 1 to 5.
- BR-08: Risk assessment must use a severity rating from 1 to 5.
- BR-09: The risk score must be calculated by multiplying likelihood by severity.
- BR-10: The system must determine the risk priority using the approved risk-rating rules.

### 10.4 Corrective-Action Rules

- BR-11: Every corrective action must belong to a hazard report.
- BR-12: Every corrective action must have a description, responsible user and due date.
- BR-13: The responsible user must be authorized to work on the construction site associated with the hazard.
- BR-14: A corrective action must have its own progress and status.
- BR-15: A responsible user must provide completion information before requesting verification.

### 10.5 Verification and Closure Rules

- BR-16: A corrective action must be verified by an authorized safety officer.
- BR-17: A user must not verify their own corrective action.
- BR-18: A failed verification must return the corrective action for further work.
- BR-19: A hazard may only be closed when all required corrective actions have passed verification.
- BR-20: Closed hazards must retain their historical records.

### 10.6 Activity History Rules

- BR-21: The system must record important hazard and corrective-action activities.
- BR-22: Each recorded activity must include the responsible user and date/time.
- BR-23: Previous activity records must not be silently overwritten or deleted during normal operations.
- BR-24: Only an authorized Safety Officer may reject a submitted hazard report.
- BR-25: Every rejected hazard report must have a recorded rejection reason.
- BR-26: Rejection must not permanently delete the hazard report or its history.
- BR-27: A Safety Officer may request additional information instead of rejecting an incomplete hazard report.
- BR-28: Every request for additional information must include a recorded explanation of what is missing.
 - BR-29: Only the original reporting worker may provide the additional information requested for their hazard report.
- BR-30: The system must preserve the original report and record subsequent updates in its activity history.
- BR-31: Workers may edit their submitted hazard reports before a Safety Officer begins reviewing them.
- BR-32: Once a hazard report enters Under Review, the reporting worker cannot freely edit its details.
- BR-33: A worker may update a report when it has Needs More Information status.
- BR-34: After risk assessment, changes to important hazard details must be performed by an authorized Safety Officer through a controlled correction process.
- BR-35: Every controlled correction must record the person making the change, the date and time, and the reason for the correction.
- BR-36: Workers cannot edit hazard reports with Closed or Rejected status through normal report editing.
- BR-37: An authorized Safety Officer may reassess an active hazard when new information or changes in site conditions affect its risk level.
- BR-38: Every reassessment must include the likelihood, severity, calculated risk score, priority, assessing Safety Officer, date and time, and reason for reassessment.
- BR-39: The system must preserve previous risk assessments instead of silently replacing them.
- BR-40: The latest approved risk assessment determines the current risk level and priority of the hazard.
- BR-41: A corrective action must be verified by an authorized Safety Officer assigned to the relevant construction site.
- BR-42: The Safety Officer who assigned a corrective action cannot verify that same corrective action.
- BR-43: The user responsible for completing a corrective action cannot verify that action.
- BR-44: Every verification decision must record the verifier, decision, comments, and date and time.
- BR-45: Only an Administrator may deactivate or reactivate a construction site.
- BR-46: Deactivating a site must prevent new hazard reports and new operational assignments for that site.
- BR-47: Deactivation must not automatically delete existing hazards, corrective actions, evidence, or historical records.
- BR-48: Existing unresolved hazards and corrective actions must remain accessible to authorized users.
- BR-49: Outstanding corrective actions must remain visible after site deactivation until they are resolved or formally handled.
- BR-50: Only an Administrator may reactivate a deactivated site.
- BR-51: Deactivation of a site must not prevent authorized users from updating, submitting, verifying, or closing corrective actions that were already created before deactivation.
 - BR-52: An authorized Safety Officer may close a risk-assessed hazard without corrective actions when corrective action is determined to be unnecessary.
- BR-53: Closing a hazard without corrective actions requires a recorded explanation.
- BR-54: A hazard cannot be closed without corrective actions if any required corrective action remains incomplete or unverified.
- BR-55: The system must record the Safety Officer responsible for the closure and the date and time.
- BR-56: An authorized Safety Officer may reopen a previously closed hazard when the hazard reoccurs or the original resolution is found to be inadequate.
- BR-57: Every reopening must include a recorded reason, the responsible Safety Officer, and the date and time.
- BR-58: Reopening a hazard must preserve its previous closure, risk assessment, corrective actions, and verification history.
- BR-59: A reopened hazard must undergo review to determine whether reassessment or additional corrective actions are required.
- BR-60: A corrective action is considered overdue when its due date has passed and it has not been verified.
- BR-61: The system must identify overdue corrective actions automatically based on their due dates and verification status.
- BR-62: Overdue corrective actions must be visible to the responsible user, authorized Safety Officers, and the Site Manager assigned to the relevant site.
- BR-63: An overdue corrective action may still be updated and submitted for verification.
- BR-64: Only an authorized Safety Officer may change an assigned corrective action's due date.
- BR-65: Every due-date change must include a recorded reason and preserve the previous due date.
- BR-66: An authorized Safety Officer may reassign a corrective action to another eligible user assigned to the same construction site.
- BR-67: Every reassignment must include a recorded reason.
- BR-68: The system must preserve the previous responsible user, new responsible user, person making the reassignment, reason, and timestamp.
- BR-69: Reassignment must not automatically change the corrective action's due date.
## 11. Detailed Role Permissions

### 11.1 Worker

Workers shall be able to:
- Submit hazard reports for their assigned construction sites.
- View hazard reports they are permitted to access.
- View corrective actions assigned to them.
- Update the progress of their assigned corrective actions.
- Submit completion information and evidence for assigned actions.

Workers shall not be able to:
- Perform official risk assessments.
- Assign corrective actions.
- Verify corrective actions.
- Manage users or construction sites.

### 11.2 Safety Officer

Safety Officers shall be able to:
- View and review hazard reports for their assigned sites.
- Perform risk assessments.
- Assign corrective actions to responsible users.
- Set corrective-action due dates.
- Monitor corrective-action progress.
- Verify completed corrective actions.
- Return corrective actions that fail verification.
- View site hazard summaries and activity histories.

Safety Officers shall not be able to:
- Manage system administrator accounts.
- Register or delete construction sites.
- Access sites outside their assignments.

### 11.3 Site Manager

Site Managers shall be able to:
- View hazard reports for their assigned sites.
- Monitor risk priorities and hazard statuses.
- View corrective actions and their progress.
- View overdue corrective actions.
- Access site summaries and reports.
- Review site activity histories.

Site Managers shall not be able to:
- Create or modify operational hazard records.
- Perform risk assessments.
- Assign corrective actions.
- Verify corrective actions.
- Manage users or construction sites.

### 11.4 Administrator

Administrators shall be able to:
- Create, update and deactivate user accounts.
- Assign user roles.
- Register and manage construction sites.
- Assign users to construction sites.
- Access system-wide records and information.
- Manage system configuration.

Administrators shall not automatically receive authority to perform safety verification unless they are separately authorized as a Safety Officer.
## 12. Hazard Lifecycle and Status Management

### 12.1 Hazard Statuses

A hazard report shall follow these statuses:

- Submitted: The hazard has been reported and is waiting for review.
- Under Review: A Safety Officer is reviewing the report.
- Risk Assessed: The hazard has received a risk assessment.
- Actions In Progress: Corrective actions have been assigned and are being addressed.
- Awaiting Verification: All required corrective actions have been submitted for verification.
- Closed: All required corrective actions have passed verification.

- Rejected: The Safety Officer has determined that the submitted report is invalid, duplicate or otherwise unacceptable and has recorded a rejection reason.
- Reopened
### 12.2 Hazard Status Rules

- HSR-01: A newly submitted hazard shall have the Submitted status.
- HSR-02: Only an authorized Safety Officer may review and assess a hazard.
- HSR-03: A hazard must be assessed before corrective actions are assigned.
- HSR-04: A hazard shall move to Actions In Progress when corrective actions are assigned.
- HSR-05: A hazard shall move to Awaiting Verification when all required corrective actions have been submitted for verification.
- HSR-06: A hazard shall move to Closed only when all required corrective actions have been verified.
- HSR-07: If any corrective action fails verification, the hazard shall return to Actions In Progress.
- HSR-08: An authorized Safety Officer may reject a hazard report during review and must provide a rejection reason.
- HSR-09: Rejected hazard reports shall remain stored and accessible to authorized users for historical reference.
- HSR-10: A rejected hazard report shall not proceed to risk assessment or corrective-action assignment.
- HSR-11: An authorized Safety Officer may return a hazard report to the reporting worker when additional information is required.
- HSR-12: The Safety Officer must record the information required when returning a report.
- HSR-13: The reporting worker may update a report with Needs More Information status.
- HSR-14: After the worker submits the requested information, the hazard report returns to Under Review.
- HSR-15: Only the authorized Safety Officer may move a report into Needs More Information status.
- HSR-16: Workers may edit their submitted hazard reports only while the status is Submitted.
- HSR-17: Workers may not directly edit hazard reports while they are Under Review, Risk Assessed, Actions In Progress, Awaiting Verification, Closed, or Rejected.
- HSR-18: When a report has Needs More Information status, the reporting worker may provide the requested information.
- HSR-19: After risk assessment, an authorized Safety Officer may correct important hazard details through a controlled correction process that records the reason and preserves the previous information.
- HSR-20: An authorized Safety Officer may reassess an active hazard when new information or changed conditions affect its risk.
- HSR-21: Every reassessment must be stored as a separate assessment record.
- HSR-22: Previous risk assessments must remain available in the hazard history.
- HSR-23: The latest approved assessment determines the current risk score and priority.
- HSR-24: An authorized Safety Officer may close a reviewed hazard without corrective actions when no corrective action is necessary.
- HSR-25: The Safety Officer must record the reason for closing a hazard without corrective actions.
- HSR-26: The system must preserve the review and risk assessment history associated with the closed hazard.
- HSR-27: A hazard with required corrective actions cannot be closed until all those actions have been verified.
- HSR-28: An authorized Safety Officer may change a Closed hazard to Reopened when the hazard reoccurs or its original resolution is inadequate.
- HSR-29: Reopening requires a recorded reason.
- HSR-30: A reopened hazard must return to Under Review for further examination.
- HSR-31: Previous closure and verification records must remain available after reopening.
- HSR-32: Following review, the Safety Officer may reassess the risk and assign additional corrective actions when necessary.
### 12.3 Corrective-Action Statuses

Each corrective action shall have its own status:

- Assigned: The corrective action has been assigned to a responsible user.
- In Progress: The responsible user is working on the action.
- Submitted for Verification: The responsible user has submitted completion information.
- Changes Required: The Safety Officer has rejected the submitted completion.
- Verified: The Safety Officer has approved the completed action.

### 12.4 Corrective-Action Status Rules

- CAR-01: Every corrective action shall begin with the Assigned status.
- CAR-02: The responsible user may update the action to In Progress.
- CAR-03: The responsible user may submit an action for verification after completing the required work.
- CAR-04: Only an authorized Safety Officer may verify or reject a submitted corrective action.
- CAR-05: A rejected corrective action shall return to In Progress.
- CAR-06: A verified corrective action shall not be modified through normal progress updates.
- CAR-07: Every corrective-action status change shall be recorded in the activity history.
- CAR-08: Only an authorized Safety Officer assigned to the relevant construction site may verify a corrective action.
- CAR-09: The Safety Officer who assigned a corrective action must not verify that same action.
- CAR-10: The person responsible for completing a corrective action must not verify that action.
- CAR-11: Every verification decision must be recorded with the verifier, decision, comments, and date and time.
## 13. Data Requirements

### 13.1 User Information

The system shall store the following information for each user:

- Unique user identifier.
- Full name.
- Email address.
- Securely hashed password.
- Assigned role.
- Account status.
- Account creation date.
- Last update date.

### 13.2 Construction Site Information

The system shall store:

- Unique site identifier.
- Site name.
- Construction type (building or road).
- General location.
- Site description.
- Site status.
- Registration date.
- Site status (Active or Inactive).
- Deactivation date and time, when applicable.
- Administrator responsible for deactivation, when applicable.

### 13.3 User-Site Assignment Information

The system shall maintain relationships between users and construction sites.

Each assignment shall contain:

- User identifier.
- Construction site identifier.
- Assignment date.
- Assignment status.

A user may be assigned to multiple construction sites.

### 13.4 Hazard Report Information

The system shall store:

- Unique hazard identifier.
- Associated construction site.
- Reporting user.
- Hazard title.
- Hazard description.
- Hazard category.
- Specific hazard location.
- Reporting date and time.
- Current hazard status.

Hazard location information shall support both construction types:

- Building construction: building, floor, room or work area, where applicable.
- Road construction: road section, chainage or work zone, where applicable.
- Rejection reason, where applicable.
- User who rejected the report, where applicable.
- Rejection date and time, where applicable.
- Additional information request explanation, requesting Safety Officer, and request date and time, where applicable.

### 13.5 Risk Assessment Information

The system shall store:

- Unique risk assessment identifier.
- Associated hazard report.
- Likelihood rating.
- Severity rating.
- Calculated risk score.
- Assigned risk priority.
- Assessing Safety Officer.
- Assessment date and time.

The system shall preserve the assessment history when an assessment is updated.

### 13.6 Corrective-Action Information

The system shall store:

- Unique corrective-action identifier.
- Associated hazard report.
- Action description.
- Responsible user.
- Assigning Safety Officer.
- Assignment date.
- Due date.
- Current status.
- Completion information.
- Submission date and time.
- Responsible user reassignment history, including previous responsible user, new responsible user, reason, person making the change, and timestamp.
- Original due date.
- Current due date.
- Due-date change history, including previous date, new date, responsible Safety Officer, reason, and timestamp.

A hazard report may contain multiple corrective actions.

### 13.7 Evidence and Verification Information

The system shall maintain completion evidence and verification records.

Verification information shall include:

- Associated corrective action.
- Verifying Safety Officer.
- Verification decision.
- Verification comments.
- Verification date and time.

Where evidence is provided as an uploaded file, the system shall store its file reference and relevant metadata.

### 13.8 Activity History Information

The system shall maintain an activity history containing:

- Unique activity identifier.
- Associated record.
- User who performed the activity.
- Activity description or type.
- Previous status, where applicable.
- New status, where applicable.
- Date and time of the activity.

### 13.9 Data Integrity Requirements

- Each record shall have a unique identifier.
- Related records shall maintain valid relationships.
- A corrective action must reference an existing hazard report.
- A risk assessment must reference an existing hazard report.
- User-site assignments must reference existing users and sites.
- Verification records must reference existing corrective actions.
- Important historical records shall be preserved.
## 14. System Constraints, Assumptions and External Requirements

### 14.1 Technical Constraints

- SC-01: The application shall be developed as a web-based system.
- SC-02: The frontend shall use React and TypeScript.
- SC-03: The backend shall use Go and the Gin framework.
- SC-04: PostgreSQL shall be used for persistent data storage.
- SC-05: The frontend and backend shall communicate through REST API endpoints.
- SC-06: The first version shall use a centralized backend application rather than a microservices architecture.

### 14.2 Project Constraints

- PC-01: The system shall support one organization managing multiple construction sites.
- PC-02: The first version shall support building and road construction.
- PC-03: The project shall focus on hazard reporting and corrective-action management.
- PC-04: The project shall be developed within the available academic project period.
- PC-05: The initial version shall prioritize essential functionality over advanced features.

### 14.3 Assumptions

- AS-01: The organization will have authorized personnel responsible for managing construction safety.
- AS-02: Each user will have an individual account.
- AS-03: Administrators will provide accurate user and construction-site information.
- AS-04: Users will have access to a device with a web browser.
- AS-05: Users will have network access when interacting with the application.
- AS-06: Safety Officers will use appropriate professional judgment when assessing hazards and verifying corrective actions.
- AS-07: Simulated construction scenarios may be used during development and testing.

### 14.4 External Requirements

- ER-01: The system shall follow applicable organizational safety procedures when configured for a construction organization.
- ER-02: The system shall consider relevant Ethiopian occupational safety and health requirements during requirements analysis.
- ER-03: Risk-rating rules shall be documented and reviewed before being used for operational decisions.
- ER-04: Users shall be responsible for providing accurate hazard descriptions and completion information.
- ER-05: The application shall not replace professional safety inspections, emergency procedures or legally required safety responsibilities.
## 15. System Acceptance Criteria
The system shall be considered functionally acceptable when the following criteria have been demonstrated through testing.
### 15.1 Authentication and Access Control

- AC-01: A registered user with valid credentials can log in successfully.
- AC-02: A user with invalid credentials cannot access protected system features.
- AC-03: Users can log out of their accounts.
- AC-04: Users cannot access functions outside their authorized permissions.
- AC-05: Users cannot access records belonging to construction sites to which they are not assigned.
- AC-06: Administrators can manage user accounts, roles, and site assignments.

### 15.2 Construction Site Management

- AC-07: An administrator can register a building construction site.
- AC-08: An administrator can register a road construction site.
- AC-09: An authorized user can access the sites assigned to them.
- AC-10: Site information is correctly stored and retrieved.

### 15.3 Hazard Reporting

- AC-11: A worker can submit a hazard report for an assigned site.
- AC-12: The system rejects a hazard report that is missing required information.
- AC-13: Each submitted report is associated with the correct site and reporting user.
- AC-14: Hazard location information can represent both building and road construction locations.
- AC-15: An authorized Safety Officer can reject an invalid or duplicate hazard report with a recorded reason.
- AC-16: Rejected hazard reports remain stored and cannot proceed to risk assessment or corrective-action assignment.
- AC-17: An authorized Safety Officer can request additional information about a hazard report and record an explanation.
- AC-18: The original reporting worker can provide the requested information, after which the report returns to Under Review.

### 15.4 Risk Assessment

- AC-19: An authorized Safety Officer can assess a reported hazard.
- AC-20: The system calculates the risk score correctly using likelihood multiplied by severity.
- AC-21: The system assigns the correct priority according to the configured risk-rating rules.
- AC-22: The system records who performed the assessment and when it occurred.
- AC-23: The system preserves previous risk assessments when a hazard is reassessed.

### 15.5 Corrective-Action Management

- AC-24: A Safety Officer can assign multiple corrective actions to one hazard report.
- AC-25: Each corrective action can have a different responsible user and due date.
- AC-26: An authorized responsible user can update the progress of an assigned action.
- AC-27: The system records corrective-action status changes.
- AC-28: A responsible user can submit completion information for verification.
- AC-29: An authorized Safety Officer can reassign a corrective action to another eligible user assigned to the same site.
- AC-30: Reassignment history is preserved and available to authorized users.
- AC-31: Reassignment does not automatically change the existing due date.

### 15.6 Verification and Closure

- AC-32: An authorized Safety Officer can verify a submitted corrective action.
- AC-33: A user cannot verify their own corrective action.
- AC-34: The Safety Officer who assigned a corrective action cannot verify that same action.
- AC-35: A Safety Officer can reject a corrective action and provide verification comments.
- AC-36: A rejected action can be returned for further work.
- AC-37: A hazard cannot be closed while any required corrective action remains unverified.
- AC-38: A hazard can be closed after all required corrective actions have passed verification.
- AC-39: An authorized Safety Officer can close a risk-assessed hazard without corrective actions when corrective action is determined to be unnecessary and a reason is recorded.

### 15.7 Monitoring and Activity History

- AC-40: A Site Manager can view summaries for assigned construction sites.
- AC-41: Authorized users can identify overdue corrective actions.
- AC-42: Important activities are recorded with the responsible user and date/time.
- AC-43: Users can view the activity history permitted by their roles and site assignments.
- AC-44: The system automatically identifies corrective actions whose due dates have passed and that remain unverified.
- AC-45: Overdue actions appear on the appropriate Worker, Safety Officer, and Site Manager dashboards.
- AC-46: An overdue action can still be completed and submitted for verification.
- AC-47: Only an authorized Safety Officer can change a due date.
- AC-48: Due-date changes preserve the previous date, new date, reason, responsible Safety Officer, and timestamp.

### 15.8 Hazard Reopening

- AC-49: An authorized Safety Officer can reopen a closed hazard with a recorded reason.
- AC-50: Reopening preserves the previous closure and verification history.
- AC-51: A reopened hazard returns to Under Review.
- AC-52: A reopened hazard can undergo reassessment and receive additional corrective actions when necessary.

### 15.9 Site Deactivation

- AC-53: An administrator can deactivate a construction site.
- AC-54: A deactivated site cannot receive new hazard reports or new corrective-action assignments.
- AC-55: Existing corrective actions remain accessible and can continue through their workflow after site deactivation.

### 15.10 General System Quality

- AC-56: The application provides meaningful validation messages for invalid operations.
- AC-57: The application can be used on supported desktop and mobile screen sizes.
- AC-58: The application preserves valid records and relationships when data is created or updated.
## 16. External Interface Requirements

### 16.1 User Interface Requirements

- UI-01: The application shall provide a clear and consistent user interface.
- UI-02: The application shall provide navigation based on the authenticated user's role.
- UI-03: The application shall display relevant dashboards for Workers, Safety Officers, Site Managers and Administrators.
- UI-04: The application shall provide forms for user login, site management, hazard reporting, risk assessment and corrective-action management.
- UI-05: The application shall display meaningful success, error and validation messages.
- UI-06: The application shall provide clear indicators for hazard priorities and corrective-action statuses.
- UI-07: The application shall support desktop, tablet and mobile screen sizes.
- UI-08: Forms shall identify required fields and explain validation errors.

### 16.2 Frontend-to-Backend Interface

- FBI-01: The frontend shall communicate with the backend through REST API endpoints.
- FBI-02: API requests and responses shall use JSON where appropriate.
- FBI-03: Protected API operations shall require valid authentication.
- FBI-04: The backend shall verify user roles and construction-site permissions before processing protected operations.
- FBI-05: The frontend shall display appropriate messages when API requests fail.
- FBI-06: The frontend shall not be trusted to enforce security permissions independently.

### 16.3 Backend-to-Database Interface

- BDI-01: The Go backend shall communicate with PostgreSQL to store and retrieve application data.
- BDI-02: Database operations shall maintain the relationships between users, sites, hazard reports, risk assessments and corrective actions.
- BDI-03: The backend shall validate data before storing it.
- BDI-04: Database queries shall use parameterized statements or an equivalent safe database access method.
- BDI-05: Related database operations that must succeed or fail together shall use database transactions where necessary.

### 16.4 API Error Handling

- API-01: The backend shall return appropriate HTTP status codes.
- API-02: Validation errors shall identify the invalid or missing information.
- API-03: Unauthorized requests shall be rejected.
- API-04: Requests for resources outside a user's permitted access shall not disclose protected information.
- API-05: Unexpected server errors shall return a safe error response without exposing internal implementation details.

### 16.5 File and Evidence Interface

- FI-01: The system shall provide an interface for submitting completion evidence when required.
- FI-02: Uploaded evidence shall be associated with the relevant corrective action.
- FI-03: The system shall validate permitted file types and file sizes.
- FI-04: Evidence shall only be accessible to authorized users.
- FI-05: The system shall retain evidence references as part of the corrective-action history.
