package com.mc.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class FileUploadUtil {
    public  static void deleteFile(String filename, String dir) throws IOException {
        Path filePath = Paths.get(dir+filename);
        Files.deleteIfExists(filePath); // 리뷰 이미지 없이 리뷰 쓴 경우 예외 방지
        /*Files.delete(filePath);*/  // 이거를 사용하면 리뷰 삭제 시 이미지 파일이 없으면 프로그램 중단시킴.
    }
    public static void saveFile(MultipartFile mf, String dir, String savedFilename) throws IOException {
        byte [] data;

        try {
            data = mf.getBytes();
            FileOutputStream fo =
                    new FileOutputStream(dir+savedFilename);
            fo.write(data);
            fo.close();

        }catch(Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}