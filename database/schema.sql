
-- =====================================================
-- Construction Site Hazard Reporting System
-- Initial PostgreSQL Database Schema
-- Step 1: User and Site Management
-- =====================================================

-- 1. ROLES
CREATE TABLE roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- Insert the four authorized system roles.
INSERT INTO roles (name, description) VALUES
    ('Worker', 'Reports hazards and updates assigned corrective actions.'),
    ('Safety Officer', 'Reviews hazards, assesses risks, assigns actions and verifies corrections.'),
    ('Site Manager', 'Monitors site activities and views reports.'),
    ('Administrator', 'Manages users, roles and construction sites.');

-- 2. USERS
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_id UUID NOT NULL REFERENCES roles(id) ON DELETE RESTRICT,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash TEXT NOT NULL,
    account_status VARCHAR(20) NOT NULL DEFAULT 'active'
        CHECK (account_status IN ('active', 'suspended', 'deactivated')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Email addresses must be unique regardless of letter case.
CREATE UNIQUE INDEX idx_users_email_lower
    ON users (LOWER(email));

-- 3. SITES
CREATE TABLE sites (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(150) NOT NULL,
    construction_type VARCHAR(20) NOT NULL
        CHECK (construction_type IN ('Building', 'Road')),
    location VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'active'
        CHECK (status IN ('active', 'inactive')),
    created_by UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    deactivated_at TIMESTAMPTZ,
    deactivated_by UUID REFERENCES users(id) ON DELETE RESTRICT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 4. USER SITE ASSIGNMENTS
CREATE TABLE user_site_assignments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    site_id UUID NOT NULL REFERENCES sites(id) ON DELETE RESTRICT,
    assigned_by UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    assigned_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'active'
        CHECK (status IN ('active', 'inactive')),

    CONSTRAINT uq_user_site UNIQUE (user_id, site_id)
);

-- Indexes for common lookups.
CREATE INDEX idx_users_role_id
    ON users(role_id);

CREATE INDEX idx_sites_status
    ON sites(status);

CREATE INDEX idx_user_site_assignments_user
    ON user_site_assignments(user_id);

CREATE INDEX idx_user_site_assignments_site
    ON user_site_assignments(site_id);

-- =====================================================
-- Step 2: Hazard Reporting and Risk Assessment
-- =====================================================

-- 5. HAZARD REPORTS
CREATE TABLE hazard_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    site_id UUID NOT NULL
        REFERENCES sites(id) ON DELETE RESTRICT,

    reported_by UUID NOT NULL
        REFERENCES users(id) ON DELETE RESTRICT,

    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,

    hazard_category VARCHAR(100) NOT NULL,

    location_details VARCHAR(255) NOT NULL,

    status VARCHAR(30) NOT NULL DEFAULT 'Submitted'
        CHECK (
            status IN (
                'Submitted',
                'Under Review',
                'Rejected',
                'Awaiting Information',
                'Assessed',
                'In Progress',
                'Pending Verification',
                'Closed',
                'Reopened'
            )
        ),

    reported_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for hazard report lookups.
CREATE INDEX idx_hazard_reports_site
    ON hazard_reports(site_id);

CREATE INDEX idx_hazard_reports_reported_by
    ON hazard_reports(reported_by);

CREATE INDEX idx_hazard_reports_status
    ON hazard_reports(status);

CREATE INDEX idx_hazard_reports_reported_at
    ON hazard_reports(reported_at);


-- 6. RISK ASSESSMENTS
CREATE TABLE risk_assessments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    hazard_id UUID NOT NULL
        REFERENCES hazard_reports(id) ON DELETE RESTRICT,

    assessed_by UUID NOT NULL
        REFERENCES users(id) ON DELETE RESTRICT,

    likelihood SMALLINT NOT NULL
        CHECK (likelihood BETWEEN 1 AND 5),

    severity SMALLINT NOT NULL
        CHECK (severity BETWEEN 1 AND 5),

    risk_score SMALLINT GENERATED ALWAYS AS
        (likelihood * severity) STORED,

    risk_level VARCHAR(20) GENERATED ALWAYS AS (
        CASE
            WHEN likelihood * severity BETWEEN 1 AND 4
                THEN 'Low'
            WHEN likelihood * severity BETWEEN 5 AND 9
                THEN 'Moderate'
            WHEN likelihood * severity BETWEEN 10 AND 16
                THEN 'High'
            ELSE 'Critical'
        END
    ) STORED,

    assessment_notes TEXT,

    assessed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for risk assessment lookups.
CREATE INDEX idx_risk_assessments_hazard
    ON risk_assessments(hazard_id);

CREATE INDEX idx_risk_assessments_assessed_by
    ON risk_assessments(assessed_by);

CREATE INDEX idx_risk_assessments_assessed_at
    ON risk_assessments(assessed_at);
    -- =====================================================
-- Step 3: Corrective Actions and Verification
-- =====================================================

-- 7. CORRECTIVE ACTIONS
CREATE TABLE corrective_actions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    hazard_id UUID NOT NULL
        REFERENCES hazard_reports(id) ON DELETE RESTRICT,

    assigned_to UUID NOT NULL
        REFERENCES users(id) ON DELETE RESTRICT,

    assigned_by UUID NOT NULL
        REFERENCES users(id) ON DELETE RESTRICT,

    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,

    due_date DATE NOT NULL,

    status VARCHAR(30) NOT NULL DEFAULT 'Assigned'
        CHECK (
            status IN (
                'Assigned',
                'In Progress',
                'Submitted for Verification',
                'Changes Required',
                'Verified'
            )
        ),

    completion_notes TEXT,
    submitted_at TIMESTAMPTZ,
    verified_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_corrective_actions_hazard
    ON corrective_actions(hazard_id);

CREATE INDEX idx_corrective_actions_assigned_to
    ON corrective_actions(assigned_to);

CREATE INDEX idx_corrective_actions_assigned_by
    ON corrective_actions(assigned_by);

CREATE INDEX idx_corrective_actions_status
    ON corrective_actions(status);

CREATE INDEX idx_corrective_actions_due_date
    ON corrective_actions(due_date);


-- 8. ACTION VERIFICATIONS
CREATE TABLE action_verifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    corrective_action_id UUID NOT NULL
        REFERENCES corrective_actions(id) ON DELETE RESTRICT,

    verified_by UUID NOT NULL
        REFERENCES users(id) ON DELETE RESTRICT,

    decision VARCHAR(30) NOT NULL
        CHECK (
            decision IN (
                'Verified',
                'Changes Required'
            )
        ),

    comments TEXT NOT NULL,

    verified_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_action_verifications_action
    ON action_verifications(corrective_action_id);

CREATE INDEX idx_action_verifications_verified_by
    ON action_verifications(verified_by);

CREATE INDEX idx_action_verifications_verified_at
    ON action_verifications(verified_at);


-- 9. HAZARD INFORMATION REQUESTS
CREATE TABLE hazard_information_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    hazard_id UUID NOT NULL
        REFERENCES hazard_reports(id) ON DELETE RESTRICT,

    requested_by UUID NOT NULL
        REFERENCES users(id) ON DELETE RESTRICT,

    request_message TEXT NOT NULL,

    response_message TEXT,

    responded_by UUID
        REFERENCES users(id) ON DELETE RESTRICT,

    requested_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    responded_at TIMESTAMPTZ,

    CONSTRAINT chk_information_request_response
        CHECK (
            (
                response_message IS NULL
                AND responded_by IS NULL
                AND responded_at IS NULL
            )
            OR
            (
                response_message IS NOT NULL
                AND responded_by IS NOT NULL
                AND responded_at IS NOT NULL
            )
        )
);

