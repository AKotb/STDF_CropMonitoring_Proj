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
import org.springframework.web.bind.annotation.ModelAttribute;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

/**
 * @author akotb
 *
 */

@Controller
public class HomeController {

	private String PYTHON_INTERPRETER = "C:/Python39/python.exe";
	private String PYTHON_SCRIPT = "C:/Users/Sayed/git/STDF_CropMonitoring_Proj/src/main/resources/try_20-4-2021.py";
	
	@GetMapping("/")
	public String userForm(Locale locale, Model model) {
		return "index";
	}

	@GetMapping("/ndvi")
	public String ndviExcute(@ModelAttribute("polygonCoordinates") String polygonCoordinates, Locale locale, Model model) {
		//int ID = Integer.parseInt(id);
		try {
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			JsonElement je = JsonParser.parseString(polygonCoordinates);
			String polygonCoordinatesJson = gson.toJson(je);
			// Creating the python command.
			String command = PYTHON_INTERPRETER + " " + PYTHON_SCRIPT + " " + gson.toJsonTree(je);

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
				model.addAttribute("imagesrc", line);
			}
			System.out.println("=================== After Python Call=================================");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("line", e.getMessage());
		}
		return "success";
	}
}
