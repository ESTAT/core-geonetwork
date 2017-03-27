How to Deploy
-------------

This instructions are based on https://webgate.ec.europa.eu/CITnet/confluence/display/IAM/ECAS+Tomcat+Client .

To deploy GeoNetwork with the ECAS authentication enabled, you should use the Tomcat provided by the European Commission. On this case, we are using a Tomcat version 8.0.28 running over Java jdk1.8.0_66. On this installation of Tomcat you have to add two files to the lib folder (`tomcat/lib`): `ecas-tomcat-8.0-4.13.0.jar` and `log4j-1.2.17.jar`. Inside this same folder (`lib`) you have to create two other folders more: `org/apache/catalina/authenticator` and `org/apache/catalina/startup`.

On the folder `lib/org/apache/catalina/authenticator` you have to create a file called `mbeans-descriptors.xml` with the following content:

```
<?xml version="1.0"?>
<mbeans-descriptors>

  <mbean name="BasicAuthenticator"
         description="An Authenticator and Valve implementation of HTTP BASIC Authentication"
         domain="Catalina"
         group="Valve"
         type="org.apache.catalina.authenticator.BasicAuthenticator">
    
    <attribute name="alwaysUseSession"
               description="Should a session always be used once a user is authenticated?"
               type="boolean"/>
      
    <attribute name="cache"
               description="Should we cache authenticated Principals if the request is part of an HTTP session?"
               type="boolean"/>
      
    <attribute name="changeSessionIdOnAuthentication"
               description="Controls if the session ID is changed if a session exists at the point where users are authenticated"
               type="boolean"/>
      
    <attribute name="className"
               description="Fully qualified class name of the managed object"
               type="java.lang.String"
               writeable="false"/>
      
    <attribute name="disableProxyCaching"
               description="Controls the caching of pages that are protected by security constraints"
               type="boolean"/>
      
    <attribute name="securePagesWithPragma"
               description="Controls the caching of pages that are protected by security constraints"
               type="boolean"/>
      
    <attribute name="secureRandomAlgorithm"
               description="The name of the algorithm to use for SSO session ID generation"
               type="java.lang.String"/>
      
    <attribute name="secureRandomClass"
               description="The name of the class to use for SSO session ID generation"
               type="java.lang.String"/>
      
    <attribute name="secureRandomProvider"
               description="The name of the provider to use for SSO session ID generation"
               type="java.lang.String"/>
      
    <attribute name="stateName"
               description="The name of the LifecycleState that this component is currently in"
               type="java.lang.String"
               writeable="false"/>
  </mbean>
  
  
  <mbean name="DigestAuthenticator"
         description="An Authenticator and Valve implementation of HTTP DIGEST Authentication"
         domain="Catalina"
         group="Valve"
         type="org.apache.catalina.authenticator.DigestAuthenticator">
    
    <attribute name="alwaysUseSession"
               description="Should a session always be used once a user is authenticated?"
               type="boolean"/>
      
    <attribute name="cache"
               description="Should we cache authenticated Principals if the request is part of an HTTP session?"
               type="boolean"/>

    <attribute name="changeSessionIdOnAuthentication"
               description="Controls if the session ID is changed if a session exists at the point where users are authenticated"
               type="boolean"/>
      
    <attribute name="className"
               description="Fully qualified class name of the managed object"
               type="java.lang.String"
               writeable="false"/>
      
    <attribute name="cnonceCacheSize"
               description="The size of the cnonce cache used to prevent replay attacks"
               type="int"/>
      
    <attribute name="disableProxyCaching"
               description="Controls the caching of pages that are protected by security constraints"
               type="boolean"/>
      
    <attribute name="key"
               description="The secret key used by digest authentication"
               type="java.lang.String"/>
      
    <attribute name="nonceValidity"
               description="The time, in milliseconds, for which a server issued nonce will be valid"
               type="long"/>

    <attribute name="opaque"
               description="The opaque server string used by digest authentication"
               type="java.lang.String"/>
      
    <attribute name="securePagesWithPragma"
               description="Controls the caching of pages that are protected by security constraints"
               type="boolean"/>
      
    <attribute name="secureRandomAlgorithm"
               description="The name of the algorithm to use for SSO session ID generation"
               type="java.lang.String"/>
      
    <attribute name="secureRandomClass"
               description="The name of the class to use for SSO session ID generation"
               type="java.lang.String"/>
      
    <attribute name="secureRandomProvider"
               description="The name of the provider to use for SSO session ID generation"
               type="java.lang.String"/>
      
    <attribute name="stateName"
               description="The name of the LifecycleState that this component is currently in"
               type="java.lang.String"
               writeable="false"/>

    <attribute name="validateUri"
               description="Should the uri be validated as required by RFC2617?"
               type="boolean"/>
  </mbean>
  
  <mbean name="FormAuthenticator"
         description="An Authenticator and Valve implementation of FORM BASED Authentication"
         domain="Catalina"
         group="Valve"
         type="org.apache.catalina.authenticator.FormAuthenticator">
    
    <attribute name="changeSessionIdOnAuthentication"
               description="Controls if the session ID is changed if a session exists at the point where users are authenticated"
               type="boolean"/>

    <attribute name="characterEncoding"
               description="Character encoding to use to read the username and password parameters from the request"
               type="java.lang.String"/>

    <attribute name="className"
               description="Fully qualified class name of the managed object"
               type="java.lang.String"
               writeable="false"/>

    <attribute name="disableProxyCaching"
               description="Controls the caching of pages that are protected by security constraints"
               type="boolean"/>
      
    <attribute name="landingPage"
               description="Controls the behavior of the FORM authentication process if the process is misused, for example by directly requesting the login page or delaying logging in for so long that the session expires"
               type="java.lang.String"/>

    <attribute name="securePagesWithPragma"
               description="Controls the caching of pages that are protected by security constraints"
               type="boolean"/>
      
    <attribute name="secureRandomAlgorithm"
               description="The name of the algorithm to use for SSO session ID generation"
               type="java.lang.String"/>
      
    <attribute name="secureRandomClass"
               description="The name of the class to use for SSO session ID generation"
               type="java.lang.String"/>
      
    <attribute name="secureRandomProvider"
               description="The name of the provider to use for SSO session ID generation"
               type="java.lang.String"/>
      
    <attribute name="stateName"
               description="The name of the LifecycleState that this component is currently in"
               type="java.lang.String"
               writeable="false"/>
  </mbean>
  
  <mbean name="NonLoginAuthenticator"
         description="An Authenticator and Valve implementation that checks only security constraints not involving user authentication"
         domain="Catalina"
         group="Valve"
         type="org.apache.catalina.authenticator.NonLoginAuthenticator">
    
    <attribute name="cache"
               description="Should we cache authenticated Principals if the request is part of an HTTP session?"
               type="boolean"/>
      
    <attribute name="changeSessionIdOnAuthentication"
               description="Controls if the session ID is changed if a session exists at the point where users are authenticated"
               type="boolean"/>

    <attribute name="className"
               description="Fully qualified class name of the managed object"
               type="java.lang.String"
               writeable="false"/>

    <attribute name="disableProxyCaching"
               description="Controls the caching of pages that are protected by security constraints"
               type="boolean"/>
      
    <attribute name="securePagesWithPragma"
               description="Controls the caching of pages that are protected by security constraints"
               type="boolean"/>
      
    <attribute name="stateName"
               description="The name of the LifecycleState that this component is currently in"
               type="java.lang.String"
               writeable="false"/>
  </mbean>
  
  
  <mbean name="SingleSignOn"
         description="A Valve that supports a 'single signon' user experience"
         domain="Catalina"
         group="Valve"
         type="org.apache.catalina.authenticator.SingleSignOn">
    
    <attribute name="className"
               description="Fully qualified class name of the managed object"
               type="java.lang.String"
               writeable="false"/>
      
    <attribute name="requireReauthentication"
               description="Should we attempt to reauthenticate each request against the security Realm?"
               type="boolean"/>

    <attribute name="cookieDomain"
               description="(Optiona) Domain to be used by sso cookies"
               type="java.lang.String" />

    <attribute name="stateName"
               description="The name of the LifecycleState that this component is currently in"
               type="java.lang.String"
               writeable="false"/>
  </mbean>


  <mbean name="SSLAuthenticator"
         description="An Authenticator and Valve implementation of authentication that utilizes SSL certificates to identify client users"
         domain="Catalina"
         group="Valve"
         type="org.apache.catalina.authenticator.SSLAuthenticator">

    <attribute name="cache"
               description="Should we cache authenticated Principals if the request is part of an HTTP session?"
               type="boolean"/>

    <attribute name="changeSessionIdOnAuthentication"
               description="Controls if the session ID is changed if a session exists at the point where users are authenticated"
               type="boolean"/>

    <attribute name="className"
               description="Fully qualified class name of the managed object"
               type="java.lang.String"
               writeable="false"/>

    <attribute name="disableProxyCaching"
               description="Controls the caching of pages that are protected by security constraints"
               type="boolean"/>
      
    <attribute name="securePagesWithPragma"
               description="Controls the caching of pages that are protected by security constraints"
               type="boolean"/>
      
    <attribute name="secureRandomAlgorithm"
               description="The name of the algorithm to use for SSO session ID generation"
               type="java.lang.String"/>
      
    <attribute name="secureRandomClass"
               description="The name of the class to use for SSO session ID generation"
               type="java.lang.String"/>
      
    <attribute name="secureRandomProvider"
               description="The name of the provider to use for SSO session ID generation"
               type="java.lang.String"/>
      
    <attribute name="stateName"
               description="The name of the LifecycleState that this component is currently in"
               type="java.lang.String"
               writeable="false"/>
  </mbean>
  
<mbean name="EcasAuthenticator"
       description="An Authenticator and Valve implementation using ECAS for Authentication"
       domain="Catalina"
       group="Valve"
       type="eu.cec.digit.ecas.client.j2ee.tomcat.EcasAuthenticator">

    <attribute name="algorithm"
               description="The message digest algorithm to be used when generating session identifiers"
               type="java.lang.String"/>

    <attribute name="cache"
               description="Should we cache authenticated Principals if the request is part of an HTTP session?"
               type="boolean"/>

    <attribute name="className"
               description="Fully qualified class name of the managed object"
               type="java.lang.String"
               writeable="false"/>

    <attribute name="debug"
               description="The debugging detail level for this component"
               type="int"/>

    <attribute name="entropy"
               description="A String initialization parameter used to increase the  entropy of the initialization of our random number generator"
               type="java.lang.String"/>

    <attribute name="stateName"
               description="The name of the LifecycleState that this component is currently in"
               type="java.lang.String"/>

    <attribute name="loginUrl"
               description="ECAS server login URL"
               type="java.lang.String"/>

    <attribute name="validateUrl"
               description="ECAS server validate URL"
               type="java.lang.String"/>

    <attribute name="serverName"
               description="Local server name (e.g. hostname without port)"
               type="java.lang.String"/>

    <attribute name="serviceUrl"
               description="Local service URL (optional)"
               type="java.lang.String"/>

    <attribute name="renew"
               description="Renew parameter to always force renewal of authentication (no SSO)"
               type="java.lang.String"/>

    <attribute name="authorizedProxy"
               description="Single authorized ECAS proxy"
               type="java.lang.String"/>

    <attribute name="acceptStrengths"
               description="Comma-separated list of accepted strengths"
               type="java.lang.String"/>

    <attribute name="applicationServer"
               description="Type of Application Server (i.e. tomcat)"
               type="java.lang.String"/>

    <attribute name="authorizedProxies"
               description="Comma-separated list of authorized ECAS proxies"
               type="java.lang.String"/>

    <attribute name="groups"
               description="Comma-separated list of groups you ask ECAS to return"
               type="java.lang.String"/>

    <attribute name="proxyCallbackUrl"
               description="Callback URL where ECAS server will connect to, for ECAS proxies"
               type="java.lang.String"/>

    <attribute name="proxyChainTrustHandler"
               description="ProxyChainTrustHandler implementing class, for ECAS proxies"
               type="java.lang.String"/>

    <attribute name="serverPort"
               description="Local server port (optional)"
               type="java.lang.String"/>

    <attribute name="serverSSLPort"
               description="Local server SSL port (optional)"
               type="java.lang.String"/>

    <attribute name="maxConnections"
               description="Maximum SSL connections in the SSL Connection Pool (default=2)"
               type="java.lang.String"/>

    <attribute name="connectionTimeout"
               description="SSL connections timeout in milliseconds (default=180000)"
               type="java.lang.String"/>

    <attribute name="strictSSLHostnameVerification"
               description="Must we use strict SSL hostname verification [true|false] (default=false)"
               type="java.lang.String"/>

    <attribute name="extraGroupHandler"
               description="ExtraGroupHandler implementing class, to add external groups"
               type="java.lang.String"/>

    <attribute name="errorPage"
               description="Error page to redirect to"
               type="java.lang.String"/>
</mbean>
</mbeans-descriptors>

```

