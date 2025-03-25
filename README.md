# 💈 BarberApp

A modern, full-stack barber shop appointment booking application built with React, TypeScript, and Supabase.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![React](https://img.shields.io/badge/React-18-blue)
![TypeScript](https://img.shields.io/badge/TypeScript-5.0-blue)
![Tailwind](https://img.shields.io/badge/Tailwind-3.0-blue)
![Supabase](https://img.shields.io/badge/Supabase-Latest-green)

## 🚀 Features

- **User Authentication**
  - Secure login and registration system
  - Role-based access control (Barbers & Customers)
  - Protected routes and authenticated sessions

- **Customer Features**
  - Browse available barbers
  - Book appointments
  - View booking history
  - Manage profile

- **Barber Features**
  - Manage availability
  - View upcoming appointments
  - Customer management
  - Dashboard analytics

## 🛠️ Tech Stack

- **Frontend**
  - React 18 with TypeScript
  - Vite for blazing-fast development
  - Tailwind CSS for styling
  - React Context for state management

- **Backend & Database**
  - Supabase for backend services
  - Real-time data synchronization
  - Secure authentication
  - PostgreSQL database

## 📦 Installation

1. Clone the repository:
```bash
git clone https://github.com/baasilali/BarberApp.git
cd BarberApp
```

2. Install dependencies:
```bash
npm install
```

3. Create a `.env` file in the root directory with your Supabase credentials:
```env
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

4. Start the development server:
```bash
npm run dev
```

## 🏗️ Project Structure

```
barberapp/
├── src/
│   ├── components/     # Reusable UI components
│   ├── contexts/       # React Context providers
│   ├── lib/           # Utility functions and configurations
│   ├── pages/         # Application routes/pages
│   └── main.tsx       # Application entry point
├── public/            # Static assets
└── supabase/         # Database configurations
```

## 🔐 Environment Variables

The following environment variables are required:

- `VITE_SUPABASE_URL`: Your Supabase project URL
- `VITE_SUPABASE_ANON_KEY`: Your Supabase anonymous key

## 🚀 Deployment

1. Build the project:
```bash
npm run build
```

2. Deploy to your preferred hosting platform (Vercel, Netlify, etc.)

## 🧪 Testing

```bash
npm run test
```

## 🤝 Contributing

1. Fork the repository
2. Create a new branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Baasil Ali** - *Initial work* - [baasilali](https://github.com/baasilali)

## 🙏 Acknowledgments

- Thanks to all contributors who have helped shape BarberApp
- Inspired by modern booking systems and barber shop needs 