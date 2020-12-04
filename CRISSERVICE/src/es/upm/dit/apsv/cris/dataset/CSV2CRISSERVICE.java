package es.upm.dit.apsv.cris.dataset;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.glassfish.jersey.client.ClientConfig;

import es.upm.dit.apsv.cris.model.Publication;
import es.upm.dit.apsv.cris.model.Researcher;

public class CSV2CRISSERVICE {

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
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(new File(f1)), "UTF8"));
		String line = br.readLine();
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
				ClientBuilder.newClient(new ClientConfig())
					.target("http://localhost:8080/CRISSERVICE/rest/Researchers").request()
					.post(Entity.entity(r, MediaType.APPLICATION_JSON), Response.class);
			}
		}
		br.close();

		final String EXPECTED_HEADER2 = "id,title,eid,publicationName,publicationDate,firstAuthor,authors";
		br = new BufferedReader(new InputStreamReader(new FileInputStream(new File(f2)), "UTF8"));	
		line = br.readLine();
		if (EXPECTED_HEADER2.equals(line)) {
			while (null != (line = br.readLine())) {
				String[] s = line.split(",");
				Publication p = new Publication();
				p.setId(s[0]);
				p.setTitle(s[1]);
				p.setPublicationName(s[3]);
				p.setPublicationDate(s[4]);
				p.setAuthors(s[6]);
		        ClientBuilder.newClient(new ClientConfig())
		        	.target("http://localhost:8080/CRISSERVICE/rest/Publications").request()
		            .post(Entity.entity(p, MediaType.APPLICATION_JSON), Response.class);
			}
		}
		br.close();
	}
}
