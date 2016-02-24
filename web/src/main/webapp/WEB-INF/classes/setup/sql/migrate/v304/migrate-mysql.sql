-- Default view for ESTAT
UPDATE settings SET value = 'estat' WHERE name = 'system/ui/defaultView';


UPDATE settings SET value='3.0.4' WHERE name='system/platform/version';
UPDATE settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';
