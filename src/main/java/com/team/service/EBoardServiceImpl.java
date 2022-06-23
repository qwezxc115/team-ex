package com.team.service;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.team.domain.EBCriteria;
import com.team.domain.EBFileVO;
import com.team.domain.EBoardVO;
import com.team.mapper.EBFileMapper;
import com.team.mapper.EBoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;


@Service
@Log4j
public class EBoardServiceImpl implements EBoardService {

	
	private String bucketName;
	private String profileName;
	private S3Client s3;
	
	@Setter (onMethod_=@Autowired)
	private EBoardMapper mapper;
	
	@Setter (onMethod_= @Autowired)
	private EBFileMapper filemapper;
	
	
	//s3 파일 업로드 연동  코드 !
	 
	public EBoardServiceImpl() {
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
 
	@Override
	@Transactional
	public void ebfregister(EBoardVO eboard, MultipartFile file) {
		ebregister(eboard);
		
		if(file !=null && file.getSize() > 0) {
			
			
			
			EBFileVO vo = new EBFileVO();
			vo.setEno(eboard.getEno());
			vo.setFileName(file.getOriginalFilename());
			
			filemapper.ebfinsert(vo);
			upload(eboard,file);
		}
		
	}
	private void upload(EBoardVO eboard, MultipartFile file) {
		
		try (InputStream is = file.getInputStream()) {		
			PutObjectRequest objectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key("experts/" + eboard.getEno() + "/" + file.getOriginalFilename())
					.contentType(file.getContentType())
					.acl(ObjectCannedACL.PUBLIC_READ)
			.build();
			
			s3.putObject(objectRequest, 
					RequestBody.fromInputStream(is, file.getSize()));
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		
	}
	
	
	
	//글 저장 
	@Override
	public void ebregister(EBoardVO eboard) {
		
		mapper.ebinsertSelectKey(eboard);
		
	}

	
	
	//글 읽어오기 
	@Override
	public EBoardVO geteb(Long eno) {
		log.info(mapper);
		log.info(eno);
		return mapper.readeb(eno);
	}

	//글 리스트 가져오기 
	@Override
	public List<EBoardVO> getebList(EBCriteria cri) {
		return mapper.getebListWithPaging(cri);
	}
	
	@Override
	public int getebToal(EBCriteria cri) {
		return mapper.getebTotalCount(cri);
	}

	
	

	@Override
	public boolean ebfmodify(EBoardVO eboard, MultipartFile file) {
		
		if(file != null & file.getSize() > 0) {
			
			EBoardVO oldboard = mapper.readeb(eboard.getEno());
			removeebFile(oldboard);
			upload(eboard,file);
			
			// _file은 삭제 후 인서트
			filemapper.ebfdeleteBybno(eboard.getEno());
			
			EBFileVO vo = new EBFileVO();
			vo.setEno(eboard.getEno());
			vo.setFileName(file.getOriginalFilename());
			filemapper.ebfinsert(vo);
			
		}
		
		return ebmodify(eboard);
	}
	
	
	@Override
	public boolean ebmodify(EBoardVO eboard) {
		return mapper.ebupdate(eboard) == 1;
	}

	@Override
	@Transactional
	public boolean ebremove(Long eno) {
		
		EBoardVO vo = mapper.readeb(eno);
		removeebFile(vo);
		int cnt = mapper.ebdelete(eno);
		return cnt == 1;
	}
	
	private void removeebFile(EBoardVO vo) {
		String key ="experts/" + vo.getEno() + "/" + vo.getFileName();
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();

		s3.deleteObject(deleteObjectRequest);
	}
	
	
}
