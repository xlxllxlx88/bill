<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 이현희:29 상세 화면  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title> 경비 등록/수정
    </title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
     <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js" integrity="sha384-FzT3vTVGXqf7wRfy8k4BiyzvbNfeYjK+frTVqZeNDFl8woCbF0CYG6g2fMEFFo/i" crossorigin="anonymous"></script>
    <!--For Commons Validator Client Side-->
    
    <script type="text/javaScript" language="javascript" defer="defer">
    
    	
    	$(document).ready(function(){
    		// 이현희:39 저장 후처리
	    	if('${updateYn}' == 'Y') {
	    	   opener.parent.fn_popCallBack('mod');
		   	   alert("저장되었습니다.");
	        }
    	
	    	// 이현희:46 삭제 후처리
	    	if('${deleteYn}' == 'Y') {
	    		alert("삭제되었습니다.");
	    	   opener.parent.fn_popCallBack('del');
	        } 
    	
    		console.log('------------------billInfo.statusCd=${billInfo.statusCd }');
    		// 이현희 29_1 : 처리상태에 따라 저장버튼 표시
    		if ('${billInfo.statusCd }' == 'J' || '${billInfo.statusCd }' == '' ) {
    			console.log('------------if');
    			$("#btnMod").show();
    			$("#btnDel").show();
    		} else {
    			console.log('------------else');
    			$("#btnMod").hide();
    			$("#btnDel").hide();
    		}
	    });
    
    	// 이현희:30 파일 변경 이벤트 
    	function fn_fileChange() {
    		$("#fileNmSpan").text('');
    	}
    	
    	//이현희:31 파일 변경 이벤트 
    	function fn_modifyBill() {
    		// 이현희:31_1. 필수 값 체크
	    	// 사용내역
	    	// 사용내역을 입력하지 않았을 때
	    	if ($("#dtlCd_id").val() == '') {
	    		// 오류메세지 출력 후 
	    		alert('사용내역을 선택해주세요.');
	    		// 사용내역으로 포커스
	    		$("#dtlCd_id").focus();
	    		return false;
	    	}
	    	// 사용일
	    	var useDt = $("#useDt").val();
	    	// 사용일을 입력하지 않았을 때
	    	if (!useDt) {
	    		alert('사용일을 입력해주세요.');
	    		$("#useDt").focus();
	    		return;
	    	// 사용일을 잘못입력 했을 때
	    	} else {
	    		if (useDt.length == 8) {
	    			// 숫자가 아닐 때
	    			if (isNaN(useDt)) {
	    				alert("사용일은 'YYYYMMDD'로 입력해주세요!");
			    		$("#useDt").focus();
			    		return;
	    			} else {
	    				// 월, 일 추출
	    				var mm = useDt.substr(4,2);
	    				var dd = useDt.substr(6,2);
	    				// 1~12월 사이만 입력 가능
	    				if (mm <= 0 || mm >= 13) {
	    					alert("잘못된 월입니다.");
	    		    		$("#useDt").focus();
	    		    		return;
	    				}
	    				// 1~31일 사이만 입력가능 
						if (dd <= 0 || dd >= 32) {
							alert("잘못된 일입니다.");
	    		    		$("#useDt").focus();
	    		    		return;
						}	    				
	    			}
	    		} else {
	    			alert("사용일은 'YYYYMMDD'로 입력해주세요.");
		    		$("#useDt").focus();
		    		return;
	    		}
	    	}
	    	
	    	// 금액
	    	// 금액이 입력되지 않았거나 0보다 작거나 같을 때
	    	if (!$("#useAmt").val() || $("#useAmt").val() <= 0) {
	    		alert("사용금액을 입력해주세요.");
	    		$("#useAmt").focus();
	    		return;
	    	}
	    	
	    	// 이현희:31_2. 저장할 데이터 post 방식으로 넘기기
	    	$("#detailForm").prop('action', 'billModify.do');
	        $("#detailForm").prop('method', 'post');
	        $("#detailForm").submit();
    	}
    	
    	// 이현희:40 삭제
    	function fn_removeBill() {
    		if (confirm('삭제하시겠습니까?')) {
    			location.href="/billRemove.do?billNum=" + $("#billNum").val();
    		}
    	}
    
    </script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

