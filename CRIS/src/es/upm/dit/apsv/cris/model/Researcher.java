package es.upm.dit.apsv.cris.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

//import javax.persistence.ElementCollection;
//import javax.persistence.Entity;
//import javax.persistence.FetchType;
//import javax.persistence.Id;

@Entity
public class Researcher implements Serializable {
	
	@Id
	private String id;
	private String name;
	private String lastname;
	@Index
	private String email;
	private String password;
	private String scopusURL;
	
	//@ElementCollection (fetch = FetchType.EAGER)
	private Set<Publication> publications;
	
	public Researcher() {
		super();
		this.publications = new HashSet<Publication>();
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getScopusURL() {
		return scopusURL;
	}
	public void setScopusURL(String scopusURL) {
		this.scopusURL = scopusURL;
	}
	public Set<Publication> getPublications() {
		return publications;
	}
	public void setPublications(Set<Publication> publications) {
		this.publications = publications;
	}

	@Override
	public String toString() {
		return "Researcher [id=" + id + ", name=" + name + ", lastname=" + lastname + ", email=" + email + ", password="
				+ password + ", scopusURL=" + scopusURL + ", publications=" + publications + "]";
	}

	
	
}
