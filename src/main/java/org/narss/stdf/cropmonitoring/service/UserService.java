/**
 * 
 */
package org.narss.stdf.cropmonitoring.service;

import java.util.List;

import org.narss.stdf.cropmonitoring.model.User;

/**
 * @author akotb
 *
 */

public interface UserService {

	void save(User user);

	List<User> list();
}
