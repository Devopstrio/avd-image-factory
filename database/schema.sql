-- Devopstrio AVD Image Factory
-- Core Image Lifecycle & Build Orchestration Database Schema
-- Target: PostgreSQL 15+

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Identity & Tenancy
CREATE TABLE IF NOT EXISTS tenants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    azure_tenant_id VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID REFERENCES tenants(id),
    email VARCHAR(255) UNIQUE NOT NULL,
    role VARCHAR(50) DEFAULT 'ImageEngineer', -- Admin, ImageEngineer, Viewer
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Image Defintions & Versions
CREATE TABLE IF NOT EXISTS images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID REFERENCES tenants(id),
    name VARCHAR(255) NOT NULL, -- e.g., Win11-Multisession-Finance
    os_type VARCHAR(50) DEFAULT 'Windows11',
    description TEXT,
    gallery_name VARCHAR(255),
    resource_group VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS image_versions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    image_id UUID REFERENCES images(id) ON DELETE CASCADE,
    version_number VARCHAR(50) NOT NULL, -- e.g., 1.2.5
    status VARCHAR(50) DEFAULT 'Building', -- Building, Available, Testing, Deprecated
    artifact_uri TEXT,
    replicated_regions TEXT[], -- Array of region names
    is_latest BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Build & Patch Orchestration
CREATE TABLE IF NOT EXISTS build_jobs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    image_id UUID REFERENCES images(id),
    initiated_by UUID REFERENCES users(id),
    packer_template VARCHAR(255),
    status VARCHAR(50), -- Queued, Running, Success, Failed
    duration_seconds INT,
    logs_uri TEXT,
    started_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP WITH TIME ZONE
);

CREATE TABLE IF NOT EXISTS patch_jobs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    image_version_id UUID REFERENCES image_versions(id),
    patch_cycle_name VARCHAR(255), -- e.g., April 2026 Monthly Patch
    vulnerabilities_fixed INT DEFAULT 0,
    status VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. Testing & Validation
CREATE TABLE IF NOT EXISTS test_results (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    image_version_id UUID REFERENCES image_versions(id),
    test_type VARCHAR(100), -- BootTime, AppCompat, SecurityScan
    result VARCHAR(20), -- Pass, Fail
    details JSONB,
    evidence_path TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. Global Publishing
CREATE TABLE IF NOT EXISTS publish_jobs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    image_version_id UUID REFERENCES image_versions(id),
    target_regions TEXT[],
    status VARCHAR(50),
    replication_progress INT DEFAULT 0,
    completed_at TIMESTAMP WITH TIME ZONE
);

-- 6. Audit & Analytics
CREATE TABLE IF NOT EXISTS reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID REFERENCES tenants(id),
    report_type VARCHAR(100) NOT NULL, -- BuildSuccessRate, ComplianceSLA
    file_path TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID REFERENCES tenants(id),
    user_id UUID REFERENCES users(id),
    action VARCHAR(255) NOT NULL,
    resource_id VARCHAR(255),
    details JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Optimization Indexes
CREATE INDEX idx_image_version_status ON image_versions(status);
CREATE INDEX idx_build_job_status ON build_jobs(status);
CREATE INDEX idx_test_result_version ON test_results(image_version_id);
CREATE INDEX idx_publish_job_version ON publish_jobs(image_version_id);
