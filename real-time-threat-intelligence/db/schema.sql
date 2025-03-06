CREATE TABLE assets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    asset_type VARCHAR(50) NOT NULL, 
    owner VARCHAR(100),              
    description TEXT,
    criticality INT CHECK (criticality BETWEEN 1 AND 5), 
    location VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE threats (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    threat_type VARCHAR(50) NOT NULL,  
    source VARCHAR(100),               
    description TEXT,
    tactics TEXT,                     
    techniques TEXT,                   
    indicators TEXT,                   
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vulnerabilities (
    id SERIAL PRIMARY KEY,
    cve_id VARCHAR(20),               
    name VARCHAR(255) NOT NULL,
    description TEXT,
    vulnerability_type VARCHAR(50),   
    severity VARCHAR(20),             
    cvss_score DECIMAL(3,1),          
    status VARCHAR(20),               
    disclosed_date DATE,
    remediation_steps TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE asset_vulnerabilities (
    id SERIAL PRIMARY KEY,
    asset_id INT REFERENCES assets(id) ON DELETE CASCADE,
    vulnerability_id INT REFERENCES vulnerabilities(id) ON DELETE CASCADE,
    date_identified DATE,
    notes TEXT,
    UNIQUE(asset_id, vulnerability_id)
);

CREATE TABLE asset_threats (
    id SERIAL PRIMARY KEY,
    asset_id INT REFERENCES assets(id) ON DELETE CASCADE,
    threat_id INT REFERENCES threats(id) ON DELETE CASCADE,
    UNIQUE(asset_id, threat_id)
);

CREATE TABLE risk_assessments (
    id SERIAL PRIMARY KEY,
    asset_id INT REFERENCES assets(id) ON DELETE CASCADE,
    threat_id INT REFERENCES threats(id) ON DELETE CASCADE,
    vulnerability_id INT REFERENCES vulnerabilities(id) ON DELETE CASCADE,
    likelihood INT CHECK (likelihood BETWEEN 1 AND 5),   
    impact INT CHECK (impact BETWEEN 1 AND 5),          
    risk_score DECIMAL(5,2),                             
    risk_level VARCHAR(20),                             
    assessment_date DATE DEFAULT CURRENT_DATE,
    next_review_date DATE,
    mitigations TEXT,                                    
    status VARCHAR(50),                                 
    assigned_to VARCHAR(100),                            
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE incidents (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    incident_date TIMESTAMP WITH TIME ZONE,
    detection_date TIMESTAMP WITH TIME ZONE,
    resolution_date TIMESTAMP WITH TIME ZONE,
    severity VARCHAR(20),                               
    status VARCHAR(50),                                
    affected_assets TEXT,                               
    threat_id INT REFERENCES threats(id),
    vulnerability_id INT REFERENCES vulnerabilities(id),
    attack_vector TEXT,
    response_actions TEXT,
    lessons_learned TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE intel_sources (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    source_type VARCHAR(50),           
    feed_url VARCHAR(255),
    api_key VARCHAR(255),
    reliability_score INT CHECK (reliability_score BETWEEN 1 AND 10),
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE intel_reports (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    source_id INT REFERENCES intel_sources(id),
    report_date DATE,
    content TEXT,
    confidence_level VARCHAR(20),      
    relevant_threats TEXT,            
    relevant_vulnerabilities TEXT,     
    tags TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE controls (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    control_type VARCHAR(50),         
    description TEXT,
    implementation_status VARCHAR(50),
    effectiveness_score INT CHECK (effectiveness_score BETWEEN 1 AND 5),
    cost DECIMAL(10,2),
    responsible_party VARCHAR(100),
    review_frequency VARCHAR(50),      
    last_review_date DATE,
    next_review_date DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE risk_controls (
    id SERIAL PRIMARY KEY,
    risk_assessment_id INT REFERENCES risk_assessments(id) ON DELETE CASCADE,
    control_id INT REFERENCES controls(id) ON DELETE CASCADE,
    date_implemented DATE,
    notes TEXT,
    UNIQUE(risk_assessment_id, control_id)
);

CREATE INDEX idx_assets_name ON assets(name);
CREATE INDEX idx_assets_type ON assets(asset_type);
CREATE INDEX idx_threats_name ON threats(name);
CREATE INDEX idx_threats_type ON threats(threat_type);
CREATE INDEX idx_vulnerabilities_cve ON vulnerabilities(cve_id);
CREATE INDEX idx_vulnerabilities_severity ON vulnerabilities(severity);
CREATE INDEX idx_risk_assessments_level ON risk_assessments(risk_level);
CREATE INDEX idx_incidents_status ON incidents(status);
CREATE INDEX idx_incidents_severity ON incidents(severity);

CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER update_assets_modtime BEFORE UPDATE ON assets FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_threats_modtime BEFORE UPDATE ON threats FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_vulnerabilities_modtime BEFORE UPDATE ON vulnerabilities FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_risk_assessments_modtime BEFORE UPDATE ON risk_assessments FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_incidents_modtime BEFORE UPDATE ON incidents FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_intel_sources_modtime BEFORE UPDATE ON intel_sources FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_intel_reports_modtime BEFORE UPDATE ON intel_reports FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_controls_modtime BEFORE UPDATE ON controls FOR EACH ROW EXECUTE FUNCTION update_modified_column();
