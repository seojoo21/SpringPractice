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
				Board List Page
				
				<!-- 게시물 등록 버튼  -->
				<button id='regBtn' type="button" class="btn btn-xs pull-right">Register
					New Board</button>
					
			</div>

			<!-- /.panel-heading -->
			<div class="panel-body">
				
				<!-- 테이블 시작  -->
				<table class="table table-striped table-bordered table-hover">
				  <thead>
				    <tr>
					  <th>#번호</th>
					  <th>제목</th>
					  <th>작성자</th>
					  <th>작성일</th>
					  <th>수정일</th>
					</tr>
				  </thead>

				  <c:forEach items="${list}" var="board">
                    <tr>
                      <td><c:out value="${board.bno }"/></td>
                        <%-- <td><a href='/board/get?bno=<c:out value="${board.bno }"/>'><c:out value="${board.title }"/></a></td>
                        <td><c:out value="${board.writer }"/></td> --%>
                               			
                        <!-- 1페이지가 아닌 조회 페이지로 이동할 수 있도록 제목의 링크 수정   -->
                        <!-- 이벤트 처리를 수월하게 하기 위해서 <a>태그에 class 속성을 하나 부여한다. -->
                        <td><a class='move' href='<c:out value="${board.bno }"/>'><c:out value="${board.title }"/></a></td>
                        <td><c:out value="${board.writer }"/></td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }" /></td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }" /></td>
                     </tr>
                  </c:forEach>
                </table>
                <!-- 테이블 끝  -->
                
                <!-- 검색 처리를 위해 검색 조건과 키워드 입력을 위한 폼 시작 -->
                <!-- 검색 후에는 주소창에 검색 조건과 키워드가 같이 GET 방식으로 처리되므로 
                이를 이용해서 <select>태그나 <input>태그의 내용을 수정한다.  -->
		<form id='searchForm' action="/board/list" method='get'>
                  <select name='type'>
                    <option value="" 
                      <c:out value="${pageMaker.cri.type == null? 'selected' : '' }"/>>--</option>
                    <option value="T" 
                      <c:out value="${pageMaker.cri.type eq 'T'? 'selected' : '' }"/>>제목</option>
                    <option value="C" 
                      <c:out value="${pageMaker.cri.type eq 'C'? 'selected' : '' }"/>>내용</option>
                    <option value="W" 
                      <c:out value="${pageMaker.cri.type eq 'W'? 'selected' : '' }"/>>작성자</option>
                    <option value="TC" 
                      <c:out value="${pageMaker.cri.type eq 'TC'? 'selected' : '' }"/>>제목 or 내용</option>
                    <option value="TW" 
                      <c:out value="${pageMaker.cri.type eq 'TW'? 'selected' : '' }"/>>제목 or 작성자</option>
                    <option value="TWC" 
                      <c:out value="${pageMaker.cri.type eq 'TWC'? 'selected' : '' }"/>>제목 or 내용 or 작성자</option>
                  </select>
                <input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' />
                <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
                <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
                <button class='btn btn-default'>Search</button>
                </form>
                <!-- 검색 처리를 위해 검색 조건과 키워드 입력을 위한 폼 끝 -->
                
				<!-- 페이지 처리 태그 추가  -->                                        
                   <div class='pull-right'>
					<ul class="pagination">

						<c:if test="${pageMaker.prev}">
              			<li class="paginate_button previous"><a href="${pageMaker.startPage-1 }">Previous</a>
              			</li>
            			</c:if>

            			<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
             			<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : ""} ">
             			<a href="${num }">${num}</a></li>
            			</c:forEach>

            			<c:if test="${pageMaker.next}">
              			<li class="paginate_button next"><a href="${pageMaker.endPage+1 }">Next</a></li>
            			</c:if>
            		  </ul>
            		</div>
				<!-- 페이지 처리 태그 끝  -->   
					</div>   
					
				<!-- 페이지 처리에 따른 URL의 이동을 처리하도록 변경하기 위해 <form>태그를 추가  -->
				<form id='actionForm' action="/board/list" method='get'>
					<input type='hidden' name='pageNum' value= '${pageMaker.cri.pageNum }'>
					<input type='hidden' name='amount' value= '${pageMaker.cri.amount }'>
				<!-- 페이지 번호를 클릭해서 이동할 때도 검색 조건과 키워드가 같이 전달되어야 하므로 hidden으로 type과 keyword가 전달되게끔 한다.  -->
                    <input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>' />
                    <input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' />
				</form>
                               
				       <!-- Modal  추가 -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
								aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">Modal title</h4>
										</div>
										<div class="modal-body">처리가 완료되었습니다.</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">Close</button>
											<button type="button" class="btn btn-primary" data-dismiss="modal">Save
												changes</button>
										</div>
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal-dialog -->
							</div>
							<!-- /.modal -->
							
							<div class='row'></div>
                            
                            </div>
                        </div>
                    </div>
               


