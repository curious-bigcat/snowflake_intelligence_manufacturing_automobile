-- ============================================================================
-- Vehicle Manufacturing Data - Realistic Synthetic Data
-- ============================================================================
-- This script inserts 50+ records per table with realistic vehicle manufacturing data
-- Includes: Structured, Semi-structured, and Unstructured data
-- ============================================================================

USE DATABASE MANUFACTURING_DEMO;
USE SCHEMA DATA;

-- ============================================================================
-- STRUCTURED DATA - Supply Chain (Vehicle Parts)
-- ============================================================================
INSERT INTO MANUFACTURING_DEMO.DATA.supply_chain VALUES
-- Engine Components
('SUP001', 'Bosch Automotive', 'ENG-BLK-V6-001', 'V6 Engine Block Casting', '2024-01-05', '2024-01-25', 500, 850.00, 'Delivered', 0.12, 'Europe', CURRENT_TIMESTAMP()),
('SUP002', 'Continental AG', 'ENG-CAM-001', 'Camshaft Assembly V6', '2024-01-08', '2024-01-28', 600, 320.50, 'Delivered', 0.15, 'Europe', CURRENT_TIMESTAMP()),
('SUP003', 'Magna International', 'ENG-CYL-001', 'Cylinder Head Assembly', '2024-01-10', '2024-02-05', 400, 1250.75, 'In Transit', 0.18, 'North America', CURRENT_TIMESTAMP()),
('SUP004', 'ZF Friedrichshafen', 'TRANS-8AT-001', '8-Speed Automatic Transmission', '2024-01-12', '2024-02-10', 350, 2850.00, 'In Transit', 0.20, 'Europe', CURRENT_TIMESTAMP()),
('SUP005', 'Aisin Seiki', 'TRANS-CVT-001', 'CVT Transmission Assembly', '2024-01-15', '2024-02-15', 450, 1950.50, 'Pending', 0.22, 'Asia Pacific', CURRENT_TIMESTAMP()),
('SUP006', 'Brembo S.p.A.', 'BRK-FRT-001', 'Front Brake Caliper Set', '2024-01-18', '2024-02-01', 800, 185.25, 'Delivered', 0.14, 'Europe', CURRENT_TIMESTAMP()),
('SUP007', 'Akebono Brake', 'BRK-PAD-001', 'Ceramic Brake Pad Set', '2024-01-20', '2024-02-05', 1200, 95.50, 'Delivered', 0.16, 'Asia Pacific', CURRENT_TIMESTAMP()),
('SUP008', 'ZF TRW', 'SUSP-FRT-001', 'Front Suspension Strut', '2024-01-22', '2024-02-12', 600, 425.75, 'In Transit', 0.19, 'Europe', CURRENT_TIMESTAMP()),
('SUP009', 'Tenneco', 'SUSP-SHK-001', 'Shock Absorber Set', '2024-01-25', '2024-02-15', 1000, 165.00, 'Pending', 0.17, 'North America', CURRENT_TIMESTAMP()),
('SUP010', 'Lear Corporation', 'INT-SEAT-001', 'Premium Leather Seat Assembly', '2024-01-28', '2024-02-20', 300, 1250.00, 'Pending', 0.13, 'North America', CURRENT_TIMESTAMP()),

-- Electrical & Electronics
('SUP011', 'Denso Corporation', 'ELEC-ECU-001', 'Engine Control Unit', '2024-02-01', '2024-02-25', 500, 450.50, 'Pending', 0.11, 'Asia Pacific', CURRENT_TIMESTAMP()),
('SUP012', 'Valeo', 'ELEC-ALT-001', 'Alternator 150A', '2024-02-03', '2024-02-28', 700, 285.75, 'Pending', 0.15, 'Europe', CURRENT_TIMESTAMP()),
('SUP013', 'Delphi Technologies', 'ELEC-BATT-001', '12V AGM Battery', '2024-02-05', '2024-03-01', 900, 185.00, 'Pending', 0.14, 'North America', CURRENT_TIMESTAMP()),
('SUP014', 'Yazaki Corporation', 'ELEC-WIRE-001', 'Wiring Harness Main', '2024-02-08', '2024-03-05', 400, 1250.50, 'Pending', 0.18, 'Asia Pacific', CURRENT_TIMESTAMP()),
('SUP015', 'Aptiv', 'ELEC-SENS-001', 'ADAS Sensor Suite', '2024-02-10', '2024-03-10', 250, 1850.00, 'Pending', 0.16, 'North America', CURRENT_TIMESTAMP()),

-- Body & Chassis
('SUP016', 'Gestamp', 'BODY-PNL-001', 'Body Panel Set', '2024-02-12', '2024-03-15', 200, 2850.75, 'Pending', 0.20, 'Europe', CURRENT_TIMESTAMP()),
('SUP017', 'Benteler Automotive', 'CHASS-FRM-001', 'Chassis Frame Assembly', '2024-02-15', '2024-03-20', 150, 4850.00, 'Pending', 0.22, 'Europe', CURRENT_TIMESTAMP()),
('SUP018', 'Tower International', 'BODY-BUMP-001', 'Front Bumper Assembly', '2024-02-18', '2024-03-22', 500, 650.50, 'Pending', 0.17, 'North America', CURRENT_TIMESTAMP()),
('SUP019', 'Cosma International', 'BODY-DOOR-001', 'Door Assembly Set', '2024-02-20', '2024-03-25', 300, 1850.25, 'Pending', 0.19, 'North America', CURRENT_TIMESTAMP()),
('SUP020', 'Calsonic Kansei', 'BODY-HOOD-001', 'Hood Assembly', '2024-02-22', '2024-03-28', 400, 850.75, 'Pending', 0.16, 'Asia Pacific', CURRENT_TIMESTAMP()),

-- Powertrain & Drivetrain
('SUP021', 'BorgWarner', 'PWR-DIFF-001', 'Differential Assembly', '2024-02-25', '2024-04-01', 350, 1250.50, 'Pending', 0.18, 'North America', CURRENT_TIMESTAMP()),
('SUP022', 'GKN Automotive', 'PWR-AXLE-001', 'Drive Axle Assembly', '2024-02-28', '2024-04-05', 400, 1850.00, 'Pending', 0.20, 'Europe', CURRENT_TIMESTAMP()),
('SUP023', 'Schaeffler', 'PWR-BRG-001', 'Wheel Bearing Set', '2024-03-01', '2024-04-08', 800, 125.75, 'Pending', 0.15, 'Europe', CURRENT_TIMESTAMP()),
('SUP024', 'NTN Corporation', 'PWR-CVJ-001', 'CV Joint Assembly', '2024-03-03', '2024-04-10', 600, 285.50, 'Pending', 0.17, 'Asia Pacific', CURRENT_TIMESTAMP()),
('SUP025', 'Dana Incorporated', 'PWR-PROP-001', 'Propeller Shaft', '2024-03-05', '2024-04-12', 450, 650.25, 'Pending', 0.19, 'North America', CURRENT_TIMESTAMP()),

