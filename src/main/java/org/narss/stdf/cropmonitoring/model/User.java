/**
 * 
 */
package org.narss.stdf.cropmonitoring.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;

/**
 * @author akotb
 *
 */

@Entity
@Table(name = "USER_TBL")
public class User {

	@Id
	@GeneratedValue
	@Column(name = "UID")
	private Long id;

	@Column(name = "FNAME")
	@Size(max = 20, min = 3, message = "{user.fname.invalid}")
	private String fname;

	@Column(name = "LNAME")
	@Size(max = 20, min = 3, message = "{user.lname.invalid}")
	private String lname;

	@Column(name = "EMAIL", unique = true)
	@Email(message = "{user.email.invalid}")
	private String email;

	@Column(name = "USERNAME", unique = true)
	@NotNull
	@Size(max = 20, min = 5, message = "{user.username.invalid}")
	private String userName;

	@Column(name = "PASSWORD")
	@Size(max = 20, min = 8, message = "{user.password.invalid}")
	private String password;

	@Column(name = "ROLE")
	private String role;

	@Column(name = "GENDER")
	private String gender;

	@Column(name = "ORGANIZATION")
	private String organization;

	@Override
	public String toString() {
		return "User [id=" + id + ", fname=" + fname + ", lname=" + lname + ", email=" + email + ", userName="
				+ userName + ", password=" + password + ", role=" + role + ", gender=" + gender + ", organization="
				+ organization + "]";
	}

	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the fname
	 */
	public String getFname() {
		return fname;
	}

	/**
	 * @param fname the fname to set
	 */
	public void setFname(String fname) {
		this.fname = fname;
	}

	/**
	 * @return the lname
	 */
	public String getLname() {
		return lname;
	}

	/**
	 * @param lname the lname to set
	 */
	public void setLname(String lname) {
		this.lname = lname;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}

	/**
	 * @param userName the userName to set
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}

	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @return the role
	 */
	public String getRole() {
		return role;
	}

	/**
	 * @param role the role to set
	 */
	public void setRole(String role) {
		this.role = role;
	}

	/**
	 * @return the gender
	 */
	public String getGender() {
		return gender;
	}

	/**
	 * @param gender the gender to set
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}

	/**
	 * @return the organization
	 */
	public String getOrganization() {
		return organization;
	}

	/**
	 * @param organization the organization to set
	 */
	public void setOrganization(String organization) {
		this.organization = organization;
	}

}
