/**
 * Performance Chart Component
 * Displays performance metrics in a visual chart using Chart.js
 */

import React from 'react';
import { Line, Bar } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  Title,
  Tooltip,
  Legend,
} from 'chart.js';

// Register ChartJS components
ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  Title,
  Tooltip,
  Legend
);

const PerformanceChart = ({ metrics }) => {
  // Prepare data for charts
  const labels = metrics.map((m) => m.period || m.evaluationDate || 'N/A');
  
  const precisionData = metrics.map((m) => m.precision || 0);
  const recallData = metrics.map((m) => m.recall || 0);
  const f1ScoreData = metrics.map((m) => m.f1Score || 0);
  const accuracyData = metrics.map((m) => m.accuracy || 0);

  // Line chart data
  const lineChartData = {
    labels,
    datasets: [
      {
        label: 'Precision',
        data: precisionData,
        borderColor: '#667eea',
        backgroundColor: 'rgba(102, 126, 234, 0.1)',
        tension: 0.4,
        fill: true,
      },
      {
        label: 'Recall',
        data: recallData,
        borderColor: '#764ba2',
        backgroundColor: 'rgba(118, 75, 162, 0.1)',
        tension: 0.4,
        fill: true,
      },
      {
        label: 'F1 Score',
        data: f1ScoreData,
        borderColor: '#27ae60',
        backgroundColor: 'rgba(39, 174, 96, 0.1)',
        tension: 0.4,
        fill: true,
      },
    ],
  };

  // Bar chart data
  const barChartData = {
    labels,
    datasets: [
      {
        label: 'Precision',
        data: precisionData,
        backgroundColor: '#667eea',
      },
      {
        label: 'Recall',
        data: recallData,
        backgroundColor: '#764ba2',
      },
      {
        label: 'F1 Score',
        data: f1ScoreData,
        backgroundColor: '#27ae60',
      },
      {
        label: 'Accuracy',
        data: accuracyData,
        backgroundColor: '#e74c3c',
      },
    ],
  };

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: true,
    plugins: {
      legend: {
        position: 'top',
      },
      title: {
        display: true,
        padding: {
          top: 10,
          bottom: 30,
        },
      },
    },
    scales: {
      y: {
        beginAtZero: true,
        max: 1,
        ticks: {
          format: {
            style: 'percent',
          },
        },
      },
    },
  };

  return (
    <div>
      <div style={{ marginBottom: '3rem' }}>
        <h4 style={{ textAlign: 'center', marginBottom: '1rem' }}>Performance Trend (Line Chart)</h4>
        <div style={{ position: 'relative', height: '300px' }}>
          <Line data={lineChartData} options={chartOptions} />
        </div>
      </div>

      <div>
        <h4 style={{ textAlign: 'center', marginBottom: '1rem' }}>Performance Comparison (Bar Chart)</h4>
        <div style={{ position: 'relative', height: '300px' }}>
          <Bar data={barChartData} options={chartOptions} />
        </div>
      </div>
    </div>
  );
};

export default PerformanceChart;
