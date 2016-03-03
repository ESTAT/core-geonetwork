package v304;

import org.apache.commons.lang.StringUtils;
import org.fao.geonet.DatabaseMigrationTask;
import org.fao.geonet.constants.Geonet;
import org.fao.geonet.utils.Log;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

/**
 *
 */
public class UpdateEncryptedSettings implements DatabaseMigrationTask {

    @Override
    public void update(Connection connection) throws SQLException {
        // TODO: Take the values from a config file. Can't inject the bean as the DatabaseMigrationTask executes before all beans are initialised
        StandardPBEStringEncryptor standardPBEStringEncryptor = new StandardPBEStringEncryptor();
        standardPBEStringEncryptor.setAlgorithm("PBEWithMD5AndDES");
        standardPBEStringEncryptor.setPassword("jasypt");

        try (Statement statement = connection.createStatement()) {
            final String encryptedSettings = "SELECT name, value FROM Settings WHERE encrypted = 'y'";

            ResultSet settingsResultSet = statement.executeQuery(encryptedSettings);
            int numberOfSettings = 0;
            Map<String, String> updates = new HashMap<String, String>();

            try {
                while (settingsResultSet.next()) {
                    String name = settingsResultSet.getString(1);
                    String value = settingsResultSet.getString(2);
                    if (StringUtils.isNotEmpty(value)) {
                        value = standardPBEStringEncryptor.encrypt(value);
                        updates.put(name, value);
                    }
                }
                Log.debug(Geonet.DB, "  Number of settings: " + numberOfSettings);
            } catch (Exception ex) {
                ex.printStackTrace();
            } finally {
                settingsResultSet.close();
            }

            for(String key : updates.keySet()) {
                statement.execute("UPDATE Settings SET value='" + updates.get(key) + "' WHERE name='" + key + "'");
            }

            final String encryptedHarvesterSettings = "SELECT name, value FROM HarvesterSettings WHERE name = 'password'";
            ResultSet harvesterSettingsResultSet = statement.executeQuery(encryptedHarvesterSettings);
            int numberOfHarvesterSettings = 0;
            updates = new HashMap<String, String>();
            try {
                while (harvesterSettingsResultSet.next()) {
                    String name = harvesterSettingsResultSet.getString(1);
                    String value = harvesterSettingsResultSet.getString(2);
                    if (StringUtils.isNotEmpty(value)) {
                        value = standardPBEStringEncryptor.encrypt(value);
                        updates.put(name, value);
                    }
                }

                Log.debug(Geonet.DB, "  Number of harvester settings: " + numberOfHarvesterSettings);
            } catch (Exception ex) {
                ex.printStackTrace();
            } finally {
                harvesterSettingsResultSet.close();
            }

            for(String key : updates.keySet()) {
                statement.execute("UPDATE HarvesterSettings SET value='" + updates.get(key) + "' WHERE name='" + key + "'");
            }


        }
    }
}
