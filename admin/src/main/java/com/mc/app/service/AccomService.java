package com.mc.app.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.mc.app.dto.Accommodations;
import com.mc.app.frame.MCService;
import com.mc.app.repository.AccomRepository;
import com.mc.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.function.Consumer;

@Service
@RequiredArgsConstructor
public class AccomService implements MCService<Accommodations,Integer> {

    final AccomRepository accomRepository;

    @Value("${app.dir.uploadimgdir}")
    String uploadDir;

    ///  숙소 추가
    @Override
    public void add(Accommodations acc) throws Exception {
        // 이미지 업로드
        acc.setImage1Name(acc.getImage1().getOriginalFilename());
        FileUploadUtil.saveFile(acc.getImage1(), uploadDir);

        accomRepository.insert(acc);
    }

    ///  숙소 수정
    @Override
    public void mod(Accommodations acc) throws Exception {
        // 이미지 교체 작업
        handleImage(acc.getImage1(), acc.getImage1Name(), acc::setImage1Name);
        handleImage(acc.getImage2(), acc.getImage2Name(), acc::setImage2Name);
        handleImage(acc.getImage3(), acc.getImage3Name(), acc::setImage3Name);
        handleImage(acc.getImage4(), acc.getImage4Name(), acc::setImage4Name);
        handleImage(acc.getImage5(), acc.getImage5Name(), acc::setImage5Name);
        
        accomRepository.update(acc);
    }

    ///  숙소 삭제
    @Override
    public void del(Integer accId) throws Exception {
        String imgname = accomRepository.selectOne(accId).getImage1Name();
        FileUploadUtil.deleteFile(imgname, uploadDir);
        accomRepository.delete(accId);
    }


    ///  호스트 id 일치하는 모든 숙소 가져오기 (페이지로)
    /// 스페이스 관리 > 내 스페이스 에서 사용
    public Page<Accommodations> getPageByHostId(String s, int pageNo) throws Exception {
        PageHelper.startPage(pageNo, 6); // 한 페이지에 6개씩 표시
        return accomRepository.selectPageByHostId(s);
    }
    
    /// 호스트 id 일치하는 모든 숙소 가져오기 (리스트로)
    public List<Accommodations> getListByHostId(String s) throws Exception {
        return accomRepository.selectListByHostId(s);
    }

    /// 숙소 id 일치하는 개별 숙소 가져오기
    /// 스페이스 관리 > 내 스페이스 > 수정 에서 사용
    @Override
    public Accommodations get(Integer integer) throws Exception {
        return accomRepository.selectOne(integer);
    }

    ///  호스트가 보유한 숙소 수 가져오기
    public int getAccommodationCountByHost(String hostId) throws Exception {
        return accomRepository.countByHostId(hostId);
    }

    /// 아래는 사용하지 않는 오버라이드 기본 함수
    @Override
    public List<Accommodations> get() throws Exception {
        return accomRepository.select();
    }

    // 공통 이미지 처리 메서드
    private void handleImage(MultipartFile imageFile, String oldFileName, Consumer<String> setNewFileName) throws Exception {
        if (imageFile != null && !imageFile.isEmpty()) {
            // 기존 파일 삭제
            FileUploadUtil.deleteFile(oldFileName, uploadDir);

            // 새 파일명 설정 및 저장
            String newFileName = imageFile.getOriginalFilename();
            setNewFileName.accept(newFileName);
            FileUploadUtil.saveFile(imageFile, uploadDir);
        }
    }
}
