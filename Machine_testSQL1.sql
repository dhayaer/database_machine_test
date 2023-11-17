-- 1
CREATE TABLE tbl_stock (
    pk_int_stock_Id SERIAL PRIMARY KEY  ,
    vchr_name VARCHAR(20),
    int_quantity INT,
     int_price INT
);
-- output
machine_test=# \d tbl_stock;
                                               Table "public.tbl_stock"
     Column      |          Type          | Collation | Nullable |                      Default         
-----------------+------------------------+-----------+----------+----------------------------------------------------
 pk_int_stock_id | integer                |           | not null | nextval('tbl_stock_pk_int_stock_id_seq'::regclass)
 vchr_name       | character varying(100) |           |          |
 int_quantity    | integer                |           |          |
 int_price       | integer                |           |          |
Indexes:
    "tbl_stock_pkey" PRIMARY KEY, btree (pk_int_stock_id)







-- 2
ALTER TABLE tbl_stock ALTER COLUMN int_price TYPE FLOAT;
-- output
machine_test=# \d tbl_stock;
                                               Table "public.tbl_stock"
     Column      |          Type          | Collation | Nullable |                      Default         
-----------------+------------------------+-----------+----------+----------------------------------------------------
 pk_int_stock_id | integer                |           | not null | nextval('tbl_stock_pk_int_stock_id_seq'::regclass)
 vchr_name       | character varying(100) |           |          |
 int_quantity    | integer                |           |          |
 int_price       | double precision       |           |          |
Indexes:
    "tbl_stock_pkey" PRIMARY KEY, btree (pk_int_stock_id)





-- 3
CREATE TABLE tbl_supplier (
    pk_int_supplier_id SERIAL PRIMARY KEY,
    vchr_supplier_name VARCHAR(25)
);
-- output
machinetest=# \d tbl_supplier
                                                 Table "public.tbl_supplier"
       Column       |         Type          | Collation | Nullable |                         Default    
--------------------+-----------------------+-----------+----------+----------------------------------------------------------
 pk_int_supplier_id | integer               |           | not null | nextval('tbl_supplier_pk_int_supplier_id_seq'::regclass)
 vchr_supplier_name | character varying(25) |           |          |
Indexes:
    "tbl_supplier_pkey" PRIMARY KEY, btree (pk_int_supplier_id)





-- 4
ALTER TABLE tbl_stock ADD COLUMN fk_int_supplier INT;
machine_test=# \d tbl_supplier;
                                                 Table "public.tbl_supplier"
       Column       |         Type          | Collation | Nullable |                         Default    
--------------------+-----------------------+-----------+----------+----------------------------------------------------------
 pk_int_supplier_id | integer               |           | not null | nextval('tbl_supplier_pk_int_supplier_id_seq'::regclass)
 vchr_supplier_name | character varying(25) |           |          |
Indexes:
    "tbl_supplier_pkey" PRIMARY KEY, btree (pk_int_supplier_id)



-- 5
ALTER TABLE tbl_stock add constraint fk_int_supplier FOREIGN KEY(fk_int_supplier)REFERENCES tbl_supplier(pk_int_supplier_id )
ON DELETE CASCADE ON UPDATE CASCADE
-- output
    machinetest=# \d tbl_stock
                                               Table "public.tbl_stock"
     Column      |          Type          | Collation | Nullable |                      Default         
-----------------+------------------------+-----------+----------+----------------------------------------------------
 pk_int_stock_id | integer                |           | not null | nextval('tbl_stock_pk_int_stock_id_seq'::regclass)
 vchr_name       | character varying(100) |           |          |
 int_quantity    | integer                |           |          |
 int_price       | double precision       |           |          |
 fk_int_supplier | integer                |           |          |
Indexes:
    "tbl_stock_pkey" PRIMARY KEY, btree (pk_int_stock_id)
Foreign-key constraints:
    "fk_int_supplier" FOREIGN KEY (fk_int_supplier) REFERENCES tbl_supplier(pk_int_supplier_id) ON UPDATE CASCADE ON DELETE CASCADE


-- 6
CREATE TABLE tbl_dept (
    pk_int_dept_id SERIAL PRIMARY KEY,
    vchr_dept_name VARCHAR(25)
);
-- output
    machinetest=# \d tbl_dept
                                              Table "public.tbl_dept"
     Column     |          Type          | Collation | Nullable |                     Default           
----------------+------------------------+-----------+----------+--------------------------------------------------
 pk_int_dept_id | integer                |           | not null | nextval('tbl_dept_pk_int_dept_id_seq'::regclass)
 vchr_dept_name | character varying(100) |           |          |
