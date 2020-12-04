package es.upm.dit.apsv.cris.servlets;

import java.io.IOException;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import es.upm.dit.apsv.cris.dao.PublicationDAO;
import es.upm.dit.apsv.cris.dao.PublicationDAOOfyImplementation;
import es.upm.dit.apsv.cris.dao.ResearcherDAO;
import es.upm.dit.apsv.cris.dao.ResearcherDAOOfyImplementation;
import es.upm.dit.apsv.cris.model.Publication;
import es.upm.dit.apsv.cris.model.Researcher;

/**
 * Servlet implementation class CreatePublicationFromEmailServlet
 */
@WebServlet("/_ah/mail/*")
public class CreatePublicationFromEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PublicationDAO pdao = PublicationDAOOfyImplementation.getInstance();
			ResearcherDAO rdao = ResearcherDAOOfyImplementation.getInstance();
			
			Properties props = new Properties();
			Session session = Session.getDefaultInstance(props, null);
			MimeMessage message = new MimeMessage(session, request.getInputStream());
			String researcherEmail = new InternetAddress(message.getFrom()[0].toString()).getAddress();
			
			Researcher r = rdao.readAsUser(researcherEmail, "");
			if(null != r) {
				Publication p = new Publication();
				String[] subject = message.getSubject().split(",");
				p.setId(subject[0]);
				p.setTitle(subject[1]);
				p.setPublicationName(subject[2]);
				p.setPublicationDate(subject[3]);
				p.setAuthors(subject[4]);
				if (null == pdao.read(p.getId())) {
					pdao.create(p);
					r.getPublications().add(p);
					rdao.update(r);
				}
			}
		} catch (MessagingException e) {
		}

	}

}
