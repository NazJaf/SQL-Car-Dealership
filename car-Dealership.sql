CREATE DATABASE CarDealership;

USE CarDealership;

CREATE TABLE "Car" (
  "CarID" SERIAL,
  "SerialNumber" VARCHAR(50),
  "Make" VARCHAR(50),
  "Model" VARCHAR(50),
  "Year" INTEGER,
  "Price" DECIMAL(10,2),
  "Status" VARCHAR(10),
  "SalespersonID" INTEGER,
  PRIMARY KEY ("CarID")
);

CREATE INDEX "UN" ON  "Car" ("SerialNumber");

CREATE TABLE "Customer" (
  "CustomerID" SERIAL,
  "Name" VARCHAR(100),
  "Phone" VARCHAR(15),
  "Email" VARCHAR(100),
  "Address" VARCHAR(150),
  PRIMARY KEY ("CustomerID")
);

CREATE TABLE "Invoice" (
  "InvoiceID" SERIAL,
  "CarID" INTEGER,
  "SalesPersonID" INTEGER,
  "CustomerID" INTEGER,
  "Date" DATE,
  "TotalAmount" DECIMAL(10,2),
  PRIMARY KEY ("InvoiceID"),
  CONSTRAINT "FK_Invoice.TotalAmount"
    FOREIGN KEY ("TotalAmount")
      REFERENCES "Customer"("Phone"),
  CONSTRAINT "FK_Invoice.InvoiceID"
    FOREIGN KEY ("InvoiceID")
      REFERENCES "Car"("Status")
);

CREATE TABLE "Part" (
  "PartID" SERIAL,
  "PartName" VARCHAR(100),
  "PartDescription" TEXT,
  "PartPrice" Decimal(10,2),
  PRIMARY KEY ("PartID")
);

CREATE TABLE "SalersPerson" (
  "SalespersonID" SERIAL,
  "Name" VARCHAR(100),
  "Phone" VARCHAR(15),
  "Email" VARCHAR(100),
  PRIMARY KEY ("SalespersonID")
);

CREATE TABLE "Mechanic" (
  "MechanicID" SERIAL,
  "Name" VARCHAR(100),
  "Specialty" VARCHAR(100),
  PRIMARY KEY ("MechanicID")
);

CREATE TABLE "ServiceTicket" (
  "TicketID" SERIAL,
  "CarID" INTEGER,
  "CustomerID" INTEGER,
  "Date" DATE,
  "Description" TEXT,
  PRIMARY KEY ("TicketID")
);

CREATE TABLE "ServiceRecord" (
  "ServiceRecordID" SERIAL,
  "TicketID" INTEGER,
  "MechanicID" INTEGER,
  "PartID" INTEGER,
  "ServiceDate" DATE,
  "Notes" TEXT,
  PRIMARY KEY ("ServiceRecordID"),
  CONSTRAINT "FK_ServiceRecord.MechanicID"
    FOREIGN KEY ("MechanicID")
      REFERENCES "Mechanic"("Name"),
  CONSTRAINT "FK_ServiceRecord.TicketID"
    FOREIGN KEY ("TicketID")
      REFERENCES "ServiceTicket"("CustomerID")
);
INSERT INTO Salesperson (Name, Phone, Email) VALUES ('Alice Brown', '555-1111', 'alice.brown@example.com');
INSERT INTO Salesperson (Name, Phone, Email) VALUES ('Bob Green', '555-2222', 'bob.green@example.com');

INSERT INTO Car (SerialNumber, Make, Model, Year, Price, Status, SalespersonID) VALUES ('ABC123', 'Toyota', 'Corolla', 2020, 20000.00, 'New', 1);
INSERT INTO Car (SerialNumber, Make, Model, Year, Price, Status, SalespersonID) VALUES ('XYZ456', 'Honda', 'Civic', 2019, 18000.00, 'Used', 2);

INSERT INTO Invoice (CarID, SalespersonID, CustomerID, Date, TotalAmount) VALUES (1, 1, @CustomerID1, '2024-08-01', 20000.00);
INSERT INTO Invoice (CarID, SalespersonID, CustomerID, Date, TotalAmount) VALUES (2, 2, @CustomerID2, '2024-08-02', 18000.00);

INSERT INTO Mechanic (Name, Specialty) VALUES ('Charlie Black', 'Engine Repair');
INSERT INTO Mechanic (Name, Specialty) VALUES ('David White', 'Transmission Repair);


CREATE FUNCTION AddCustomer(
    name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(150)
)
RETURNS INT
BEGIN
    INSERT INTO Customer (Name, Phone, Email, Address)
    VALUES (name, phone, email, address);
    RETURN LAST_INSERT_ID();
END 



SET @CustomerID1 = AddCustomer('John Doe', '555-1234', 'john.doe@example.com', '123 Elm St');
SET @CustomerID2 = AddCustomer('Jane Smith', '555-5678', 'jane.smith@example.com', '456 Oak St');