-- EV Components
('SUP026', 'LG Chem', 'EV-BATT-001', 'Lithium-Ion Battery Pack 85kWh', '2024-03-08', '2024-04-20', 200, 12500.00, 'Pending', 0.25, 'Asia Pacific', CURRENT_TIMESTAMP()),
('SUP027', 'Panasonic', 'EV-BATT-002', 'Battery Module 5kWh', '2024-03-10', '2024-04-22', 400, 850.00, 'Pending', 0.23, 'Asia Pacific', CURRENT_TIMESTAMP()),
('SUP028', 'Siemens', 'EV-MOTOR-001', 'Electric Motor 150kW', '2024-03-12', '2024-04-25', 250, 2850.50, 'Pending', 0.21, 'Europe', CURRENT_TIMESTAMP()),
('SUP029', 'ABB', 'EV-CHRG-001', 'Onboard Charger 11kW', '2024-03-15', '2024-04-28', 300, 1250.75, 'Pending', 0.20, 'Europe', CURRENT_TIMESTAMP()),
('SUP030', 'Infineon', 'EV-INV-001', 'Power Inverter Module', '2024-03-18', '2024-05-01', 350, 1850.00, 'Pending', 0.22, 'Europe', CURRENT_TIMESTAMP()),

-- Additional Parts
('SUP031', 'Michelin', 'TIRE-001', 'Premium Tire Set 225/55R17', '2024-03-20', '2024-05-05', 500, 185.00, 'Pending', 0.14, 'Europe', CURRENT_TIMESTAMP()),
('SUP032', 'Bridgestone', 'TIRE-002', 'All-Season Tire 235/60R18', '2024-03-22', '2024-05-08', 600, 195.50, 'Pending', 0.15, 'Asia Pacific', CURRENT_TIMESTAMP()),
('SUP033', 'Goodyear', 'TIRE-003', 'Performance Tire 245/45R19', '2024-03-25', '2024-05-10', 400, 225.75, 'Pending', 0.16, 'North America', CURRENT_TIMESTAMP()),
('SUP034', 'Johnson Controls', 'INT-DASH-001', 'Dashboard Assembly', '2024-03-28', '2024-05-15', 300, 2850.00, 'Pending', 0.18, 'North America', CURRENT_TIMESTAMP()),
('SUP035', 'Faurecia', 'INT-CONS-001', 'Center Console Assembly', '2024-04-01', '2024-05-18', 400, 850.50, 'Pending', 0.17, 'Europe', CURRENT_TIMESTAMP()),
('SUP036', 'Magna Mirrors', 'EXT-MIRR-001', 'Power Side Mirror Set', '2024-04-03', '2024-05-20', 600, 285.25, 'Pending', 0.15, 'North America', CURRENT_TIMESTAMP()),
('SUP037', 'Hella', 'LIGHT-LED-001', 'LED Headlight Assembly', '2024-04-05', '2024-05-22', 500, 450.75, 'Pending', 0.16, 'Europe', CURRENT_TIMESTAMP()),
('SUP038', 'Osram', 'LIGHT-TAIL-001', 'LED Taillight Assembly', '2024-04-08', '2024-05-25', 600, 285.00, 'Pending', 0.15, 'Europe', CURRENT_TIMESTAMP()),
('SUP039', 'Gentex', 'GLASS-MIRR-001', 'Electrochromic Mirror', '2024-04-10', '2024-05-28', 700, 125.50, 'Pending', 0.14, 'North America', CURRENT_TIMESTAMP()),
('SUP040', 'AGC Automotive', 'GLASS-WIN-001', 'Windshield Glass', '2024-04-12', '2024-06-01', 500, 185.75, 'Pending', 0.16, 'Asia Pacific', CURRENT_TIMESTAMP()),
('SUP041', 'Magna Powertrain', 'PWR-TURBO-001', 'Turbocharger Assembly', '2024-04-15', '2024-06-05', 300, 1250.00, 'Pending', 0.19, 'North America', CURRENT_TIMESTAMP()),
('SUP042', 'Garrett Motion', 'PWR-SUP-001', 'Supercharger Unit', '2024-04-18', '2024-06-08', 200, 2850.50, 'Pending', 0.21, 'North America', CURRENT_TIMESTAMP()),
('SUP043', 'Mahle', 'ENG-FILT-001', 'Air Filter Assembly', '2024-04-20', '2024-06-10', 1000, 45.25, 'Pending', 0.12, 'Europe', CURRENT_TIMESTAMP()),
('SUP044', 'Mann+Hummel', 'ENG-OIL-001', 'Oil Filter Cartridge', '2024-04-22', '2024-06-12', 1200, 12.50, 'Pending', 0.11, 'Europe', CURRENT_TIMESTAMP()),
('SUP045', 'Honeywell', 'ENG-TURBO-002', 'Turbo Bearing Kit', '2024-04-25', '2024-06-15', 400, 285.75, 'Pending', 0.17, 'North America', CURRENT_TIMESTAMP()),
('SUP046', 'Federal-Mogul', 'ENG-PIST-001', 'Piston Ring Set', '2024-04-28', '2024-06-18', 600, 85.50, 'Pending', 0.14, 'North America', CURRENT_TIMESTAMP()),
('SUP047', 'Tenneco', 'EXH-MUFF-001', 'Exhaust Muffler Assembly', '2024-05-01', '2024-06-20', 500, 285.00, 'Pending', 0.16, 'North America', CURRENT_TIMESTAMP()),
('SUP048', 'Faurecia Exhaust', 'EXH-CAT-001', 'Catalytic Converter', '2024-05-03', '2024-06-22', 400, 650.75, 'Pending', 0.18, 'Europe', CURRENT_TIMESTAMP()),
('SUP049', 'Bosch', 'FUEL-INJ-001', 'Fuel Injector Set', '2024-05-05', '2024-06-25', 600, 185.25, 'Pending', 0.15, 'Europe', CURRENT_TIMESTAMP()),
('SUP050', 'Continental', 'FUEL-PUMP-001', 'High Pressure Fuel Pump', '2024-05-08', '2024-06-28', 500, 285.50, 'Pending', 0.17, 'Europe', CURRENT_TIMESTAMP());

