SET SERVEROUTPUT ON;

-- Some Alteration to schema for this exercise
ALTER TABLE CUSTOMERS ADD ISVIP CHAR(5);

ALTER TABLE LOANS ADD LOANINTERESTRATE NUMBER;

-- Initialize LoanInterestRate with existing InterestRate values
UPDATE LOANS
SET
    LOANINTERESTRATE = INTERESTRATE;

-- Scenario 1 
-- Apply 1% discount to customers above 60 years old
BEGIN
    FOR CUST IN (
        SELECT
            CUSTOMERID,
            DOB
        FROM
            CUSTOMERS
        WHERE
            MONTHS_BETWEEN(SYSDATE, DOB) / 12 > 60
    ) LOOP
        UPDATE LOANS
        SET
            LOANINTERESTRATE = LOANINTERESTRATE * 0.99
        WHERE
            CUSTOMERID = CUST.CUSTOMERID;

    END LOOP;
END;
/
SELECT * FROM Loans;

-- Scenario 2 
-- Promote to VIP if balance > $10,000
BEGIN
    FOR CUST IN (
        SELECT
            CUSTOMERID
        FROM
            CUSTOMERS
        WHERE
            BALANCE > 10000
    ) LOOP
        UPDATE CUSTOMERS
        SET
            ISVIP = 'TRUE'
        WHERE
            CUSTOMERID = CUST.CUSTOMERID;

    END LOOP;
END;
/
SELECT * FROM CUSTOMERS;

-- Scenario 3
-- Print reminders for loans due in the next 30 days
BEGIN
    FOR loan_rec IN (
        SELECT L.LoanID, C.Name, L.EndDate
        FROM Loans L
        JOIN Customers C ON L.CustomerID = C.CustomerID
        WHERE L.EndDate BETWEEN SYSDATE AND SYSDATE + 30
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || loan_rec.LoanID ||
                             ' for ' || loan_rec.Name ||
                             ' is due on ' || TO_CHAR(loan_rec.EndDate, 'YYYY-MM-DD'));
    END LOOP;
END;
/

-- I have added an example recorded because no record currently matches such condition
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (888, 1, 2500, 6.5, SYSDATE, SYSDATE + 10);

COMMIT;