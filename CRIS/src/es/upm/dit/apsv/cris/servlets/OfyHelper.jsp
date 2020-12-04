package es.upm.dit.apsv.cris.servlets;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.googlecode.objectify.ObjectifyService;

import es.upm.dit.apsv.cris.model.Publication;
import es.upm.dit.apsv.cris.model.Researcher;

/**
 * Servlet implementation class OfyHelper
 */
@WebListener
public class OfyHelper implements ServletContextListener {
		@Override
		public void contextInitialized(ServletContextEvent event) {
			ObjectifyService.begin();
			ObjectifyService.register(Researcher.class);
			ObjectifyService.register(Publication.class);
		}

		@Override
		public void contextDestroyed(ServletContextEvent sce) { }

}