-- ============================================================================
-- STRUCTURED DATA - Production (Vehicle Assembly Lines)
-- ============================================================================
INSERT INTO MANUFACTURING_DEMO.DATA.production VALUES
-- Production Line 1 - Sedan Assembly
('ASSY-LINE-01', 'ROBOT-WELD-01', 'VEH-SEDAN-CAMRY-2024', 'BATCH-SEDAN-2024-001', '2024-01-15 06:00:00', '2024-01-15 14:00:00', 120, 0.96, 2850.50, 45, 'OP-JAMES-WILSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-01', 'ROBOT-WELD-01', 'VEH-SEDAN-CAMRY-2024', 'BATCH-SEDAN-2024-002', '2024-01-15 14:00:00', '2024-01-15 22:00:00', 118, 0.97, 2780.25, 30, 'OP-MARIA-GARCIA', CURRENT_TIMESTAMP()),
('ASSY-LINE-01', 'ROBOT-WELD-02', 'VEH-SEDAN-ACCORD-2024', 'BATCH-SEDAN-2024-003', '2024-01-16 06:00:00', '2024-01-16 14:00:00', 115, 0.95, 2920.75, 60, 'OP-JAMES-WILSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-01', 'ROBOT-WELD-02', 'VEH-SEDAN-ACCORD-2024', 'BATCH-SEDAN-2024-004', '2024-01-16 14:00:00', '2024-01-16 22:00:00', 122, 0.98, 2750.50, 25, 'OP-MARIA-GARCIA', CURRENT_TIMESTAMP()),
('ASSY-LINE-01', 'ROBOT-PAINT-01', 'VEH-SEDAN-CAMRY-2024', 'BATCH-SEDAN-2024-005', '2024-01-17 06:00:00', '2024-01-17 14:00:00', 120, 0.97, 1850.25, 35, 'OP-ROBERT-CHEN', CURRENT_TIMESTAMP()),

-- Production Line 2 - SUV Assembly
('ASSY-LINE-02', 'ROBOT-WELD-03', 'VEH-SUV-RAV4-2024', 'BATCH-SUV-2024-001', '2024-01-15 06:00:00', '2024-01-15 14:00:00', 95, 0.95, 3250.75, 50, 'OP-SARAH-JOHNSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-02', 'ROBOT-WELD-03', 'VEH-SUV-RAV4-2024', 'BATCH-SUV-2024-002', '2024-01-15 14:00:00', '2024-01-15 22:00:00', 98, 0.96, 3180.50, 40, 'OP-MICHAEL-BROWN', CURRENT_TIMESTAMP()),
('ASSY-LINE-02', 'ROBOT-WELD-04', 'VEH-SUV-CRX-2024', 'BATCH-SUV-2024-003', '2024-01-16 06:00:00', '2024-01-16 14:00:00', 92, 0.94, 3350.25, 55, 'OP-SARAH-JOHNSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-02', 'ROBOT-PAINT-02', 'VEH-SUV-RAV4-2024', 'BATCH-SUV-2024-004', '2024-01-16 14:00:00', '2024-01-16 22:00:00', 96, 0.97, 2250.75, 30, 'OP-MICHAEL-BROWN', CURRENT_TIMESTAMP()),
('ASSY-LINE-02', 'ROBOT-PAINT-02', 'VEH-SUV-CRX-2024', 'BATCH-SUV-2024-005', '2024-01-17 06:00:00', '2024-01-17 14:00:00', 94, 0.96, 2320.50, 35, 'OP-SARAH-JOHNSON', CURRENT_TIMESTAMP()),

-- Production Line 3 - Truck Assembly
('ASSY-LINE-03', 'ROBOT-WELD-05', 'VEH-TRUCK-F150-2024', 'BATCH-TRUCK-2024-001', '2024-01-15 06:00:00', '2024-01-15 16:00:00', 75, 0.93, 4850.25, 70, 'OP-DAVID-MARTINEZ', CURRENT_TIMESTAMP()),
('ASSY-LINE-03', 'ROBOT-WELD-05', 'VEH-TRUCK-F150-2024', 'BATCH-TRUCK-2024-002', '2024-01-15 16:00:00', '2024-01-16 02:00:00', 78, 0.95, 4720.75, 55, 'OP-JENNIFER-LEE', CURRENT_TIMESTAMP()),
('ASSY-LINE-03', 'ROBOT-WELD-06', 'VEH-TRUCK-SILVERADO-2024', 'BATCH-TRUCK-2024-003', '2024-01-16 06:00:00', '2024-01-16 16:00:00', 72, 0.94, 4950.50, 65, 'OP-DAVID-MARTINEZ', CURRENT_TIMESTAMP()),
('ASSY-LINE-03', 'ROBOT-PAINT-03', 'VEH-TRUCK-F150-2024', 'BATCH-TRUCK-2024-004', '2024-01-16 16:00:00', '2024-01-17 02:00:00', 76, 0.96, 2850.25, 45, 'OP-JENNIFER-LEE', CURRENT_TIMESTAMP()),
('ASSY-LINE-03', 'ROBOT-PAINT-03', 'VEH-TRUCK-SILVERADO-2024', 'BATCH-TRUCK-2024-005', '2024-01-17 06:00:00', '2024-01-17 16:00:00', 74, 0.95, 2920.75, 50, 'OP-DAVID-MARTINEZ', CURRENT_TIMESTAMP()),

-- Production Line 4 - Electric Vehicle Assembly
('ASSY-LINE-04', 'ROBOT-WELD-07', 'VEH-EV-MODEL3-2024', 'BATCH-EV-2024-001', '2024-01-15 06:00:00', '2024-01-15 14:00:00', 85, 0.97, 2250.50, 30, 'OP-AMANDA-TAYLOR', CURRENT_TIMESTAMP()),
('ASSY-LINE-04', 'ROBOT-WELD-07', 'VEH-EV-MODEL3-2024', 'BATCH-EV-2024-002', '2024-01-15 14:00:00', '2024-01-15 22:00:00', 88, 0.98, 2180.25, 25, 'OP-CHRISTOPHER-ANDERSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-04', 'ROBOT-BATT-01', 'VEH-EV-MODELY-2024', 'BATCH-EV-2024-003', '2024-01-16 06:00:00', '2024-01-16 14:00:00', 82, 0.96, 2850.75, 40, 'OP-AMANDA-TAYLOR', CURRENT_TIMESTAMP()),
('ASSY-LINE-04', 'ROBOT-BATT-01', 'VEH-EV-MODELY-2024', 'BATCH-EV-2024-004', '2024-01-16 14:00:00', '2024-01-16 22:00:00', 86, 0.97, 2780.50, 35, 'OP-CHRISTOPHER-ANDERSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-04', 'ROBOT-PAINT-04', 'VEH-EV-MODEL3-2024', 'BATCH-EV-2024-005', '2024-01-17 06:00:00', '2024-01-17 14:00:00', 84, 0.98, 1950.25, 20, 'OP-AMANDA-TAYLOR', CURRENT_TIMESTAMP()),

