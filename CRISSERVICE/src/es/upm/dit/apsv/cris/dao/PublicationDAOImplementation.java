package es.upm.dit.apsv.cris.dao;

import java.util.Collection;
import java.util.List;

import org.hibernate.Session;

import es.upm.dit.apsv.cris.model.Publication;
import es.upm.dit.apsv.cris.model.Publication;

public class PublicationDAOImplementation implements PublicationDAO {

	private static PublicationDAOImplementation instance = null;
	private PublicationDAOImplementation() {}
	public static PublicationDAOImplementation getInstance() {
	    if( null == instance ) {
	        instance = new PublicationDAOImplementation();
	    }
	    return instance;
	}
	
	public Publication create( Publication p ) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.save(p);
			session.getTransaction().commit();
		} catch (Exception e) {
		} finally {
			session.close();
		}
		return p;
	}

	public Publication read( String id ) {
		Session session = SessionFactoryService.get().openSession();
		Publication p = null;
		try {
			session.beginTransaction();
			p = session.get(Publication.class, id);
			session.getTransaction().commit();
		} catch (Exception e) {
		} finally {
			session.close();
		}
		return p;
	}

	public Publication update( Publication p ) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(p);
			session.getTransaction().commit();
		} catch (Exception e) {
		} finally {
			session.close();
		}
		return p;
	}

	public Publication delete( Publication p ) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.delete(p);		
			session.getTransaction().commit();
		} catch (Exception e) {
		} finally {
			session.close();
		}
		return p;
	}


	public List<Publication> readAll() {
		Session session = SessionFactoryService.get().openSession();
		List<Publication> ls = null;
		try {
			session.beginTransaction();
			ls = (List<Publication>) session.createQuery("from Publication").list();
			session.getTransaction().commit();
		} catch (Exception e) {
		} finally {
			session.close();
		}
		return ls;
	}
	
}
