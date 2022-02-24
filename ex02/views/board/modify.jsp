<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 게시판이 들어갈 핵심적인 페이지의 내용 부분 위까지를 잘라서 header.jsp의 내용으로 처리한다.  -->
<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				Board Modify Page
			</div>

			<!-- /.panel-heading -->
			<div class="panel-body">
				
				<!-- 테이블 시작  -->
                            
                              <!--   POST방식이므로 <form>태그를 이용해서 필요한 데이터를 전송한다.  
                              	get.jsp와 비슷하지만 제목, 내용을 수정할 수 있도록 readonly 속성을 없앤다. 
                               -->
                          
                            	<form role="form" action="/board/modify" method="post">
                            	
                            	<!-- 페이징 처리 중 수정 페이지에서 다시 목록 페이지로의 이동 시 페이지 번호 유지를 위해 Criteria 클래스의 변수 pageNum, amount를 추가 -->
                            	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
        			<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
					
        			<!-- 수정 페이지에서의 다시 목록 페이지로 이동 시 검색 처리 결과 유지를 위해 type과 keyword의 처리를 추가한다.  -->
		                <input type='hidden' name='type' value='<c:out value="${cri.type}"/>' />
		                <input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>' />
                            	
                          		<div class="form-group">
                          		<label>#번호</label>
                          		<input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
                          		</div>
                          		
                          		<div class="form-group">
                          		<label>제목</label>
                          		<input class="form-control" name='title' value='<c:out value="${board.title}"/>' >
                          		</div>
                          		
                          		<div class="form-group">
                          		<label>내용</label>
                          		<textarea class="form-control" rows="3" name='content'>
                          		<c:out value="${board.content }" />
                          		</textarea>
                          		</div>
                          		
                          		<div class="form-group">
                          		<label>작성자</label>
                          		<input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
                          		</div>
                          		
                          		<!-- 등록일과 수정일이 나중에 BoardVO로 수집되어야 하므로 날짜 포맷을 'yyyy/MM/dd'로 하여 추가한다. (날짜 포맷 일치 해야함)  -->
                          		
                          		<div class="form-group">
                          		<label>작성일</label>
                          		<input class="form-control" name='regDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.regdate}"/>' readonly="readonly">
                          		</div>
                          		
                          		<div class="form-group">
                          		<label>수정일</label>
                          		<input class="form-control" name='updateDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.updateDate}"/>' readonly="readonly">
                          		</div>
                          		
                          		<!-- 수정,삭제,목록으로 돌아가기 버튼  -->
                          		<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
                          		<button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
                             	<button type="submit" data-oper='list' class="btn btn-info">목록으로</button>
                          		
                          		</form>
                             <!-- 테이블 끝  -->
                            </div>
                        </div>
                    </div>
                </div>
         
<!-- 수정, 삭제, 목록으로 돌아가기 버튼별 동작을 자바스크립트로 설정       -->  
<script type="text/javascript">
$(document).ready(function() {
	
	var formObj = $("form");
	
	$('button').on("click", function(e) {
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation==='remove'){
			formObj.attr("action", "/board/remove");
			
		} else if (operation === 'list') {
			// 목록 페이지로 이동 
			formObj.attr("action", "/board/list").attr("method","get");
			
			// 만일 사용자가 '목록으로' 버튼을 클릭하면 <form>태그에서 필요한 부분만 잠시 복사(clone)해서 보관해두고, 
			// <form> 태그 내의 모든 내용은 지워버린다.(empty)
			var pageNumTag = $("input[name='pageNum']").clone(); 
			var amountTag = $("input[name='amount']").clone();
			// 검색 처리 결과 유지를 위해 keyword와 type 역시 동일하게 추가한다.
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
			
			formObj.empty(); // 'board/list'로의 이동은 아무런 파라미터가 없기 때문에 <form>태그의 모든 내용은 삭제한 상태에서 submit()을 진행한다. 
			// 이후에 다시 필요한 태그들만 추가해서 '/board/list'를 호출하는 형태를 이용한다.
			
			formObj.append(pageNumTag); 
			formObj.append(amountTag);
			// 검색 처리 결과 유지를 위해 keyword와 type 역시 동일하게 추가한다.
			formObj.append(keywordTag);
			formObj.append(typeTag);
		
		}
		formObj.submit();
	});
});

</script>
                
<!-- 게시판이 들어갈 핵심적인 페이지의 내용의 아래 부분을 잘라서 footer.jsp의 내용으로 처리한다.  -->
<%@include file="../includes/footer.jsp" %>              
              
