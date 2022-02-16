package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
// 오라클 SQL Developer에서 만든 테이블 설계를 기준을 작성한다. 
// 아래 인스턴스 변수들은 모두 SQL Developer에서 만든 테이블의 Column_Name과 같다. 
// Lombok 라이브러리의 @Data 애노테이션을 이용하여 getter/setter/toString을 만든다.  
public class BoardVO {
	
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;

}
