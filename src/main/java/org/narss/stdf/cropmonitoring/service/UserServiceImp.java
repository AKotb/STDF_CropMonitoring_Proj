/**
 * 
 */
package org.narss.stdf.cropmonitoring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.narss.stdf.cropmonitoring.dao.UserDao;
import org.narss.stdf.cropmonitoring.model.User;

/**
 * @author akotb
 *
 */

@Service
public class UserServiceImp implements UserService {

	@Autowired
	private UserDao userDao;

	@Transactional
	public void save(User user) {
		userDao.save(user);
	}

	@Transactional(readOnly = true)
	public List<User> list() {
		return userDao.list();
	}

}
