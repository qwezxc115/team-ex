package com.team.service;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.team.domain.CBCriteria;
import com.team.domain.CBFileVO;
import com.team.domain.CBoardVO;
import com.team.mapper.CBFileMapper;
import com.team.mapper.CBoardMapper;

import lombok.Setter;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class CBoardServiceImpl implements CBoardService {

	
	
	private String bucketName;
	private String profileName;
	private S3Client s3;
	
	
	 @Setter (onMethod_=@Autowired)
	 private CBoardMapper mapper;
	 
	 @Setter (onMethod_=@Autowired)
	 private CBFileMapper filemapper;
	
	
	 
	//s3 파일 업로드 연동  코드 !
	 
	public CBoardServiceImpl() {
		this.bucketName = "choongang-gohome";
		this.profileName = "gohome1";
		
		/*  
		 * create
		 *  /home/tomcat/.aws/credentials
		 */
		
		/*
		 * Path contentLocation = new File(System.getProperty("user.home") +
		 * "/.aws/credentials").toPath(); ProfileFile pf = ProfileFile.builder()
		 * .content(contentLocation) .type(ProfileFile.Type.CREDENTIALS) .build();
		 * ProfileCredentialsProvider pcp = ProfileCredentialsProvider.builder()
		 * .profileFile(pf) .profileName(profileName) .build();
		 * 
		 * this.s3 = S3Client.builder() .credentialsProvider(pcp) .build();
		 */
	}
 
	 
	 
	//파일 업로드 
	
	@Override
	@Transactional
	public void cbfregister(CBoardVO cboard, MultipartFile file) {
		cbregister(cboard);
		
		if(file !=null && file.getSize() > 0) {
			
		
			CBFileVO vo = new CBFileVO();
			vo.setBno(cboard.getBno());
			vo.setFileName(file.getOriginalFilename());
			
			filemapper.cbfinsert(vo);
			upload(cboard, file);
		}
	}

	private void upload(CBoardVO cboard, MultipartFile file) {

		try (InputStream is = file.getInputStream()) {		
			PutObjectRequest objectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key("cboard/" + cboard.getBno() + "/" + file.getOriginalFilename())
					.contentType(file.getContentType())
					.acl(ObjectCannedACL.PUBLIC_READ)
			.build();
			
			s3.putObject(objectRequest, 
					RequestBody.fromInputStream(is, file.getSize()));
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		
	}
	
	
	 
	 
	//게시글 저장 
	@Override
	public void cbregister(CBoardVO cboard) {
		
		mapper.cbinsertSelectKey(cboard);
		
	}

	//게시글 읽어오기 
	@Override
	public CBoardVO getcb(Long bno) {
		return mapper.readcb(bno);
	}


	//게시글 리스트 가져오기 
	@Override
	public List<CBoardVO> getcbList(CBCriteria cri) {
		
		return mapper.getcbListWithPaging(cri);
	}

	// 게시글 리스트 가져오기 마이페이지
	@Override
	public List<CBoardVO> getcbList(String writer) {
		return mapper.getcbList(writer);
	}
	

	@Override
	public int getcbToal(CBCriteria cri) {
		return mapper.getcbTotalCount(cri);
	}







	@Override
	public boolean cbfmodify(CBoardVO cboard, MultipartFile file) {
		
		if (file != null & file.getSize() > 0) {
			// s3는 삭제 후 재업로드
			CBoardVO oldBoard = mapper.readcb(cboard.getBno());
			removecbFile(oldBoard);
			upload(cboard, file);

			
			filemapper.cbfdeleteBybno(cboard.getBno());

			CBFileVO vo = new CBFileVO();
			vo.setBno(cboard.getBno());
			vo.setFileName(file.getOriginalFilename());
			filemapper.cbfinsert(vo);
		}
		return cbmodify(cboard);
	}

	
	@Override
	public boolean cbmodify(CBoardVO cboard) {
		return mapper.cbupdate(cboard) == 1;
	}
	

	@Override
	@Transactional
	public boolean cbremove(Long bno) {
		
		
		
		//s3 저장한 파일 삭제
		CBoardVO vo = mapper.readcb(bno);
		removecbFile(vo);
		
		int cnt = mapper.cbdelete(bno);
		
		return cnt == 1;
	}

	private void removecbFile(CBoardVO vo) {
//		String bucketName = "";
		String key ="cboard/" + vo.getBno() + "/" + vo.getFileName();
				

		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();

		s3.deleteObject(deleteObjectRequest);
	}



	@Override
	public List<CBoardVO> getCbMainList() {
		return mapper.getCbMainList();
	}
	

}
