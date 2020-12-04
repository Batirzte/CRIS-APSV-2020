package es.upm.dit.apsv.cris.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import es.upm.dit.apsv.cris.dao.ResearcherDAOImplementation;
import es.upm.dit.apsv.cris.model.Researcher;

/**
 * Servlet implementation class CreateResearcherServlet
 */
@WebServlet("/CreateResearcherServlet")
public class CreateResearcherServlet extends HttpServlet {
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
		if ((user != null) && (user.getId().equals("root"))) {
			Researcher n = new Researcher();
			n.setId(request.getParameter("id"));
			n.setName(request.getParameter("name"));
			n.setLastname(request.getParameter("lastname"));
			n.setEmail(request.getParameter("email"));
			n.setPassword(request.getParameter("password"));
			if (null == ResearcherDAOImplementation.getInstance().read(n.getId()))
				ResearcherDAOImplementation.getInstance().create(n);
			response.sendRedirect(request.getContextPath() + "/AdminServlet");
		}
		else {
			request.setAttribute("message", "Invalid user or password");
			getServletContext().getRequestDispatcher("/LoginView.jsp").forward(request, response);
		}
			
			
	}

}
