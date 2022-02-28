package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	@Setter(onMethod_= @Autowired)
	private ReplyMapper mapper;
	
	// 테스트 전에 해당 번호의 게시물이 존재하는지 반드시 확인할 것 
//	private Long[] bnoArr = {507915L, 507914L, 507913L, 507912L, 507911L};
	
	// 1. ReplyMapper 타입의 객체가 정상적으로 사용이 가능한지 확인
//	@Test
//	public void testMapper() {
//		log.info(mapper);
//		
//	}
	
	
	// 2. 외래키를 사용하는 등록 작업 테스트 
//	@Test
//	public void testCreate() {
//		IntStream.rangeClosed(1, 10).forEach(i -> {
//			
//			ReplyVO vo = new ReplyVO();
//			
//			//게시물 번호
//			vo.setBno(bnoArr[i % 5]); // bnoArr는 게시물 번호의 일부로 실제 데이터베이스에 있는 번호여야만한다. (PK와 FK의 관계로 묶여있기 때문에) 
//			vo.setReply("댓글 테스트" + i);
//			vo.setReplyer("replyer" + i);
//			
//			mapper.insert(vo);
//		});
//		
//	}
	
	// 3. 댓글 조회 테스트  
//	@Test
//	public void testRead() {
//		Long targetRno = 5L;
//		
//		ReplyVO vo = mapper.read(targetRno);
//		
//		log.info(vo);
//	}
	
	// 4. 댓글 삭제 테스트
//	@Test
//	public void testDelete() {
//		Long targetRno = 1L;
//		
//		mapper.delete(targetRno);
//	}
	
	// 5. 댓글 수정 테스트
//	@Test
//	public void testUpdate() {
//		Long targetRNO = 10L;
//		ReplyVO vo = mapper.read(targetRNO);
//		
//		vo.setReply("Update Reply");
//		
//		int count = mapper.update(vo);
//		
//		log.info("UPDATE COUNT:" + count);
//	}

	// 6. 댓글 목록 조회 테스트 
//	@Test
//	public void testList() {
//		Criteria cri = new Criteria();
//		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
//		replies.forEach(reply -> log.info(reply));
//	}
	
//	7. 댓글 페이징 처리 테스트 
	@Test
	public void testList2() {
		Criteria cri = new Criteria(2,10);
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 507923L);
		replies.forEach(reply -> log.info(reply));
	}
}