CREATE INDEX idx_information_requests_hazard
    ON hazard_information_requests(hazard_id);

CREATE INDEX idx_information_requests_requested_by
    ON hazard_information_requests(requested_by);

CREATE INDEX idx_information_requests_responded_by
    ON hazard_information_requests(responded_by);
    -- =====================================================
-- Step 4: History and Lifecycle Tracking
-- =====================================================

-- 10. ACTION ASSIGNMENT HISTORY
CREATE TABLE action_assignment_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    corrective_action_id UUID NOT NULL
        REFERENCES corrective_actions(id) ON DELETE RESTRICT,

    previous_user_id UUID
        REFERENCES users(id) ON DELETE RESTRICT,

    new_user_id UUID NOT NULL
        REFERENCES users(id) ON DELETE RESTRICT,

    changed_by UUID NOT NULL
        REFERENCES users(id) ON DELETE RESTRICT,

         change_reason TEXT,

    changed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_assignment_change_reason
        CHECK (
            previous_user_id IS NULL
            OR change_reason IS NOT NULL
        )
);

CREATE INDEX idx_assignment_history_action
    ON action_assignment_history(corrective_action_id);

CREATE INDEX idx_assignment_history_changed_by
    ON action_assignment_history(changed_by);


-- 11. ACTION DUE DATE HISTORY
CREATE TABLE action_due_date_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    corrective_action_id UUID NOT NULL
        REFERENCES corrective_actions(id) ON DELETE RESTRICT,

    previous_due_date DATE,

    new_due_date DATE NOT NULL,

    changed_by UUID NOT NULL
        REFERENCES users(id) ON DELETE RESTRICT,

        change_reason TEXT,

    changed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_due_date_change_reason
        CHECK (
            previous_due_date IS NULL
            OR change_reason IS NOT NULL
        )
);

