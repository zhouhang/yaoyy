package com.ms.tools;

import com.google.common.io.ByteStreams;
import com.google.common.io.Files;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;

/**
 * 文件工具类
 */
public class FileUtil {

    private static Logger logger = LoggerFactory.getLogger(FileUtil.class);

    private FileUtil() {
    }

    public static String getFileExt(String fileName) {
        int index = fileName.lastIndexOf('.');
        if (index == -1) {
            return "";
        }
        String ext = fileName.substring(index);
        return ext;
    }

    public static String getFilePathNoExt(String fileName) {
        int index = fileName.lastIndexOf('.');
        if (index == -1) {
            return "";
        }
        String path = fileName.substring(0, index);
        return path;
    }

    public static File save(InputStream inputStream, String path, String fileName) throws IOException {
        File file = new File(path, fileName);
        if (file.exists()) {
            throw new RuntimeException("该文件已存在!");
        }
        //OutputStream out = new FileOutputStream(file);
        // TODO:资源保存后会出现资源诶JAVA虚拟机占用的情况
        Files.createParentDirs(file);
        Files.write(ByteStreams.toByteArray(inputStream), file);
//        inputStream.close();
        return file;
    }

    /**
     * 删除单个文件
     * @param   fileName    被删除文件的文件名
     * @return 单个文件删除成功返回true,否则返回false
     */
    public static boolean deleteFile(String fileName){
        File file = new File(fileName);
        if(file.isFile() && file.exists()){
            file.delete();
            return true;
        }else{
            return false;
        }
    }
}

