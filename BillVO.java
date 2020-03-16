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
package egovframework.example.bill.service;

import org.springframework.web.multipart.MultipartFile;

import egovframework.example.sample.service.SampleDefaultVO;

/**
 * @Class Name : SampleVO.java
 * @Description : SampleVO Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */
public class BillVO extends SampleDefaultVO {
	/*이현희:2. VO 만들기*/
	static final long serialVersionUID = 1L;

	private int    no;					// 순번
	private int    billNum;				// 청구번호
	private String useDt;				// 사용일
	private String dtlCd;				// 사용내역코드
	private String dtlNm;				// 사용내역명
	private int    useAmt;				// 사용금액
	private int    apprAmt;			    // 승인금액
	private String statusCd;			// 처리상태코드
	private String statusNm;			// 처리상태명
	private String regDt;			    // 등록일
	private String fileNm;				// 파일명
	private String filePath;			// 파일경로
	private int    progSeq;				// 처리순번
	private String statusDt;			// 처리일시
	private String note;				// 비고
	private MultipartFile uploadFile;	// 파일

	// 검색조건
	private String searchYm;			// 등록연월(검색조건)
	private String searchDtlCd;			// 사용내역(검색조건)
	private String searchStatusCd;		// 처리상태(검색조건)
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getBillNum() {
		return billNum;
	}
	public void setBillNum(int billNum) {
		this.billNum = billNum;
	}
	public String getUseDt() {
		return useDt;
	}
	public void setUseDt(String useDt) {
		this.useDt = useDt;
	}
	public String getDtlCd() {
		return dtlCd;
	}
	public void setDtlCd(String dtlCd) {
		this.dtlCd = dtlCd;
	}
	public String getDtlNm() {
		return dtlNm;
	}
	public void setDtlNm(String dtlNm) {
		this.dtlNm = dtlNm;
	}
	public int getUseAmt() {
		return useAmt;
	}
	public void setUseAmt(int useAmt) {
		this.useAmt = useAmt;
	}
	public int getApprAmt() {
		return apprAmt;
	}
	public void setApprAmt(int apprAmt) {
		this.apprAmt = apprAmt;
	}
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public String getStatusNm() {
		return statusNm;
	}
	public void setStatusNm(String statusNm) {
		this.statusNm = statusNm;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public int getProgSeq() {
		return progSeq;
	}
	public void setProgSeq(int progSeq) {
		this.progSeq = progSeq;
	}
	public String getStatusDt() {
		return statusDt;
	}
	public void setStatusDt(String statusDt) {
		this.statusDt = statusDt;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getSearchYm() {
		return searchYm;
	}
	public void setSearchYm(String searchYm) {
		this.searchYm = searchYm;
	}
	public String getSearchDtlCd() {
		return searchDtlCd;
	}
	public void setSearchDtlCd(String searchDtlCd) {
		this.searchDtlCd = searchDtlCd;
	}
	public String getSearchStatusCd() {
		return searchStatusCd;
	}
	public void setSearchStatusCd(String searchStatusCd) {
		this.searchStatusCd = searchStatusCd;
	}
	@Override
	public String toString() {
		return "BillVO [billNum=" + billNum + ", useDt=" + useDt + ", dtlCd=" + dtlCd + ", dtlNm=" + dtlNm + ", useAmt="
				+ useAmt + ", apprAmt=" + apprAmt + ", statusCd=" + statusCd + ", statusNm=" + statusNm + ", regDt="
				+ regDt + ", fileNm=" + fileNm + ", filePath=" + filePath + ", progSeq=" + progSeq + ", statusDt="
				+ statusDt + ", note=" + note + ", uploadFile=" + uploadFile + ", searchYm=" + searchYm
				+ ", searchDtlCd=" + searchDtlCd + ", searchStatusCd=" + searchStatusCd + "]";
	}
	
}
