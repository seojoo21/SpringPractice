package org.zerock.mapper;

import java.util.List;

// import org.apache.ibatis.annotations.Select; // @Select 애노테이션을 가지고 오기 위한 myBatis의 import구문  
import org.zerock.domain.BoardVO;

// MyBatis의 SQL을 처리하기 위해 Mapper 인터페이스와 Mapper XML을 만들어 MyBatis가 SQL을 처리하도록 한다. 


// 게시판의 SQL을 처리하기 위한 Mapper 인터페이스: 
public interface BoardMapper {

//  1. 게시물 전체를 읽어온다. 
//	@Select("select * from tbl_board where bno > 0") // 애노테이션을 이용한 간단한 처리
	public List<BoardVO> getList();

//	2. 게시물을 생성한다. (Create) 
//	insert()는 단순히 시퀀스 다음의 값을 구해서 insert할 때 사용한다. 
//	insert 문은 몇 건의 데이터가 변경되었는지만 알려주기 때문에 추가된 데이터의 PK값은 알 수 없지만, 1번의 SQL처리만으로 작업이 완료되는 장점이 있다.
	public void insert(BoardVO board);

//	insertSelectKey()는 @SelectKey라는 MyBatis의 어노테이션을 이용한다.
// 	@SelectKey는 주로 PK 값을 미리(before) SQL을 통해서 처리해두고 특정한 이름으로 결과를 보관하는 방식이다.
//	@Insert 할 때 SQL문을 보면 #{bno}와 같이 이미 처리된 결과를 이용하는 것을 볼 수 있다. 
	public void insertSelectKey(BoardVO board);

//	3. 특정 게시물을 읽어온다. (Read) 
// 	PK값인 bno를 기준으로 특정 게시물을 읽어온다. 
	public BoardVO read(Long bno);

//	4. 특정 게시물을 삭제한다. (Delete) 
	public int delete(Long bno);

//	5. 특정 게시물을 수정한다. (Update)
	public int update(BoardVO board);

}
