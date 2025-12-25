# Vehicle Rental System – Database Design & SQL Queries

## Project Overview

This project is a **Vehicle Rental System** designed to manage users, vehicles, and bookings, serving as a practical demonstration of relational database concepts. The purpose of this system is to showcase understanding of:

- Designing database tables and defining relationships
- Implementing primary and foreign keys
- Writing SQL queries using JOIN, EXISTS, WHERE, GROUP BY, and HAVING

The system models a simplified real-world vehicle rental business and illustrates the use of relational databases in managing business operations effectively.

---

## Part 1: Database Design and Tables

The Vehicle Rental System database consists of three main tables:

### 1. Users

- Stores information about users, including their role (Admin or Customer), name, email, password, and phone number.
- Each email is unique to prevent duplicate accounts.

### 2. Vehicles

- Stores details of vehicles such as name, type (car/bike/truck), model, registration number, rental price per day, and availability status.
- Each vehicle has a unique registration number
- Includes rental price per day and availability status

### 3. Bookings

- Links users to vehicles through foreign keys.
- Stores booking details including start and end dates, booking status, and total cost.

---

## Entity Relationship Diagram (ERD)

The ERD illustrates the following relationships:

- **One-to-Many (User → Bookings)** A single user can have multiple bookings.
- **Many-to-One (Bookings → Vehicle):** Multiple bookings can reference a single vehicle.
- **Logical One-to-One (Logical):** Each booking connects exactly one user with one vehicle.

**ERD Tool Used:** Lucidchart

**ERD Link:** https://lucid.app/lucidchart/d5bedb08-ea33-4f83-b7d7-3e8f32597ff0/edit?beaconFlowId=4C20E7EE557D72D2&invitationId=inv_f40e75ce-dc35-4870-a627-a45bbdbf9729&page=0_0#

---

## Part 2: SQL Queries

### Query 1. Retrieve Booking Information (JOIN)

**Requirement:** Retrieve booking information along with customer name and vehicle name.

**Concepts used:** INNER JOIN

```postgresql
SELECT
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM bookings AS b
INNER JOIN users AS u ON b.user_id = u.user_id
INNER JOIN vehicles AS v ON b.vehicle_id = v.vehicle_id;
```

### Query 2. Find Vehicles Never Booked (EXISTS / NOT EXISTS)

**Requirement:** Find all vehicles that have never been booked.

**Concepts used:** NOT EXISTS

```postgresql
SELECT * FROM vehicles AS v
WHERE NOT EXISTS (
    SELECT *
    FROM bookings AS b
    WHERE v.vehicle_id = b.vehicle_id
)
ORDER BY v.vehicle_id ASC;
```

### Query 3. Retrieve Available Vehicles of a Specific Type (WHERE)

**Requirement:** Retrieve all available vehicles of type 'car'.

**Concepts used:** SELECT, WHERE

```postgresql
SELECT * FROM vehicles
WHERE type = 'car'
  AND status = 'available';
```

### Query 4. Total Number of Bookings per Vehicle (GROUP BY and HAVING)

**Requirement:** Find the total number of bookings for each vehicle and display only vehicles with more than 2 bookings.

**Concepts used:** GROUP BY, HAVING, COUNT

```postgresql
SELECT
    v.name AS vehicle_name,
    COUNT(*) AS total_bookings
FROM vehicles AS v
INNER JOIN bookings AS b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.name
HAVING (COUNT(*) > 2);
```
