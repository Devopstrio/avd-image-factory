<div align="center">

<img src="https://raw.githubusercontent.com/Devopstrio/.github/main/assets/Browser_logo.png" height="90" alt="Devopstrio Logo" />

<h1>Azure Virtual Desktop (AVD) Image Factory</h1>

<p><strong>Automated Golden Image Lifecycle & Global Distribution Orchestration</strong></p>

[![Image Lifecycle](https://img.shields.io/badge/Strategy-Immutable_Desktops-522c72?style=for-the-badge&labelColor=000000)](https://devopstrio.co.uk/)
[![Platform](https://img.shields.io/badge/Compute-AVD_Image_Gallery-0078d4?style=for-the-badge&logo=microsoftazure&labelColor=000000)](https://devopstrio.co.uk/)
[![Hardening](https://img.shields.io/badge/Security-CIS_Hardened-success?style=for-the-badge&labelColor=000000)](https://devopstrio.co.uk/)
[![Automation](https://img.shields.io/badge/Orchestration-Packer_Powered-962964?style=for-the-badge&labelColor=000000)](/apps/build-engine)

</div>

---

## 🏛️ Executive Summary

The **AVD Image Factory** is a flagship enterprise platform designed to automate the most critical component of a desktop virtualization estate: the golden image. In large-scale AVD environments, manual image creation is the leading cause of security drift, application instability, and operational bottlenecks.

This platform provides an automated, "Infrastructure as Code" approach to the image lifecycle. By leveraging **HashiCorp Packer**, **Azure Compute Gallery**, and **App Layering** techniques, it enables organizations to build, harden, patch, test, and distribute secure Windows 11 images globally in a fraction of the time. The factory ensures that every session host in the fleet is built from a verified, compliant, and optimized baseline, drastically reducing incident rates and improving the end-user experience.

### Strategic Business Outcomes
- **Eliminate Security Drift**: Ensure 100% compliance with CIS benchmarks and corporate hardening standards through automated build-time validation.
- **Rapid Patching & Remediation**: Reduce the window of vulnerability by automating the monthly OS and application patch cycle with zero manual intervention.
- **Global Consistency**: Automatically replicate golden images across multiple Azure regions to support disaster recovery and global workforce requirements.
- **Fail-Safe Rollbacks**: Maintain versioned image artifacts in the Azure Compute Gallery, enabling instant rollback to a previous known-good state if an update causes issues.

---

## 🏗️ Technical Architecture Details

### 1. High-Level Image Factory Architecture
```mermaid
graph TD
    Trigger[Monthly Patch / Code Change] --> Factory[Image Factory API]
    Factory --> Build[Build Engine - Packer]
    Build --> Hardening[Security Hardened Baseline]
    Hardening --> Test[Test Engine - App Validation]
    Test --> Publish[Publish Engine - Compute Gallery]
    Publish --> AVD[AVD Host Pools]
    
    subgraph "Control Plane"
        Portal[Image Ops Dashboard]
        API[FastAPI Gateway]
        Ledger[PostgreSQL State Ledger]
    end
    
    subgraph "Automation & Registry"
        Scripts[Installation Scripts]
        Gallery[Azure Shared Image Gallery]
        Artifacts[Packer VHDs]
    end
    
    API --> Ledger
    Build --> Scripts
    Publish --> Gallery
```

### 2. Image Build Workflow (Packer)
```mermaid
sequenceDiagram
    participant API as Factory API
    participant Packer as Packer Worker
    participant Azure as Azure VM (Temp)
    participant Gallery as Compute Gallery

    API->>Packer: Start Build (Win11-Multisession)
    Packer->>Azure: Deploy Build VM
    Packer->>Azure: Run App Installation Scripts
    Packer->>Azure: Run CIS Hardening & Sysprep
    Packer->>Azure: Capture Image Artifact
    Packer->>Gallery: Create New Version
    Packer->>Azure: Terminate Build VM
```

### 3. Patch Ring Lifecycle
```mermaid
graph TD
    Update[MS Patch Tuesday] --> Ring0[Ring 0: Lab Validation]
    Ring0 -->|Pass| Ring1[Ring 1: Pilot / IT Users]
    Ring1 -->|Pass| Ring2[Ring 2: Production Batch A]
    Ring2 -->|Pass| Ring3[Ring 3: Global Fleet]
    Ring0 -.->|Fail| Rollback[Abort & Alert]
```

### 4. Test Validation Flow
```mermaid
graph LR
    Image[New Image Version] --> Boot[Boot Test]
    Boot --> Login[Synthetic Login Test]
    Login --> Apps[App Launch Checks]
    Apps --> Performance[Benchmarking (Disk/IO)]
    Performance --> Pass[Mark as Verified]
```

### 5. Publish Replication Flow
```mermaid
graph TD
    Hub[UK South (Source)] --> Master[Image Version v1.2.0]
    Master --> Rep1[US East Replication]
    Master --> Rep2[Japan East Replication]
    Master --> Rep3[Australia East Replication]
    Rep1 --> Pool[Regional Host Pools]
```

### 6. Security Trust Boundary
```mermaid
graph TD
    User[Image Engineer] --> Entra[Entra ID / RBAC]
    Entra --> API[Factory API]
    API --> KV[Key Vault - Build Secrets]
    KV --> Azure[ARM API]
```

### 7. AVD Enterprise Topology
```mermaid
graph LR
    Factory[Image Factory] --> Gallery[Compute Gallery]
    Gallery --> Prod[Production Pools]
    Gallery --> Dev[Developer Pools]
    Gallery --> DR[DR Standby Pools]
```

### 8. API Request Lifecycle
```mermaid
graph LR
    Req[POST /images/build] --> Auth[Verify JWT]
    Auth --> Valid[Validate Manifest YAML]
    Valid --> Job[Queue Build Job]
    Job --> Notify[Slack/Teams Hook]
```

### 9. Multi-Tenant Tenancy Model
```mermaid
graph TD
    Org[Global Org]
    Org --> BU1[Finance Images]
    Org --> BU2[Developer Images]
    BU1 --> Sec[Strict Security Ring]
```

### 10. Monitoring & Telemetry Flow
```mermaid
graph LR
    Logs[Packer STDOUT] --> LAW[Log Analytics]
    LAW --> Dashboard[Grafana Build Success]
    Dashboard --> Alerts[Slack Notification]
```

### 11. Disaster Recovery Topology
```mermaid
graph TD
    Primary[UK South Gallery] --> Global[Global Replication]
    Global --> Secondary[US East 2 Gallery]
    Secondary --> Standby[Recovery Pools]
```

### 12. Rollback Workflow
```mermaid
graph TD
    Issues[High Incident Rate Detected] --> Decision[Rollback Triggered]
    Decision --> Update[Revert Host Pool to v-1.1.0]
    Update --> Drain[Drain Bad Hosts]
    Drain --> Reimage[Immediate Re-image]
```

### 13. App Layering Flow
```mermaid
graph LR
    Base[OS Layer] --> Chrome[Global App Layer]
    Chrome --> SAP[Finance App Layer]
    SAP --> Final[Unified Golden Image]
```

### 14. CI/CD Operations Pipeline
```mermaid
graph LR
    Code[Packer Config Change] --> Check[HCL Format Check]
    Check --> Build[Build Container API]
    Build --> Deploy[AKS Rollout]
```

### 15. Executive Governance Workflow
```mermaid
graph TD
    Metrics[Build Time / Success Rate] --> Scorecard[Desktop Health Report]
    Scorecard --> Board[Monthly Ops Review]
```

### 16. Host Pool Assignment Flow
```mermaid
graph TD
    Publish[Publish v1.5.0] --> Select[Identify Target Pools]
    Select --> Trigger[Automated Re-imaging Workflow]
```

### 17. Identity Federation Model
```mermaid
graph LR
    Builder[Build Identity] --> MSI[Managed Identity]
    MSI --> Vault[Fetch Admin PW]
```

### 18. Compliance Drift Workflow
```mermaid
graph TD
    Scan[Nightly Compliance Scan] --> Detect[Drift Detected]
    Detect --> Rebuild[Trigger Factory Rebuild]
```

### 19. Global Region Topology
```mermaid
graph TD
    Central[Global Image Hub]
    Central --> EMEA[EMEA Slaves]
    Central --> AMER[AMER Slaves]
    Central --> APAC[APAC Slaves]
```

### 20. Version Lifecycle Model
```mermaid
graph LR
    Dev[Development] --> Preview[Preview / Beta]
    Preview --> Current[Current / Prod]
    Current --> Deprecated[Deprecated]
    Deprecated --> Deleted[Deleted]
```

---

## 🚀 Environment Deployment

### Terraform Orchestration
```bash
cd terraform/environments/prd
terraform init
terraform apply -auto-approve
```

---
<sub>&copy; 2026 Devopstrio &mdash; Engineering Standardized Digital Workspace Excellence.</sub>
