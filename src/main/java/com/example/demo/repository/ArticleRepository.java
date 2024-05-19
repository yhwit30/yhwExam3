package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ArticleRepository {

	@Select("""
			SELECT answer
			FROM qna
			WHERE `key` = "${key}"
			""")
	public List<String> dofind(String key);
}
