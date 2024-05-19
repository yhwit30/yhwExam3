package com.example.demo.controller;

import java.io.DataOutputStream;
  import java.io.IOException;
  import java.io.InputStream;
  import java.net.HttpURLConnection;
  import java.net.MalformedURLException;
  import java.net.URL;
  import java.util.HashMap;
  import java.util.Map;
   
  import com.google.gson.Gson;
   
  public class Example2 {
   
      static public String apiTest2 () {
          String openApiURL = "http://aiopen.etri.re.kr:8000/WikiQA";
          String accessKey = "2da09661-bc43-4952-8ed2-e63b51200cec";    // 발급받은 API Key
          String type = "ENGINE_TYPE";            // 분석할 문단 데이터
          String question = "대전의 관광지를 추천해줘";          // 질문 데이터
          Gson gson = new Gson();
       
          Map<String, Object> request = new HashMap<>();
          Map<String, String> argument = new HashMap<>();
       
          argument.put("question", question);
          argument.put("type", type);
       
          request.put("argument", argument);
       
       
          URL url;
          Integer responseCode = null;
          String responBody = null;
          try {
                  url = new URL(openApiURL);
                  HttpURLConnection con = (HttpURLConnection)url.openConnection();
                  con.setRequestMethod("POST");
                  con.setDoOutput(true);
                  con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
                  con.setRequestProperty("Authorization", accessKey);
           
  
       
                  DataOutputStream wr = new DataOutputStream(con.getOutputStream());
                  wr.write(gson.toJson(request).getBytes("UTF-8"));
                  wr.flush();
                  wr.close();
       
                  responseCode = con.getResponseCode();
                  InputStream is = con.getInputStream();
                  byte[] buffer = new byte[is.available()];
                  int byteRead = is.read(buffer);
                  responBody = new String(buffer);
       
                  System.out.println("[responseCode] " + responseCode);
                  System.out.println("[responBody]");
                  System.out.println(responBody);
       
          } catch (MalformedURLException e) {
                  e.printStackTrace();
          } catch (IOException e) {
                  e.printStackTrace();
          }
          
          return responBody;
      }
  }