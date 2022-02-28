package org.zerock.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/replies")
@Slf4j
@AllArgsConstructor
public class ReplyController {
	
  private ReplyService service;

  // 1. 댓글 등록 처리 
  // JSON 방식의 데이터만 처리하고(consumes), 문자열을 반환한다(produces). 
  @PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
  // @RequestBody를 적용해서 JSON 데이터를 ReplyVO 타입으로 변환하도록 지정한다. 
  public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
	  
	  log.info("ReplyVO:" + vo);
	  
	  //내부적으로 ReplyServiceImpl을 호출해서 register()를 호출하고, 
	  //댓글이 추가된 숫자를 확인해서 브라우저에서 '200 OK'혹은 '500 Internal Server Error'를 반환하도록 한다. 
	  int insertCount = service.register(vo);
	  
	  log.info("Reply Insert Count" + insertCount); 
	  
	  return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	  
  }
  
  // 2. 특정 게시물의 댓글 목록 확인 
  // getList()는 Criteria를 이용해서 파라미터를 수집하는데, 
  // '/{bno}/{page}'의 'page'값은 Criteria을 생성해서 직접 처리해야한다. 
  // 'bno'값은 @PathVariable을 이용해 파라미터로 처리한다.
//  @GetMapping(value = "/pages/{bno}/{page}",
//		  produces = {
//				  MediaType.APPLICATION_XML_VALUE,
//				  MediaType.APPLICATION_JSON_UTF8_VALUE})
//  public ResponseEntity<List<ReplyVO>> getList(
//		  @PathVariable("page") int page,
//		  @PathVariable("bno") Long bno) {
//
//	  	log.info("getList.............");
//	  	Criteria cri = new Criteria(page,10);
//	  	 
//	  return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
//  }
  
  // 3. 댓글 조회
  @GetMapping(value = "/{rno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
  public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
	  log.info("get: "+ rno );
	  return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
  }
  
  // 4. 댓글 삭제 
  @DeleteMapping(value = "/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
  public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
	  log.info("remove: " + rno);
	  return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
  }
  
  // 5. 댓글 수정 
  @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, 
		  value = "/{rno}",
		  consumes = "application/json",
		  produces = {MediaType.TEXT_PLAIN_VALUE})
  public ResponseEntity<String> modify (
		  @RequestBody ReplyVO vo,
		  @PathVariable("rno") Long rno) {
	  	
	  		vo.setRno(rno);
	  		log.info("rno: " + rno);
	  		log.info("modify: " + vo);
	  		
	  		return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	  
  }
  
  // 6. 페이징 처리된 특정 게시물의 댓글 확인 
  @GetMapping(value = "/pages/{bno}/{page}", 
		      produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})  
  public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno) {
	  Criteria cri = new Criteria(page, 10);
	  log.info("get Reply List bno: " + bno);
	  log.info("cri:" + cri);
	  return new ResponseEntity<>(service.getListPage(cri, bno),HttpStatus.OK); 
  }
  
}
