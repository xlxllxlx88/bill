/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.bill.web;

import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.bill.service.BillService;
import egovframework.example.bill.service.BillVO;

@Controller
public class BillController {

	/*이현희:1. controller 만들기 (만들어져 있는거 복사)*/
	
	/*이현희:1_1. 서비스 만들기 전이지만 일단 서비스 선언*/
	//Controller는 넘어온 요청을 처리하기 위해 Service를 선언
	/** EgovSampleService */
	@Resource(name = "billService")
	private BillService billService;
	
	/*이현희:1_2. 리스트 메서드 만들기*/
	/** 경비관리 리스트 */
	// "/billList.do" 입력받으면  getBillList 메서드 찾고
	@RequestMapping(value = "/billList.do")
	//jsp에서 보낸 파라미터 받음 @ModelAttribute("billVO") BillVO billVO,
	public String getBillList(@ModelAttribute("billVO") BillVO billVO, ModelMap model) throws Exception {
		
		System.out.println("------------BillController/getBillList");
		System.out.println("------------billVO=" + billVO.toString());
		
		// 경비관리 리스트 조회하는 service 호출 (파라미터는  billVO)
		List<BillVO> list = billService.getBillList(billVO);
		// 데이터는 모델에 담고
		model.addAttribute("billList", list);
		
		//이현희:21 조회 조건 유지
		model.addAttribute("searchYm", billVO.getSearchYm());
		model.addAttribute("searchDtlCd", billVO.getSearchDtlCd());
		model.addAttribute("searchStatusCd", billVO.getSearchStatusCd());
		
		// list 호출
		return "bill/billList";
	}
	
	/*이현희:8. 등록view 메서드 만들기*/
	/** 등록화면 이동 */
	// "/billAddView.do" 입력받으면 goBillAdd 메서드를 찾음 (등록화면만 보여줌)
	@RequestMapping(value = "/billAddView.do")
	public String goBillAdd(@ModelAttribute("billVO") BillVO billVO, String insertYn, ModelMap model) throws Exception {
		
		/*이현희:15 저장 후처리 받는곳*/
		model.addAttribute("insertYn", insertYn);
		
		// billAdd - 저장 호풀
		return "bill/billAdd";
	}
	
	
	/*이현희:10. 저장 메서드 만들기*/
	/** 경비 등록 */
	// "/billAdd.do" 입력받으면 billAdd 메서드를 찾음
	@RequestMapping(value = "/billAdd.do")
	//jsp에서 보낸 파라미터 받음 @ModelAttribute("billVO") BillVO billVO,
	public String billAdd(@ModelAttribute("billVO") BillVO billVO) throws Exception {
		
		System.out.println("------------BillController/billAdd");
		System.out.println("------------billVO=" + billVO.toString());
		
		// 사용자 목록 조회하는 service 호출 (파라미터는  billVO), 리턴 없음
		billService.billAdd(billVO);
		/*이현희:14 저장 후처리 보내는곳 */
		// insertYn=Y일때 값을 안가지고 /billAddView.do로 url만 보냄
		return "redirect:/billAddView.do?insertYn=Y";
	}
	
	/*이현희:24 상세팝업 이동하는 메서드*/
	/** 등록화면 이동 */
	// "/billAddView.do" 입력받으면 goBillAdd 메서드를 찾음 (등록화면만 보여줌)
	@RequestMapping(value = "/billDtlView.do")
	public String goBillDtl(@ModelAttribute("billVO") BillVO billVO, String updateYn, String deleteYn, ModelMap model) throws Exception {
		
		System.out.println("------------BillController/goBillDtl");
		System.out.println("------------billVO=" + billVO.toString());
		System.out.println("------------updateYn=" + updateYn);
		System.out.println("------------deleteYn=" + deleteYn);
		
		Object info = billService.getBillDtl(billVO);
		model.addAttribute("billInfo", info);
		
		/*이현희:38 저장 후처리 받는곳 */
		model.addAttribute("updateYn", updateYn);
		model.addAttribute("deleteYn", deleteYn);
		model.addAttribute("searchYm", billVO.getSearchYm());
		model.addAttribute("searchDtlCd", billVO.getSearchDtlCd());
		model.addAttribute("searchStatusCd", billVO.getSearchStatusCd());
		
		return "bill/billDtl";
	}
	