<script type="text/javascript">
/*  모달창을 보여주는 작업을 위한 jQuery */
	$(document).ready(
		function() {
			var result = '<c:out value="${result}"/>';

			checkModal(result);
			
			history.replaceState({},null,null); // 뒤로 가기 시 모달창이 다시 뜨는 문제를 해결하기 위해 window의 history 객체를 사용함. 
	
/* 	checkModal()함수는 파라미터에 따라서 모달창을 보여주거나 내용을 수정한 뒤 보이도록 작성 
	checkModal()에서는 새로운 게시글이 작성되는 경우 RedirectAttributes로 게시물의 번호가 전송되므로 이를 이용해서 모달창의 내용을 수정함  */
	
	function checkModal(result) { 
		if (result ==='' || history.state ) { // 뒤로 가기 시 모달창이 다시 뜨는 문제를 해결하기 위해 window의 history 객체를 사용함. 
			return;
		}
		
		if(parseInt(result) > 0) {
			$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
		}
		
	/* 	아래 코드를 호출하면 모달창이 보이게 됨 */
		$("#myModal").modal("show");
	}
		
/* 	'게시물 등록'버튼을 누르면 게시물 등록 페이지로 이동한다.  */
	$("#regBtn").on("click", function() {
		self.location = "/board/register";
	});
	
/* <a>태그를 클릭해도 페이지 이동이 없도록 preventDefault()처리하고, 
<form>태그 내 pageNum 값은 href속성 값으로 변경. 
이 처리를 하고 나면 화면에서 페이지 번호를 클릭했을 때 <form> 태그 내의 페이지 번호가 바뀌는 것을 브라우저 개발자 도구를 통해 확인 할 수 있다.  */
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click", function(e) {
		
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
/* 게시물의 제목을 클릭했을 때 이동하도록 이벤트 처리 추가 */
/* 게시물의 제목을 클릭하면 <form> 태그에 추가로 bno값을 전송하기 위해서 <input>태그를 만들어 추가하고,
 * <form> 태그의 action은 '/board/get'으로 변경한다. 
 * 이 처리가 정상적으로 되었다면 게시물의 제목을 클릭했을 때 pageNum과 amount 파라미터가 추가로 전달되는 것을 볼 수 있다. */
 
$(".move").on("click", function(e){
	
	e.preventDefault();
	actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
	actionForm.attr("action", "/board/get");
	actionForm.submit();
	});	
	
});

/* 검색 처리를 위해 검색 버튼을 클릭하면 검색은 내가 지금 보고 있는 페이지가 아닌 1페이지를 하도록 수정하고,
화면에 검색 조건과 키워드가 보이게 처리하는 이벤트 처리를 추가한다.  */

/* 브라우저에서 검색 버튼을 클릭하면 <form> 태그의 전송은 막고, 페이지의 번호는 1이 되도록 처리한다.
화면에서 키워드가 없다면 검색을 하지 않도록 제어한다.  */

	var searchForm = $("#searchForm");
	$("#searchForm button").on("click", function (e) {
		
		if(!searchForm.find("option:selected").val()) {
			alert("검색 종류를 선택하세요.");
			return false;
		}
		
		if(!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요.");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
	});

	</script>                
	
<!-- 게시판이 들어갈 핵심적인 페이지의 내용의 아래 부분을 잘라서 footer.jsp의 내용으로 처리한다.  -->
<%@include file="../includes/footer.jsp" %>              
              
