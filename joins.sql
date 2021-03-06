SELECT TNAME, TABTYPE, CLUSTERID  FROM TAB;

SELECT USERNAME FROM SYS.ALL_USERS;

--------------------------DATA GENERATING SECTION-------------------------------

CREATE TABLE SUPPLIERS(
    SUPPLIER_ID VARCHAR(10),
    SUPPLIER_NAME VARCHAR(15)
);

INSERT INTO SUPPLIERS VALUES('&SUPPLIER_ID', '&SUPPLIER_NAME');
INSERT INTO SUPPLIERS VALUES('10000', 'IBM');
INSERT INTO SUPPLIERS VALUES('10001', 'Hewlett Packard');
INSERT INTO SUPPLIERS VALUES('10002', 'Microsoft');
INSERT INTO SUPPLIERS VALUES('10003', 'NVIDIA');

CREATE TABLE ORDERS(
    ORDER_ID VARCHAR(10),
    SUPPLIER_ID VARCHAR(10),
    ORDER_DATE DATE
);

INSERT INTO ORDERS VALUES('&ORDER_ID', '&SUPPLIER_ID', '&ORDER_DATE');
INSERT INTO ORDERS VALUES('500125', '10000', '12-05-2003');
INSERT INTO ORDERS VALUES('500126', '10001', '13-05-2003');
INSERT INTO ORDERS VALUES('500127', '10004', '14-05-2003');


------------------------INNER JOIN----------------------------------------------

SELECT SUPPLIERS.SUPPLIER_ID, SUPPLIERS.SUPPLIER_NAME, ORDERS.ORDER_DATE
    FROM SUPPLIERS
    INNER JOIN ORDERS
    ON SUPPLIERS.SUPPLIER_ID = ORDERS.SUPPLIER_ID;
    
-----------------------LEFT OUTER JOIN------------------------------------------

SELECT SUPPLIERS.SUPPLIER_ID, SUPPLIERS.SUPPLIER_NAME, ORDERS.ORDER_DATE
    FROM SUPPLIERS
    LEFT OUTER JOIN ORDERS
    ON SUPPLIERS.SUPPLIER_ID = ORDERS.SUPPLIER_ID;
    
----------------------RIGHT OUTER JOIN------------------------------------------

SELECT SUPPLIERS.SUPPLIER_ID, SUPPLIERS.SUPPLIER_NAME, ORDERS.ORDER_DATE
    FROM SUPPLIERS
    RIGHT OUTER JOIN ORDERS
    ON SUPPLIERS.SUPPLIER_ID = ORDERS.SUPPLIER_ID;
    
---------------------FULL OUTER JOIN--------------------------------------------

SELECT SUPPLIERS.SUPPLIER_ID, SUPPLIERS.SUPPLIER_NAME, ORDERS.ORDER_DATE
    FROM SUPPLIERS
    FULL OUTER JOIN ORDERS
    ON SUPPLIERS.SUPPLIER_ID = ORDERS.SUPPLIER_ID;
    
---------------------CROSS JOIN-------------------------------------------------

SELECT SUPPLIERS.SUPPLIER_ID SUPPLIER_ID,
    SUPPLIERS.SUPPLIER_NAME SUPPLIER_NAME,
    ORDERS.ORDER_ID ORDER_ID,
    ORDERS.SUPPLIER_ID SUPPLIER_ID_0,
    ORDERS.ORDER_DATE ORDER_DATE FROM SUPPLIERS
    CROSS JOIN ORDERS;
    
    
    
--------------------SUB QUERIES-------------------------------------------------

CREATE TABLE STUDENT(
    STUDENTID VARCHAR(4),
    NAME VARCHAR(10),
    CONSTRAINT PK_SID PRIMARY KEY(STUDENTID)
);

INSERT INTO STUDENT VALUES('&STUDENTID', '&NAME');
INSERT INTO STUDENT VALUES('V001', 'ABE');
INSERT INTO STUDENT VALUES('V002', 'ABHAY');
INSERT INTO STUDENT VALUES('V003', 'ACELIN');
INSERT INTO STUDENT VALUES('V004', 'ADELPHOS');

