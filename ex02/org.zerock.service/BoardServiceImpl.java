package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service  
// @Service 애너테이션: 이 클래스에서 가장 중요한 부분. 
// 계층 구조상 주로 비즈니스 영역을 담당하는 객체임을 표시하기 위해 사용. 작성된 애너테이션은 패키지를 읽어 들이는 동안 처리   
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	//spring 4.3 이상에서 자동 처리 
	//@AllArgsConstructor는 모든 파라미터를 이용하는 생성자를 만든다. 
	private BoardMapper mapper;

	
	// 신규 게시물 등록 
	@Override
	public void register(BoardVO board) {
		log.info("register......" + board);
		mapper.insertSelectKey(board);
	}

	// 특정 게시물 조회. 게시물 번호가 파라미터 
	@Override
	public BoardVO get(Long bno) {
		log.info("get......." + bno);
		return mapper.read(bno);
	}

	// 특정 게시물 수정. 정상적으로 수정이 이루어지면 1이라는 값 반환 
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify....." + board);
		return mapper.update(board) == 1;
	}
	
	// 특정 게시물 삭제. 정상적으로 삭제가 이루어지면 1이라는  반환 
	@Override
	public boolean remove(Long bno) {
		log.info("remove...."+bno);
		return mapper.delete(bno) == 1;
	}

	// 모든 게시물 조회 
	@Override
	public List<BoardVO> getList() {
		log.info("getList.........");
		return mapper.getList();
	}


}
