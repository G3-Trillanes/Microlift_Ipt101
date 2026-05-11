-- Create the admins table
CREATE TABLE admins_table (
    admin_id TEXT PRIMARY KEY,
    admin_name TEXT NOT NULL,
    admin_email TEXT NOT NULL,
    admin_location TEXT,
    status TEXT
);

-- Insert the XML data into the table
INSERT INTO admins_table (admin_id, admin_name, admin_email, admin_location, status) 
VALUES 
    ('A001', 'Juan D Cruz', 'juancruz@gmail.com', 'San Pablo, Laguna', 'Active'),
    ('A002', 'Maria Santos', 'mariasantos@gmail.com', 'Lipa City, Batangas', 'Active'),
    ('A003', 'Carlos Reyes', 'carlosreyes@gmail.com', 'Batangas City, Batangas', 'Inactive'),
    ('A004', 'Angela Mendoza', 'angelamendoza@gmail.com', 'Calamba City, Laguna', 'Active'),
    ('A005', 'Joshua Flores', 'joshuaflores@gmail.com', 'Lucena City, Quezon', 'Suspended');

    -- Create the job_hunters table
CREATE TABLE job_hunters (
    job_hunter_id TEXT PRIMARY KEY,
    job_hunter_name TEXT NOT NULL,
    job_hunter_email TEXT NOT NULL,
    job_hunter_location TEXT,
    availability TEXT
);

-- Insert the XML data into the table
INSERT INTO job_hunters (job_hunter_id, job_hunter_name, job_hunter_email, job_hunter_location, availability) 
VALUES 
    ('H001', 'Maria S Lopez', 'marialopez@gmail.com', 'Tanauan City, Batangas', 'Available'),
    ('H002', 'Carlos Mendoza', 'carlosmendoza@gmail.com', 'Santo Tomas, Batangas', 'Unavailable'),
    ('H003', 'Angela Reyes', 'angelareyes@gmail.com', 'Lipa City, Batangas', 'Available'),
    ('H004', 'Joshua Rivera', 'joshuarivera@gmail.com', 'Batangas City, Batangas', 'Available'),
    ('H005', 'Daniel Flores', 'danielflores@gmail.com', 'San Pablo, Laguna', 'Unavailable'),
    ('H006', 'Sarah Bautista', 'sarahbautista@gmail.com', 'Lucena City, Quezon', 'Available'),
    ('H007', 'Mark Santos', 'marksantos@gmail.com', 'Lemery, Batangas', 'Available'),
    ('H008', 'Kevin Dela Cruz', 'kevindelacruz@gmail.com', 'San Jose, Batangas', 'Unavailable'),
    ('H009', 'Ralph Garcia', 'ralphgarcia@gmail.com', 'San Pablo, Laguna', 'Available'),
    ('H010', 'Jenny Morales', 'jennymorales@gmail.com', 'Malvar, Batangas', 'Available');

    -- Create the employers table
CREATE TABLE employers (
    employer_id TEXT PRIMARY KEY,
    employer_name TEXT NOT NULL,
    employer_contact TEXT,
    employer_location TEXT,
    industry TEXT
);

-- Insert the XML data into the table
INSERT INTO employers (employer_id, employer_name, employer_contact, employer_location, industry) 
VALUES 
    ('E001', 'BuildRight Construction', '09123456789', 'Batangas City, Batangas', 'Construction'),
    ('E002', 'Batangas Steel Works', '09111111111', 'Lipa City, Batangas', 'Manufacturing'),
    ('E003', 'Golden Harvest Farm', '09222222222', 'Rosario, Batangas', 'Agriculture'),
    ('E004', 'Metro Auto Repair', '09333333333', 'Tanauan City, Batangas', 'Automotive Services'),
    ('E005', 'South Luzon Electrical Services', '09444444444', 'Calamba City, Laguna', 'Electrical Services'),
    ('E006', 'CleanWave Laundry Services', '09555555555', 'Lucena City, Quezon', 'Laundry Services'),
    ('E007', 'Prime Furniture Makers', '09666666666', 'Tanauan City, Batangas', 'Furniture Manufacturing'),
    ('E008', 'Fresh Catch Market', '09777777777', 'Batangas City, Batangas', 'Retail and Seafood Market'),
    ('E009', 'QuickFix Plumbing Services', '09170000009', 'San Jose, Batangas', 'Plumbing Services'),
    ('E010', 'Sunrise Hardware', '09170000010', 'Lipa City, Batangas', 'Hardware and Retail');

    -- Create the jobs table with a foreign key linking to the employers table
CREATE TABLE jobs (
    job_id TEXT PRIMARY KEY,
    employer_id TEXT NOT NULL,
    job_name TEXT NOT NULL,
    job_type TEXT,
    job_location TEXT,
    job_status TEXT,
    job_description TEXT,
    CONSTRAINT fk_employer
        FOREIGN KEY (employer_id) 
        REFERENCES employers(employer_id)
        ON DELETE CASCADE
);

