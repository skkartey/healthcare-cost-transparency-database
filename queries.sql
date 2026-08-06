-- ============================================================
-- Healthcare Cost Transparency Database
-- Sample SQL Queries
-- ============================================================


-- 1. List all treatments with service names and costs

SELECT
    t.treatment_id,
    t.treatment_date,
    p.first_name & ' ' & p.last_name AS patient_name,
    s.service_name,
    ts.quantity,
    s.cost,
    t.cost AS total_treatment_cost
FROM Treatment AS t
INNER JOIN Treatment_Service AS ts
    ON t.treatment_id = ts.treatment_id
INNER JOIN Service AS s
    ON ts.service_id = s.service_id
INNER JOIN Patient AS p
    ON t.patient_id = p.patient_id;


-- 2. List all invoices with their services

SELECT
    i.invoice_id,
    p.first_name & ' ' & p.last_name AS patient_name,
    s.service_name,
    isv.quantity,
    isv.cost,
    i.total_amount
FROM Invoice AS i
INNER JOIN Invoice_Service AS isv
    ON i.invoice_id = isv.invoice_id
INNER JOIN Service AS s
    ON isv.service_id = s.service_id
INNER JOIN Patient AS p
    ON i.patient_id = p.patient_id;


-- 3. Compare billing estimates with actual invoice costs

SELECT
    be.estimate_id,
    p.first_name & ' ' & p.last_name AS patient_name,
    s.service_name,
    be.estimated_cost,
    i.total_amount AS actual_cost,
    (i.total_amount - be.estimated_cost) AS difference
FROM BillingEstimate AS be
INNER JOIN Patient AS p
    ON be.patient_id = p.patient_id
INNER JOIN Service AS s
    ON be.service_id = s.service_id
INNER JOIN Invoice AS i
    ON be.estimate_id = i.invoice_id;