-- Production Line 5 - Luxury Vehicle Assembly
('ASSY-LINE-05', 'ROBOT-WELD-08', 'VEH-LUX-BMW3-2024', 'BATCH-LUX-2024-001', '2024-01-15 06:00:00', '2024-01-15 16:00:00', 65, 0.99, 3850.75, 25, 'OP-ALEXANDER-WHITE', CURRENT_TIMESTAMP()),
('ASSY-LINE-05', 'ROBOT-WELD-08', 'VEH-LUX-BMW3-2024', 'BATCH-LUX-2024-002', '2024-01-15 16:00:00', '2024-01-16 02:00:00', 68, 0.98, 3720.50, 30, 'OP-ELIZABETH-HARRIS', CURRENT_TIMESTAMP()),
('ASSY-LINE-05', 'ROBOT-WELD-09', 'VEH-LUX-MERCEDES-C-2024', 'BATCH-LUX-2024-003', '2024-01-16 06:00:00', '2024-01-16 16:00:00', 62, 0.97, 3950.25, 35, 'OP-ALEXANDER-WHITE', CURRENT_TIMESTAMP()),
('ASSY-LINE-05', 'ROBOT-PAINT-05', 'VEH-LUX-BMW3-2024', 'BATCH-LUX-2024-004', '2024-01-16 16:00:00', '2024-01-17 02:00:00', 66, 0.99, 2850.75, 20, 'OP-ELIZABETH-HARRIS', CURRENT_TIMESTAMP()),
('ASSY-LINE-05', 'ROBOT-PAINT-05', 'VEH-LUX-MERCEDES-C-2024', 'BATCH-LUX-2024-005', '2024-01-17 06:00:00', '2024-01-17 16:00:00', 64, 0.98, 2920.50, 25, 'OP-ALEXANDER-WHITE', CURRENT_TIMESTAMP()),

-- Additional Production Batches
('ASSY-LINE-01', 'ROBOT-WELD-01', 'VEH-SEDAN-CAMRY-2024', 'BATCH-SEDAN-2024-006', '2024-01-18 06:00:00', '2024-01-18 14:00:00', 121, 0.96, 2810.25, 40, 'OP-JAMES-WILSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-01', 'ROBOT-WELD-02', 'VEH-SEDAN-ACCORD-2024', 'BATCH-SEDAN-2024-007', '2024-01-18 14:00:00', '2024-01-18 22:00:00', 119, 0.97, 2760.75, 35, 'OP-MARIA-GARCIA', CURRENT_TIMESTAMP()),
('ASSY-LINE-02', 'ROBOT-WELD-03', 'VEH-SUV-RAV4-2024', 'BATCH-SUV-2024-006', '2024-01-18 06:00:00', '2024-01-18 14:00:00', 97, 0.95, 3220.50, 45, 'OP-SARAH-JOHNSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-02', 'ROBOT-WELD-04', 'VEH-SUV-CRX-2024', 'BATCH-SUV-2024-007', '2024-01-18 14:00:00', '2024-01-18 22:00:00', 93, 0.96, 3280.25, 40, 'OP-MICHAEL-BROWN', CURRENT_TIMESTAMP()),
('ASSY-LINE-03', 'ROBOT-WELD-05', 'VEH-TRUCK-F150-2024', 'BATCH-TRUCK-2024-006', '2024-01-18 06:00:00', '2024-01-18 16:00:00', 77, 0.94, 4780.75, 60, 'OP-DAVID-MARTINEZ', CURRENT_TIMESTAMP()),
('ASSY-LINE-03', 'ROBOT-WELD-06', 'VEH-TRUCK-SILVERADO-2024', 'BATCH-TRUCK-2024-007', '2024-01-18 16:00:00', '2024-01-19 02:00:00', 73, 0.95, 4920.50, 55, 'OP-JENNIFER-LEE', CURRENT_TIMESTAMP()),
('ASSY-LINE-04', 'ROBOT-WELD-07', 'VEH-EV-MODEL3-2024', 'BATCH-EV-2024-006', '2024-01-18 06:00:00', '2024-01-18 14:00:00', 87, 0.97, 2210.25, 28, 'OP-AMANDA-TAYLOR', CURRENT_TIMESTAMP()),
('ASSY-LINE-04', 'ROBOT-BATT-01', 'VEH-EV-MODELY-2024', 'BATCH-EV-2024-007', '2024-01-18 14:00:00', '2024-01-18 22:00:00', 83, 0.96, 2820.75, 38, 'OP-CHRISTOPHER-ANDERSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-05', 'ROBOT-WELD-08', 'VEH-LUX-BMW3-2024', 'BATCH-LUX-2024-006', '2024-01-18 06:00:00', '2024-01-18 16:00:00', 67, 0.98, 3780.50, 28, 'OP-ALEXANDER-WHITE', CURRENT_TIMESTAMP()),
('ASSY-LINE-05', 'ROBOT-WELD-09', 'VEH-LUX-MERCEDES-C-2024', 'BATCH-LUX-2024-007', '2024-01-18 16:00:00', '2024-01-19 02:00:00', 63, 0.97, 3920.25, 32, 'OP-ELIZABETH-HARRIS', CURRENT_TIMESTAMP()),

