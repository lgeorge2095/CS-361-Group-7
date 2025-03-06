import ThreatLogs from "./ThreatLogs";
import RiskScores from "./RiskScores";
import RealTimeAlerts from "./RealTimeAlerts";

function ThreatDashboard() {
  return (
    <div>
      {/* Header */}
      <div className="dashboard-header">
        <h1 className="dashboard-title">Real-Time Threat Intelligence</h1>
        <p className="dashboard-subtitle">
          Live Threat Updates will be displayed here.
        </p>
      </div>

      {/* Dashboard Grid */}
      <div className="dashboard-grid">
        {/* Left Column */}
        <div className="left-column">
          <ThreatLogs />
          <RiskScores />
        </div>

        {/* Right Column */}
        <RealTimeAlerts />
      </div>
    </div>
  );
};

export default ThreatDashboard;
