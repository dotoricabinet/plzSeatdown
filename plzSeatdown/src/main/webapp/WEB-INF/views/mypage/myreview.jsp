<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mypage-프로필</title>
<link rel="stylesheet" href="${contextPath}/resources/css/mypage_myreview.css"/>
<style>
            
     #heartimg{
     		width:45px;
     		height:45px;
     		
     }       
</style>
</head>
<body class="homepage is-preload">
   <jsp:include page="/WEB-INF/views/common/header.jsp"/>
   <jsp:include page="/WEB-INF/views/common/nav.jsp"/>
   
   
      <!-- 사이드바 패널 -->
         <div id="wrap">
            <div class="sidebarpan">
               <div class="showContent pl-3 pr-10">
                     <div id="title" class="mb-4">
                     <h4 style="font-weight:bold;"> </h4>
                  </div>
                  <div id="seatId" class="mb-5">
                     <h5> </h5>
                  </div>
                  <div id="review">
                     <!-- 카드 1 시작 -->
                     <div class="card">
                        <div class="card-content">
                           <div class="profile" style="display:inline-block; width:100%; height: 50px;" >
                           <c:set var="src1" value="${contextPath}/resources/images/user.png"/>
                                    <c:if test="${profile.memberNo == loginMember.memberNo}">
                                       <c:set var ="src1" value="${contextPath}/resources/profileImages/${profile.profilePath}"/>
                                    </c:if>
                              <img class="img-circle profile-photo" src="${src1}" width="50" height="50" style="border-radius: 5em;"/>
                              <div style="display:inline-block; width:100px;" id="reviewNick"></div>
                           <div class="reviewLikeCount" id="likeCount" style="display:inline-block; float:right;">
                           	<img id="heartimg" src="${contextPath}/resources/images/like2.png" style="position: relative;">
                           <span style="position : absolute; top:27px; right:46px; color:red;"><b id="reviewLike"></b></span>
                           </div>
                           </div>
                           <div class="mb-4 mt-4">
                              <div style="display: inline-block; width: 100px; font-weight: bold;">
                                 <span>시야</span>
                                 <span style="display: block; background: url(http://i.imgur.com/YsyS5y8.png) 0 -50px repeat-x;" class="star-prototype" id="reviewSight"> </span>
                              </div>
                              <div style="display: inline-block;  width: 100px; font-weight: bold;">
                                 <span>간격</span>
                                 <span style="display: block; background: url(http://i.imgur.com/YsyS5y8.png) 0 -50px repeat-x;" class="star-prototype" id="reviewLegroom"> </span>
                              </div>
                              <div style="display: inline-block; width: 100px; font-weight: bold;">
                                 <span>편안함</span>
                                 <span style="display: block; background: url(http://i.imgur.com/YsyS5y8.png) 0 -50px repeat-x;" class="star-prototype" id="reviewComfort"> </span>
                              </div>
                           </div>
                           <%--    <c:if test="${revieweh.reviewWriter == loginMember.memberNo}">
                                 <c:forEach var="rimage" items="${rimgList}" varStatus="vs">
                                       <c:set var ="src2" value="${contextPath}/resources/images/${rimage.reviewImagePath}"/>
                                       </c:forEach>
                                    </c:if> --%> 
                              <img class="img-responsive" src="" id="reviewImage"/>
                              <div class="sub-heading mt-4 mb-4">
                                 <pre id="reviewComment"></pre>
                              </div>
                        </div>
                     </div>
                     <!-- 카드 1 끝 -->
                  </div>
               </div>
            </div>
            <div class="overlay"></div>
         </div>
         
   
      <!-- Main -->
         <div class="wrapper style1">
            <div class="container">
               <div class="row gtr-200">
               
                  <div class="col-2 col-12-mobile" id="sidebar" style="width: 200px;">
                  <h4><a href="mypage">내 리뷰</a></h4>
                     <ul>
                        <li><a href="mypage">프로필</a></li>
                       	<c:set var="snslogin" value="${loginMember.memberId }"/>
                        <c:if test="${!fn:startsWith(snslogin,'_')}">
									<li><a href="changePwd">비밀번호 변경</a></li>
									<li><a href="secession">회원 탈퇴</a></li>
                        </c:if>
                        <li><a href="myreview">내 리뷰</a></li>
                        <li><a href="myticket">내 티켓</a></li>
                        <li><a href="mycommu">내 커뮤</a></li>
                        <li><a href="ask">문의 내역</a></li>
                       <li><a href="alarmSetting">알림 설정</a></li>
                     </ul>
                  </div>
                  
                  <div class="col-10 col-12-mobile imp-mobile" id="content">
                     <table id="list-table"class="table" style="margin-left:20px;">
                        <thead>
                          <tr>
                             <th scope="col" style="border-bottom:0px;">번호</th>
                           <th scope="col" style="border-bottom:0px;">장소(좌석)</th>
                           <th scope="col" style="border-bottom:0px;">좌석 별점</th>
                           <th scope="col" style="border-bottom:0px;">공연장</th>
                           <th scope="col" style="border-bottom:0px;">날짜</th>
                           <!-- <th scope="col" style="border-bottom:0px;">사진</th> -->
                           <th scope="col" style="border-bottom:0px;"></th>
                          </tr>
                        </thead>
                        <tbody class= "commu-body">
                           <c:if test="${empty list}">
                              <tr>
                                 <td colspan="7">존재하는 리뷰가 없습니다.</td>
                              </tr>
                           </c:if>
                           <c:if test="${!empty list}">
                              <c:forEach var="revieweh" items="${list}" varStatus="vs">
                                 <tr class="seats">
                                    <td style="border-top:0px; padding-top:22px;" name="reviewNo">${revieweh.reviewNo}</td>
                                    <c:if test="${revieweh.seatFloor == null && revieweh.seatArea != null }">
                                    <td style="border-top:0px; padding-top:22px;">${revieweh.seatArea}구역&nbsp;${revieweh.seatRow}열&nbsp;${revieweh.seatCol}번</td>
                                    </c:if>
                                    <c:if test="${revieweh.seatFloor != null && revieweh.seatArea == null }">
                                    <td style="border-top:0px; padding-top:22px;">${revieweh.seatFloor}층&nbsp;${revieweh.seatRow}열&nbsp;${revieweh.seatCol}번</td>
                                    </c:if>
                                    <c:if test="${revieweh.seatFloor != null && revieweh.seatArea != null }">
                                    <td style="border-top:0px; padding-top:22px;">${revieweh.seatFloor}층&nbsp;${revieweh.seatArea}구역&nbsp;${revieweh.seatRow}열&nbsp;${revieweh.seatCol}번</td>
                                    </c:if>
                                    <td style="border-top:0px; padding-top:22px;"><span class="star-prototype" style="display:inline;  background: url(http://i.imgur.com/YsyS5y8.png) 0 -18px repeat-x;">${(revieweh.reviewSight + revieweh.reviewComfort + revieweh.reviewLegroom)/3}</span></td>
                                    <td class="contentwrap" style="border-top:0px; padding-top:22px; height:55px;">${revieweh.thName}</td>
                                    <td style="border-top:0px; padding-top:22px;">${revieweh.reviewCreateDt}</td>
                                    <%-- <td style="border-top:0px; padding-top:22px;">${rimage.reviewImageStatus}</td> --%>
                                    <td style="border-top:0px; padding-top:15px;">
                                    <a href="${contextPath}/review/updateForm?no=${revieweh.reviewNo}" id="filedelete" type="button"  class="btn btn-outline-secondary updatebtn" style="border:0px;">
                                    <img src="${contextPath}/resources/images/pen.png" class="edit">
                                    </a></td>
                                </tr>
                              </c:forEach>
                           </c:if>
                        </tbody>
                       </table>
                       

                        <!-- 페이징바 -->
                           <div class="col-md-12 d-flex justify-content-center">
                           <ul class="pagination pagination-info">
                           <c:if test="${pInf.currentPage > 1}">
                            <li class="page-item">
                               <!-- 맨 처음으로(<<) -->
                                <a class="page-link" href="
                                <c:url value="myreview"> 
                                   <c:param name="currentPage" value="1"/>
                                </c:url>
                                ">&lt;&lt;</a>
                            </li>
                   
                            <li class="page-item">
                               <!-- 이전으로(<) -->
                                  <a class="page-link" href="
                                  <c:url value="myreview">
                                  <c:param name="currentPage" value="${pInf.currentPage-1}"/>
                                  </c:url>
                                  ">PREV</a>
                            </li>
                            </c:if>
                   
                            <!-- 10개의 페이지 목록 -->
                                <c:forEach var="p" begin="${pInf.startPage}" end="${pInf.endPage}">
                               <c:if test="${p == pInf.currentPage}">
                                     <li class="active page-item">
                                            <a class="page-link">${p}</a>
                                     </li>
                               </c:if>
                               <c:if test="${p != pInf.currentPage}">
                                  <li class="page-item">
                                      <a class="page-link" href="
                                      <c:url value="myreview">
                                         <c:param name="currentPage" value="${p}"/>
                                      </c:url>
                                      ">${p}</a>
                                  </li>
                                  </c:if>
                              </c:forEach>
                            <!-- 다음 페이지로(>) -->
                            <c:if test="${pInf.currentPage < pInf.maxPage }">
                            <li class="page-item">
                                <a class="page-link" href="
                                   <c:url value="myreview">
                                      <c:param name="currentPage" value="${pInf.currentPage+1}"/>
                                   </c:url>
                                ">NEXT</a>
                            </li>
                   
                            <!-- 맨 끝으로(>>) -->
                            <li class="page-item">
                                <a class="page-link" href="
                                   <c:url value="myreview">
                                      <c:param name="currentPage" value="${pInf.maxPage}"/>
                                   </c:url>
                                ">&gt;&gt;</a>
                            </li>
                            </c:if>
                        </ul>
                       </div>
                       
                       
                  </div>
               </div>
            </div>
         </div>
   
   
            
      <script>
