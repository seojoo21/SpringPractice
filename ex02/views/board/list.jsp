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
                               			<td><a href='/board/get?bno=<c:out value="${board.bno }"/>'><c:out value="${board.title }"/></a></td>
                               			<td><c:out value="${board.writer }"/></td>
                               			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }" /></td>
                               			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }" /></td>
                               		</tr>
                               	</c:forEach>
                               </table>
                               <!-- 테이블 끝  -->

<!-- 페이지 처리 태그 추가  -->                                        
                               

<!-- 페이지 처리 태그 끝  -->      
                               
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
                </div>
        

<!-- 모달창을 보여주는 작업을 위한 jQuery    -->
<script type="text/javascript">
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
	})
});
</script>                
<!-- 게시판이 들어갈 핵심적인 페이지의 내용의 아래 부분을 잘라서 footer.jsp의 내용으로 처리한다.  -->
<%@include file="../includes/footer.jsp" %>              
              
