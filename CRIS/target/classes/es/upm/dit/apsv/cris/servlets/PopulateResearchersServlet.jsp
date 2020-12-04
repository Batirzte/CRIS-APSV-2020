package es.upm.dit.apsv.cris.servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import es.upm.dit.apsv.cris.dao.ResearcherDAO;
import es.upm.dit.apsv.cris.dao.ResearcherDAOOfyImplementation;
import es.upm.dit.apsv.cris.model.Researcher;

/**
 * Servlet implementation class PopulateResearchersServlet
 */
@MultipartConfig
@WebServlet("/PopulateResearchersServlet")
public class PopulateResearchersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	final String EXPECTED_HEADER = "id,name,lastName,scopusUrl,eid";

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Researcher user = (Researcher) (request.getSession().getAttribute("user"));
		if ((user == null) || (! user.getId().equals("root"))) {
			request.setAttribute("message", "Invalid user or password");
			getServletContext().getRequestDispatcher("/LoginView.jsp").forward(request, response);
		}
		ResearcherDAO rdao = ResearcherDAOOfyImplementation.getInstance();

		Part filePart = request.getPart("file");
		InputStream fileContent = filePart.getInputStream();
		BufferedReader bReader = new BufferedReader(new InputStreamReader(fileContent, "UTF8"));
		String line = bReader.readLine();
		int i = 0;
		if (EXPECTED_HEADER.equals(line))
			while (null != (line = bReader.readLine())) {
				String[] lSplit = line.split(",");
				Researcher r = new Researcher();
				r.setId(lSplit[0]);
				r.setName(lSplit[1]);
				r.setLastname(lSplit[2]);
				r.setScopusURL(lSplit[3]);
				r.setEmail(lSplit[0]);
				if (null == rdao.read(r.getId())) {
					rdao.create(r);
					i++;
				}
			}

		bReader.close();
		request.setAttribute("message", i + " researchers inserted");
		response.sendRedirect(request.getContextPath() + "/AdminServlet");
	}
}
