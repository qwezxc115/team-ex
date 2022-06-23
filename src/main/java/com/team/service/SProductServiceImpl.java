package com.team.service;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.team.domain.SPCriteria;
import com.team.domain.SProductVO;
import com.team.domain.Store_fileVO;
import com.team.mapper.SProductMapper;
import com.team.mapper.Store_fileMapper;

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
public class SProductServiceImpl implements SProductService {
	   private String bucketName;
	   private String profileName;
	   private S3Client s3;

	   @Setter (onMethod_ = @Autowired)
	   private SProductMapper mapper;

	   @Setter (onMethod_ = @Autowired)
	   private Store_fileMapper fileMapper;
	   
	   
	   
	   
	   public SProductServiceImpl() {
       
			this.bucketName = "choongang-gohome";
			this.profileName = "gohome1";


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
		public void register(SProductVO svo) {
			mapper.insertSelectKey(svo);
		}
	   
	   
	   @Override  
	   @Transactional // 트랜잭션 작동 여부 확인
	   public void register(SProductVO svo, MultipartFile[] mfile) {
		   register(svo);
	      
	      for (MultipartFile store_file : mfile) { 

	         if (store_file != null && store_file.getSize() > 0) {
	            Store_fileVO sfvo = new Store_fileVO();
	            sfvo.setPno(svo.getPno());
	            sfvo.setFileName(store_file.getOriginalFilename());

	            fileMapper.insert(sfvo);
				upload(svo, store_file);
	         }
	      }
	     }

	   // s3에 파일 업로드 
	   private void upload(SProductVO svo, MultipartFile mfile) {
		   log.info("####################################3");
		   log.info(svo.getPno() + "/" + mfile.getOriginalFilename());
		   log.info("####################################3");

		      try (InputStream is = mfile.getInputStream()) {
			       PutObjectRequest objectRequest = PutObjectRequest.builder()
			        	   .bucket(bucketName)
			               .key("store/" +svo.getPno() + "/" + mfile.getOriginalFilename())
			               .contentType(mfile.getContentType())
			               .acl(ObjectCannedACL.PUBLIC_READ)
			               .build();		   
			         
			       s3.putObject(objectRequest,
			    		   RequestBody.fromInputStream(is, mfile.getSize()));
			         
		      } catch (Exception e) {
			      throw new RuntimeException(e);
			  }

	   	}
		
	  
	   
	    @Override
	    public SProductVO read(Long pno) {
	    	
	 	   SProductVO svo = mapper.read(pno);
	 	   
	 	   List<String> store_file = fileMapper.getByPno(pno);
	 	      svo.setFileName(store_file);
	 	      return svo;
	    }

		@Override
		public boolean modify(SProductVO svo) {
			return mapper.update(svo) == 1;
		}	    
	    
		
		
		@Override
		@Transactional
		public boolean modify(SProductVO svo, MultipartFile[] store_file) {
			
			if (store_file.length > 0 && store_file[0].getSize() > 0) {

				SProductVO oldimage = mapper.read(svo.getPno());
				removeFile(oldimage);
	
				fileMapper.deleteByPno(svo.getPno());
			}
			for (MultipartFile file : store_file) {
				log.info("테스트:" + file.toString());

				if (file != null & file.getSize() > 0) {

					Store_fileVO sfvo = new Store_fileVO();
					sfvo.setPno(svo.getPno());
					sfvo.setFileName(file.getOriginalFilename());
					fileMapper.insert(sfvo);
					upload(svo, file);
				}
			}
			return modify(svo);
		}
	    

		
		
		
		@Override
		@Transactional
		public boolean remove(Long pno) {
			// 댓글 삭제
			// replyMapper.deleteByPno(pno);
			
			// 파일 삭제 (s3)
			SProductVO vo = mapper.read(pno);
			removeFile(vo);
			
			// 파일 삭제 (db)
			fileMapper.deleteByPno(pno);
			
			
			// 게시물 삭제
			int cnt = mapper.delete(pno);
			
			return cnt == 1;
		}
 
		
		private void removeFile(SProductVO svo) {
			for (String fileName : svo.getFileName()) {
				String key = "store/" + svo.getPno() + "/" + fileName;
			
			DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
					.bucket(bucketName)
					.key(key)
					.build();
			
			s3.deleteObject(deleteObjectRequest);
		}
		}
		


	    @Override
	    public List<SProductVO> getCateList(SPCriteria cri) {
	       return mapper.getCateListWithPaging(cri);
	    }
	    
	    
	   @Override
	   public int getTotal(SPCriteria cri) {
	      return mapper.getTotalCount(cri); 
	   }

		@Override
		public List<SProductVO> getsproductMainList() {

			return mapper.getsproductMainList();
		}



	}
