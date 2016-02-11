ALTER TABLE serviceparameters ADD COLUMN occur varchar(1) default '+';
UPDATE serviceparameters SET occur='+';
ALTER TABLE serviceparameters ADD COLUMN id int NOT NULL AUTO_INCREMENT PRIMARY KEY;