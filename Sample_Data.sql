BEGIN
    -- 10 Distinct Campus Events
    INSERT INTO ETMS_EVENT (event_id, title, location, event_date, capacity) VALUES (1, 'SRC Akwaaba Night', 'ATU Main Auditorium', TO_DATE('2026-07-15', 'YYYY-MM-DD'), 500);
    INSERT INTO ETMS_EVENT (event_id, title, location, event_date, capacity) VALUES (2, 'Computer Science Tech Hackathon', 'CS Lab 3', TO_DATE('2026-07-20', 'YYYY-MM-DD'), 80);
    INSERT INTO ETMS_EVENT (event_id, title, location, event_date, capacity) VALUES (3, 'Applied Science Seminar', 'Conference Hall', TO_DATE('2026-07-25', 'YYYY-MM-DD'), 150);
    INSERT INTO ETMS_EVENT (event_id, title, location, event_date, capacity) VALUES (4, 'ATU Homecoming Concert', 'Sports Stadium', TO_DATE('2026-08-02', 'YYYY-MM-DD'), 800);
    INSERT INTO ETMS_EVENT (event_id, title, location, event_date, capacity) VALUES (5, 'Database Implementation Workshop', 'BTech Block Room 4', TO_DATE('2026-08-10', 'YYYY-MM-DD'), 60);
    INSERT INTO ETMS_EVENT (event_id, title, location, event_date, capacity) VALUES (6, 'Campus Startup Pitch Day', 'Amatks Hall', TO_DATE('2026-08-15', 'YYYY-MM-DD'), 100);
    INSERT INTO ETMS_EVENT (event_id, title, location, event_date, capacity) VALUES (7, 'Faculty of Applied Science Games', 'ATU Park', TO_DATE('2026-08-22', 'YYYY-MM-DD'), 400);
    INSERT INTO ETMS_EVENT (event_id, title, location, event_date, capacity) VALUES (8, 'Cybersecurity Awareness Seminar', 'Main Auditorium', TO_DATE('2026-09-05', 'YYYY-MM-DD'), 300);
    INSERT INTO ETMS_EVENT (event_id, title, location, event_date, capacity) VALUES (9, 'Graphic Design Exhibition', 'Art Studio', TO_DATE('2026-09-12', 'YYYY-MM-DD'), 120);
    INSERT INTO ETMS_EVENT (event_id, title, location, event_date, capacity) VALUES (10, 'End of Semester Dinner Awards', 'Movenpick Hotel', TO_DATE('2026-09-28', 'YYYY-MM-DD'), 200);

    -- Base Tickets Configured For Events
    INSERT INTO ETMS_TICKET (ticket_id, event_id, type, price) VALUES (101, 1, 'Regular', 20);
    INSERT INTO ETMS_TICKET (ticket_id, event_id, type, price) VALUES (102, 1, 'VIP', 50);
    INSERT INTO ETMS_TICKET (ticket_id, event_id, type, price) VALUES (103, 2, 'Regular', 0);
    INSERT INTO ETMS_TICKET (ticket_id, event_id, type, price) VALUES (104, 4, 'Regular', 30);
    INSERT INTO ETMS_TICKET (ticket_id, event_id, type, price) VALUES (105, 4, 'VIP', 70);
    INSERT INTO ETMS_TICKET (ticket_id, event_id, type, price) VALUES (106, 10, 'Regular', 50);
    COMMIT;
END;
/

-- PL/SQL Loop block generating 105 distinct attendee rows dynamically
DECLARE
    v_user_id NUMBER;
    v_booking_id NUMBER;
BEGIN
    FOR i IN 1..105 LOOP
        v_user_id := 200 + i;
        v_booking_id := 500 + i;
        
        -- Insert unique attendee account
        INSERT INTO ETMS_USER (user_id, username, password_hash, email, role)
        VALUES (v_user_id, 'student_' || i, 'hash_pass_' || i, 'student' || i || '@atu.edu.gh', 'ATTENDEE');
        
        -- Insert corresponding booking log entries
        INSERT INTO ETMS_BOOKING (booking_id, user_id, ticket_id, quantity)
        VALUES (v_booking_id, v_user_id, 101 + MOD(i, 6), 1);
        
        -- Insert verified payment logs for the dashboard metrics
        INSERT INTO ETMS_PAYMENT (payment_id, booking_id, amount, payment_date)
        VALUES (900 + i, v_booking_id, CASE WHEN MOD(i, 6) = 0 THEN 50 WHEN MOD(i, 6) = 1 THEN 20 ELSE 30 END, SYSDATE);
    END LOOP;
    COMMIT;
END;
/