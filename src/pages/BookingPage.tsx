import React from 'react';
import { useParams } from 'react-router-dom';

export default function BookingPage() {
  const { barberId } = useParams();

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <h1 className="text-2xl font-semibold text-gray-900">Book Appointment</h1>
      {/* We'll implement this fully in the next step */}
    </div>
  );
}