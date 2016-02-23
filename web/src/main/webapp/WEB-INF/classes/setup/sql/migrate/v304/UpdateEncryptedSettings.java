package v304;

import org.fao.geonet.ApplicationContextHolder;
import org.fao.geonet.DatabaseMigrationTask;
import org.fao.geonet.constants.Geonet;
import org.fao.geonet.utils.Log;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 */
public class UpdateEncryptedSettings  implements DatabaseMigrationTask {
    @Override
    public void update(Connection connection) throws SQLException {
        try (Statement statement = connection.createStatement()) {
            final String encryptedSettings = "SELECT name, value FROM Settings WHERE encrypted = 'y'";

            ResultSet metadataResultSet = statement.executeQuery(encryptedSettings);
            int numberOfMetadata = 0;
            try {
                while (metadataResultSet.next()) {
                    String name = metadataResultSet.getString(1);
                    String value = metadataResultSet.getString(2);
                    StandardPBEStringEncryptor encryptor = (StandardPBEStringEncryptor) ApplicationContextHolder.get().getBean("strongEncryptor");
                    value = encryptor.encrypt(value);

                    statement.execute("UPDATE Settings SET value='" + value + "' WHERE name='" + name + "'");
                }

                Log.debug(Geonet.DB, "  Number of metadata: " + numberOfMetadata);
            } finally {
                metadataResultSet.close();
            }

        }
    }
}
