/*
 * This is a revorked copy of the Shibboleth version designed to handle ecas authentication
 * 
 * 
 *  Copyright (C) 2014 GeoSolutions S.A.S.
 *  http://www.geo-solutions.it
 * 
 *  GPLv3 + Classpath exception
 * 
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 * 
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 * 
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package org.fao.geonet.kernel.security.cas;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import jeeves.resources.dbms.Dbms;
import jeeves.server.ProfileManager;
import jeeves.server.resources.ResourceManager;
import jeeves.utils.Log;
import jeeves.utils.SerialFactory;

//import org.fao.geonet.constants.Geonet;
//import org.fao.geonet.kernel.security.GeonetworkUser;
//import org.fao.geonet.lib.Lib;
//import org.jdom.Element;

/**
 *
 * @author ETj (etj at geo-solutions.it)
 */
public class CASUserUtils {

	private static final String VIA_CAS = "Via CAS";
	private static final String CAS_FLAG = "CAS";

	//--------------------------------------------------------------------------

	/**
	 * Update the user to match the provided details, or create a new record
	 * for them if they don't have one already.
	 *
	 * @param context The Jeeves ServiceContext
	 * @param dbms The database connection.
	 * @param username The user's username, must not be null.
	 * @param surname The surname of the user
	 * @param firstname The first name of the user.
	 * @param profile The name of the user type.
	 * @throws SQLException If the record cannot be saved.
	 */
	public static void updateUser(Dbms dbms, SerialFactory serialFactory,
            String username, String surname, String firstname,
            String profile, String group,
            boolean updateProfile) throws SQLException
	{
//        boolean groupProvided = ((group != null) && (!(group.equals(""))));
//        int groupId = -1;
//        if (groupProvided) {
//            String query = "SELECT id FROM Groups WHERE name=?";
//
//            List list  = dbms.select(query, group).getChildren();
//
//            if (list.isEmpty()) {
//                groupId = serialFactory.getSerial(dbms, "Groups");
//
//                query = "INSERT INTO GROUPS(id, name) VALUES(?,?)";
//                dbms.execute(query, groupId, group);
//                Lib.local.insert(dbms, "Groups", groupId, group);
//
//            } else {
//                String gi = ((Element) list.get(0)).getChildText("id");
//
//                groupId = Integer.valueOf(gi);
//            }
//        }
		//--- update user information into the database

        int usersUpdated;

        if(updateProfile) {
            String query = "UPDATE Users SET name=?, surname=?, profile=?, password=?, authtype=? WHERE username=?";
            usersUpdated = dbms.execute(query, firstname, surname, profile, VIA_CAS, CAS_FLAG, username);
        } else {
            String query = "UPDATE Users SET name=?, surname=?, password=?, authtype=? WHERE username=?";
            usersUpdated = dbms.execute(query, firstname, surname, VIA_CAS, CAS_FLAG, username);
        }

		//--- if the user was not found --> add it

//		if (usersUpdated == 0)
//		{
//			int userId = serialFactory.getSerial(dbms, "Users");
//
//			String query = 	"INSERT INTO Users(id, username, name, surname, profile, password, authtype) "+
//						"VALUES(?,?,?,?,?,?,?)";
//
//			dbms.execute(query, userId, username, firstname, surname, profile, VIA_CAS, CAS_FLAG);
//
//            if (groupProvided) {
//                String query2 = "SELECT count(*) as numr FROM UserGroups WHERE groupId=? and userId=?";
//                List list  = dbms.select(query2, groupId, userId).getChildren();
//
//                String count = ((Element) list.get(0)).getChildText("numr");
//
//                 if (count.equals("0")) {
//                     query = "INSERT INTO UserGroups(userId, groupId) "+
//                             "VALUES(?,?)";
//                     dbms.execute(query, userId, groupId);
//
//                 }
//            }
//		}

		dbms.commit();
	}

//    private static String getHeader(HttpServletRequest req, String name, String defValue) {
//
//		String value = req.getHeader(name);
//
//		if (value == null)
//			return defValue;
//
//		if (value.length() == 0)
//			return defValue;
//
//		return value;
//    }



}
