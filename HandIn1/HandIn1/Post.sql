CREATE TABLE Post (
    PostID         INT NOT NULL,
    LoanDate       DATETIME NOT NULL,
    PaymentDate    DATETIME NULL,
    PersonID       INT NOT NULL,
[Amount] MONEY NOT NULL, 
    CONSTRAINT pk_Post PRIMARY KEY CLUSTERED (PostID),
CONSTRAINT fk_Post FOREIGN KEY (PersonID)
    REFERENCES PersonSb (PersonID)
    ON DELETE Cascade
    ON UPDATE CASCADE)
GO
