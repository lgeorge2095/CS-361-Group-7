import "./App.css";
import { useState } from "react";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import Login from "./components/Login";
import ThreatDashboard from "./components/ThreatDashboard";

function App() {
    const [isLoggedIn, setIsLoggedIn] = useState(false);

    return (
        <Router>
            <Routes>
                <Route path="/login" element={<Login onLogin={() => setIsLoggedIn(true)} />} />
                <Route
                    path="/dashboard"
                    element={isLoggedIn ? <ThreatDashboard /> : <Navigate to="/login" />}
                />
                <Route path="*" element={<Navigate to={isLoggedIn ? "/dashboard" : "/login"} />} />

            </Routes>
        </Router>

    );
}

export default App;