CREATE TABLE MARKS(
    STUDENTID VARCHAR(4),
    TOTAL_MARKS NUMBER,
    CONSTRAINT FK_SID FOREIGN KEY(STUDENTID) REFERENCES STUDENT(STUDENTID)
);

INSERT INTO MARKS VALUES('&STUDENTID', '&TOTAL_MARKS');
INSERT INTO MARKS VALUES('V001', '95');
INSERT INTO MARKS VALUES('V002', '80');
INSERT INTO MARKS VALUES('V003', '74');
INSERT INTO MARKS VALUES('V004', '81');

SELECT * FROM MARKS WHERE STUDENTID = 'V002';

--SECOND QUERY

SELECT A.STUDENTID, A.NAME, B.TOTAL_MARKS
    FROM STUDENT A, MARKS B
    WHERE A.STUDENTID = B.STUDENTID
    AND B.TOTAL_MARKS > 80;
    
------------------- SUB QUERY --------------------------------------------------

SELECT A.STUDENTID, A.NAME, B.TOTAL_MARKS
    FROM STUDENT A, MARKS B
    WHERE A.STUDENTID = B.STUDENTID
    AND B.TOTAL_MARKS >
        (SELECT TOTAL_MARKS 
            FROM MARKS
            WHERE STUDENTID = 'V002');
            


------------------ SALES DATA MANIPULATION -------------------------------------

CREATE TABLE SALES(
    SALES_ID VARCHAR(5),
    SALES_DATE DATE,
    DAYY NUMBER,
    MONTHH NUMBER,
    YEARR NUMBER,
    SALES_AMOUNT NUMBER
);

--INSERT INTO SALES VALUES('&SALES_ID', '&SALES_DATE', '&DAY', '&MONTH', '&YEAR', '&SALES_AMOUNT');
INSERT INTO SALES VALUES('ID1', '01-01-2016', '01', '01', '2016', '874');
INSERT INTO SALES VALUES('ID2', '02-02-2016', '02', '02', '2016', '354');
INSERT INTO SALES VALUES('ID3', '03-03-2016', '03', '03', '2016', '657');
INSERT INTO SALES VALUES('ID4', '04-04-2016', '04', '04', '2016', '234');
INSERT INTO SALES VALUES('ID5', '05-05-2016', '05', '05', '2016', '676');
INSERT INTO SALES VALUES('ID6', '06-06-2016', '06', '06', '2016', '878');
INSERT INTO SALES VALUES('ID7', '07-07-2016', '07', '07', '2016', '123');
INSERT INTO SALES VALUES('ID8', '08-08-2016', '08', '08', '2016', '876');
INSERT INTO SALES VALUES('ID9', '09-09-2016', '09', '09', '2016', '342');
INSERT INTO SALES VALUES('ID10', '10-10-2016', '10', '10', '2016', '564');
INSERT INTO SALES VALUES('ID11', '11-11-2016', '11', '11', '2016', '845');
INSERT INTO SALES VALUES('ID12', '12-12-2016', '12', '12', '2016', '763');

--SELECT * FROM SALES;

--DELETE FROM SALES WHERE SALES_ID = 'ID2';

-------------- PL SQL CASE STATEMENT -------------------------------------------

SELECT
    CASE
        WHEN DAYY <= 3
            THEN '1sT QUARTER'
        WHEN DAYY <= 6
            THEN '2nd QUARTER'
        WHEN DAYY <= 9
            THEN '3rd QUARTER'
        WHEN DAYY <= 12
            THEN '4th QUARTER'
    END
    AS QUARTERS
    FROM SALES;
    
SELECT MONTHH, SALES_DATE, 
    CASE
        WHEN DAYY <= 3
            THEN '1sT QUARTER'
        WHEN DAYY <= 6
            THEN '2nd QUARTER'
        WHEN DAYY <= 9
            THEN '3rd QUARTER'
        WHEN DAYY <= 12
            THEN '4th QUARTER'
    END
    AS QUARTERS
    FROM SALES;
    
