package com.team.service;

import java.io.InputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.team.domain.Criteria;
import com.team.domain.NoticeVO;
import com.team.domain.Notice_fileVO;
import com.team.mapper.CsMapper;
import com.team.mapper.Notice_fileMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
@Log4j
public class CsServiceImpl implements CsService {

	private String bucketName;
	private String profileName;
	private S3Client s3;

	@Setter(onMethod_ = @Autowired)
	private CsMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private Notice_fileMapper fileMapper;

	public CsServiceImpl() {
		this.bucketName = "choongang-comzjaal";
		this.profileName = "spring1";

		//		   Path contentLocation = new File(System.getProperty("user.home") + "/.aws/credentials").toPath();
		//		      ProfileFile pf = ProfileFile.builder()
		//		            .content(contentLocation)
		//		            .type(ProfileFile.Type.CREDENTIALS)
		//		            .build();
		//		      ProfileCredentialsProvider pcp = ProfileCredentialsProvider.builder()
		//		            .profileFile(pf)
		//		            .profileName(profileName)
		//		            .build();
		//		      
		//		      this.s3 = S3Client.builder()
		//		            .credentialsProvider(pcp)
		//		            .build();
	}

	@Override
	public List<NoticeVO> getNoticeList(Criteria cri) {

		return mapper.getNoticeList(cri);
	}

	@Override
	public int getTotalN(Criteria cri) {
		//게시글 총 갯수 구하는 매퍼  
		return mapper.getTotalCountN(cri);
	}

	@Override
	public void noticeWriting(NoticeVO nvo) {
		mapper.noticeWriting(nvo);
	}

	@Override
	public void noticeWriting(NoticeVO nvo, MultipartFile[] mfile) {
		noticeWriting(nvo);

		for (MultipartFile notice_file : mfile) {

			if (notice_file != null && notice_file.getSize() > 0) {
				Notice_fileVO nfvo = new Notice_fileVO();
				nfvo.setNno(nvo.getNno());
				nfvo.setFileName(notice_file.getOriginalFilename());

				fileMapper.insert(nfvo);
				upload_notice(nvo, notice_file);
			}
		}
	}

	// s3에 파일 업로드 
	private void upload_notice(NoticeVO nvo, MultipartFile mfile) {
		log.info("####################################s3에 올라간 파일명 확인");
		log.info(nvo.getNno() + "/" + mfile.getOriginalFilename());
		log.info("####################################s3에 올라간 파일명 확인");

		try (InputStream is = mfile.getInputStream()) {
			PutObjectRequest objectRequest = PutObjectRequest.builder().bucket(bucketName)
					.key("notice/" + nvo.getNno() + "/" + mfile.getOriginalFilename())
					.contentType(mfile.getContentType()).acl(ObjectCannedACL.PUBLIC_READ).build();

			s3.putObject(objectRequest, RequestBody.fromInputStream(is, mfile.getSize()));

		} catch (Exception e) {
			throw new RuntimeException(e);
		}

	}

	@Override
	public NoticeVO noticeReading(int nno) {
		NoticeVO nvo = mapper.noticeReading(nno);
		List<String> notice_file = fileMapper.getByNno(nno);
		nvo.setFileName(notice_file);
		return nvo;
	}

	@Override
	public boolean noticeModify(NoticeVO nvo) {
		return mapper.noticeModify(nvo) == 1;

	}

	@Override
	@Transactional
	public boolean noticeModify(NoticeVO nvo, MultipartFile[] notice_file) {

		// s3 삭제
		NoticeVO oldimage = mapper.noticeReading(nvo.getNno());
		removeNoticeFile(oldimage);

		// db delete
		fileMapper.deleteByNno(nvo.getNno());

		for (MultipartFile file : notice_file) {
			log.info("테스트:" + file.toString());

			if (file != null & file.getSize() > 0) {

				Notice_fileVO nfvo = new Notice_fileVO();
				nfvo.setNno(nvo.getNno());
				nfvo.setFileName(file.getOriginalFilename());
				fileMapper.insert(nfvo);
				upload_notice(nvo, file);
			}

		}
		return noticeModify(nvo);
	}

	// s3 noticeFile 삭제
	private void removeNoticeFile(NoticeVO nvo) {
		for (String fileName : nvo.getFileName()) {
			String key = "notice/" + nvo.getNno() + "/" + fileName;

			DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder().bucket(bucketName).key(key).build();

			s3.deleteObject(deleteObjectRequest);
		}
	}

	@Override
	public boolean noticeDelete(int nno) {

		// 파일 삭제 (s3)
		NoticeVO nvo = mapper.noticeReading(nno);
		removeNoticeFile(nvo);

		// notice 삭제
		int cnt = mapper.noticeDelete(nno);

		return cnt == 1;
	}

	//메인공지사항 글조회
	@Override
	public List<NoticeVO> getNoticeMainList() {

		return mapper.getNoticeMainList();
	}

}
