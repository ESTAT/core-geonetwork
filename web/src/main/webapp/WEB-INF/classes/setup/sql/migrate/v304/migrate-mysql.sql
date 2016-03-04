-- Default view for ESTAT
UPDATE settings SET value = 'estat' WHERE name = 'system/ui/defaultView';

UPDATE Settings SET encrypted='y' WHERE name='system/proxy/password';
UPDATE Settings SET encrypted='y' WHERE name='system/feedback/mailServer/password';
UPDATE HarvesterSettings SET encrypted='y' WHERE name='password';

UPDATE settings SET value='3.0.4' WHERE name='system/platform/version';
UPDATE settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';
