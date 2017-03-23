package com.ms.service.utils;

import com.ms.dao.model.HuqiaoSupplier;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;


/**
 * Author: koabs
 * 7/28/16.
 * 解析上传的报价excel文件
 */
public class ExcelParse {

    static Logger logger = LoggerFactory.getLogger(ExcelParse.class);

    public static List<HuqiaoSupplier> parseEnquiryXLS(InputStream inp) throws IOException, InvalidFormatException {

        List<HuqiaoSupplier> list = new ArrayList<>();

        XSSFWorkbook wb = new XSSFWorkbook(inp);
        Sheet sheet = wb.getSheetAt(0);

        // Decide which rows to process
        int rowStart = Math.max(sheet.getFirstRowNum(), 1);
        int rowEnd = sheet.getLastRowNum();

        for (int rowNum = rowStart; rowNum <= rowEnd; rowNum++) {
            Row r = sheet.getRow(rowNum);
            if (r == null) {
                continue;
            }
            HuqiaoSupplier huqiaoSupplier = new HuqiaoSupplier();

            for (int cn = 0; cn < 6; cn++) {
                // 0商品名称(必填)	1切制规格（必填）片型	2等级（必填）	3产地
                Cell c = r.getCell(cn, Row.RETURN_BLANK_AS_NULL);
                if (c == null) {
                    // The spreadsheet is empty in this cell
                    continue;
                } else {
                    try {
                        switch (cn) {
                            case 0:
                                huqiaoSupplier.setSupplierNum(getCellValue(c));
                                break;
                            case 1:
                                huqiaoSupplier.setName(getCellValue(c));
                                break;
                            case 4:
                                huqiaoSupplier.setEnterCategoryStr(getCellValue(c));
                                break;
                            case 5:
                                huqiaoSupplier.setMobile(getCellValue(c));
                                break;
                           default:
                               break;
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        //TODO: continue
                    }


                }

            }
            System.out.println(huqiaoSupplier);
            list.add(huqiaoSupplier);
        }

        inp.close();
        return list;
    }



    private static String getCellValue(Cell c) {
        String value = "";
        // Do something useful with the cell's contents
        switch (c.getCellType()) {
            case Cell.CELL_TYPE_STRING:
                value = c.getRichStringCellValue().getString();
                break;
            case Cell.CELL_TYPE_NUMERIC:
                if (DateUtil.isCellDateFormatted(c)) {
                    value = String.valueOf(c.getDateCellValue().getTime());
                } else {
                    BigDecimal bigDecimal = new BigDecimal(c.getNumericCellValue());
                    value = bigDecimal.toString();
                }
                break;
            case Cell.CELL_TYPE_BOOLEAN:
                value = String.valueOf(c.getBooleanCellValue());
                break;
            case Cell.CELL_TYPE_FORMULA:
                // TODO: 针对数字型 公式
                BigDecimal bigDecimal = new BigDecimal(c.getNumericCellValue());
                value = bigDecimal.toString();
                break;
            default:
        }

        return value;
    }

    /**
     * 返回excel
     * @param response
     * @param workbook
     * @param fileName
     */
    public static void returnExcel(HttpServletResponse response, HttpServletRequest request, Workbook workbook, String fileName) {
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        try {
            workbook.write(os);
            byte[] content = os.toByteArray();
            InputStream is = new ByteArrayInputStream(content);
            // 设置response参数，可以打开下载页面
            response.reset();
            response.setContentType("application/octet-stream");

            String name;
            if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0 ||
                    request.getHeader("User-Agent").toUpperCase().indexOf("TRIDENT") > 0) {
                name = URLEncoder.encode(fileName, "UTF-8");
            } else {
                name = new String(fileName.getBytes("UTF-8"), "ISO8859-1");
            }

            response.setHeader("Content-disposition", "attachment;filename="
                    + name + ".xls");
            ServletOutputStream out = response.getOutputStream();
            BufferedInputStream bis = null;
            BufferedOutputStream bos = null;
            try {
                bis = new BufferedInputStream(is);
                bos = new BufferedOutputStream(out);
                byte[] buff = new byte[2048];
                int bytesRead;
                // Simple read/write loop.
                while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                    bos.write(buff, 0, bytesRead);
                }

                out.flush();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (bis != null)
                    bis.close();
                if (bos != null)
                    bos.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
