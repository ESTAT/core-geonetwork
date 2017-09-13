package v303;

import org.fao.geonet.DatabaseMigrationTask;
import org.fao.geonet.constants.Geonet;
import org.fao.geonet.utils.Log;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SetSequenceMySqlTableValueToMaxOfMetadataAndStats implements DatabaseMigrationTask {
    @Override
    public void update(Connection connection) throws SQLException {
        Log.debug(Geonet.DB, "SetSequenceValueToMaxOfMetadataAndStats");
        
        //If this is mysql, just skip it!
        if(!connection.getMetaData().getDatabaseProductName().equalsIgnoreCase("MySQL")) {
            return;
        }
        
        

        try (Statement statement = connection.createStatement()) {
            final String numberOfMetadataSQL = "SELECT max(id) as NB FROM metadata";
            final String numberOfParamsSQL = "SELECT max(id) as NB FROM params";
            final String numberOfRequestsSQL = "SELECT max(id) as NB FROM requests";

            ResultSet metadataResultSet = statement.executeQuery(numberOfMetadataSQL);
            int numberOfMetadata = 0;
            try {
                if (metadataResultSet.next()) {
                    numberOfMetadata = metadataResultSet.getInt(1);
                }

                Log.debug(Geonet.DB, "  Number of metadata: " + numberOfMetadata);
            } finally {
                metadataResultSet.close();
            }

            int numberOfParams = 0;
            ResultSet paramsResultSet = statement.executeQuery(numberOfParamsSQL);
            try {
                if (paramsResultSet.next()) {
                    numberOfParams = paramsResultSet.getInt(1);
                }
                Log.debug(Geonet.DB, "  Number of params (statistics): " + numberOfParams);
            } finally {
                paramsResultSet.close();
            }

            int numberOfRequests = 0;
            ResultSet requestsResultSet = statement.executeQuery(numberOfRequestsSQL);
            try {
                if (requestsResultSet.next()) {
                    numberOfRequests = requestsResultSet.getInt(1);
                }
                Log.debug(Geonet.DB, "  Number of requests (statistics): " + numberOfRequests);
            } finally {
                requestsResultSet.close();
            }
            try {
                int newSequenceValue = Math.max(numberOfMetadata, Math.max(numberOfParams, numberOfRequests)) + 1;
                Log.debug(Geonet.DB, "  Set sequence to value: " + newSequenceValue);
                final String updateSequenceSQL = "INSERT INTO HIBERNATE_SEQUENCE VALUES (" + newSequenceValue + ")";

                statement.execute(updateSequenceSQL);

                // TODO: Probably a scenario for Oracle db
                // ALTER sequence HIBERNATE_SEQUENCE increment by X;
                // select seq1.nextval from dual;
                // ALTER sequence HIBERNATE_SEQUENCE increment by 1;
                Log.debug(Geonet.DB, "  Sequence updated.");
            } catch (Exception e) {
                Log.debug(Geonet.DB, "  Sequence not updated. Error is: " + e.getMessage());
                Log.error(Geonet.DB, e);
                // On Oracle : To restart the sequence at a different number, you must drop and re-create it.
            }
        } catch (Exception e) {
            Log.debug(Geonet.DB, "  Exception while updating sequence. " +
                    "Error is: " + e.getMessage());
            Log.error(Geonet.DB, e);
        }
    }
}