-- Insert the XML data into the table
INSERT INTO jobs (job_id, employer_id, job_name, job_type, job_location, job_status, job_description) 
VALUES 
    ('J001', 'E001', 'Construction Worker', 'Manual Labor', 'Lipa City, Batangas', 'Filled', 'Performs basic construction tasks on site. Assists skilled workers in building structures. Handles tools and materials safely. Follows safety protocols at all times. Works under supervision of foreman.'),
    ('J002', 'E002', 'Welder', 'Skilled Labor', 'Batangas City, Batangas', 'Open', 'Joins metal parts using welding equipment. Reads basic technical drawings. Ensures strong and clean welds. Maintains welding tools and safety gear. Works in industrial or construction settings.'),
    ('J004', 'E004', 'Auto Mechanic', 'Technical Work', 'Tanauan City, Batangas', 'Open', 'Diagnoses vehicle engine problems. Repairs and replaces faulty car parts. Performs routine vehicle maintenance. Uses diagnostic tools and equipment. Ensures vehicles are safe to operate.'),
    ('J005', 'E005', 'Electrician', 'Electrical Work', 'Calamba City, Laguna', 'Open', 'Installs and repairs electrical systems. Reads electrical blueprints and diagrams. Ensures wiring meets safety standards. Troubleshoots electrical issues efficiently. Maintains tools and safety compliance.'),
    ('J006', 'E006', 'Laundry Staff', 'Service Work', 'Lucena City, Quezon', 'Filled', 'Washes and cleans clothes and linens. Operates washing and drying machines. Sorts garments by fabric and color. Ensures proper folding and packaging. Maintains cleanliness of laundry area.'),
    ('J007', 'E007', 'Carpenter', 'Woodwork', 'Tanauan City, Batangas', 'Open', 'Builds and repairs wooden structures. Measures and cuts wood accurately. Reads basic construction plans. Uses hand and power tools safely. Finishes surfaces for quality output.'),
    ('J008', 'E008', 'Delivery Rider', 'Logistics', 'Batangas City, Batangas', 'Open', 'Delivers packages to assigned locations. Follows efficient delivery routes. Ensures items are handled safely. Communicates with customers and dispatch. Maintains motorcycle in good condition.'),
    ('J009', 'E009', 'Plumber', 'Maintenance Work', 'San Jose, Batangas', 'Reopened', 'Installs and repairs water systems. Fixes leaks and pipe blockages. Reads plumbing layouts and plans. Uses plumbing tools effectively. Ensures proper water flow systems.'),
    ('J010', 'E010', 'Store Helper', 'Retail Work', 'Lipa City, Batangas', 'Open', 'Assists in daily store operations. Stocks shelves and organizes products. Helps customers with basic inquiries. Maintains cleanliness of store area. Supports cashier and inventory tasks.'),
    ('J011', 'E001', 'Painter', 'Construction Work', 'Tanauan City, Batangas', 'Open', 'Applies paint to interior and exterior surfaces. Prepares walls by cleaning and sanding. Mixes colors for desired finishes. Uses brushes, rollers, and spray tools. Ensures smooth and even paint application.'),
    ('J012', 'E003', 'Gardener', 'Outdoor Work', 'Rosario, Batangas', 'Reopened', 'Maintains plants, lawns, and gardens. Waters and prunes plants regularly. Removes weeds and garden debris. Applies fertilizers and soil care techniques. Ensures outdoor spaces are clean and presentable.'),
    ('J013', 'E005', 'Warehouse Staff', 'Logistics', 'Calamba City, Laguna', 'Closed', 'Organizes items in warehouse storage. Packs and labels goods for shipment. Tracks inventory records accurately. Loads and unloads delivery items. Maintains order and cleanliness in warehouse.'),
    ('J014', 'E001', 'Tile Installer', 'Construction Work', 'Batangas City, Batangas', 'Closed', 'Installs tiles on floors and walls. Measures and cuts tiles precisely. Applies adhesives and grout properly. Ensures even alignment and finishing. Repairs or replaces damaged tiles.'),
    ('J015', 'E008', 'Car Wash Attendant', 'Service Work', 'Lemery, Batangas', 'Reopened', 'Washes and cleans vehicle exteriors. Cleans interiors including vacuuming. Applies wax and polishing services. Uses cleaning equipment safely. Ensures customer satisfaction with results.');

    -- Create the payments table with foreign keys linking to job_hunters and jobs
CREATE TABLE payments (
    payment_id TEXT PRIMARY KEY,
    job_hunter_id TEXT NOT NULL,
    job_id TEXT NOT NULL,
    payment_amount NUMERIC NOT NULL,
    payment_date DATE NOT NULL,
    payment_reference TEXT,
    CONSTRAINT fk_job_hunter
        FOREIGN KEY (job_hunter_id) 
        REFERENCES job_hunters(job_hunter_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_job
        FOREIGN KEY (job_id) 
        REFERENCES jobs(job_id)
        ON DELETE CASCADE
);

-- Insert the XML data into the table
INSERT INTO payments (payment_id, job_hunter_id, job_id, payment_amount, payment_date, payment_reference) 
VALUES 
    ('P001', 'H001', 'J001', 650, '2026-04-27', 'REF123456'),
    ('P002', 'H003', 'J002', 850, '2026-04-28', 'REF123457'),
    ('P003', 'H004', 'J004', 1200, '2026-04-29', 'REF123458'),
    ('P004', 'H006', 'J007', 950, '2026-04-30', 'REF123459'),
    ('P005', 'H007', 'J008', 700, '2026-05-01', 'REF123460'),
    ('P006', 'H009', 'J010', 550, '2026-05-02', 'REF123461'),
    ('P007', 'H010', 'J011', 800, '2026-05-03', 'REF123462'),
    ('P008', 'H001', 'J013', 900, '2026-05-04', 'REF123463'),
    ('P009', 'H003', 'J014', 1100, '2026-05-05', 'REF123464');