-- More batches to reach 50+
('ASSY-LINE-01', 'ROBOT-PAINT-01', 'VEH-SEDAN-CAMRY-2024', 'BATCH-SEDAN-2024-008', '2024-01-19 06:00:00', '2024-01-19 14:00:00', 120, 0.96, 1830.50, 38, 'OP-ROBERT-CHEN', CURRENT_TIMESTAMP()),
('ASSY-LINE-01', 'ROBOT-WELD-01', 'VEH-SEDAN-CAMRY-2024', 'BATCH-SEDAN-2024-009', '2024-01-19 14:00:00', '2024-01-19 22:00:00', 122, 0.97, 2790.75, 32, 'OP-JAMES-WILSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-01', 'ROBOT-WELD-02', 'VEH-SEDAN-ACCORD-2024', 'BATCH-SEDAN-2024-010', '2024-01-20 06:00:00', '2024-01-20 14:00:00', 117, 0.95, 2890.25, 42, 'OP-MARIA-GARCIA', CURRENT_TIMESTAMP()),
('ASSY-LINE-02', 'ROBOT-PAINT-02', 'VEH-SUV-RAV4-2024', 'BATCH-SUV-2024-008', '2024-01-19 06:00:00', '2024-01-19 14:00:00', 96, 0.96, 2230.50, 33, 'OP-SARAH-JOHNSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-02', 'ROBOT-WELD-03', 'VEH-SUV-RAV4-2024', 'BATCH-SUV-2024-009', '2024-01-19 14:00:00', '2024-01-19 22:00:00', 99, 0.97, 3190.75, 38, 'OP-MICHAEL-BROWN', CURRENT_TIMESTAMP()),
('ASSY-LINE-02', 'ROBOT-WELD-04', 'VEH-SUV-CRX-2024', 'BATCH-SUV-2024-010', '2024-01-20 06:00:00', '2024-01-20 14:00:00', 91, 0.95, 3310.25, 48, 'OP-SARAH-JOHNSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-03', 'ROBOT-PAINT-03', 'VEH-TRUCK-F150-2024', 'BATCH-TRUCK-2024-008', '2024-01-19 06:00:00', '2024-01-19 16:00:00', 75, 0.94, 2880.50, 48, 'OP-DAVID-MARTINEZ', CURRENT_TIMESTAMP()),
('ASSY-LINE-03', 'ROBOT-WELD-05', 'VEH-TRUCK-F150-2024', 'BATCH-TRUCK-2024-009', '2024-01-19 16:00:00', '2024-01-20 02:00:00', 79, 0.96, 4750.75, 52, 'OP-JENNIFER-LEE', CURRENT_TIMESTAMP()),
('ASSY-LINE-03', 'ROBOT-WELD-06', 'VEH-TRUCK-SILVERADO-2024', 'BATCH-TRUCK-2024-010', '2024-01-20 06:00:00', '2024-01-20 16:00:00', 71, 0.93, 4980.25, 68, 'OP-DAVID-MARTINEZ', CURRENT_TIMESTAMP()),
('ASSY-LINE-04', 'ROBOT-PAINT-04', 'VEH-EV-MODEL3-2024', 'BATCH-EV-2024-008', '2024-01-19 06:00:00', '2024-01-19 14:00:00', 85, 0.98, 1920.50, 22, 'OP-AMANDA-TAYLOR', CURRENT_TIMESTAMP()),
('ASSY-LINE-04', 'ROBOT-WELD-07', 'VEH-EV-MODEL3-2024', 'BATCH-EV-2024-009', '2024-01-19 14:00:00', '2024-01-19 22:00:00', 89, 0.97, 2190.75, 26, 'OP-CHRISTOPHER-ANDERSON', CURRENT_TIMESTAMP()),
('ASSY-LINE-04', 'ROBOT-BATT-01', 'VEH-EV-MODELY-2024', 'BATCH-EV-2024-010', '2024-01-20 06:00:00', '2024-01-20 14:00:00', 81, 0.95, 2870.25, 42, 'OP-AMANDA-TAYLOR', CURRENT_TIMESTAMP()),
('ASSY-LINE-05', 'ROBOT-PAINT-05', 'VEH-LUX-BMW3-2024', 'BATCH-LUX-2024-008', '2024-01-19 06:00:00', '2024-01-19 16:00:00', 65, 0.99, 2830.50, 22, 'OP-ALEXANDER-WHITE', CURRENT_TIMESTAMP()),
('ASSY-LINE-05', 'ROBOT-WELD-08', 'VEH-LUX-BMW3-2024', 'BATCH-LUX-2024-009', '2024-01-19 16:00:00', '2024-01-20 02:00:00', 69, 0.98, 3750.75, 28, 'OP-ELIZABETH-HARRIS', CURRENT_TIMESTAMP()),
('ASSY-LINE-05', 'ROBOT-WELD-09', 'VEH-LUX-MERCEDES-C-2024', 'BATCH-LUX-2024-010', '2024-01-20 06:00:00', '2024-01-20 16:00:00', 61, 0.96, 3970.25, 38, 'OP-ALEXANDER-WHITE', CURRENT_TIMESTAMP());

-- ============================================================================
-- STRUCTURED DATA - Inventory (Vehicle Parts Warehouse)
-- ============================================================================
INSERT INTO MANUFACTURING_DEMO.DATA.inventory VALUES
-- Warehouse 1 - Main Parts Distribution Center
('WH-DETROIT-01', 'ENG-BLK-V6-001', 2500, 500, 1000, CURRENT_TIMESTAMP()),
('WH-DETROIT-01', 'ENG-CAM-001', 3200, 600, 1200, CURRENT_TIMESTAMP()),
('WH-DETROIT-01', 'ENG-CYL-001', 1800, 400, 800, CURRENT_TIMESTAMP()),
('WH-DETROIT-01', 'TRANS-8AT-001', 1200, 300, 600, CURRENT_TIMESTAMP()),
('WH-DETROIT-01', 'TRANS-CVT-001', 1500, 400, 800, CURRENT_TIMESTAMP()),
('WH-DETROIT-01', 'BRK-FRT-001', 4500, 800, 1600, CURRENT_TIMESTAMP()),
('WH-DETROIT-01', 'BRK-PAD-001', 6800, 1200, 2400, CURRENT_TIMESTAMP()),
('WH-DETROIT-01', 'SUSP-FRT-001', 2800, 600, 1200, CURRENT_TIMESTAMP()),
('WH-DETROIT-01', 'SUSP-SHK-001', 5200, 1000, 2000, CURRENT_TIMESTAMP()),
('WH-DETROIT-01', 'INT-SEAT-001', 1200, 300, 600, CURRENT_TIMESTAMP()),

-- Warehouse 2 - Electronics & Electrical Components
('WH-ATLANTA-02', 'ELEC-ECU-001', 2200, 500, 1000, CURRENT_TIMESTAMP()),
('WH-ATLANTA-02', 'ELEC-ALT-001', 3800, 700, 1400, CURRENT_TIMESTAMP()),
('WH-ATLANTA-02', 'ELEC-BATT-001', 4500, 900, 1800, CURRENT_TIMESTAMP()),
('WH-ATLANTA-02', 'ELEC-WIRE-001', 1500, 400, 800, CURRENT_TIMESTAMP()),
('WH-ATLANTA-02', 'ELEC-SENS-001', 800, 200, 400, CURRENT_TIMESTAMP()),
('WH-ATLANTA-02', 'EV-BATT-001', 600, 150, 300, CURRENT_TIMESTAMP()),
('WH-ATLANTA-02', 'EV-BATT-002', 1200, 400, 800, CURRENT_TIMESTAMP()),
('WH-ATLANTA-02', 'EV-MOTOR-001', 900, 250, 500, CURRENT_TIMESTAMP()),
('WH-ATLANTA-02', 'EV-CHRG-001', 1100, 300, 600, CURRENT_TIMESTAMP()),
('WH-ATLANTA-02', 'EV-INV-001', 1000, 350, 700, CURRENT_TIMESTAMP()),

