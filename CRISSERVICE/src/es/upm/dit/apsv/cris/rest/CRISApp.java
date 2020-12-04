package es.upm.dit.apsv.cris.rest;

import javax.ws.rs.ApplicationPath;

import org.glassfish.jersey.server.ResourceConfig;

@ApplicationPath("rest")
public class CRISApp extends ResourceConfig {
	public CRISApp() {
		packages("es.upm.dit.apsv.cris.rest");
	}

}
