package org.zerock.domain;

import lombok.Data;

@Data
public class Criteria {
	
	private int pageNum; // 현재 페이지 번호 
	private int amount; // 페이지당 게시물 개수 
	
	// Criteria 클래스의 기본 생성자 - 기본값 1페이지, 페이지당 게시물 10개 
	public Criteria() {
		this(1,10);
	}
	
	// Criteria 클래스의 생성자  
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		
	}

}
