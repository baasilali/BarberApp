/*
  # Initial Schema for Barber Booking Application

  1. New Tables
    - users
      - Standard user profile information
      - Role-based access (customer/barber)
    - services
      - Available haircut/styling services
      - Pricing and duration
    - barber_profiles
      - Extended information for barbers
      - Working hours and specialties
    - appointments
      - Booking information
      - Status tracking
    - barber_services
      - Links barbers to their offered services
    - portfolio_images
      - Barber work showcase
    
  2. Security
    - RLS policies for all tables
    - Role-based access control
*/

-- Create custom types
CREATE TYPE user_role AS ENUM ('customer', 'barber');
CREATE TYPE appointment_status AS ENUM ('pending', 'confirmed', 'completed', 'cancelled');

-- Users table (extends Supabase auth)
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  role user_role NOT NULL DEFAULT 'customer',
  full_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  phone TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Services table
CREATE TABLE services (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT,
  base_price DECIMAL(10,2) NOT NULL,
  duration_minutes INTEGER NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Barber profiles
CREATE TABLE barber_profiles (
  id UUID PRIMARY KEY REFERENCES users(id),
  bio TEXT,
  experience_years INTEGER,
  specialties TEXT[],
  location TEXT,
  working_hours JSONB,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Appointments
CREATE TABLE appointments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID REFERENCES users(id),
  barber_id UUID REFERENCES barber_profiles(id),
  service_id UUID REFERENCES services(id),
  start_time TIMESTAMPTZ NOT NULL,
  end_time TIMESTAMPTZ NOT NULL,
  status appointment_status DEFAULT 'pending',
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Barber services (many-to-many relationship)
CREATE TABLE barber_services (
  barber_id UUID REFERENCES barber_profiles(id),
  service_id UUID REFERENCES services(id),
  custom_price DECIMAL(10,2),
  is_active BOOLEAN DEFAULT true,
  PRIMARY KEY (barber_id, service_id)
);

-- Portfolio images
CREATE TABLE portfolio_images (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  barber_id UUID REFERENCES barber_profiles(id),
  image_url TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE services ENABLE ROW LEVEL SECURITY;
ALTER TABLE barber_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE barber_services ENABLE ROW LEVEL SECURITY;
ALTER TABLE portfolio_images ENABLE ROW LEVEL SECURITY;

-- RLS Policies

-- Users can read their own data
CREATE POLICY "Users can read own data" ON users
  FOR SELECT USING (auth.uid() = id);

-- Services are readable by all authenticated users
CREATE POLICY "Services are publicly readable" ON services
  FOR SELECT TO authenticated USING (true);

-- Barber profiles are readable by all authenticated users
CREATE POLICY "Barber profiles are publicly readable" ON barber_profiles
  FOR SELECT TO authenticated USING (true);

-- Barbers can update their own profiles
CREATE POLICY "Barbers can update own profile" ON barber_profiles
  FOR UPDATE USING (auth.uid() = id);

-- Appointments policies
CREATE POLICY "Users can read own appointments" ON appointments
  FOR SELECT USING (
    auth.uid() = customer_id OR 
    auth.uid() = barber_id
  );

CREATE POLICY "Customers can create appointments" ON appointments
  FOR INSERT WITH CHECK (auth.uid() = customer_id);

-- Portfolio images are readable by all authenticated users
CREATE POLICY "Portfolio images are publicly readable" ON portfolio_images
  FOR SELECT TO authenticated USING (true);

-- Barbers can manage their portfolio
CREATE POLICY "Barbers can manage their portfolio" ON portfolio_images
  FOR ALL USING (auth.uid() = barber_id);

-- Insert some initial services
INSERT INTO services (name, description, base_price, duration_minutes) VALUES
  ('Basic Haircut', 'Classic haircut with clippers and scissors', 30.00, 30),
  ('Beard Trim', 'Professional beard grooming and shaping', 20.00, 20),
  ('Hair & Beard Combo', 'Complete grooming package', 45.00, 45),
  ('Premium Styling', 'Haircut with premium styling and products', 50.00, 45),
  ('Kids Haircut', 'Haircut for children under 12', 25.00, 30);