Indexes:
    "tbl_dept_pkey" PRIMARY KEY, btree (pk_int_dept_id)

-- 7
CREATE TABLE tbl_classes (
    pk_int_class_id SERIAL PRIMARY KEY,
    vchr_class_name VARCHAR(28),
    fk_int_dept_id INT,
    FOREIGN KEY(fk_int_supplier)REFERENCES tbl_dept(pk_int_dept_id )
    ON DELETE CASCADE ON UPDATE CASCADE
);
-- output
machinetest=# \d tbl_classes
                                              Table "public.tbl_classes"
     Column      |         Type          | Collation | Nullable |                       Default         
-----------------+-----------------------+-----------+----------+------------------------------------------------------
 pk_int_class_id | integer               |           | not null | nextval('tbl_classes_pk_int_class_id_seq'::regclass)
 vchr_class_name | character varying(20) |           |          |
 fk_int_dept_id  | integer               |           |          |
Indexes:
    "tbl_classes_pkey" PRIMARY KEY, btree (pk_int_class_id)
Foreign-key constraints:
    "tbl_classes_fk_int_dept_id_fkey" FOREIGN KEY (fk_int_dept_id) REFERENCES tbl_dept(pk_int_dept_id) ON UPDATE CASCADE ON DELETE CASCADE


