import React, { useState, useEffect } from "react";

function AssetList() {
  const [assets, setAssets] = useState([]);

  useEffect(() => {
    fetch("http://127.0.0.1:5000/api/assets")
      .then((response) => response.json())
      .then((data) => setAssets(data))
      .catch((error) => console.error("Error fetching assets:", error));
  }, []);

  return (
    <div className="asset-list">
      <h2>Asset Inventory</h2>
      <div className="asset-list-container">
        <table>
          <thead>
            <tr>
              <th>Asset Name</th>
              <th>Type</th>
              <th>Description</th>
            </tr>
          </thead>
          <tbody>
            {assets.length > 0 ? (
              assets.map((asset, index) => (
                <tr key={index}>
                  <td>{asset.asset_name}</td>
                  <td>{asset.asset_type}</td>
                  <td>{asset.description}</td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan="3">Loading assets...</td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default AssetList;
