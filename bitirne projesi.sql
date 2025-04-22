
 -- 1. Önce ayrı olarak veritabanını oluşturun:
-- CREATE DATABASE online_education_platform;

-- 2. Sonra oluşturulan veritabanına bağlanın ve aşağıdaki SQL komutlarını çalıştırın:

-- Üyeler (Members) tablosu
CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Kategoriler (Categories) tablosu
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Eğitimler (Courses) tablosu
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    instructor VARCHAR(100) NOT NULL,
    category_id INTEGER REFERENCES categories(category_id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Katılımlar (Enrollments) tablosu
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    course_id INTEGER NOT NULL REFERENCES courses(course_id),
    enrollment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (member_id, course_id)
);

-- Sertifikalar (Certificates) tablosu
CREATE TABLE certificates (
    certificate_id SERIAL PRIMARY KEY,
    certificate_code VARCHAR(100) NOT NULL UNIQUE,
    course_id INTEGER NOT NULL REFERENCES courses(course_id),
    issue_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Sertifika Atamaları (CertificateAssignments) tablosu
CREATE TABLE certificate_assignments (
    assignment_id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    certificate_id INTEGER NOT NULL REFERENCES certificates(certificate_id),
    assignment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    UNIQUE (member_id, certificate_id)
);

-- Blog Gönderileri (BlogPosts) tablosu
CREATE TABLE blog_posts (
    post_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    publication_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    author_id INTEGER NOT NULL REFERENCES members(member_id),
    views_count INTEGER DEFAULT 0,
    is_published BOOLEAN DEFAULT TRUE
);

-- Örnek kategori verileri
INSERT INTO categories (name, description) VALUES 
('Yapay Zeka', 'Yapay zeka ve makine öğrenimi ile ilgili eğitimler'),
('Blokzincir', 'Blokzincir teknolojisi ve kripto para birimleri hakkında eğitimler'),
('Siber Güvenlik', 'Ağ güvenliği ve siber savunma üzerine eğitimler');