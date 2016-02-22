package org.fao.geonet.utils;

import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerFactory;
import java.util.Properties;

/**
 * This class is to prevent the situation that rogue applications running in the same JVM as does GeoNetwork can set
 * the System property about XSLT TransformerFactory, and so override GeoNetwork's own definition in a classpath file,
 * causing GeoNetwork to not function.
 *
 *  Class holds a static TransformerFactory that is instantiated from the implementation name in the classpath file
 *  "META-INF/services/javax.xml.transform.TransformerFactory" (or if reading that had failed, from whatever is the
 * current System property).
 *
 * @author heikki doeleman
 */
public class TransformerFactoryFactory {

    private static TransformerFactory factory ;
    private final static String SYSTEM_PROPERTY_NAME = "javax.xml.transform.TransformerFactory";

    public static void init(String implementationName) {
        debug("Implementation name: " + implementationName);
        if(implementationName != null && implementationName.length() > 0) {
            // Code for DIGIT environment (ESTAT).
            // TODO: Solve this with the custom class loader
            Properties props = System.getProperties();
            // remember current system property
            String currentSystemProperty = null;
            if(props.containsKey(SYSTEM_PROPERTY_NAME)) {
                currentSystemProperty = props.getProperty(SYSTEM_PROPERTY_NAME);
                debug("Current system property: " + currentSystemProperty);
            }
            // set system property to what GeoNetwork needs
            props.setProperty(SYSTEM_PROPERTY_NAME, implementationName);
            // use the system property
            factory = TransformerFactory.newInstance();
            // reset the system property to what it was before
            if(currentSystemProperty != null) {
                props.setProperty(SYSTEM_PROPERTY_NAME, currentSystemProperty);
            }
            else {
                props.remove(SYSTEM_PROPERTY_NAME);
            }
            // End - Code for DIGIT environment (ESTAT).

            //factory = TransformerFactory.newInstance(implementationName, null);

        } else {
            factory = TransformerFactory.newInstance();
        }
    }

    public static TransformerFactory getTransformerFactory() throws TransformerConfigurationException {
    	if (factory == null) {
    		debug("TransformerFactoryFactory is null. Initializing ...");
    		init(null);
    	}
        debug("TransformerFactoryFactory: "
        		    + factory.getClass().getName() 
        			+ " produces transformer implementation " 
        			+ factory.newTransformer().getClass().getName());
        return factory;
    }

	private static void debug  (String message) { Log.debug  (Log.TRANSFORMER_FACTORY, message); }

    // used for JUnit testing into Eclipse (which selects an incompatible TransformerFactory)
    public static void setTransformerFactory(TransformerFactory _factory) {
        factory = _factory;
    }
}