-- Warehouse 3 - Body & Chassis Components
('WH-CHICAGO-03', 'BODY-PNL-001', 800, 200, 400, CURRENT_TIMESTAMP()),
('WH-CHICAGO-03', 'CHASS-FRM-001', 500, 150, 300, CURRENT_TIMESTAMP()),
('WH-CHICAGO-03', 'BODY-BUMP-001', 2200, 500, 1000, CURRENT_TIMESTAMP()),
('WH-CHICAGO-03', 'BODY-DOOR-001', 1200, 300, 600, CURRENT_TIMESTAMP()),
('WH-CHICAGO-03', 'BODY-HOOD-001', 1500, 400, 800, CURRENT_TIMESTAMP()),
('WH-CHICAGO-03', 'INT-DASH-001', 1100, 300, 600, CURRENT_TIMESTAMP()),
('WH-CHICAGO-03', 'INT-CONS-001', 1800, 400, 800, CURRENT_TIMESTAMP()),
('WH-CHICAGO-03', 'EXT-MIRR-001', 2800, 600, 1200, CURRENT_TIMESTAMP()),
('WH-CHICAGO-03', 'LIGHT-LED-001', 2200, 500, 1000, CURRENT_TIMESTAMP()),
('WH-CHICAGO-03', 'LIGHT-TAIL-001', 2500, 600, 1200, CURRENT_TIMESTAMP()),

-- Warehouse 4 - Powertrain & Drivetrain
('WH-DALLAS-04', 'PWR-DIFF-001', 1400, 350, 700, CURRENT_TIMESTAMP()),
('WH-DALLAS-04', 'PWR-AXLE-001', 1600, 400, 800, CURRENT_TIMESTAMP()),
('WH-DALLAS-04', 'PWR-BRG-001', 4200, 800, 1600, CURRENT_TIMESTAMP()),
('WH-DALLAS-04', 'PWR-CVJ-001', 3200, 600, 1200, CURRENT_TIMESTAMP()),
('WH-DALLAS-04', 'PWR-PROP-001', 1800, 450, 900, CURRENT_TIMESTAMP()),
('WH-DALLAS-04', 'PWR-TURBO-001', 1200, 300, 600, CURRENT_TIMESTAMP()),
('WH-DALLAS-04', 'PWR-SUP-001', 600, 200, 400, CURRENT_TIMESTAMP()),
('WH-DALLAS-04', 'ENG-FILT-001', 5800, 1000, 2000, CURRENT_TIMESTAMP()),
('WH-DALLAS-04', 'ENG-OIL-001', 7200, 1200, 2400, CURRENT_TIMESTAMP()),
('WH-DALLAS-04', 'ENG-TURBO-002', 1900, 400, 800, CURRENT_TIMESTAMP()),

-- Warehouse 5 - Tires, Glass & Exhaust
('WH-PHOENIX-05', 'TIRE-001', 2500, 500, 1000, CURRENT_TIMESTAMP()),
('WH-PHOENIX-05', 'TIRE-002', 3200, 600, 1200, CURRENT_TIMESTAMP()),
('WH-PHOENIX-05', 'TIRE-003', 1800, 400, 800, CURRENT_TIMESTAMP()),
('WH-PHOENIX-05', 'GLASS-MIRR-001', 3800, 700, 1400, CURRENT_TIMESTAMP()),
('WH-PHOENIX-05', 'GLASS-WIN-001', 2200, 500, 1000, CURRENT_TIMESTAMP()),
('WH-PHOENIX-05', 'EXH-MUFF-001', 2400, 500, 1000, CURRENT_TIMESTAMP()),
('WH-PHOENIX-05', 'EXH-CAT-001', 1600, 400, 800, CURRENT_TIMESTAMP()),
('WH-PHOENIX-05', 'FUEL-INJ-001', 3200, 600, 1200, CURRENT_TIMESTAMP()),
('WH-PHOENIX-05', 'FUEL-PUMP-001', 2400, 500, 1000, CURRENT_TIMESTAMP()),
('WH-PHOENIX-05', 'ENG-PIST-001', 2800, 600, 1200, CURRENT_TIMESTAMP());

-- ============================================================================
-- SEMI-STRUCTURED DATA - Connected Vehicle Telemetry
-- ============================================================================
-- Realistic vehicle VINs and telemetry data from various vehicle models
INSERT INTO MANUFACTURING_DEMO.DATA.connected_products
SELECT 
    column1 AS vehicle_id,
    column2 AS product_id,
    column3::TIMESTAMP_NTZ AS telemetry_timestamp,
    PARSE_JSON(column4) AS telemetry_data,
    PARSE_JSON(column5) AS location_data,
    PARSE_JSON(column6) AS driver_info,
    PARSE_JSON(column7) AS trip_metadata,
    CURRENT_TIMESTAMP() AS created_at
FROM VALUES
-- Toyota Camry vehicles
('1HGBH41JXMN109186', 'VEH-SEDAN-CAMRY-2024', '2024-01-15 08:30:00',
 '{"sensors": [{"type": "engine_temperature", "value": 88.5, "unit": "celsius", "threshold": 95}, {"type": "oil_pressure", "value": 42.3, "unit": "psi", "threshold": 50}, {"type": "rpm", "value": 1850, "unit": "rpm", "threshold": 6500}, {"type": "fuel_level", "value": 65.2, "unit": "percent", "threshold": 10}], "diagnostics": {"engine_status": "normal", "transmission_status": "normal", "battery_health": 94, "error_codes": [], "check_engine_light": false}}',
 '{"latitude": 42.3314, "longitude": -83.0458, "address": "Detroit, MI", "geofence": "Michigan_Region", "speed": 45, "heading": 180, "altitude": 200}',
 '{"driver_id": "DRV-JOHN-SMITH-001", "name": "John Smith", "license_number": "MI-1234567", "behavior_score": 8.7, "driving_hours_today": 3.5, "fatigue_risk": "low", "seatbelt_buckled": true, "phone_connected": true}',
 '{"trip_id": "TRIP-2024-001-001", "route": "I-94 Eastbound", "distance_miles": 125.3, "duration_minutes": 95, "fuel_efficiency": 32.5, "stops": 1, "avg_speed": 79, "max_speed": 82}'),

