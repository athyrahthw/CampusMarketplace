<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Marketplace</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Homepage Specific Styles -->
    <style>
        :root {
            --primary-purple: #8a4fff;
            --light-purple: #a982ff;
            --pale-purple: #f0e6ff;
            --dark-purple: #6b3fc1;
            --accent-green: #4CAF50;
            --accent-pink: #ff4f8b;
            --accent-blue: #36a2ff;
            --accent-orange: #ff9d42;
            --accent-teal: #2dd4bf;
            --light-bg: #f8f5ff;
            --card-bg: #ffffff;
            --text-dark: #2c3e50;
            --text-light: #666;
            --shadow-light: 0 4px 15px rgba(138, 79, 255, 0.1);
            --shadow-medium: 0 8px 25px rgba(138, 79, 255, 0.15);
            --shadow-heavy: 0 15px 40px rgba(138, 79, 255, 0.2);
            --gradient-primary: linear-gradient(135deg, var(--primary-purple), var(--light-purple));
            --gradient-secondary: linear-gradient(135deg, var(--accent-pink), var(--accent-orange));
            --gradient-success: linear-gradient(135deg, var(--accent-green), var(--accent-teal));
        }

        /* ===== BASE STYLES ===== */
        body {
            background: linear-gradient(135deg, #f8f5ff 0%, #e8e0ff 100%);
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: var(--text-dark);
        }

        /* ===== ANIMATED BACKGROUND ===== */
        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .bg-circle {
            position: absolute;
            border-radius: 50%;
            background: radial-gradient(circle, var(--light-purple) 0%, transparent 70%);
            opacity: 0.1;
            animation: float 20s infinite linear;
        }

        .bg-circle:nth-child(1) {
            width: 300px;
            height: 300px;
            top: 10%;
            left: 5%;
            animation-delay: 0s;
        }

        .bg-circle:nth-child(2) {
            width: 200px;
            height: 200px;
            top: 60%;
            right: 10%;
            background: radial-gradient(circle, var(--accent-pink) 0%, transparent 70%);
            animation-delay: 5s;
        }

        .bg-circle:nth-child(3) {
            width: 150px;
            height: 150px;
            bottom: 20%;
            left: 20%;
            background: radial-gradient(circle, var(--accent-blue) 0%, transparent 70%);
            animation-delay: 10s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        /* ===== NAVIGATION ===== */
        .homepage-nav {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 1rem 2rem;
            box-shadow: var(--shadow-light);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 3px solid transparent;
            border-image: var(--gradient-primary);
            border-image-slice: 1;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-logo {
            display: flex;
            align-items: center;
            gap: 15px;
            text-decoration: none;
        }

        .nav-logo i {
            font-size: 2.5rem;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            filter: drop-shadow(0 2px 4px rgba(138, 79, 255, 0.3));
        }

        .nav-logo h1 {
            font-size: 2rem;
            font-weight: 800;
            margin: 0;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 10px rgba(138, 79, 255, 0.2);
        }

        .nav-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .nav-btn {
            padding: 12px 28px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
        }

        .nav-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.6s ease;
        }

        .nav-btn:hover::before {
            left: 100%;
        }

        .nav-btn-primary {
            background: var(--gradient-primary);
            color: white;
            border: none;
            box-shadow: 0 6px 20px rgba(138, 79, 255, 0.3);
        }

        .nav-btn-primary:hover {
            transform: translateY(-4px) scale(1.05);
            box-shadow: 0 12px 30px rgba(138, 79, 255, 0.4);
        }

        .nav-btn-secondary {
            background: white;
            color: var(--primary-purple);
            border: 2px solid var(--light-purple);
            box-shadow: 0 4px 15px rgba(138, 79, 255, 0.1);
        }

        .nav-btn-secondary:hover {
            background: var(--pale-purple);
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(138, 79, 255, 0.2);
            border-color: var(--primary-purple);
        }

        /* ===== HERO SECTION ===== */
        .hero-section {
            max-width: 1200px;
            margin: 4rem auto;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
            position: relative;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: -100px;
            right: -100px;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(168, 85, 247, 0.1) 0%, transparent 70%);
            z-index: -1;
        }

        @media (max-width: 992px) {
            .hero-section {
                grid-template-columns: 1fr;
                gap: 3rem;
            }
        }

        .hero-content h1 {
            font-size: 3.8rem;
            font-weight: 800;
            line-height: 1.1;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--accent-pink) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 5px 15px rgba(138, 79, 255, 0.1);
        }

        .hero-content p {
            font-size: 1.3rem;
            color: var(--text-dark);
            line-height: 1.7;
            margin-bottom: 2rem;
            opacity: 0.9;
        }

        .hero-stats {
            display: flex;
            gap: 3rem;
            margin-top: 2rem;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            border: 2px solid rgba(138, 79, 255, 0.1);
            box-shadow: var(--shadow-light);
        }

        .stat-item {
            text-align: center;
            flex: 1;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            display: block;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            line-height: 1;
        }

        .stat-label {
            font-size: 0.95rem;
            color: var(--text-light);
            font-weight: 500;
            margin-top: 0.5rem;
        }

        .hero-image {
            position: relative;
            animation: floatImage 6s ease-in-out infinite;
        }

        @keyframes floatImage {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }

        .hero-image::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 110%;
            height: 110%;
            background: var(--gradient-primary);
            border-radius: 30px;
            filter: blur(40px);
            opacity: 0.3;
            z-index: -1;
        }

        .hero-image-content {
            background: white;
            border-radius: 30px;
            padding: 2rem;
            box-shadow: var(--shadow-heavy);
            border: 3px solid transparent;
            background-clip: padding-box;
            position: relative;
            overflow: hidden;
        }

        .hero-image-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: var(--gradient-primary);
        }

        .image-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-top: 1rem;
        }

        .image-item {
            background: var(--light-bg);
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            border: 2px solid var(--pale-purple);
            transition: all 0.3s ease;
        }

        .image-item:hover {
            transform: translateY(-5px);
            border-color: var(--light-purple);
            box-shadow: var(--shadow-medium);
        }

        .image-item i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            display: block;
        }

        .image-item:nth-child(1) i { color: var(--primary-purple); }
        .image-item:nth-child(2) i { color: var(--accent-pink); }
        .image-item:nth-child(3) i { color: var(--accent-blue); }
        .image-item:nth-child(4) i { color: var(--accent-orange); }

        .image-item span {
            font-weight: 600;
            color: var(--text-dark);
            font-size: 0.9rem;
        }

        /* ===== FEATURES SECTION ===== */
        .features-section {
            max-width: 1200px;
            margin: 6rem auto;
            padding: 0 2rem;
            position: relative;
        }

        .features-section::before {
            content: '';
            position: absolute;
            bottom: -100px;
            left: -100px;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(255, 79, 139, 0.1) 0%, transparent 70%);
            z-index: -1;
        }

        .section-header {
            text-align: center;
            margin-bottom: 4rem;
        }

        .section-header h2 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--primary-purple), var(--dark-purple));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .section-header p {
            font-size: 1.2rem;
            color: var(--text-light);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .feature-card {
            background: white;
            border-radius: 20px;
            padding: 2.5rem 2rem;
            text-align: center;
            border: 3px solid transparent;
            background-clip: padding-box;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            box-shadow: var(--shadow-light);
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: var(--gradient-primary);
        }

        .feature-card:nth-child(2)::before { background: var(--gradient-secondary); }
        .feature-card:nth-child(3)::before { background: var(--gradient-success); }
        .feature-card:nth-child(4)::before { background: linear-gradient(135deg, var(--accent-blue), var(--accent-teal)); }
        .feature-card:nth-child(5)::before { background: linear-gradient(135deg, var(--accent-orange), #ff6b6b); }
        .feature-card:nth-child(6)::before { background: linear-gradient(135deg, var(--primary-purple), var(--accent-blue)); }

        .feature-card:hover {
            transform: translateY(-15px) scale(1.02);
            box-shadow: 0 25px 50px rgba(138, 79, 255, 0.2);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            background: var(--gradient-primary);
            color: white;
            box-shadow: 0 10px 20px rgba(138, 79, 255, 0.2);
        }

        .feature-card:nth-child(2) .feature-icon { background: var(--gradient-secondary); }
        .feature-card:nth-child(3) .feature-icon { background: var(--gradient-success); }
        .feature-card:nth-child(4) .feature-icon { background: linear-gradient(135deg, var(--accent-blue), var(--accent-teal)); }
        .feature-card:nth-child(5) .feature-icon { background: linear-gradient(135deg, var(--accent-orange), #ff6b6b); }
        .feature-card:nth-child(6) .feature-icon { background: linear-gradient(135deg, var(--primary-purple), var(--accent-blue)); }

        .feature-card h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 1rem;
        }

        .feature-card p {
            color: var(--text-light);
            line-height: 1.6;
            margin: 0;
        }

        /* ===== HOW IT WORKS ===== */
        .how-it-works {
            max-width: 1200px;
            margin: 6rem auto;
            padding: 4rem 2rem;
            background: linear-gradient(135deg, rgba(138, 79, 255, 0.05) 0%, rgba(255, 79, 139, 0.05) 100%);
            border-radius: 40px;
            position: relative;
            overflow: hidden;
        }

        .how-it-works::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z' fill='%238a4fff' fill-opacity='0.03' fill-rule='evenodd'/%3E%3C/svg%3E");
        }

        .steps {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 3rem;
            margin-top: 3rem;
            position: relative;
            z-index: 1;
        }

        .step {
            text-align: center;
            position: relative;
            padding: 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow-light);
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .step:hover {
            transform: translateY(-10px);
            border-color: var(--light-purple);
            box-shadow: var(--shadow-medium);
        }

        .step-number {
            width: 60px;
            height: 60px;
            background: var(--gradient-primary);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            font-weight: 800;
            margin: 0 auto 1.5rem;
            border: 4px solid white;
            box-shadow: 0 8px 20px rgba(138, 79, 255, 0.3);
        }

        .step:nth-child(2) .step-number { background: var(--gradient-secondary); }
        .step:nth-child(3) .step-number { background: var(--gradient-success); }
        .step:nth-child(4) .step-number { background: linear-gradient(135deg, var(--accent-blue), var(--accent-teal)); }

        .step h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 1rem;
        }

        .step p {
            color: var(--text-light);
            line-height: 1.6;
        }

        /* ===== CTA SECTION ===== */
        .cta-section {
            max-width: 1000px;
            margin: 6rem auto;
            padding: 5rem 2rem;
            background: var(--gradient-primary);
            border-radius: 40px;
            text-align: center;
            color: white;
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(138, 79, 255, 0.4);
        }

        .cta-section::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.2) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .cta-content {
            position: relative;
            z-index: 1;
        }

        .cta-content h2 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            color: white;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .cta-content p {
            font-size: 1.3rem;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto 3rem;
            line-height: 1.6;
        }

        .cta-buttons {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .cta-btn {
            padding: 18px 40px;
            border-radius: 50px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
            font-size: 1.1rem;
            border: 3px solid transparent;
            min-width: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            position: relative;
            overflow: hidden;
        }

        .cta-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.6s ease;
        }

        .cta-btn:hover::before {
            left: 100%;
        }

        .cta-btn-primary {
            background: white;
            color: var(--primary-purple);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .cta-btn-primary:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }

        .cta-btn-secondary {
            background: transparent;
            color: white;
            border-color: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(10px);
        }

        .cta-btn-secondary:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: white;
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        /* ===== FOOTER ===== */
        .homepage-footer {
            background: linear-gradient(135deg, var(--dark-purple) 0%, #5a2fa3 100%);
            color: white;
            margin-top: auto;
            padding-top: 5rem;
            position: relative;
            overflow: hidden;
        }

        .homepage-footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-purple), var(--accent-pink), var(--accent-blue), var(--accent-orange));
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            position: relative;
            z-index: 1;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 3rem;
            margin-bottom: 3rem;
        }

        .footer-column h3 {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            color: white;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .footer-column h3 i {
            font-size: 1.8rem;
            background: linear-gradient(135deg, #ffd166, #ff9d42);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .footer-column p {
            opacity: 0.8;
            line-height: 1.7;
            margin-bottom: 1.5rem;
            font-size: 1rem;
        }

        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 0;
        }

        .footer-links a:hover {
            color: white;
            transform: translateX(10px);
        }

        .footer-links a i {
            width: 24px;
            text-align: center;
            color: var(--accent-orange);
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .social-link {
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-decoration: none;
            font-size: 1.2rem;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .social-link:hover {
            background: var(--primary-purple);
            transform: translateY(-5px) rotate(10deg);
            border-color: white;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        .footer-bottom {
            text-align: center;
            padding: 2.5rem 0;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            opacity: 0.8;
            font-size: 0.95rem;
        }

        .footer-bottom p {
            margin: 0.5rem 0;
        }

        /* ===== RESPONSIVE DESIGN ===== */
        @media (max-width: 768px) {
            .hero-content h1 {
                font-size: 2.8rem;
            }
            
            .hero-stats {
                flex-direction: column;
                gap: 2rem;
                padding: 1.5rem;
            }
            
            .cta-content h2 {
                font-size: 2.5rem;
            }
            
            .section-header h2 {
                font-size: 2.5rem;
            }
            
            .cta-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .cta-btn {
                width: 100%;
                max-width: 300px;
            }
            
            .nav-actions {
                flex-direction: column;
                gap: 0.8rem;
            }
            
            .nav-btn {
                padding: 10px 20px;
                font-size: 0.95rem;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .hero-section {
                padding: 0 1rem;
            }
            
            .features-section,
            .how-it-works,
            .cta-section {
                padding: 0 1rem;
                margin: 4rem auto;
            }
            
            .footer-container {
                padding: 0 1rem;
            }
            
            .hero-content h1 {
                font-size: 2.2rem;
            }
            
            .section-header h2 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <!-- Animated Background -->
    <div class="bg-animation">
        <div class="bg-circle"></div>
        <div class="bg-circle"></div>
        <div class="bg-circle"></div>
    </div>

    <!-- ===== NAVIGATION ===== -->
    <nav class="homepage-nav">
        <div class="nav-container">
            <a href="index.jsp" class="nav-logo">
                <i class="fas fa-store"></i>
                <h1>Campus Marketplace</h1>
            </a>
            
            <div class="nav-actions">
                <a href="login.jsp" class="nav-btn nav-btn-secondary">
                    <i class="fas fa-sign-in-alt"></i>
                    Sign In
                </a>
                <a href="register.jsp" class="nav-btn nav-btn-primary">
                    <i class="fas fa-rocket"></i>
                    Get Started
                </a>
            </div>
        </div>
    </nav>

    <!-- ===== HERO SECTION ===== -->
    <section class="hero-section">
        <div class="hero-content">
            <h1>Your Campus Trading Hub</h1>
            <p>Buy, sell, and trade textbooks, electronics, furniture, and more with fellow students. A safe, student-only marketplace designed for your campus community.</p>
            
            <div class="hero-stats">
                <div class="stat-item">
                    <span class="stat-number">500+</span>
                    <span class="stat-label">Active Students</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number">$25K+</span>
                    <span class="stat-label">Saved Monthly</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number">98%</span>
                    <span class="stat-label">Satisfaction Rate</span>
                </div>
            </div>
            
            <div class="cta-buttons">
                <a href="register.jsp" class="cta-btn cta-btn-primary">
                    <i class="fas fa-rocket"></i>
                    Join Now - It's Free
                </a>
                <a href="#how-it-works" class="cta-btn cta-btn-secondary">
                    <i class="fas fa-play-circle"></i>
                    See How It Works
                </a>
            </div>
        </div>
        
        <div class="hero-image">
            <div class="hero-image-content">
                <h3 style="color: var(--primary-purple); margin-bottom: 1rem; font-size: 1.5rem;">Popular Categories</h3>
                <div class="image-grid">
                    <div class="image-item">
                        <i class="fas fa-book"></i>
                        <span>Textbooks</span>
                    </div>
                    <div class="image-item">
                        <i class="fas fa-laptop"></i>
                        <span>Electronics</span>
                    </div>
                    <div class="image-item">
                        <i class="fas fa-tshirt"></i>
                        <span>Clothing</span>
                    </div>
                    <div class="image-item">
                        <i class="fas fa-bicycle"></i>
                        <span>Bikes</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== FEATURES SECTION ===== -->
    <section class="features-section">
        <div class="section-header">
            <h2>Why Choose Campus Marketplace?</h2>
            <p>Experience the best platform for campus trading with these amazing features</p>
        </div>
        
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <h3>Campus Verified</h3>
                <p>All users are verified campus members, ensuring a safe and trusted trading environment.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-bolt"></i>
                </div>
                <h3>Instant Listings</h3>
                <p>List items in seconds with our simple interface. Upload photos, set prices, and start selling.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-comments"></i>
                </div>
                <h3>Built-in Messaging</h3>
                <p>Communicate securely with buyers and sellers through our integrated messaging system.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-search"></i>
                </div>
                <h3>Smart Search</h3>
                <p>Find exactly what you need with advanced filters and campus-specific categories.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-heart"></i>
                </div>
                <h3>Save Favorites</h3>
                <p>Save items you love and get notified when prices drop or new similar items are listed.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h3>Price Trends</h3>
                <p>See historical price trends for items to make informed buying and selling decisions.</p>
            </div>
        </div>
    </section>

    <!-- ===== HOW IT WORKS ===== -->
    <section class="how-it-works" id="how-it-works">
        <div class="section-header">
            <h2 style="color: white;">How It Works</h2>
            <p style="color: rgba(255,255,255,0.9);">Getting started with Campus Marketplace is easy and takes just a few minutes</p>
        </div>
        
        <div class="steps">
            <div class="step">
                <div class="step-number">1</div>
                <h3>Create Account</h3>
                <p>Sign up with your campus email. We verify you're a student to keep the community safe.</p>
            </div>
            
            <div class="step">
                <div class="step-number">2</div>
                <h3>Browse or List</h3>
                <p>Find great deals from other students or list your own items for sale in just a few clicks.</p>
            </div>
            
            <div class="step">
                <div class="step-number">3</div>
                <h3>Connect & Chat</h3>
                <p>Message sellers directly through our secure platform to ask questions or negotiate prices.</p>
            </div>
            
            <div class="step">
                <div class="step-number">4</div>
                <h3>Meet & Trade</h3>
                <p>Arrange safe, on-campus meetups in designated trading spots to complete your transactions.</p>
            </div>
        </div>
    </section>

    <!-- ===== CTA SECTION ===== -->
    <section class="cta-section">
        <div class="cta-content">
            <h2>Ready to Start Trading?</h2>
            <p>Join thousands of students who are already saving money and making connections on Campus Marketplace.</p>
            
            <div class="cta-buttons">
                <a href="register.jsp" class="cta-btn cta-btn-primary">
                    <i class="fas fa-user-plus"></i>
                    Create Free Account
                </a>
                <a href="login.jsp" class="cta-btn cta-btn-secondary">
                    <i class="fas fa-sign-in-alt"></i>
                    Sign In to Your Account
                </a>
            </div>
        </div>
    </section>

    <!-- ===== FOOTER ===== -->
    <footer class="homepage-footer">
        <div class="footer-container">
            <div class="footer-grid">
                <div class="footer-column">
                    <h3><i class="fas fa-store"></i> Campus Marketplace</h3>
                    <p>Your trusted platform for buying, selling, and trading within your campus community. Designed for students, by students.</p>
                    <div class="social-links">
                        <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                
                <div class="footer-column">
                    <h3><i class="fas fa-link"></i> Quick Links</h3>
                    <div class="footer-links">
                        <a href="index.jsp"><i class="fas fa-home"></i> Home</a>
                        <a href="about.jsp"><i class="fas fa-info-circle"></i> About Us</a>
                        <a href="contact.jsp"><i class="fas fa-envelope"></i> Contact</a>
                        <a href="faq.jsp"><i class="fas fa-question-circle"></i> FAQ</a>
                    </div>
                </div>
                
                <div class="footer-column">
                    <h3><i class="fas fa-cube"></i> Categories</h3>
                    <div class="footer-links">
                        <a href="#"><i class="fas fa-book"></i> Textbooks</a>
                        <a href="#"><i class="fas fa-laptop"></i> Electronics</a>
                        <a href="#"><i class="fas fa-tshirt"></i> Clothing</a>
                        <a href="#"><i class="fas fa-couch"></i> Furniture</a>
                    </div>
                </div>
                
                <div class="footer-column">
                    <h3><i class="fas fa-headset"></i> Support</h3>
                    <div class="footer-links">
                        <a href="mailto:support@campusmarket.edu"><i class="fas fa-envelope"></i> support@campusmarket.edu</a>
                        <a href="tel:1234567890"><i class="fas fa-phone"></i> (123) 456-7890</a>
                        <a href="#"><i class="fas fa-map-marker-alt"></i> Student Center, Room 205</a>
                    </div>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2024 Campus Marketplace. All rights reserved. | Designed for Students, By Students</p>
                <p>A student-run initiative promoting sustainability through reuse and exchange.</p>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add animation to elements when they come into view
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);

            // Observe elements for animation
            document.querySelectorAll('.feature-card, .step, .hero-image').forEach(el => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(30px)';
                el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                observer.observe(el);
            });

            // Smooth scroll for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function(e) {
                    e.preventDefault();
                    const targetId = this.getAttribute('href');
                    if (targetId === '#') return;
                    
                    const targetElement = document.querySelector(targetId);
                    if (targetElement) {
                        window.scrollTo({
                            top: targetElement.offsetTop - 80,
                            behavior: 'smooth'
                        });
                    }
                });
            });

            // Add hover effect to buttons
            document.querySelectorAll('.nav-btn, .cta-btn').forEach(btn => {
                btn.addEventListener('mouseenter', function() {
                    this.style.transform = this.style.transform || 'none';
                });
                
                btn.addEventListener('mouseleave', function() {
                    if (!this.classList.contains('hover')) {
                        this.style.transform = '';
                    }
                });
            });
        });
    </script>
</body>
</html>