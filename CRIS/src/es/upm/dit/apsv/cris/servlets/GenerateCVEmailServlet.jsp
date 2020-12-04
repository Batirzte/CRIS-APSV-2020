package es.upm.dit.apsv.cris.servlets;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import es.upm.dit.apsv.cris.dao.ResearcherDAO;
import es.upm.dit.apsv.cris.dao.ResearcherDAOOfyImplementation;
import es.upm.dit.apsv.cris.model.Publication;
import es.upm.dit.apsv.cris.model.Researcher;

/**
 * Servlet implementation class GenerateCVEmailServlet
 */
@WebServlet("/GenerateCVEmailServlet")
public class GenerateCVEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Researcher user = (Researcher) (request.getSession().getAttribute("user"));
		if ((user == null) || (! user.getId().equals("root"))) {
			request.setAttribute("message", "Invalid user or password");
			getServletContext().getRequestDispatcher("/LoginView.jsp").forward(request, response);
		}
		ResearcherDAO rdao = ResearcherDAOOfyImplementation.getInstance();
		String id = request.getParameter("id");
		
		Researcher r = rdao.read(id);
		if (r == null) {
			request.setAttribute("message", "Researcher not found " + id);
		}
		else {
			Properties props = new Properties();
			Session session = Session.getDefaultInstance(props, null);
			try {
				Message msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress("root@cris-256318.appspotmail.com", "CRIS System"));
				msg.addRecipient(Message.RecipientType.TO,
						new InternetAddress(r.getEmail(), r.getName()));
				msg.setSubject("Your Curriculum Vitae");
				String text = "";
				for (Publication p : r.getPublications())
					text+= p.getPublicationName() +" " + p.getId() + " ";
				msg.setText(text);
				Transport.send(msg);
			}
			catch (Exception e) {
			} 
		}
		response.sendRedirect(request.getContextPath() + "/AdminServlet");
	}

}