-- 8
CREATE TABLE tbl_enrollment (
    pk_int_enrollment_id SERIAL PRIMARY KEY,
    int_count INT,
    fk_int_class_id INT,
    FOREIGN KEY(fk_int_class_id)REFERENCES tbl_classes(pk_int_class_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
-- output
machinetest=# \d tbl_enrollment
                                            Table "public.tbl_enrollment"
        Column        |  Type   | Collation | Nullable |                           Default              
----------------------+---------+-----------+----------+--------------------------------------------------------------
 pk_int_enrollment_id | integer |           | not null | nextval('tbl_enrollment_pk_int_enrollment_id_seq'::regclass)
 int_count            | integer |           |          |
 fk_int_class_id      | integer |           |          |
Indexes:
    "tbl_enrollment_pkey" PRIMARY KEY, btree (pk_int_enrollment_id)
Foreign-key constraints:
    "tbl_enrollment_fk_int_class_id_fkey" FOREIGN KEY (fk_int_class_id) REFERENCES tbl_classes(pk_int_class_id) ON UPDATE CASCADE ON DELETE CASCADE


-- 9
ALTER TABLE tbl_classes ADD CONSTRAINT unique_class_name UNIQUE(vchr_class_name);
-- output
machinetest=# \d tbl_classes
                                              Table "public.tbl_classes"
     Column      |         Type          | Collation | Nullable |                       Default         
-----------------+-----------------------+-----------+----------+------------------------------------------------------
 pk_int_class_id | integer               |           | not null | nextval('tbl_classes_pk_int_class_id_seq'::regclass)
 vchr_class_name | character varying(20) |           |          |
 fk_int_dept_id  | integer               |           |          |
Indexes:
    "tbl_classes_pkey" PRIMARY KEY, btree (pk_int_class_id)
    "unique_class_name" UNIQUE CONSTRAINT, btree (vchr_class_name)
Foreign-key constraints:
    "tbl_classes_fk_int_dept_id_fkey" FOREIGN KEY (fk_int_dept_id) REFERENCES tbl_dept(pk_int_dept_id) ON UPDATE CASCADE ON DELETE CASCADE
Referenced by:
    TABLE "tbl_enrollment" CONSTRAINT "tbl_enrollment_fk_int_class_id_fkey" FOREIGN KEY (fk_int_class_id) REFERENCES tbl_classes(pk_int_class_id) ON UPDATE CASCADE ON DELETE CASCADE



-- 10
ALTER TABLE tbl_dept ADD COLUMN vchr_dept_description VARCHAR(28);
-- output
machinetest=# \d tbl_dept
                                                 Table "public.tbl_dept"
        Column         |          Type          | Collation | Nullable |                     Default    
-----------------------+------------------------+-----------+----------+--------------------------------------------------
 pk_int_dept_id        | integer                |           | not null | nextval('tbl_dept_pk_int_dept_id_seq'::regclass)
 vchr_dept_name        | character varying(100) |           |          |
 vchr_dept_description | character varying(20)  |           |          |
Indexes:
    "tbl_dept_pkey" PRIMARY KEY, btree (pk_int_dept_id)
Referenced by:
    TABLE "tbl_classes" CONSTRAINT "tbl_classes_fk_int_dept_id_fkey" FOREIGN KEY (fk_int_dept_id) REFERENCES tbl_dept(pk_int_dept_id) ON UPDATE CASCADE ON DELETE CASCADE




-- 11
INSERT INTO tbl_supplier VALUES
(1,'logitech'),
(2,'samsung'),
(3,'Iball'),
(4,'LG'),
(5,'Creative');
-- output
   machinetest=# select * from tbl_supplier;
 pk_int_supplier_id | vchr_supplier_name
--------------------+--------------------
                  1 | Logitech
                  2 | Samsung
                  3 | Iball
                  4 | LG
                  5 | Creative
(5 rows)



-- 1
INSERT INTO tbl_stock VALUES
(1,'Mouse',10,500,1),
(2,'Keyboard',5,450,3),
(3,'Modem',10,1200,2),
(4,'Memory',100,1500,5),
(5,'Headphone',50,750,4),
(6,'Memory',2,3500,4);
-- output
 
machinetest=# select * from tbl_stock;
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               1 | Mouse     |           10 |       500 |               1
               2 | Keyboard  |            5 |       450 |               3
               3 | Modem     |           10 |      1200 |               2
               4 | Memory    |          100 |      1500 |               5
               5 | Headphone |           50 |       750 |               4
               6 | Memory    |            2 |      3500 |               4
(6 rows)



-- 2
UPDATE tbl_stock SET price = price + 1.50;
-- output
machinetest=# select * from tbl_stock;
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               1 | Mouse     |           10 |     501.5 |               1
               2 | Keyboard  |            5 |     451.5 |               3
               3 | Modem     |           10 |    1201.5 |               2
               4 | Memory    |          100 |    1501.5 |               5
               5 | Headphone |           50 |     751.5 |               4
               6 | Memory    |            2 |    3501.5 |               4
(6 rows)



-- 3
SELECT * from tbl_stock where int_price > 1000;
-- output
pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               3 | Modem     |           10 |    1201.5 |               2
               4 | Memory    |          100 |    1501.5 |               5
               6 | Memory    |            2 |    3501.5 |               4
(3 rows)



-- 4
SELECT * FROM tbl_stock ORDER BY item_name ASC;
-- output
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               5 | Headphone |           50 |     751.5 |               4
               2 | Keyboard  |            5 |     451.5 |               3
               4 | Memory    |          100 |    1501.5 |               5
               6 | Memory    |            2 |    3501.5 |               4
               3 | Modem     |           10 |    1201.5 |               2
               1 | Mouse     |           10 |     501.5 |               1
(6 rows)



-- 5
SELECT * FROM tbl_stock ORDER BY item_name ASC LIMIT 3;
-- output pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               5 | Headphone |           50 |     751.5 |               4
               2 | Keyboard  |            5 |     451.5 |               3
               4 | Memory    |          100 |    1501.5 |               5
(3 rows)


-- 6
SELECT * FROM tbl_stock ORDER BY item_name DESC LIMIT 3;
-- output
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               1 | Mouse     |           10 |     501.5 |               1
               3 | Modem     |           10 |    1201.5 |               2
               4 | Memory    |          100 |    1501.5 |               5
(3 rows)



-- 7
SELECT item_name, int_quantity, int_price, (int_quantity * int_price) AS extended_price
FROM tbl_stock;
-- output
vchr_name | int_price | int_quantity_int_price
-----------+-----------+------------------------
 Mouse     |        10 |                   5015
 Keyboard  |         5 |                 2257.5
 Modem     |        10 |                  12015
 Memory    |       100 |                 150150
 Headphone |        50 |                  37575
 Memory    |         2 |                   7003
(6 rows)


-- 8
DELETE FROM tbl_stock WHERE supplier_name = 'creative';
-- output
machinetest=# select * from tbl_stock;
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               1 | Mouse     |           10 |     501.5 |               1
               2 | Keyboard  |            5 |     451.5 |               3
               3 | Modem     |           10 |    1201.5 |               2
               5 | Headphone |           50 |     751.5 |               4
               6 | Memory    |            2 |    3501.5 |               4
(5 rows)


-- 9

-- output
INSERT INTO tbl_dept VALUES
(1,'Computer Science','CS'),
(2,'Electrinics','EC'),
(3,'Commerce','CC'),
(4,'Arts','AR');

machinetest=# select * from tbl_dept;
 pk_int_dept_id |  vchr_dept_name  | vchr_dept_description
----------------+------------------+-----------------------
              1 | Computer Science | CS
              2 | Electrinics      | EC
              3 | Commerce         | CC
              4 | Arts             | AR
(4 rows)




