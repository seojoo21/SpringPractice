package org.zerock.domain;

import lombok.Data;

@Data
public class pageDTO {
	
	private int startPage;	// 시작 페이지 번호 
	private int endPage;	// 끝 페이지 번호 
	private boolean prev;
	private boolean next;	// 이전, 다음 
	
	private int total; // 전체 데이터 수 
	private Criteria cri; 
	// Criteria 안에는 현재 페이지 번호(pageNum), 페이지에서 보여주는 데이터 수(amount)를 가지고 있으므로 이를 이용해서 필요한 모든 내용 계산 가능
	
	
	//생성자 정의 
	//Criteria와 전체 데이터 수 (total)를 파라미터로 지정 
	public pageDTO(Criteria cri, int total) {
		
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		this.startPage = this.endPage - 9;
		
		// realEnd: 진짜 끝 페이지 
		int realEnd = (int)(Math.ceil((total*1.0))/cri.getAmount());
		
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}

}
