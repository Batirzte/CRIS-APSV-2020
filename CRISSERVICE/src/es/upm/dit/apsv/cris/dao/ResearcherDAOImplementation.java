package es.upm.dit.apsv.cris.dao;

import java.util.Collection;
import java.util.List;

import org.hibernate.Session;

import es.upm.dit.apsv.cris.model.Researcher;

public class ResearcherDAOImplementation implements ResearcherDAO {

	private static ResearcherDAOImplementation instance = null;
	private ResearcherDAOImplementation() {}
	public static ResearcherDAOImplementation getInstance() {
		if( null == instance ) {
			instance = new ResearcherDAOImplementation();
		}
		return instance;
	}

	public Researcher create( Researcher r ) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.save(r);
			session.getTransaction().commit();
		} catch (Exception e) {
		} finally {
			session.close();
		}
		return r;
	}

	public Researcher read( String id ) {
		Session session = SessionFactoryService.get().openSession();
		Researcher r = null;
		try {
			session.beginTransaction();
			r = session.get(Researcher.class, id);
			session.getTransaction().commit();
		} catch (Exception e) {
		} finally {
			session.close();
		}
		return r;
	}

	public Researcher update( Researcher r ) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(r);
			session.getTransaction().commit();
		} catch (Exception e) {
		} finally {
			session.close();
		}
		return r;
	}

	public Researcher delete( Researcher r ) {
		Session session = SessionFactoryService.get().openSession();
		try {
			session.beginTransaction();
			session.delete(r);		
			session.getTransaction().commit();
		} catch (Exception e) {
		} finally {
			session.close();
		}
		return r;
	}


	public List<Researcher> readAll() {
		Session session = SessionFactoryService.get().openSession();
		List<Researcher> ls = null;
		try {
			session.beginTransaction();
			ls = (List<Researcher>) session.createQuery("from Researcher").list();
			session.getTransaction().commit();
		} catch (Exception e) {
		} finally {
			session.close();
		}
		return ls;
	}

	public Researcher readAsUser(String email, String password) {
		Session session = SessionFactoryService.get().openSession();
		Researcher r = null;
		try {
			session.beginTransaction();
			r = (Researcher) session
			        .createQuery("select r from Researcher r where r.email= :email and r.password = :password")
			        .setParameter("email", email)
			        .setParameter("password", password)
			        .uniqueResult();
			session.getTransaction().commit();
		} catch (Exception e) {
		} finally {
			session.close();
		}
		return r;
	}

}