On the folder `lib/org/apache/catalina/startup `you have to create a file called `Authenticators.properties` with the following content:

```
#
# ECAS Software
# Copyright (c) 2012 European Commission
# Licensed under the EUPL
# You may not use this work except in compliance with the Licence.
# You may obtain a copy of the Licence at:
# http://ec.europa.eu/idabc/eupl
#
# This product includes the CAS software developed by Yale University,
# Copyright (c) 2000-2004 Yale University. All rights reserved.
# THE CAS SOFTWARE IS PROVIDED "AS IS," AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ARE EXPRESSLY
# DISCLAIMED. IN NO EVENT SHALL YALE UNIVERSITY OR ITS EMPLOYEES BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED, THE COSTS OF
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED IN ADVANCE OF THE POSSIBILITY OF SUCH
# DAMAGE.
#

BASIC=org.apache.catalina.authenticator.BasicAuthenticator
CLIENT-CERT=org.apache.catalina.authenticator.SSLAuthenticator
DIGEST=org.apache.catalina.authenticator.DigestAuthenticator
FORM=org.apache.catalina.authenticator.FormAuthenticator
NONE=org.apache.catalina.authenticator.NonLoginAuthenticator
SPNEGO=org.apache.catalina.authenticator.SpnegoAuthenticator
ECAS=eu.cec.digit.ecas.client.j2ee.tomcat.EcasAuthenticator
```

Finally, make sure your jdk trusts the ECAS certificates. Download them from https://webgate.ec.europa.eu/CITnet/confluence/display/IAM/Downloads-Certificates and import them on the keystore of your JVM or specific certstore for Tomcat (see https://tomcat.apache.org/tomcat-8.0-doc/ssl-howto.html).

To import in the JVM certstore:

```
$ keytool -import -v -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -alias EuropeanCommissionRootCA -file EuropeanCommissionRootCA.cer

$ keytool -import -v -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -alias CommisSignClassA -file CommisSignClassA.cer
```

Now you can run GeoNetwork on this Tomcat and it will use ECAS authentication based on the Tomcat configuration.