/*       // 게시글 상세보기 기능 (jquery를 통해 작업)
      $(function(){
         $("#list-table td").click(function(){
            var qnaNo = $(this).parent().children().eq(0).text();
            // 쿼리스트링을 이용하여 get 방식으로 글 번호를 server로 전달
            <c:url var="detailUrl" value="detail"> // 주소창의 detail
                    <c:param name="currentPage" value="${pInf.currentPage}"/>
                  </c:url>
            location.href="${detailUrl}&no="+reviewNo;
         }).mouseenter(function(){
            $(this).parent().css("cursor", "pointer");
         });
      }); */
      
         $(function(){
            $(".seats").mouseenter(function(){
               $(this).parent().css("cursor", "pointer");
            })
         });
         
      
      
         // sidebar pannel 기능
         
         $(function(){
            var arr = new Array();
            <c:forEach var="r" items="${list}">
               var review = {
                  reviewNo : "${r.reviewNo}",
                  reviewSight : "${r.reviewSight}",
                  reviewComfort : "${r.reviewComfort}",
                  reviewComment : "${r.reviewComment}",
                  reviewLegroom : "${r.reviewLegroom}",
                  reviewCreateDt : "${r.reviewCreateDt}",
                  seatArea : "${r.seatArea}",
                  seatFloor : "${r.seatFloor}",
                  seatRow : "${r.seatRow}",
                  seatCol : "${r.seatCol}",
                  thName : "${r.thName}",
                  reviewWriter : "${r.reviewWriter}",
                  memberNickname : "${r.memberNickname}",
                  likeCount : "${r.likeCount}"
               }
               
               arr.push(review);
            </c:forEach>
            
           	
            
            var arrimg = new Array();
            <c:forEach var="rimg" items="${rimgList}">
               var reviewImg = {
            		 reviewImgPath : "${rimg.reviewImgPath}"
               }
               
               arrimg.push(reviewImg);
            </c:forEach>
            
            
            
            $(".seats").on({
               click : function(){
                  
                  var index = $(this).index();
                  
                  var indexno = $(this).children("td[name=reviewNo]").text();
                  
                  
                  $(".sidebarpan").addClass("active");
                  
                  
                  $("body").addClass("scrollHidden").on("scroll touchmove mousewheel", function(e){
                     e.preventDefault();
                  }); // 스크롤 불가능
                  $(".overlay").fadeIn();
                  
                 
                  $("#reviewNick").text(arr[index].memberNickname);
                  $("#title").children("h4").text(arr[index].thName);
                  if(arr[index].seatFloor != "" && arr[index].seatArea != ""){
                  	$("#seatId").children("h5").text(arr[index].seatFloor + "층" + arr[index].seatArea + "구역" + arr[index].seatRow + "열  " + arr[index].seatCol + "번에 대한 리뷰");
                  }
                  else if(arr[index].seatFloor == ""  && arr[index].seatArea != ""){
                		$("#seatId").children("h5").text(arr[index].seatArea + "구역" + arr[index].seatRow + "열  " + arr[index].seatCol + "번에 대한 리뷰");
                  }
                  else if(arr[index].seatFloor != "" && arr[index].seatArea == ""){
                	  $("#seatId").children("h5").text(arr[index].seatFloor + "층" + arr[index].seatRow + "열  " + arr[index].seatCol + "번에 대한 리뷰");
                  }
                  $("#reviewSight").text(arr[index].reviewSight).generateStars();
                  $("#reviewLegroom").text(arr[index].reviewLegroom).generateStars();
                  $("#reviewComfort").text(arr[index].reviewComfort).generateStars();
                  $("#reviewLike").text(arr[index].likeCount);
                  $("#reviewComment").html(arr[index].reviewComment);
                  
                  console.log(arrimg[index].reviewImgPath);
                  
                  if(arr[index].reviewWriter == "${loginMember.memberNo}"){
                	  if(arrimg[index].reviewImgPath == ""){
                		 $("#reviewImage").prop("src","");  
                	  }else{
                    	 $("#reviewImage").prop("src", "${contextPath}/resources/reviewImages/"+arrimg[index].reviewImgPath);
                	  }
                  }
                  
                  
               }
            });
            $(".overlay").on({
               click : function(){
                  $(".sidebarpan").removeClass("active");
                  $("body").removeClass("scrollHidden").off("scroll touchmove mousewheel");
                  $(".overlay").fadeOut();
               }
            });
         });
         
        
         
         // 별점 기능
         $.fn.generateStars = function() {
          return this.each(function(i,e){$(e).html($('<span/>').width($(e).text()*16));});
         };

         // 숫자 평점을 별로 변환하도록 호출하는 함수
         $('.star-prototype').generateStars();

      
   </script>
   
   
   
   <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>