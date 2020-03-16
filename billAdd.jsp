<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 이현희:9. 등록 jsp 만들기 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title> 경비 등록/수정
    </title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script type="text/javaScript" language="javascript" defer="defer">
       
	    $(document).ready(function(){
	        
	    	// 이현희:16 저장 후처리 화면
	    	if('${insertYn}' == 'Y') {
		   	   alert("저장되었습니다.");
	 		   opener.parent.fn_popCallBack('add');
	        }
	    	
	    });
	    
	    // 이현희:9_3. 저장버튼 이벤트 만들기 
	    function fn_add() {
	    	// 이현희:9_3_1. 필수 값 체크
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
	    	
	    	// 영수증 파일
	    	// 파일이 없을 때
	    	if (!$("#uploadFile").val()) {
	    		alert("영수증파일을 등록해주세요.");
	    		$("#uploadFile").focus();
	    		return;
	    	}
	    	
	    	// 이현희:9_3_2. 저장할 데이터 post 방식으로 넘기기
	    	$("#addForm").prop('action', 'billAdd.do');
	        $("#addForm").prop('method', 'post');
	        $("#addForm").submit();
	    }
	    
    </script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

<form:form commandName="billVO"  id="addForm"  name="addForm" enctype="multipart/form-data">
    <div id="content_pop">
       <!-- 타이틀 -->
       <div id="title">
          <ul>
             <li>
             	<img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>
                                경비 등록/수정
             </li>
          </ul>
       </div>
       <!-- // 상세정보 등록 -->
       <!-- 이현희:9_1. 등록 input 만들기 -->
       <div id="table">
       <table width="100%" border="1" cellpadding="0" cellspacing="0" style="bordercolor:#D3E2EC; bordercolordark:#FFFFFF; BORDER-TOP:#C2D0DB 2px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-RIGHT:#ffffff 1px solid; BORDER-BOTTOM:#C2D0DB 1px solid; border-collapse: collapse;">
          <colgroup>
             <col width="150"/>
             <col width="?"/>
          </colgroup>
          <tr>
             <td class="tbtd_caption"><label for="dtlCd">사용내역 *</label></td>
             <td class="tbtd_content">
                 <select id="dtlCd_id" name="dtlCd">
                   <!-- 아무것도 선택하기 전에는 '선택'으로 표시 -->
                   <option value=""   label="선택"/>
                   <option value="NB" label="식대(야근)"/> 
                   <option value="NT" label="택시비(야근)"/> 
                   <option value="HT" label="택시비(회식)"/> 
                   <option value="S"  label="사무용품 구매"/> 
                   <option value="G"  label="교육비"/> 
                   <option value="J"  label="접대비"/> 
                </select>
             </td>
          </tr>
          <tr>
             <td class="tbtd_caption"><label for="useDt">사용일 *</label></td>
             <td class="tbtd_content">
                <form:input path="useDt" cssClass="txt" maxlength="8"/>
             </td>
          </tr>
          <tr>
             <td class="tbtd_caption"><label for="useAmt">금액 *</label></td>
             <td class="tbtd_content">
                <form:input path="useAmt" maxlength="30" cssClass="txt"  />
             </td>
          </tr>
          <tr>
             <td class="tbtd_caption"><label for="uploadFile">영수증 *</label></td>
             <td class="tbtd_content">
                <input multiple="multiple" type="file" id="uploadFile" name="uploadFile"/>
             </td>
          </tr>
       </table>
      </div>
      <!-- btn -->
      <div id="sysbtn">
         <ul>
         	  <!-- 등록버튼 클릭하면 fn_add() -->
         	  <!-- 이현희:9_2. 버튼 만들기 -->
              <li>
            	  <span class="btn_blue_l">
                      <a href="javascript:fn_add();">저장</a>
                      <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                  </span>
              </li>
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