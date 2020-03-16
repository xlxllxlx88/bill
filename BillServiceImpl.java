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
package egovframework.example.bill.service.impl;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.bill.service.BillService;
import egovframework.example.bill.service.BillVO;
import egovframework.example.cost.service.CostVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("billService")
public class BillServiceImpl extends EgovAbstractServiceImpl implements BillService {

	/*이현희:4. 서비스 임플 만들기(처음만들때 리스트가져오는 메서드 까지 같이 만듦)*/
	private static final Logger LOGGER = LoggerFactory.getLogger(BillServiceImpl.class);

	//impl은 넘어온 요청을 처리하기 위해 mapper를 호출하기 위해 mapper선언
	@Resource(name="billMapper")
	private BillMapper billMapper;
	
	/** 경비관리 리스트 */
	@Override
	public List<BillVO> getBillList(BillVO billVO) throws Exception {
		System.out.println("------------BillServiceImpl/getBillList");
		System.out.println("------------BillServiceImpl/getBillList billVO=" + billVO.toString());
		
		// 경비관리 리스트 조회하는 mapper 호출	
		List<BillVO> result = billMapper.getBillList(billVO);
		return result;
	}
	
	/*이현희:11. 저장 서비스임플 만들기*/
	/** 경비 등록 */
	@Override
	public void billAdd(BillVO billVO) throws Exception {
		System.out.println("------------BillServiceImpl/billAdd");
		System.out.println("------------BillServiceImpl/billAdd billVO=" + billVO.toString());
		
		/*이현희:11_1. 파일저장*/
		//파일첨부
		MultipartFile mf = billVO.getUploadFile();
		
		// 파일이 존재한다면
		if(mf != null) {
			//업로드한 파일 이름, 저장할 위치
			String fileNm = mf.getOriginalFilename();
			String filePath = "bill\\";
			
			// update에 필요한 정보 세팅
			billVO.setFileNm(fileNm);		
			billVO.setFilePath(filePath);
			
			try {
				// 파일생성 "C:\\img\\" 밑에 실제 경로 "bill\\" + 파일이름
				mf.transferTo(new File("C:\\img\\" + filePath + fileNm));
			} catch (Exception e) {
				// try문에서 에러발생 시 오류 출력
				e.printStackTrace();
			}
		}
		
		/*이현희:11_1. 데이터 저장*/
		// 경비관리 등록하는 mapper 호출
		billMapper.billAdd(billVO);
		
	}
	
	/*이현희:26 경비상세 메서드*/
	public Object getBillDtl(BillVO billVO) throws Exception {
		System.out.println("------------BillServiceImpl/getBillDtl");
		System.out.println("------------BillServiceImpl/getBillDtl billVO=" + billVO.toString());
		Object info = billMapper.selectBillDtl(billVO);
		return info; 
	}
	
	/*이현희:34. 수정 서비스임플 만들기*/
	/** 경비 등록 */
	@Override
	public void billModify(BillVO billVO) throws Exception {
		System.out.println("------------BillServiceImpl/billModify");
		System.out.println("------------BillServiceImpl/billModify billVO=" + billVO.toString());
		
		/*이현희:11_1. 파일저장*/
		//파일첨부
		MultipartFile mf = billVO.getUploadFile();
		
		// 파일이 존재한다면
		if(mf != null) {
			//업로드한 파일 이름, 저장할 위치
			String fileNm = mf.getOriginalFilename();
			String filePath = "bill\\";
			
			// update에 필요한 정보 세팅
			billVO.setFileNm(fileNm);		
			billVO.setFilePath(filePath);
			
			try {
				// 파일생성 "C:\\img\\" 밑에 실제 경로 "bill\\" + 파일이름
				mf.transferTo(new File("C:\\img\\" + filePath + fileNm));
			} catch (Exception e) {
				// try문에서 에러발생 시 오류 출력
				e.printStackTrace();
			}
		}
		
		/*이현희:11_1. 데이터 저장*/
		// 경비관리 등록하는 mapper 호출
		billMapper.billModify(billVO);
		
	}
	
	/*이현희:43. 삭제메서드*/
	@Override
	public void billRemove(BillVO billVO) throws Exception {
		billMapper.billRemove(billVO);
	}
}	



