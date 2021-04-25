/**
 * 
 */
package org.narss.stdf.cropmonitoring.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @author akotb
 *
 */

@Controller
public class HomeController {

	private String PYTHON_INTERPRETER = "C:/Users/akotb/AppData/Local/Programs/Python/Python39/python.exe";
	private String PYTHON_SCRIPT = "C:/Users/akotb/eclipse-workspace/STDF_CropMonitoring_Proj/src/main/resources/test.py";
	
	@GetMapping("/")
	public String userForm(Locale locale, Model model) {
		return "home";
	}

	@GetMapping("/ndvi")
	public String ndviExcute(Locale locale, Model model) {
		System.out.println("=================== Before Python Call=================================");
		try {
			// Creating the python command.
			String command = PYTHON_INTERPRETER + " " + PYTHON_SCRIPT;

			System.out.println("Python Command: " + command);

			// Executing the python command.
			ProcessBuilder builder = new ProcessBuilder("cmd.exe", "/c", command);
			builder.redirectErrorStream(true);
			Process p = builder.start();

			// Reads output of the python code.
			BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
			String line;
			while (true) {
				line = r.readLine();
				if (line == null) {
					break;
				}
				model.addAttribute("line", line);
			}
			System.out.println("=================== After Python Call=================================");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("line", e.getMessage());
		}
		return "success";
	}
}
