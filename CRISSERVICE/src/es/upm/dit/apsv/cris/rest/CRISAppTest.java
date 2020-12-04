package es.upm.dit.apsv.cris.rest;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.glassfish.jersey.client.ClientConfig;

import es.upm.dit.apsv.cris.model.Publication;
import es.upm.dit.apsv.cris.model.Researcher;

public class CRISAppTest {
    private static String baseURI = "http://localhost:8080/CRISSERVICE/rest";
    
    public static WebTarget getWebTarget(String s) {
        ClientConfig config = new ClientConfig();
        Client client = ClientBuilder.newClient(config);       
        return client.target(baseURI + s);     
    }
    
    public static void testResearchersList() {
        WebTarget target = getWebTarget("/Researchers");
        String response = target.request().accept(MediaType.APPLICATION_JSON).get(String.class);    
        System.out.println("testResearchersList() " + response);      
    }
    
    public static void testResearchersGet() {
        WebTarget target = getWebTarget("/Researchers");
        String rid = "01010101";
        Researcher Researcher = target.path(rid)
                    .request().accept(MediaType.APPLICATION_JSON)
                    .get(Researcher.class);
        System.out.println("testResearchersGet() " + Researcher);       
    } 
    
    public static void testResearchersAdd() {
        WebTarget target = getWebTarget("/Researchers");
        Researcher r = new Researcher();
        r.setId("010101012");
        r.setName("Juan Carlos");
        r.setLastname("Dueñas");
        r.setEmail("juancarlos.duenas@upm.es");
        r.setPassword("1234");
        r.setScopusURL("http://www.dit.upm.es");
        Response response = target.request()
                .post(Entity.entity(r, MediaType.APPLICATION_JSON), Response.class);
         
        System.out.println("testResearchersAdd() " + response.getLocation().toString());
    }
    
    public static void testResearchersUpdate() {
        WebTarget target = getWebTarget("/Researchers");
        Researcher r = new Researcher();
        String rid = "010101012";
        r.setId("010101012");
        r.setName("Juan C.");
        r.setLastname("Dueñas");
        r.setEmail("juancarlos.duenas@upm.es");
        r.setPassword("1234");
        r.setScopusURL("http://www.dit.upm.es");
        Response response = target.path(rid).request()
                .post(Entity.entity(r, MediaType.APPLICATION_JSON), Response.class);
        System.out.println("testResearchersUpdate() " + response);      
    }
    
    public  static void testResearchersDelete() {
        WebTarget target = getWebTarget("/Researchers");
        String rid = "010101012";
        Response response = target.path(rid).request()
                .delete(Response.class);
        System.out.println("testResearchersDelete() " + response);      
    }
    
    public static void testPublicationsList() {
        WebTarget target = getWebTarget("/Publications");
        String response = target.request().accept(MediaType.APPLICATION_JSON).get(String.class);    
        System.out.println("testPublicationsList() " + response);      
    }
    
    public static void testPublicationsGet() {
        WebTarget target = getWebTarget("/Publications");
        String rid = "11111111";
        Publication Publication = target.path(rid)
                    .request().accept(MediaType.APPLICATION_JSON)
                    .get(Publication.class);
        System.out.println("testPublicationsGet() " + Publication);       
    } 
    
    public static void testPublicationsAdd() {
        WebTarget target = getWebTarget("/Publications");
        Publication r = new Publication();
        r.setId("11111112");
        r.setTitle("Publication title");
        r.setPublicationName("Journal name");
        r.setPublicationDate("date");
        r.setAuthors("010101012");
        r.setCiteCount(0);
        Response response = target.request()
                .post(Entity.entity(r, MediaType.APPLICATION_JSON), Response.class);
         
        System.out.println("testPublicationsAdd() " + response.getLocation().toString());
    }
    
    public static void testPublicationsUpdate() {
        WebTarget target = getWebTarget("/Publications");
        Publication r = new Publication();
        String rid = "11111112";
        r.setId("11111112");
        r.setTitle("Publication title");
        r.setPublicationName("Journal name");
        r.setPublicationDate("date");
        r.setAuthors("010101012");
        r.setCiteCount(10);
        Response response = target.path(rid).request()
                .post(Entity.entity(r, MediaType.APPLICATION_JSON), Response.class);
        System.out.println("testPublicationsUpdate() " + response);      
    }
    
    public  static void testPublicationsDelete() {
        WebTarget target = getWebTarget("/Publications");
        String rid = "11111112";
        Response response = target.path(rid).request()
                .delete(Response.class);
        System.out.println("testPublicationsDelete() " + response);      
    }
    
    public static void main (String[] args) {
    	testResearchersList();
    	testResearchersGet();
    	testResearchersAdd();
    	testResearchersUpdate();
    	testResearchersDelete();
    	
    	testPublicationsList();
    	testPublicationsGet();
    	testPublicationsAdd();
    	testPublicationsUpdate();
    	testPublicationsDelete();
    }
  
}
