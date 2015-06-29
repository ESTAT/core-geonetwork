DELETE FROM Settings WHERE parentid IN (
        SELECT id FROM (SELECT * FROM Settings) 
            AS a WHERE name LIKE 'statistics'
    );   
DELETE FROM Settings WHERE name LIKE 'statistics';
INSERT INTO Settings (SELECT max(id) + 1, 1, 'statistics', NULL FROM Settings);
INSERT INTO Settings (SELECT id+1, id, 'snippet', '' FROM Settings WHERE name LIKE 'statistics');
UPDATE Settings SET value='2.10.3.1' WHERE name='version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='subVersion';