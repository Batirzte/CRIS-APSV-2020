package es.upm.dit.apsv.cris.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import es.upm.dit.apsv.cris.dao.ResearcherDAO;
import es.upm.dit.apsv.cris.dao.ResearcherDAOOfyImplementation;
import es.upm.dit.apsv.cris.model.Researcher;

/**
 * Servlet implementation class ResearcherServlet
 */
@WebServlet("/ResearcherServlet")
public class ResearcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResearcherServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = (String) request.getParameter("id");
//		ResearcherDAO rdao = ResearcherDAOImplementation.getInstance();
		ResearcherDAO rdao = ResearcherDAOOfyImplementation.getInstance();
		Researcher ri = rdao.read(id);
		request.setAttribute ("ri", ri);
		request.setAttribute ("publications", (ri != null) ? ri.getPublications() : null);
		getServletContext().getRequestDispatcher("/ResearcherView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
