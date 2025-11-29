-- Refuse on low semantic signal
WITH k AS ( /* top-k select like above */ )
SELECT IFF(COUNT(*)=0 OR MAX(sim) < 0.25, 'REFUSE', 'OK') AS gate
FROM k;
