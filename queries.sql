-- Query 1: JOIN
SELECT
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM bookings AS b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id;

-- Query 2: EXISTS
SELECT * FROM vehicles AS v
WHERE NOT EXISTS (
    SELECT *
    FROM bookings AS b
    WHERE v.vehicle_id = b.vehicle_id
)
ORDER BY v.vehicle_id ASC;

-- Query 3: WHERE
SELECT * FROM vehicles
WHERE type = 'car' 
  AND status = 'available';

-- Query 4: GROUP BY and HAVING
SELECT 
    v.name AS vehicle_name,
    COUNT(*) AS total_bookings
FROM vehicles AS v
INNER JOIN bookings AS b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.name
HAVING (COUNT(*) > 2);