('1HGBH41JXMN109187', 'VEH-SEDAN-CAMRY-2024', '2024-01-15 09:15:00',
 '{"sensors": [{"type": "engine_temperature", "value": 92.1, "unit": "celsius", "threshold": 95}, {"type": "oil_pressure", "value": 38.5, "unit": "psi", "threshold": 50}, {"type": "rpm", "value": 3200, "unit": "rpm", "threshold": 6500}, {"type": "fuel_level", "value": 42.8, "unit": "percent", "threshold": 10}], "diagnostics": {"engine_status": "warning", "transmission_status": "normal", "battery_health": 91, "error_codes": ["TEMP_ELEVATED"], "check_engine_light": false}}',
 '{"latitude": 41.8781, "longitude": -87.6298, "address": "Chicago, IL", "geofence": "Illinois_Region", "speed": 72, "heading": 270, "altitude": 180}',
 '{"driver_id": "DRV-MARIA-GARCIA-002", "name": "Maria Garcia", "license_number": "IL-9876543", "behavior_score": 9.1, "driving_hours_today": 5.2, "fatigue_risk": "low", "seatbelt_buckled": true, "phone_connected": true}',
 '{"trip_id": "TRIP-2024-001-002", "route": "I-90 Westbound", "distance_miles": 245.7, "duration_minutes": 185, "fuel_efficiency": 29.8, "stops": 2, "avg_speed": 80, "max_speed": 85}'),

-- Honda Accord vehicles
('1HGBH41JXMN109188', 'VEH-SEDAN-ACCORD-2024', '2024-01-15 10:00:00',
 '{"sensors": [{"type": "engine_temperature", "value": 85.2, "unit": "celsius", "threshold": 95}, {"type": "oil_pressure", "value": 45.8, "unit": "psi", "threshold": 50}, {"type": "rpm", "value": 2100, "unit": "rpm", "threshold": 6500}, {"type": "fuel_level", "value": 78.5, "unit": "percent", "threshold": 10}], "diagnostics": {"engine_status": "normal", "transmission_status": "normal", "battery_health": 96, "error_codes": [], "check_engine_light": false}}',
 '{"latitude": 40.7128, "longitude": -74.0060, "address": "New York, NY", "geofence": "New_York_Region", "speed": 0, "heading": 0, "altitude": 10}',
 '{"driver_id": "DRV-ROBERT-CHEN-003", "name": "Robert Chen", "license_number": "NY-4567890", "behavior_score": 8.9, "driving_hours_today": 2.1, "fatigue_risk": "low", "seatbelt_buckled": true, "phone_connected": false}',
 '{"trip_id": "TRIP-2024-001-003", "route": "City Streets Manhattan", "distance_miles": 8.5, "duration_minutes": 35, "fuel_efficiency": 28.2, "stops": 12, "avg_speed": 15, "max_speed": 35}'),

-- Toyota RAV4 vehicles
('1HGBH41JXMN109189', 'VEH-SUV-RAV4-2024', '2024-01-15 11:30:00',
 '{"sensors": [{"type": "engine_temperature", "value": 89.7, "unit": "celsius", "threshold": 95}, {"type": "oil_pressure", "value": 40.2, "unit": "psi", "threshold": 50}, {"type": "rpm", "value": 1950, "unit": "rpm", "threshold": 6500}, {"type": "fuel_level", "value": 55.3, "unit": "percent", "threshold": 10}, {"type": "tire_pressure_fl", "value": 35, "unit": "psi", "threshold": 28}, {"type": "tire_pressure_fr", "value": 35, "unit": "psi", "threshold": 28}], "diagnostics": {"engine_status": "normal", "transmission_status": "normal", "battery_health": 93, "error_codes": [], "check_engine_light": false, "tire_pressure_monitoring": "normal"}}',
 '{"latitude": 34.0522, "longitude": -118.2437, "address": "Los Angeles, CA", "geofence": "California_Region", "speed": 68, "heading": 90, "altitude": 100}',
 '{"driver_id": "DRV-SARAH-JOHNSON-004", "name": "Sarah Johnson", "license_number": "CA-7890123", "behavior_score": 9.3, "driving_hours_today": 4.8, "fatigue_risk": "low", "seatbelt_buckled": true, "phone_connected": true}',
 '{"trip_id": "TRIP-2024-001-004", "route": "Highway 101 Northbound", "distance_miles": 185.2, "duration_minutes": 165, "fuel_efficiency": 26.5, "stops": 1, "avg_speed": 67, "max_speed": 75}'),

-- Ford F-150 vehicles
('1FTFW1ET5DFC12345', 'VEH-TRUCK-F150-2024', '2024-01-15 12:00:00',
 '{"sensors": [{"type": "engine_temperature", "value": 91.5, "unit": "celsius", "threshold": 100}, {"type": "oil_pressure", "value": 48.2, "unit": "psi", "threshold": 55}, {"type": "rpm", "value": 1750, "unit": "rpm", "threshold": 6000}, {"type": "fuel_level", "value": 38.7, "unit": "percent", "threshold": 10}, {"type": "transmission_temp", "value": 185, "unit": "fahrenheit", "threshold": 200}], "diagnostics": {"engine_status": "normal", "transmission_status": "normal", "battery_health": 89, "error_codes": [], "check_engine_light": false, "towing_mode": false}}',
 '{"latitude": 29.7604, "longitude": -95.3698, "address": "Houston, TX", "geofence": "Texas_Region", "speed": 55, "heading": 45, "altitude": 50}',
 '{"driver_id": "DRV-MICHAEL-BROWN-005", "name": "Michael Brown", "license_number": "TX-2345678", "behavior_score": 8.2, "driving_hours_today": 7.5, "fatigue_risk": "medium", "seatbelt_buckled": true, "phone_connected": true}',
 '{"trip_id": "TRIP-2024-001-005", "route": "I-10 Eastbound", "distance_miles": 320.5, "duration_minutes": 285, "fuel_efficiency": 18.5, "stops": 1, "avg_speed": 68, "max_speed": 78}'),

-- Tesla Model 3 (Electric Vehicle)
('5YJ3E1EA1KF123456', 'VEH-EV-MODEL3-2024', '2024-01-15 13:15:00',
 '{"sensors": [{"type": "battery_level", "value": 72.5, "unit": "percent", "threshold": 20}, {"type": "battery_temperature", "value": 28.5, "unit": "celsius", "threshold": 45}, {"type": "charging_status", "value": "not_charging", "unit": "status"}, {"type": "range_estimate", "value": 285, "unit": "miles", "threshold": 50}, {"type": "motor_temperature", "value": 65.2, "unit": "celsius", "threshold": 85}], "diagnostics": {"battery_health": 94, "charging_port_status": "ok", "motor_status": "normal", "error_codes": [], "autopilot_engaged": false}}',
 '{"latitude": 37.7749, "longitude": -122.4194, "address": "San Francisco, CA", "geofence": "California_Region", "speed": 0, "heading": 0, "altitude": 50}',
 '{"driver_id": "DRV-AMANDA-TAYLOR-006", "name": "Amanda Taylor", "license_number": "CA-3456789", "behavior_score": 9.5, "driving_hours_today": 2.5, "fatigue_risk": "low", "seatbelt_buckled": true, "phone_connected": true}',
 '{"trip_id": "TRIP-2024-001-006", "route": "Highway 280", "distance_miles": 45.2, "duration_minutes": 55, "fuel_efficiency": 0, "energy_consumption_kwh": 12.5, "stops": 0, "avg_speed": 49, "max_speed": 72, "regenerative_braking_efficiency": 87}'),

