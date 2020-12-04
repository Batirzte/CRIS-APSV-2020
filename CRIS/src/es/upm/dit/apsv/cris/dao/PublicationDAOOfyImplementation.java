package es.upm.dit.apsv.cris.dao;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import es.upm.dit.apsv.cris.model.Publication;


public class PublicationDAOOfyImplementation implements PublicationDAO {

	private static PublicationDAOOfyImplementation instance = null;
	private PublicationDAOOfyImplementation() {}
	public static PublicationDAOOfyImplementation getInstance() {
		if( null == instance ) {
			instance = new PublicationDAOOfyImplementation();
		}
		return instance;
	}
	
	@Override
	public Publication create(Publication publication) {
		ofy().save().entity(publication).now();
		return publication;
	}

	@Override
	public Publication read(String publicationId) {
		Publication p = ofy().load().type(Publication.class).id(publicationId).now();
		return p;
	}

	@Override
	public Publication update(Publication publication) {
		ofy().save().entity(publication).now();
		return publication;
	}

	@Override
	public Publication delete(Publication publication) {
		ofy().delete().entity(publication).now();
		return publication;
	}

	@Override
	public List<Publication> readAll() {
		return ofy().load().type(Publication.class).list();
	}

	
	public List<Publication> parsePublications(Collection<String> ids) {
		return new ArrayList<Publication>(ofy().load().type(Publication.class).ids(ids).values());
	}
}
