package com.cqgVipShare.util;

import org.apache.commons.io.FileUtils;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.json.JSONObject;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.SocketException;

/**
 * 文件上传工具�?
 *
 * @author lenovo
 */
public class FileUploadUtils {

	private static Class<? extends Object> cls = FileUploadUtils.class;
	
	//资讯内容上传的图�?(by 石超)
	public static String appUploadContentImg(HttpServletRequest request, MultipartFile myFile, String folder) throws Exception {
		try {
			//重置文件�?
			long time = System.currentTimeMillis();
			String timeStr = String.valueOf(time);
			String[] originalFileName = myFile.getOriginalFilename().split("\\.");
			String fileName = timeStr + "." + originalFileName[1];
			String name=myFile.getOriginalFilename().substring(myFile.getOriginalFilename().lastIndexOf(".")+1);
				//            FTPClient client = getFTPClient("", 1,"","");
//			String writeTempPath = "D:\\resource";
				//            String writeTempPath = "/home/terabithia";

				
			String avaPath ="/CqgVipShare/upload/"+fileName;
//			String writeTempPath = request.getSession().getServletContext().getRealPath("/");
			String realPath="D:\\resource\\CqgVipShare\\";
			System.out.println(avaPath);
				/**
				 * @author 马鹏�?
				 * @desc 裁剪图片
				 */
				
//			File storeFile =  new File(writeTempPath + "uploads/", fileName);
			File storeFile =  new File(realPath, fileName);
			FileUtils.copyInputStreamToFile(myFile.getInputStream(),storeFile );
				//			uploadFileForFTP(client, fileName, writeTempPath + "\\" + fileName, "Resource\\htkApp\\upload\\" + folder);
				//			uploadFileForFTP(client, fileName, writeTempPath + "/" + fileName, "Resource\\htkApp\\upload\\" + folder);
				//			String avaPath = OtherUtils.getRootDirectory() + Globals.PROJECT_URL + Globals.PHOTO_URL + folder + fileName;
				//			String avaPath = OtherUtils.getRootDirectory() + Globals.PROJECT_URL + Globals.PHOTO_URL + folder + newName;
				//			String rjson = "{\"code\": 0,\"msg\": \"成功\",\"data\": {\"src\": \"" + avaPath + "\"}}";
			JSONObject map = new JSONObject();
			map.put("code", 0);
			map.put("msg", "成功");
			JSONObject js = new JSONObject();
			js.put("src", avaPath);
			map.put("data", js);
			return map.toString();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("");
		}
	}
	

	//获取ftp连接成功对象，连接失败则抛出异常
	public static FTPClient getFTPClient(String ftpHost, Integer ftpPort, String userName, String password) throws Exception {
		try {
			//创建ftp对象
			FTPClient ftpClient = new FTPClient();
			int port = ftpPort == null ? 21 : ftpPort;
			//传入主机和端口建立连�?
			ftpClient.connect(ftpHost, port);
			//用户名�?�密码登�?
			ftpClient.login(userName, password);
			;
			if (!FTPReply.isPositiveCompletion(ftpClient.getReplyCode())) {
				ftpClient.disconnect();
				throw new Exception(ftpClient.getReplyString());
			}
			return ftpClient;
		} catch (SocketException e1) {
			throw new SocketException(e1.getMessage());
		} catch (IOException e2) {
			throw new IOException(e2.getMessage());
		} catch (Exception e3) {
			throw new Exception(e3.getMessage());
		}
	}

	//读取ftp服务器上文件方法
	public static String readFileForFTP(FTPClient ftpClient, String ftpPath, String fileName) {
		StringBuffer resultBuffer = new StringBuffer();
		FileInputStream inFile = null;
		InputStream in = null;
		try {
			//设置编码
			ftpClient.setControlEncoding("UTF-8");
			//文件类型
			ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
			//
			ftpClient.enterLocalPassiveMode();
			//改变访问的ftp服务器目�?
			ftpClient.changeWorkingDirectory(ftpPath);
			//根据当前文件下的文件名接收文�?
			in = ftpClient.retrieveFileStream(fileName);
		} catch (FileNotFoundException e1) {
			return "下载配置文件失败，请联系管理�?.";
		} catch (SocketException e2) {
		} catch (IOException e3) {
			return "配置文件读取失败，请联系管理�?.";
		}
		//处理接收到的输入�?
		if (in != null) {
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(in));
			String data = null;
			try {
				while ((data = bufferedReader.readLine()) != null) {
					resultBuffer.append(data).append("\n");
				}
			} catch (IOException e1) {
			} finally {
				try {
					ftpClient.disconnect();
				} catch (IOException e) {
				}
			}
		} else {
			return null;
		}
		return resultBuffer.toString();
	}


	//上传至ftp服务器文件方�?
	public static void uploadFileForFTP(FTPClient ftpClient, String ftpFileName, String writeTempFilePath, String operatePath) throws Exception {
		try {
			//设置passiveMode传输
			ftpClient.enterLocalPassiveMode();
			//设置传输方式
			ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
			//对远程目录的处理
			String remoteFileName = ftpFileName;
			//改变操作目录
			ftpClient.changeWorkingDirectory(operatePath);
			//本地写入成功
			File file = new File(writeTempFilePath);
			InputStream in = new FileInputStream(file);
			ftpClient.storeFile(remoteFileName, in);
			in.close();
			file.delete();
			return;
		} catch (Exception e) {
			ftpClient.disconnect();
			throw new Exception("上传图片到服务器失败");
		} finally {
			try {
				ftpClient.disconnect();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	public static String getRootDirectory() {
		return "http://120.27.5.36:8500/";
	}


}
