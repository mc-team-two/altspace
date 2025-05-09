package com.mc.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Slf4j
public class FileUploadUtil {
    // 파일 삭제
    public static void deleteFile(String filename, String dir) throws IOException {
        if (filename == null || filename.isEmpty()) {
            log.warn("삭제할 파일명이 비어있습니다.");
            return;
        }

        Path filePath = Paths.get(dir, filename);
        Files.deleteIfExists(filePath);
        log.info("파일 삭제 완료: " + filePath.toString());
    }
    // 파일 저장
    public static void saveFile(MultipartFile mf, String dir) throws IOException {
        if (mf == null || mf.isEmpty()) {
            log.warn("업로드할 파일이 비어있습니다.");
            return;
        }

        String filename = mf.getOriginalFilename();
        if (filename == null || filename.isEmpty()) {
            log.warn("파일 이름이 비어있습니다. 저장을 건너뜁니다.");
            return;
        }

        // 디렉토리 생성
        File folder = new File(dir);
        if (!folder.exists()) {
            folder.mkdirs();
            log.info("디렉토리 생성: " + folder.getAbsolutePath());
        }

        Path filePath = Paths.get(dir, filename);

        try (FileOutputStream fos = new FileOutputStream(filePath.toFile())) {
            fos.write(mf.getBytes());
            log.info("파일 저장 완료: " + filePath.toString());
        } catch (Exception e) {
            log.error("파일 저장 중 오류 발생", e);
            throw e;
        }
    }

    // 파일 저장 2
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