<form:form commandName="billVO"  id="detailForm"  name="detailForm" enctype="multipart/form-data">
   <input type="hidden" id="billNum" name="billNum" value="${billInfo.billNum}"/>
    <div id="content_pop">
       <!-- 타이틀 -->
       <div id="title">
          <ul>
             <li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>
                청구내역
                </li>
          </ul>
       </div>
       <!-- // 상세정보 -->
       <div id="table">
       <table width="100%" border="1" cellpadding="0" cellspacing="0" style="bordercolor:#D3E2EC; bordercolordark:#FFFFFF; BORDER-TOP:#C2D0DB 2px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-RIGHT:#ffffff 1px solid; BORDER-BOTTOM:#C2D0DB 1px solid; border-collapse: collapse;">
          <colgroup>
             <col width="150"/>
             <col width="?"/>
          </colgroup>
          <tr>
             <td class="tbtd_caption"><label for="dtlCd">사용내역 *</label></td>
             <td class="tbtd_content">
                 <select name="dtlCd" id="dtlCd">
                   	<option value="NB" <c:if test="${billInfo.dtlCd eq 'NB'}">selected</c:if> >식대(야근)</option>
                 	<option value="NT" <c:if test="${billInfo.dtlCd eq 'NT'}">selected</c:if> >택시비(야근)</option>
                 	<option value="NB" <c:if test="${billInfo.dtlCd eq 'HT'}">selected</c:if> >택시비(회식)</option>
                 	<option value="S"  <c:if test="${billInfo.dtlCd eq 'S'}" >selected</c:if> >사무용품 구매</option>
                 	<option value="G"  <c:if test="${billInfo.dtlCd eq 'G'}" >selected</c:if> >교육비</option>
                 	<option value="J"  <c:if test="${billInfo.dtlCd eq 'J'}" >selected</c:if> >접대비</option>
                </select>
             </td>
          </tr>
          <tr>
             <td class="tbtd_caption"><label for="useDt">사용일 *</label></td>
             <td class="tbtd_content">
                <form:input path="useDt" maxlength="8" cssClass="txt" value="${billInfo.useDt}"/>
             </td>
          </tr>
          <tr>
             <td class="tbtd_caption"><label for="useAmt">금액 *</label></td>
             <td class="tbtd_content">
                <form:input path="useAmt" maxlength="10" cssClass="txt" value="${billInfo.useAmt}"/>
             </td>
          </tr>
          <tr>
             <td class="tbtd_caption"><label for="uploadFile">파일첨부</label></td>
             <td class="tbtd_content">
                <input type="file" id="uploadFile" name="uploadFile" onChange="fn_fileChange();"/>
                <span id="fileNmSpan">${billInfo.fileNm}</span>
             </td>
          </tr>
       </table>
      </div>
      <!-- 타이틀-->
      <div id="title">
          <ul>
             <li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>
                          처리내역
             </li>
          </ul>
      </div>
      <!-- // 상세정보 -->
      <div id="table">
       <table width="100%" border="1" cellpadding="0" cellspacing="0" style="bordercolor:#D3E2EC; bordercolordark:#FFFFFF; BORDER-TOP:#C2D0DB 2px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-RIGHT:#ffffff 1px solid; BORDER-BOTTOM:#C2D0DB 1px solid; border-collapse: collapse;">
          <colgroup>
             <col width="150"/>
             <col width="?"/>
          </colgroup>
          <tr>
             <td class="tbtd_caption"><label for="statusCd">처리상태</label></td>
             <td class="tbtd_content">${billInfo.statusNm }</td>
          </tr>
          <tr>
             <td class="tbtd_caption"><label for="statusDt">처리일시</label></td>
             <td class="tbtd_content">${billInfo.statusDt}</td>
          </tr>
          <tr>
             <td class="tbtd_caption"><label for="approvalAmt">승인금액</label></td>
             <td class="tbtd_content">${billInfo.apprAmt}</td>
          </tr>
          <tr>		
			<td class="tbtd_caption"><label for="note">비고</label></td>	
			<td class="tbtd_content">${billInfo.note}</td>	
		  </tr>		
       </table>
      </div>
      <c:if test="${not empty billInfo.fileNm}">
      <!-- 타이틀-->
      <div id="title">
          <ul>
             <li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>
             	 영수증
             </li>
          </ul>
      </div>
      <div>
      	<img src="/img/${billInfo.filePath}${billInfo.fileNm}" alt="파일이미지" style="height: 200px;" />
      </div>
      </c:if>
      <!-- btn -->
      <div id="sysbtn">
         <ul>
            <li>
             <span class="btn_blue_l" id="btnMod">
                 <a href="javascript:fn_modifyBill();">저장</a>
                 <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
             </span>
            </li>
            <!-- 삭제버튼 클릭하면 fn_deleteStatus() -->
            <li>
             <span class="btn_blue_l" id="btnDel">
                 <a href="javascript:fn_removeBill();">삭제</a>
                 <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
             </span>
            </li>
            <!-- 닫기버튼  -->
            <li>
             <span class="btn_blue_l">
                 <a href="javascript:self.close();">닫기</a>
                 <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
             </span>
            </li>
           </ul>
      </div>
    </div>
</form:form>
</body>
</html>