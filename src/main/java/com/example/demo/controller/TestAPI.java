package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestAPI {

	@RequestMapping("/usr/test/APITest")
	@ResponseBody
	public String APITest() {
		
		String result = Example.apiTest();

		return result;
	}

	@RequestMapping("/usr/test/APITest2")
	public String APITest2(Model model) {
		
		String result = ApiExamSearchBlog.naverApi();

		model.addAttribute("result", result);
		
		return "/usr/test/APITest2";
	}

	@RequestMapping("/usr/test/APITest3")
	@ResponseBody
	public String APITest3() {
		
		String result = Example2.apiTest2();

		return result;
	}

	@RequestMapping("/usr/test/APITest4")
	public String APITest4() {

		return "/usr/test/APITest4";
	}
	
	@RequestMapping("/usr/test/APITest5")
	public String APITest5() {
		
		return "/usr/test/APITest5";
	}

	@RequestMapping("/usr/test/AddFindTest")
	public String AddFindTest() {

		return "/usr/test/AddFindTest";
	}

	@RequestMapping("/usr/test/AddFindTest2")
	public String AddFindTest2() {
		
		return "/usr/test/AddFindTest2";
	}
	
	@RequestMapping("/usr/test/weatherApiTest")
	public String weatherApiTest() {

		return "/usr/test/weatherApiTest";
	}
}