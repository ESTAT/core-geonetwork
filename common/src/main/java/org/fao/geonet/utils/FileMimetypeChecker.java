//=============================================================================
//===	Copyright (C) 2001-2005 Food and Agriculture Organization of the
//===	United Nations (FAO-UN), United Nations World Food Programme (WFP)
//===	and United Nations Environment Programme (UNEP)
//===
//===	This library is free software; you can redistribute it and/or
//===	modify it under the terms of the GNU Lesser General Public
//===	License as published by the Free Software Foundation; either
//===	version 2.1 of the License, or (at your option) any later version.
//===
//===	This library is distributed in the hope that it will be useful,
//===	but WITHOUT ANY WARRANTY; without even the implied warranty of
//===	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
//===	Lesser General Public License for more details.
//===
//===	You should have received a copy of the GNU Lesser General Public
//===	License along with this library; if not, write to the Free Software
//===	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
//===
//===	Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
//===	Rome - Italy. email: GeoNetwork@fao.org
//==============================================================================

package org.fao.geonet.utils;

import org.apache.tika.Tika;
import org.fao.geonet.exceptions.FileUploadInvalidTypeEx;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

/**
 * Utility class to validate a file mimetype.
 *
 * @author josegar
 */
public class FileMimetypeChecker {

    /**
     * Checks the file mimetype is valid from a list of allowed mime types. If not valid throws an exception.
     *
     * @param file
     * @throws Exception
     */
    public static void verify(InputStream inputStream, List<String> allowedMimetypes) throws IOException {
        String type = new Tika().detect(inputStream);

        if (!allowedMimetypes.contains(type)) {
            throw new FileUploadInvalidTypeEx();

        }
    }

    /**
     * Checks the file mimetype is valid from a list of allowed mime types. If not valid throws an exception.
     *
     * @param file
     * @throws Exception
     */
    public static void verify(Path file, List<String> allowedMimetypes) throws IOException {
        if (!Files.exists(file)) return;

        String type = new Tika().detect(file);

        if (!allowedMimetypes.contains(type)) {
            throw new FileUploadInvalidTypeEx();

        }
    }

    /**
     * Checks the file mimetype is not an invalid one from a list of non allowed mime types. If not valid throws an exception.
     *
     * @param file
     * @throws Exception
     */
    public static void verifyNotInvalid(Path file, List<String> invalidMimetypes) throws IOException {
        if (!Files.exists(file)) return;

        String type = new Tika().detect(file);

        if (invalidMimetypes.contains(type)) {
            throw new FileUploadInvalidTypeEx();

        }
    }

    /**
     * Checks the inputStream mimetype is not an invalid one from a list of non allowed mime types.
     * If not valid throws an exception.
     *
     * @param inputStream
     * @throws Exception
     */
    public static void verifyNotInvalid(InputStream inputStream, List<String> invalidMimetypes) throws IOException {

        String type = new Tika().detect(inputStream);

        if (invalidMimetypes.contains(type)) {
            throw new FileUploadInvalidTypeEx();
        }
    }
}