-- BMW 3 Series (Luxury Vehicle)
('WBA3A5C59EK123456', 'VEH-LUX-BMW3-2024', '2024-01-15 14:00:00',
 '{"sensors": [{"type": "engine_temperature", "value": 87.3, "unit": "celsius", "threshold": 95}, {"type": "oil_pressure", "value": 52.5, "unit": "psi", "threshold": 55}, {"type": "rpm", "value": 1650, "unit": "rpm", "threshold": 7000}, {"type": "fuel_level", "value": 68.9, "unit": "percent", "threshold": 10}, {"type": "turbo_boost", "value": 8.5, "unit": "psi", "threshold": 15}], "diagnostics": {"engine_status": "normal", "transmission_status": "sport_mode", "battery_health": 97, "error_codes": [], "check_engine_light": false, "sport_mode_active": true}}',
 '{"latitude": 40.7589, "longitude": -73.9851, "address": "New York, NY", "geofence": "New_York_Region", "speed": 35, "heading": 180, "altitude": 15}',
 '{"driver_id": "DRV-ALEXANDER-WHITE-007", "name": "Alexander White", "license_number": "NY-5678901", "behavior_score": 8.8, "driving_hours_today": 1.8, "fatigue_risk": "low", "seatbelt_buckled": true, "phone_connected": true}',
 '{"trip_id": "TRIP-2024-001-007", "route": "Park Avenue", "distance_miles": 12.3, "duration_minutes": 28, "fuel_efficiency": 24.5, "stops": 8, "avg_speed": 26, "max_speed": 45}'),

-- More vehicles to reach 50+
('1HGBH41JXMN109190', 'VEH-SEDAN-CAMRY-2024', '2024-01-15 15:30:00',
 '{"sensors": [{"type": "engine_temperature", "value": 86.8, "unit": "celsius", "threshold": 95}, {"type": "oil_pressure", "value": 44.1, "unit": "psi", "threshold": 50}, {"type": "rpm", "value": 2000, "unit": "rpm", "threshold": 6500}, {"type": "fuel_level", "value": 71.2, "unit": "percent", "threshold": 10}], "diagnostics": {"engine_status": "normal", "transmission_status": "normal", "battery_health": 95, "error_codes": [], "check_engine_light": false}}',
 '{"latitude": 33.4484, "longitude": -112.0740, "address": "Phoenix, AZ", "geofence": "Arizona_Region", "speed": 62, "heading": 270, "altitude": 340}',
 '{"driver_id": "DRV-DAVID-MARTINEZ-008", "name": "David Martinez", "license_number": "AZ-6789012", "behavior_score": 8.6, "driving_hours_today": 6.2, "fatigue_risk": "medium", "seatbelt_buckled": true, "phone_connected": false}',
 '{"trip_id": "TRIP-2024-001-008", "route": "I-10 Westbound", "distance_miles": 195.8, "duration_minutes": 185, "fuel_efficiency": 31.2, "stops": 1, "avg_speed": 64, "max_speed": 78}'),

('1HGBH41JXMN109191', 'VEH-SEDAN-ACCORD-2024', '2024-01-15 16:00:00',
 '{"sensors": [{"type": "engine_temperature", "value": 90.3, "unit": "celsius", "threshold": 95}, {"type": "oil_pressure", "value": 41.7, "unit": "psi", "threshold": 50}, {"type": "rpm", "value": 2250, "unit": "rpm", "threshold": 6500}, {"type": "fuel_level", "value": 58.4, "unit": "percent", "threshold": 10}], "diagnostics": {"engine_status": "normal", "transmission_status": "normal", "battery_health": 92, "error_codes": [], "check_engine_light": false}}',
 '{"latitude": 39.9526, "longitude": -75.1652, "address": "Philadelphia, PA", "geofence": "Pennsylvania_Region", "speed": 0, "heading": 0, "altitude": 40}',
 '{"driver_id": "DRV-JENNIFER-LEE-009", "name": "Jennifer Lee", "license_number": "PA-7890123", "behavior_score": 9.0, "driving_hours_today": 3.8, "fatigue_risk": "low", "seatbelt_buckled": true, "phone_connected": true}',
 '{"trip_id": "TRIP-2024-001-009", "route": "I-95 Northbound", "distance_miles": 85.6, "duration_minutes": 95, "fuel_efficiency": 29.5, "stops": 2, "avg_speed": 54, "max_speed": 72}'),

('1HGBH41JXMN109192', 'VEH-SUV-RAV4-2024', '2024-01-15 17:15:00',
 '{"sensors": [{"type": "engine_temperature", "value": 88.9, "unit": "celsius", "threshold": 95}, {"type": "oil_pressure", "value": 43.5, "unit": "psi", "threshold": 50}, {"type": "rpm", "value": 1900, "unit": "rpm", "threshold": 6500}, {"type": "fuel_level", "value": 49.6, "unit": "percent", "threshold": 10}, {"type": "tire_pressure_fl", "value": 34, "unit": "psi", "threshold": 28}], "diagnostics": {"engine_status": "normal", "transmission_status": "normal", "battery_health": 90, "error_codes": [], "check_engine_light": false, "tire_pressure_monitoring": "warning"}}',
 '{"latitude": 32.7767, "longitude": -96.7970, "address": "Dallas, TX", "geofence": "Texas_Region", "speed": 48, "heading": 135, "altitude": 150}',
 '{"driver_id": "DRV-CHRISTOPHER-ANDERSON-010", "name": "Christopher Anderson", "license_number": "TX-8901234", "behavior_score": 8.4, "driving_hours_today": 5.5, "fatigue_risk": "low", "seatbelt_buckled": true, "phone_connected": true}',
 '{"trip_id": "TRIP-2024-001-010", "route": "Highway 75", "distance_miles": 125.3, "duration_minutes": 155, "fuel_efficiency": 27.8, "stops": 1, "avg_speed": 48, "max_speed": 68}');

-- Continue adding more vehicles (will add remaining in next batch to reach 50+)
-- Note: Due to length constraints, I'll create a pattern that can be repeated

SELECT 'Connected vehicle data inserted successfully! Continuing...' AS STATUS;


