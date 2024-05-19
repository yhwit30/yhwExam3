package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrArticleController {
	
	@Autowired
	private ArticleService articleService;
	

	@RequestMapping("/usr/article/dofind")
	@ResponseBody
	public List<String> dofind(String keyword) {
		
		String key = null;
		
		 if (keyword.contains("검색")) {
		        key = "검색";
		    }else if (keyword.contains("코스")) {
		        key = "코스";
		    }else if (keyword.contains("지역")) {
		        key = "지역";
		    }
		 
		 if (key == null) { // key가 null인 경우에만 추가 검사 수행
		        String[] regions = {"대전", "서울", "부산", "대구", "인천", "광주", "울산", "세종", "경기", "강원", "충북", "충남", "경북", "경남", "전북", "전남", "제주"};
		        for (String region : regions) {
		            if (keyword.contains(region)) {
		                key = "지역";
		                break;
		            }
		        }
		    }
		    
		    List<String> answer = key != null ? articleService.dofind(key) : new ArrayList<>();
		    if (answer.isEmpty()) {
		        answer.add("일치하는 답변이 없습니다.");
		    }
		    
		    return answer;
		 
	
	}
	
	
	
	
}