	/*이현희:32 수정 메서드*/
	@RequestMapping(value = "/billModify.do")
	public String billModify(@ModelAttribute("billVO") BillVO billVO) throws Exception {
		
		System.out.println("------------BillController/billModify");
		System.out.println("------------billVO=" + billVO.toString());
		
		billService.billModify(billVO);
		/*이현희:37 저장 후처리 보내는곳 */
		return "redirect:/billDtlView.do?billNum=" + billVO.getBillNum() + "&updateYn=Y";
	}
	
	// 이현희:41 삭제
	@RequestMapping(value = "/billRemove.do")
	public String billRemove(@ModelAttribute("billVO") BillVO billVO) throws Exception {
		
		System.out.println("------------BillController/billRemove");
		System.out.println("------------billVO=" + billVO.toString());
		
		billService.billRemove(billVO);
		
		return "redirect:/billDtlView.do?deleteYn=Y";
	}
	
	//이현희:48 엑셀다운로드 컨트롤러
	@RequestMapping(value = "/billExcelDown.do")
	public void billExcelDown(@ModelAttribute("billVO") BillVO billVO, HttpServletResponse response) throws Exception {
		
		OutputStream out = null;
        
        try {
            HSSFWorkbook workbook = BillExcelDownload(billVO);
            
            Date today = new Date();
            SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmm");
            System.out.println("--------------------" + format.format(today));
            response.reset();
            response.setHeader("Content-Disposition", "attachment;filename=bill_" + format.format(today) + ".xls");
            response.setContentType("application/vnd.ms-excel");
            out = new BufferedOutputStream(response.getOutputStream());
            
            workbook.write(out);
            out.flush();
            
        } catch (Exception e) {
        	System.out.println("exception during downloading excel file");
        	e.printStackTrace();
        } finally {
            if(out != null) out.close();
        }    
		
	}
	
	//이현희:47 엑셀다운로드 객체 생성
	public HSSFWorkbook BillExcelDownload(BillVO billVO) throws Exception {
        
        
        HSSFWorkbook workbook = new HSSFWorkbook();
        
        HSSFSheet sheet = workbook.createSheet("엑셀시트명");
        
        HSSFRow row = null;
        
        HSSFCell cell = null;
        
        List<BillVO> list = billService.getBillList(billVO);
        
        row = sheet.createRow(0);
        String[] headerKey = {"순번", "사용일", "사용내역", "사용금액", "승인금액", "처리상태", "등록일"};
        
        for(int i=0; i<headerKey.length; i++) {
            cell = row.createCell(i);
            cell.setCellValue(headerKey[i]);
        }
        
        for(int i=0; i<list.size(); i++) {
            row = sheet.createRow(i + 1);
            Map<String, Object> vo = (Map<String, Object>)list.get(i);
            // 순번
            cell = row.createCell(0);
//            cell.setCellValue(vo.getEx1());
            cell.setCellValue(String.valueOf(vo.get("no")));
            
            // 사용일
            cell = row.createCell(1);
//            cell.setCellValue(vo.getUseDt());
            cell.setCellValue((String)vo.get("useDt"));
            
            // 사용내역
            cell = row.createCell(2);
//            cell.setCellValue(vo.getDtlNm());
            cell.setCellValue((String)vo.get("dtlNm"));
            
            // 사용금액
            cell = row.createCell(3);
//            cell.setCellValue(vo.getUseAmt());
            cell.setCellValue(String.valueOf(vo.get("useAmt")));
            
            // 승인금액
            cell = row.createCell(4);
//            cell.setCellValue(vo.getApprAmt());
            cell.setCellValue(String.valueOf(vo.get("apprAmt")));
            
            // 처리상태
            cell = row.createCell(5);
//            cell.setCellValue(vo.getStatusNm());
            cell.setCellValue((String)vo.get("statusNm"));
            
            // 등록일
            cell = row.createCell(6);
//            cell.setCellValue(vo.getRegDt());
            cell.setCellValue((String)vo.get("regDt"));
 
        }
        
        return workbook;
    }
	

}