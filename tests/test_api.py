import pytest
from fastapi.testclient import TestClient
from backend.src.main import app

# Devopstrio AVD Image Factory
# Integration Tests for Automated Image Orchestration

client = TestClient(app)

def test_health_check_operational():
    """Verify that the factory gateway is reportable and healthy."""
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "operational"

def test_image_catalog_listing():
    """Ensure that the platform can retrieve managed image definitions."""
    response = client.get("/images")
    assert response.status_code == 200
    data = response.json()
    assert len(data) > 0
    assert "latest_version" in data[0]

def test_build_trigger_acceptance():
    """Verify that a build request for a specific template is correctly queued."""
    payload = {
        "image_name": "Win11-Multisession-Corp",
        "template_type": "Windows11",
        "replicate_to_regions": ["eastus", "westeurope"],
        "initiated_by": "engineer-123"
    }
    response = client.post("/images/build", json=payload)
    assert response.status_code == 202
    assert "job_id" in response.json()
    assert response.json()["status"] == "Running"

def test_submission_of_validation_results():
    """Ensure build agents can correctly report test success to the API."""
    payload = {
        "version_id": "v1.4.2",
        "test_type": "Security-CIS-Scan",
        "is_success": True,
        "details": {"score": 98, "drift": 0}
    }
    response = client.post("/images/test", json=payload)
    assert response.status_code == 200
    assert response.json()["verified"] is True

def test_publish_replication_trigger():
    """Verify image replication commands are accepted correctly."""
    response = client.post("/images/publish?version_id=v1.4.2", json=["uksouth", "northeurope"])
    assert response.status_code == 200
    assert "replication_id" in response.json()

def test_analytics_summary_reporting():
    """Check that high-level build success metrics are reportable."""
    response = client.get("/analytics/summary")
    assert response.status_code == 200
    assert "build_success_rate" in response.json()
