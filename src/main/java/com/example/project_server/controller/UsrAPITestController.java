package com.example.project_server.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrAPITestController {

	@RequestMapping("/usr/home/APITest")
	public String showAPITest() {
		return "/usr/home/APITest";
	}

	@RequestMapping("/usr/home/APITest2")
	public String showAPITest2() {
		return "/usr/home/APITest2";
	}

}