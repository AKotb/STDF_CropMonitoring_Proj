/**
 * 
 */
package org.narss.stdf.cropmonitoring.controller;

import java.util.Locale;

import javax.validation.Valid;

import org.narss.stdf.cropmonitoring.model.User;
import org.narss.stdf.cropmonitoring.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * @author akotb
 *
 */
@Controller
public class UserController {

	/*@Autowired
	private UserService userService;

	@GetMapping("/manageusers")
	public String userForm(Locale locale, Model model) {
		model.addAttribute("user", new User());
		model.addAttribute("users", userService.list());
		return "manageusers";
	}

	@PostMapping("/saveuser")
	public String saveUser(@ModelAttribute("user") @Valid User user, BindingResult result, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("users", userService.list());
			return "manageusers";
		}
		userService.save(user);
		return "redirect:/manageusers";
	}*/
}