CREATE INDEX idx_due_date_history_action
    ON action_due_date_history(corrective_action_id);

CREATE INDEX idx_due_date_history_changed_by
    ON action_due_date_history(changed_by);


-- 12. HAZARD LIFECYCLE EVENTS
CREATE TABLE hazard_lifecycle_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    hazard_id UUID NOT NULL
        REFERENCES hazard_reports(id) ON DELETE RESTRICT,

    event_type VARCHAR(20) NOT NULL
        CHECK (event_type IN ('CLOSED', 'REOPENED')),

    closure_type VARCHAR(30)
        CHECK (
            closure_type IN (
                'Verified Actions',
                'No Action Required'
            )
        ),

    reason TEXT,

    performed_by UUID NOT NULL
        REFERENCES users(id) ON DELETE RESTRICT,

    performed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_hazard_lifecycle_details
        CHECK (
            (
                event_type = 'CLOSED'
                AND closure_type IS NOT NULL
                AND (
                    closure_type <> 'No Action Required'
                    OR reason IS NOT NULL
                )
            )
            OR
            (
                event_type = 'REOPENED'
                AND closure_type IS NULL
                AND reason IS NOT NULL
            )
        )
);

CREATE INDEX idx_hazard_lifecycle_hazard
    ON hazard_lifecycle_events(hazard_id);

CREATE INDEX idx_hazard_lifecycle_performed_by
    ON hazard_lifecycle_events(performed_by);

CREATE INDEX idx_hazard_lifecycle_performed_at
    ON hazard_lifecycle_events(performed_at);
    -- =====================================================
-- Step 5: General Activity Logging
-- =====================================================

-- 13. ACTIVITY LOGS
CREATE TABLE activity_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    actor_user_id UUID
        REFERENCES users(id) ON DELETE RESTRICT,

    site_id UUID
        REFERENCES sites(id) ON DELETE RESTRICT,

    hazard_id UUID
        REFERENCES hazard_reports(id) ON DELETE RESTRICT,

    corrective_action_id UUID
        REFERENCES corrective_actions(id) ON DELETE RESTRICT,

    target_user_id UUID
        REFERENCES users(id) ON DELETE RESTRICT,

    action VARCHAR(100) NOT NULL,

    description TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for activity history and reporting.
CREATE INDEX idx_activity_logs_actor
    ON activity_logs(actor_user_id);

CREATE INDEX idx_activity_logs_site
    ON activity_logs(site_id);

CREATE INDEX idx_activity_logs_hazard
    ON activity_logs(hazard_id);

CREATE INDEX idx_activity_logs_corrective_action
    ON activity_logs(corrective_action_id);

CREATE INDEX idx_activity_logs_created_at
    ON activity_logs(created_at);