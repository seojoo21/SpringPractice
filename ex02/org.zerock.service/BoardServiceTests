package org.zerock.service;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_= {@Autowired })
	private BoardService service;
	
	// BoardService 객체가 제대로 주입이 가능한지 확인하는 작업 
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	// 게시물이 새로 등록되는지 확인하는 작업 
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");
		
		service.register(board);
		
		log.info("생성된 게시물의 번호: " + board.getBno());
	}
	
	// 목록(리스트)가 잘 불려오는지 확인하는 작업 
	@Test
	public void testGetList() {
		// 1. getList() 페이징 처리 전 테스트 코드 
		// service.getList().forEach(board -> log.info(board));
		// 2. getList() 페이징 처리 후 테스트 코드
		service.getList(new Criteria(2,10)).forEach(board -> log.info(board));
		
	}

	// 특정 게시물이 잘 불려오는지 확인하는 작업 (게시물의 번호인 VNO가 파라미터이며, 테스트에서는 VNO=1로 확인) 
	@Test
	public void testGet() {
		log.info(service.get(1L));

	}
	
	// 특정 게시물이 잘 삭제되는지 확인하는 작업. 해당 게시물이 존재할 때 true를 반환. 
	@Test
	public void testDelete() {
		
		// 게시물 번호의 존재 여부를 확인하고 테스트할 것
		log.info("REMOVE RESULT: " +service.remove(2L));
	}
	
	// 특정 게시물이 수정 가능한지 확인하는 작업 
	@Test
	public void testUpdate() {
		BoardVO board = service.get(1L);
		
		if(board==null) {
			return;
		}
		
		board.setTitle("제목 수정합니다.");
		log.info("MODIFY RESULT: " +service.modify(board));
	}

}
