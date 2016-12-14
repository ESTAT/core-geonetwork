package org.fao.geonet.utils;

import org.apache.commons.lang.StringUtils;
import org.fao.geonet.exceptions.BadParameterEx;

import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Utility class to validate a file path.
 *
 * @author josegar
 */
public class FilePathChecker {

    /**
     * Checks that a file path is not absolute path and doesn't have .. characters, throwing an exception
     * in these cases.
     *
     * @param filePath
     * @throws Exception
     */
    public static void verify(String filePath) throws Exception {
        if (filePath.contains("..")) {
            throw new BadParameterEx(
                    "Invalid character found in path.",
                    filePath);
        }

        Path path = Paths.get(filePath);
        if (path.isAbsolute() || filePath.startsWith("/") ||
                filePath.startsWith("://", 1))  {
            throw new SecurityException("Wrong filename");
        }
    }
}
