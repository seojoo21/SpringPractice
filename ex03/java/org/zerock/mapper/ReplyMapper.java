package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	
	// 1. 외래키를 사용하는 등록 작업  
	public int insert(ReplyVO vo);
	
	// 2. 댓글 조회 처리를 추가한다.
	public ReplyVO read(Long bno);
	
	// 3. 댓글 삭제 처리를 추가한다. 
	public int delete(Long bno);
	
	// 4. 댓글 수정 처리를 추가한다.
	public int update(ReplyVO reply);
	
	// 5. 페이징 처리가 된 댓글 목록을 가져온다. 
	public List<ReplyVO> getListWithPaging (
		@Param("cri") Criteria cri,
		@Param("bno") Long bno); // ReplyMapper.xml의 #{bno}가 @Param("bno")와 매칭되어서 사용된다.
	
	// 6. 게시물 별 댓글 숫자를 파악한다. 
	public int getCountByBno(Long bno);
	
}
