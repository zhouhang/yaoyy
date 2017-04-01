package com.ms.service.utils;

import com.ms.dao.model.HuqiaoSupplier;
import com.ms.dao.vo.SupplierVo;
import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
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
                            case 2:
                                huqiaoSupplier.setMobile(getCellValue(c));
                                break;
                            case 3:
                                huqiaoSupplier.setCategory(getCellValue(c));
                                break;
                            case 4:
                                huqiaoSupplier.setBatchNumber(getCellValue(c));
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
     *
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

    /**
     * 导出供应商信息excel
     * @param list
     * @return
     */
    public static Workbook  exportSupplierInfo( List<SupplierVo> list){
        Workbook wb = new HSSFWorkbook();
        Sheet s = wb.createSheet();
        Row r = null;
        Cell c = null;
        String[] titles = null;
        wb.setSheetName(0, "供应商信息");
        // 数据有效性约束
        CellRangeAddressList addressList = new CellRangeAddressList(
                0, 65535, 5, 5);
        DVConstraint dvConstraint = DVConstraint.createNumericConstraint(
                DVConstraint.ValidationType.INTEGER,
                DVConstraint.OperatorType.BETWEEN, "0", "100000");
        DataValidation dataValidation = new HSSFDataValidation
                (addressList, dvConstraint);
        s.addValidationData(dataValidation);

        // 设置询价单信息 cell title
        titles = new String[]{"供应商编号", "供应商姓名", "手机号", "经营品种",
                               "信息核实状态","信息来源", "信息核实人","信息核实时间",
                               "实地考察人","实地考察认证时间","签约人","签约时间"};
        for(int i=0;i<titles.length;i++){
            s.setColumnWidth(i, 20 * 256);
        }

        r = s.createRow(0);
        for (int cellnum = 0; cellnum < titles.length; cellnum++) {
            c = r.createCell(cellnum);
            c.setCellValue(titles[cellnum]);
        }

        CellStyle cellStyle = wb.createCellStyle();
        cellStyle.setLocked(true);

        DataFormat format= wb.createDataFormat();
        CellStyle numberStyle = wb.createCellStyle();
        numberStyle.setDataFormat(format.getFormat("0.00"));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");

        for (int rownum = (short) 1; rownum < list.size()+1; rownum++) {

            r = s.createRow(rownum);
            SupplierVo supplierVo = list.get(rownum-1);

            c = r.createCell(0);
            c.setCellValue(supplierVo.getId());
            c.setCellStyle(cellStyle);
            c = r.createCell(1);
            c.setCellValue(supplierVo.getName());
            c.setCellStyle(cellStyle);
            c = r.createCell(2);
            c.setCellValue(supplierVo.getPhone());
            c.setCellStyle(cellStyle);
            c = r.createCell(3);
            c.setCellValue(supplierVo.getEnterCategoryStr());
            c.setCellStyle(cellStyle);
            c = r.createCell(4);
            c.setCellValue(supplierVo.getStatusText());
            c.setCellStyle(cellStyle);
            c = r.createCell(5);
            c.setCellValue(supplierVo.getSourceText());
            c.setCellStyle(cellStyle);

            c = r.createCell(6);
            c.setCellValue(supplierVo.getCertifyMemberName()==null?"":supplierVo.getCertifyMemberName());
            c.setCellStyle(cellStyle);
            c = r.createCell(7);
            c.setCellValue(supplierVo.getCertifyTime()==null?"":sdf.format(supplierVo.getCertifyTime()));
            c.setCellStyle(cellStyle);
            c = r.createCell(8);
            c.setCellValue(supplierVo.getJudgeMemberName()==null?"":supplierVo.getJudgeMemberName());
            c.setCellStyle(cellStyle);
            c = r.createCell(9);
            c.setCellValue(supplierVo.getJudgeTime()==null?"":sdf.format(supplierVo.getJudgeTime()));
            c.setCellStyle(cellStyle);
            c = r.createCell(10);
            c.setCellValue(supplierVo.getSignMemberName()==null?"":supplierVo.getSignMemberName());
            c.setCellStyle(cellStyle);
            c = r.createCell(11);
            c.setCellValue(supplierVo.getSignTime()==null?"":sdf.format(supplierVo.getSignTime()));
            c.setCellStyle(cellStyle);

        }
        return wb;
    }

}
