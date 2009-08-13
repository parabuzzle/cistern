package org.cistern.log4j.appender;

import org.apache.log4j.Logger;
import org.apache.log4j.LogManager;
import org.cistern.log4j.appender.LogObject;
import org.cistern.log4j.appender.TCPAppender;


public class App 
{
	private static final Logger log = Logger.getLogger("com.yahoo.groups.log4j.cistern");

	
    public static void main( String[] args )
    {
    	//LogObject log = new LogObject("Data Section <<<NAME>>>", "NAME/000/Cistern", "1", "1");
    	//log.setLoglevel_id("3");
    	log.debug("Debug   Message");
    	log.info("Info   Message");
    	log.warn("warn   Message");
    	log.error("error   Message");
    	log.fatal("fatal   Message");
        
        
    }
}
