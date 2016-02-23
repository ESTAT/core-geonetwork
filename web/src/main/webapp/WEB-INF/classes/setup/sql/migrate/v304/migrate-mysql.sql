ALTER TABLE Settings ADD COLUMN encrypted VARCHAR(1) DEFAULT 'n';

UPDATE Settings SET encrypted='y' WHERE name='system/proxy/password';
UPDATE Settings SET encrypted='y' WHERE name='system/feedback/mailServer/password';

UPDATE settings SET value='3.0.4' WHERE name='system/platform/version';
UPDATE settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';
