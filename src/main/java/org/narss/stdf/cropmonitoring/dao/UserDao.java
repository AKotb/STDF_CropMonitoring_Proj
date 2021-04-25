/**
 * 
 */
package org.narss.stdf.cropmonitoring.dao;

import java.util.List;

import org.narss.stdf.cropmonitoring.model.User;

/**
 * @author akotb
 *
 */

public interface UserDao {

	void save(User user);

	List<User> list();
}
