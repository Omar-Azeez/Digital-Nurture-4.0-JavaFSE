-- ex3: Stored procedures

-- Scenario 1
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    UPDATE Accounts
    SET Balance = Balance * 1.01
    WHERE AccountType = 'Savings';

    COMMIT;
END;

BEGIN
    ProcessMonthlyInterest;
END;

SELECT * FROM ACCOUNTS;

-- Scenario 2
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    dept_name IN VARCHAR2,
    bonus_percent IN NUMBER
) AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * bonus_percent / 100)
    WHERE Department = dept_name;

    COMMIT;
END;

BEGIN
    UpdateEmployeeBonus('IT',10);
END;

SELECT * FROM EMPLOYEES;

-- Scenario 3
CREATE OR REPLACE PROCEDURE TransferFunds(
    from_account IN NUMBER,
    to_account IN NUMBER,
    amount IN NUMBER
) AS
    from_balance NUMBER;
BEGIN
    -- Check balance of source account
    SELECT Balance INTO from_balance FROM Accounts WHERE AccountID = from_account FOR UPDATE;

    IF from_balance >= amount THEN
        -- Deduct from source
        UPDATE Accounts
        SET Balance = Balance - amount
        WHERE AccountID = from_account;

        -- Add to destination
        UPDATE Accounts
        SET Balance = Balance + amount
        WHERE AccountID = to_account;

        COMMIT;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance in source account');
    END IF;
END;

BEGIN
    TransferFunds(1, 2, 200);  -- Transfer $200 from Account 1 to Account 2
END;

SELECT * FROM Accounts;