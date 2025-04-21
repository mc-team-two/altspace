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

import java.util.List;

@Service
@RequiredArgsConstructor
public class AccomService implements MCService<Accommodations,Integer> {

    final AccomRepository accomRepository;

    @Value("${app.dir.uploadimgdir}")
    String uploadDir;

    @Override
    public void add(Accommodations acc) throws Exception {
        acc.setImage1Name(acc.getImage1().getOriginalFilename());
        FileUploadUtil.saveFile(acc.getImage1(), uploadDir);
        accomRepository.insertAccommodation(acc);
    }

    @Override
    public void mod(Accommodations acc) throws Exception {

        // 1. 새로운 이미지가 없을때
        if(acc.getImage1().isEmpty()){
            accomRepository.updateAccommodation(acc);
        }
        // 2. 새로운 이미지가 있을때
        else{
            FileUploadUtil.deleteFile(acc.getImage1Name(), uploadDir);
            acc.setImage1Name(acc.getImage1().getOriginalFilename());
            accomRepository.updateAccommodation(acc);
            FileUploadUtil.saveFile(acc.getImage1(), uploadDir);
        }

        // 1. 새로운 이미지가 없을때
        if(acc.getImage2().isEmpty()){
            accomRepository.updateAccommodation(acc);
        }
        // 2. 새로운 이미지가 있을때
        else{
            FileUploadUtil.deleteFile(acc.getImage2Name(), uploadDir);
            acc.setImage2Name(acc.getImage2().getOriginalFilename());
            accomRepository.updateAccommodation(acc);
            FileUploadUtil.saveFile(acc.getImage2(), uploadDir);
        }

        // 1. 새로운 이미지가 없을때
        if(acc.getImage3().isEmpty()){
            accomRepository.updateAccommodation(acc);
        }
        // 2. 새로운 이미지가 있을때
        else{
            FileUploadUtil.deleteFile(acc.getImage3Name(), uploadDir);
            acc.setImage3Name(acc.getImage3().getOriginalFilename());
            accomRepository.updateAccommodation(acc);
            FileUploadUtil.saveFile(acc.getImage3(), uploadDir);
        }

        // 1. 새로운 이미지가 없을때
        if(acc.getImage4().isEmpty()){
            accomRepository.updateAccommodation(acc);
        }
        // 2. 새로운 이미지가 있을때
        else{
            FileUploadUtil.deleteFile(acc.getImage4Name(), uploadDir);
            acc.setImage4Name(acc.getImage4().getOriginalFilename());
            accomRepository.updateAccommodation(acc);
            FileUploadUtil.saveFile(acc.getImage4(), uploadDir);
        }

        // 1. 새로운 이미지가 없을때
        if(acc.getImage5().isEmpty()){
            accomRepository.updateAccommodation(acc);
        }
        // 2. 새로운 이미지가 있을때
        else{
            FileUploadUtil.deleteFile(acc.getImage5Name(), uploadDir);
            acc.setImage5Name(acc.getImage5().getOriginalFilename());
            accomRepository.updateAccommodation(acc);
            FileUploadUtil.saveFile(acc.getImage5(), uploadDir);
        }

        accomRepository.updateAccommodation(acc);
    }

    @Override
    public void del(Integer accId) throws Exception {
        String imgname = accomRepository.selectOne(accId).getImage1Name();
        FileUploadUtil.deleteFile(imgname, uploadDir);
        accomRepository.delete(accId);
    }

    @Override
    public Accommodations get(Integer integer) throws Exception {
        return accomRepository.selectOne(integer);
    }

    @Override
    public List<Accommodations> get() throws Exception {
        return accomRepository.select();
    }

    public List<Accommodations> getByHostId(String s) throws Exception {
        return accomRepository.selectByHostId(s);
    }

    public Page<Accommodations> getPageByHostId(String s, int pageNo) throws Exception {
        PageHelper.startPage(pageNo, 3); // 한 페이지에 3개씩 표시
        return accomRepository.selectPageByHostId(s);
    }

}
