package es.upm.dit.apsv.cris.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.google.cloud.pubsub.v1.stub.GrpcSubscriberStub;
import com.google.cloud.pubsub.v1.stub.SubscriberStub;
import com.google.cloud.pubsub.v1.stub.SubscriberStubSettings;
import com.google.pubsub.v1.AcknowledgeRequest;
import com.google.pubsub.v1.ProjectSubscriptionName;
import com.google.pubsub.v1.PullRequest;
import com.google.pubsub.v1.PullResponse;
import com.google.pubsub.v1.ReceivedMessage;

import es.upm.dit.apsv.cris.dao.PublicationDAO;
import es.upm.dit.apsv.cris.dao.PublicationDAOOfyImplementation;
import es.upm.dit.apsv.cris.dao.ResearcherDAO;
import es.upm.dit.apsv.cris.dao.ResearcherDAOOfyImplementation;
import es.upm.dit.apsv.cris.model.Publication;
import es.upm.dit.apsv.cris.model.Researcher;

/**
 * Servlet implementation class UpdatePublicationsQueueServlet
 */
@WebServlet("/UpdatePublicationsQueueServlet")
public class UpdatePublicationsQueueServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		ResearcherDAO rdao = ResearcherDAOOfyImplementation.getInstance();
		try {
		if ((id != null) && !(id.equals("")) && (null != rdao.read(id))) {
			Researcher researcher = rdao.read(id);
			PublicationDAO pdao = PublicationDAOOfyImplementation.getInstance();
			SubscriberStubSettings subscriberStubSettings = SubscriberStubSettings.newBuilder().build();
			SubscriberStub subscriber = GrpcSubscriberStub.create(subscriberStubSettings);
			String subscriptionName = ProjectSubscriptionName.format("cris-256318","cris");
			PullRequest pullRequest = PullRequest.newBuilder()
					.setMaxMessages(100)
					.setReturnImmediately(true)
					.setSubscription(subscriptionName)
					.build();

			PullResponse pullResponse = subscriber.pullCallable().call(pullRequest);
			List<String> ackIds = new ArrayList<String>();
			for (ReceivedMessage message : pullResponse.getReceivedMessagesList()) {
					JSONObject jsonPublication = (JSONObject) new JSONParser().parse(
							message.getMessage().getData().toStringUtf8());
					if (null != pdao.read((String) jsonPublication.get("id")))
						continue;
					Publication publication = new Publication();
					publication.setId((String) jsonPublication.get("id"));
					publication.setTitle((String) jsonPublication.get("title"));
					publication.setPublicationName((String) jsonPublication.get("publicationName"));
					publication.setPublicationDate((String) jsonPublication.get("publicationDate"));
					publication.setAuthors((String) jsonPublication.get("authors"));

					Researcher r2 = rdao.read((String) jsonPublication.get("firstAuthor"));
					if ((r2 != null) && (r2.getId().equals(researcher.getId()))) {
						pdao.create(publication);
						r2.getPublications().add(publication);
						rdao.update(r2);
						ackIds.add(message.getAckId());
					}
			}
			
			if(!ackIds.isEmpty()) {
				AcknowledgeRequest acknowledgeRequest = AcknowledgeRequest.newBuilder()
						.setSubscription(subscriptionName)
						.addAllAckIds(ackIds)
						.build();
				subscriber.acknowledgeCallable().call(acknowledgeRequest);
			}
		}
		} catch(Exception e) {}
		response.sendRedirect(request.getContextPath() + "/ResearcherServlet?id=" + request.getParameter("id"));
	}
}
