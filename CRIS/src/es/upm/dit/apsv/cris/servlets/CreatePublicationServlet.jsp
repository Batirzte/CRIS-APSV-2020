package es.upm.dit.apsv.cris.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import es.upm.dit.apsv.cris.dao.PublicationDAOImplementation;
import es.upm.dit.apsv.cris.dao.PublicationDAOOfyImplementation;
import es.upm.dit.apsv.cris.dao.ResearcherDAOImplementation;
import es.upm.dit.apsv.cris.dao.ResearcherDAOOfyImplementation;
import es.upm.dit.apsv.cris.model.Publication;
import es.upm.dit.apsv.cris.model.Researcher;

/**
 * Servlet implementation class CreatePublicationServlet
 */
@WebServlet("/CreatePublicationServlet")
public class CreatePublicationServlet extends HttpServlet {
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
		if ((user != null) && (! user.getId().equals("root")) && (null != ResearcherDAOOfyImplementation.getInstance().read(user.getId()) )) {
			//user = ResearcherDAOImplementation.getInstance().read(user.getId());
			user = ResearcherDAOOfyImplementation.getInstance().read(user.getId());
			Publication p = new Publication();
			p.setId(request.getParameter("id"));
			p.setTitle(request.getParameter("title"));
			p.setPublicationName(request.getParameter("publicationname"));
			p.setPublicationDate(request.getParameter("publicationdate"));
			p.setAuthors(request.getParameter("authors"));
			//if (null == PublicationDAOImplementation.getInstance().read(p.getId())) {
			if (null == PublicationDAOOfyImplementation.getInstance().read(p.getId())) {
				//PublicationDAOImplementation.getInstance().create(p);
				PublicationDAOOfyImplementation.getInstance().create(p);
				user.getPublications().add(p);
				//ResearcherDAOImplementation.getInstance().update(user);
				ResearcherDAOOfyImplementation.getInstance().update(user);
			}
			request.setAttribute ("ri", user);
			request.setAttribute("publications", user.getPublications());
			//request.getSession().setAttribute("user", ResearcherDAOImplementation.getInstance().read(user.getId()));
			request.getSession().setAttribute("user", ResearcherDAOOfyImplementation.getInstance().read(user.getId()));
			getServletContext().getRequestDispatcher("/ResearcherView.jsp").forward(request, response);
		}
		else {
			request.setAttribute("message", "You are not allowed to add Publications");
			getServletContext().getRequestDispatcher("/LoginView.jsp").forward(request, response);
		}

	}

}
