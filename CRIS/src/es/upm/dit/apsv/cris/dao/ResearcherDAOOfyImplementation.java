package es.upm.dit.apsv.cris.dao;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import es.upm.dit.apsv.cris.model.Researcher;

public class ResearcherDAOOfyImplementation implements ResearcherDAO {

	private static ResearcherDAOOfyImplementation instance = null;
	private ResearcherDAOOfyImplementation() {}
	public static ResearcherDAOOfyImplementation getInstance() {
		if( null == instance ) {
			instance = new ResearcherDAOOfyImplementation();
		}
		return instance;
	}

	@Override
	public Researcher create(Researcher researcher) {
		ofy().save().entity(researcher).now();
		return researcher;
	}

	@Override
	public Researcher read(String researcherId) {
		return ofy().load().type(Researcher.class).id(researcherId).now();
	}

	@Override
	public Researcher update(Researcher researcher) {
		ofy().save().entity(researcher).now();
		return researcher;
	}

	@Override
	public Researcher delete(Researcher researcher) {
		ofy().delete().entity(researcher).now();
		return researcher;
	}

	@Override
	public List<Researcher> readAll() {
		return (List<Researcher>) ofy().load().type(Researcher.class).list();
	}

	public List<Researcher> parseResearchers(Collection<String> ids) {
		return new ArrayList<Researcher>(ofy().load().type(Researcher.class).ids(ids).values());
	}

	@Override
	public Researcher readAsUser(String email, String password) {
		return ofy().load().type(Researcher.class).filter("email", email).first().now();
	}

}
