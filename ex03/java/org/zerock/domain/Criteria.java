package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class Criteria {
	
	private int pageNum; // 현재 페이지 번호 
	private int amount; // 페이지당 게시물 개수 
	
	private String type; // 검색 처리를 위한 검색 조건 추가 
	private String keyword; // 검색 처리를 위한 검색 키워드 추가 
	
	// Criteria 클래스의 기본 생성자 - 기본값 1페이지, 페이지당 게시물 10개 
	public Criteria() {
		this(1,10);
	}
	
	// Criteria 클래스의 생성자  
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		
	}
	
	// 검색 조건(type)이 각 글자 (T: title 제목, C: content 내용, W: writer 작성자)로 구성되어 있으므로 
	// 검색 조건을 배열로 만들어서 한 번에 처리하고자 한다.
	// getTypeArr() 메서드의 배열을 이용해서 MyBatis의 동적 태그를 활용할 수 있다. 
	public String[] getTypeArr() {
		 return type == null? new String[] {} : type.split("");
	}
	
	//UriComponentsBuilder를 이용하여 링크를 생성하는 기능을 추가 
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword",this.getKeyword());
		
		return builder.toUriString();
	}
	
	

}