--DROP TABLE SALES;

DESCRIBE SALES;

----------------- FINDING SECOND MAXIMUM VALUE ---------------------------------

SELECT MAX(SALES_AMOUNT) FROM SALES WHERE SALES_AMOUNT NOT IN (SELECT MAX(SALES_AMOUNT) FROM SALES);

SELECT MAX(SALES_AMOUNT) FROM SALES WHERE SALES_AMOUNT < (SELECT MAX(SALES_AMOUNT) FROM SALES);

--SELECT ISDATE('01/11/2018') AS "MM/DD/YYYY";

SELECT * FROM SALES;

----------------- EXTRACTING YEAR FROM DATE COLUMN -----------------------------

SELECT EXTRACT(YEAR FROM SALES_DATE) FROM SALES;

SELECT MAX(SALES_AMOUNT) FROM SALES GROUP BY EXTRACT(YEAR FROM SALES_DATE);

------------- GETTING CURRENT DATE ---------------------------------------------

SELECT SYSDATE FROM TAB WHERE ROWNUM <= 1;

------------ GET RESULTS IN BETWEEN A TIME FRAME -------------------------------

SELECT SALES_ID FROM SALES WHERE EXTRACT(MONTH FROM SALES_DATE) BETWEEN 1 AND 3;

------------- GET COUNT BETWEEN A TIME FRAME -----------------------------------

SELECT COUNT(*) AS SALES_COUNT FROM SALES 
    WHERE EXTRACT(MONTH FROM SALES_DATE) BETWEEN 2 AND 8;

-------------- GET SALES AMOUNT GREATER THAN 500 -------------------------------

SELECT SALES_ID, SALES_DATE, SALES_AMOUNT FROM SALES
    WHERE SALES_AMOUNT < 500;
    
-------------- LIKE VALUE FINDER -----------------------------------------------

SELECT SALES_ID FROM SALES WHERE SALES_ID LIKE 'ID1%';

SELECT SALES_ID FROM SALES WHERE LOWER(SALES_ID) LIKE 'id1%';

------------- YEAR EXTRACTION --------------------------------------------------

SELECT EXTRACT(YEAR FROM CURRENT_DATE) AS YEARR FROM TAB WHERE ROWNUM <= 1;

------------ FINDING DUPLICATED IN THE TABLE -----------------------------------

SELECT SALES_ID, SALES_AMOUNT FROM SALES GROUP BY SALES_ID, SALES_AMOUNT HAVING COUNT(SALES_ID) > 1 AND COUNT(SALES_AMOUNT) > 1;

DELETE FROM SALES WHERE SALES_ID = (SELECT SALES_ID FROM SALES GROUP BY SALES_ID HAVING COUNT(SALES_ID) > 1);

------------- GETTING VALUES ABOVE AVERAGE -------------------------------------

SELECT * FROM SALES WHERE SALES_AMOUNT >= (SELECT AVG(SALES_AMOUNT) FROM SALES);

------------ COMPARE TWO COLUMNS -----------------------------------------------

SELECT SALES_ID, SALES_DATE, SALES_AMOUNT FROM SALES WHERE EXTRACT(YEAR FROM SALES_DATE) = YEARR;

-------------- SUBSTRING VALUES ------------------------------------------------

SELECT SUBSTR(SALES_ID, 0, 2) AS ID FROM SALES;

SELECT SALES_ID FROM SALES WHERE SUBSTR(SALES_ID, 0, 2) LIKE 'ID%';

---------------- ROW NUMBER FUNCTIONS ------------------------------------------

SELECT SALES_ID, SALES_DATE, ROW_NUMBER() OVER(ORDER BY SALES_AMOUNT DESC) FROM SALES;

----------------- AVERAGE WITHOUT AVG ------------------------------------------

SELECT AVG(SALES_AMOUNT) FROM SALES;

SELECT SUM(SALES_AMOUNT)/COUNT(*) FROM SALES;

SELECT STDDEV(SALES_AMOUNT) FROM SALES;

