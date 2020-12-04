package es.upm.dit.apsv.cris.dataset;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import es.upm.dit.apsv.cris.dao.PublicationDAO;
import es.upm.dit.apsv.cris.dao.PublicationDAOImplementation;
import es.upm.dit.apsv.cris.dao.ResearcherDAO;
import es.upm.dit.apsv.cris.dao.ResearcherDAOImplementation;
import es.upm.dit.apsv.cris.model.Publication;
import es.upm.dit.apsv.cris.model.Researcher;

public class CSV2DB {

	/**
	 * args[0] should contains authors csv path. 
	 * Authors csv should have the following structure "AuthorId;Name;lName;Affiliation"
	 * 
	 * args[1] should contains publications csv path. 
	 * Publications csv should have the following structure "PublicationId;PublicationName;CiteCount;Auth1,Auth2,..."
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {

		final String EXPECTED_HEADER1 = "id,name,lastName,scopusUrl,eid";

		String f1 = args.length >1 ? args[0] : "researchers.csv";
		String f2 = args.length >2 ? args[1] : "publications.csv";
		final ResearcherDAO rdao = ResearcherDAOImplementation.getInstance();
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(new File(f1)), "UTF8"));
		String line = br.readLine();
		int i = 0;
		if (EXPECTED_HEADER1.equals(line)){
			while (null != (line = br.readLine())) {
				String[] s = line.split(",");
				Researcher r = new Researcher();
				r.setId(s[0]);
				r.setName(s[1]);
				r.setLastname(s[2]);
				r.setEmail(s[0]);
				r.setScopusURL(s[3]);
				r.setPassword("1234");
				if (null == rdao.read(r.getId())) {
					rdao.create(r);
					i++;
					System.out.println(i);
				}
			}
		}
		br.close();

		
		final String EXPECTED_HEADER2 = "id,title,eid,publicationName,publicationDate,firstAuthor,authors";
		PublicationDAO pdao = PublicationDAOImplementation.getInstance();

		br = new BufferedReader(new InputStreamReader(new FileInputStream(new File(f2)), "UTF8"));
		
		line = br.readLine();
		i = 0;
		if (EXPECTED_HEADER2.equals(line)) {
			while (null != (line = br.readLine())) {
				String[] s = line.split(",");
				Publication p = new Publication();
				p.setId(s[0]);
				p.setTitle(s[1]);
				p.setPublicationName(s[3]);
				p.setPublicationDate(s[4]);
				p.setAuthors(s[6]);
				if (null == pdao.read(p.getId())) 
					pdao.create(p);
					i++;
			}
		}
		br.close();
	}
}
