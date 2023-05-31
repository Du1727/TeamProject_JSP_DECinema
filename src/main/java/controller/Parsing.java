//인덱스에 필요한 영화정보

package controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.net.URLEncoder;

import org.apache.coyote.ContinueResponseTiming;
import org.json.JSONArray;
import org.json.JSONObject;

public class Parsing {	
	
	//박스오피스 영화이름
	public String[] getMovieData() throws Exception {

        // 현재 날짜 구하기
        LocalDate now = LocalDate.now().minusDays(1); 
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");        
        
        String url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=" + now.format(formatter);
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        con.setRequestMethod("GET");
        con.setRequestProperty("User-Agent", "Mozilla/5.0");

        int responseCode = con.getResponseCode();

        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        JSONObject jsonObj = new JSONObject(response.toString());
        JSONArray jsonArray = jsonObj.getJSONObject("boxOfficeResult").getJSONArray("dailyBoxOfficeList");

        int length = jsonArray.length();
        String[] movieArr = new String[length];

        for (int i = 0; i < length; i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            movieArr[i] = jsonObject.getString("movieNm") + "/" + jsonObject.getString("audiAcc"); //영화 이름 + 누적 관객수
        }
        return movieArr;
    }

	//이름으로 영화정보 검색 
	public String[] getMovie(String movieName) {
		try {			
			int movieCode = getMovieCode(movieName);
	        String[] movie = new String[12];
            String url = "https://api.themoviedb.org/3/movie/" + movieCode + "?api_key=b747505050bb2b9ee61098bfeca5cee0&language=ko-KR";
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();

            con.setRequestMethod("GET");
            con.setRequestProperty("User-Agent", "Mozilla/5.0");

            int responseCode = con.getResponseCode();

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            //[0]영화이름 [1]디렉터 [2]배우 [3]장르 [4]영화설명 [5]오픈일자 [6]종료일자 [7]포스터URL [8]상영시간 [9]영상URL [10]연령제한 [11] 평점
            JSONObject jsonObj = new JSONObject(response.toString());
            movie[0] = jsonObj.getString("title");//영화이름
            movie[5] = jsonObj.getString("release_date");//오픈일자
            movie[6] = "2024-03-01";//종료일자		             
            movie[11] = Double.toString(jsonObj.getDouble("vote_average"));//평점	             
            try {
            	movie[7] = "https://image.tmdb.org/t/p/original" + jsonObj.getString("poster_path");//포스터URL
			} catch (Exception e) {
				movie[7] = "https://3.bp.blogspot.com/-WhBe10rJzG4/U4W-hvWvRCI/AAAAAAAABxg/RyWcixpgr3k/s1600/noimg.jpg";//이미지URL
			}                	                
            
            String[] dummy = getMovieDetail(movie[0]);
            if(dummy[0] != null) {
                movie[8] = dummy[0];//상영시간
                movie[1] = dummy[3];//디렉터                
                movie[2] = dummy[4];//배우            
                movie[3] = dummy[5];//장르
                movie[4] = dummy[2];//영화 설명
                if(movie[4] == null || movie[4].equals("")) {
                	movie[4] = jsonObj.getString("overview");
                }
	            movie[9] = getTrailerURL(movieCode);	
                movie[10] = dummy[1]; //연령제한		     
            }
	        return movie;
		} catch (Exception e) {
			e.printStackTrace();
		}  
        return null; 
	}
	//이름으로 TMDB 영화코드 검색
	public int getMovieCode(String movieName) throws Exception {
		
        try {            
            // API 요청 주소	        	
            String apiUrl = "https://api.themoviedb.org/3/search/movie?api_key=9438087812a8e9304a74e341a23d1a9d&language=kr&query=" + movieName.replaceAll(" ", "%20");                
            URL url = new URL(apiUrl);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // JSON 파싱
            JSONObject jsonObject = new JSONObject(response.toString());
            JSONArray results = jsonObject.getJSONArray("results");
            JSONObject result = results.getJSONObject(0);
            return result.getInt("id");	            
		} catch (Exception e) {
			return 0;                   
		}
    }
	
	//ID로 영화정보 검색 
	public String[][] popularMovieList() {
		try {			
			int k = 0;
	        int[] movieList = popularMovieIdList();
	        String[][] movie = new String[movieList.length][12];
	        for(int i = 0; i < movieList.length; i++) {
	            if(movieList[i] > 0) {
	                String url = "https://api.themoviedb.org/3/movie/" + movieList[i] + "?api_key=b747505050bb2b9ee61098bfeca5cee0&language=ko-KR";
	                URL obj = new URL(url);
	                HttpURLConnection con = (HttpURLConnection) obj.openConnection();

	                con.setRequestMethod("GET");
	                con.setRequestProperty("User-Agent", "Mozilla/5.0");

	                int responseCode = con.getResponseCode();

	                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	                String inputLine;
	                StringBuffer response = new StringBuffer();

	                while ((inputLine = in.readLine()) != null) {
	                    response.append(inputLine);
	                }
	                in.close();
	                //[0]영화이름 [1]디렉터 [2]배우 [3]장르 [4]영화설명 [5]오픈일자 [6]종료일자 [7]포스터URL [8]상영시간 [9]영상URL [10]연령제한 [11]평점
	                JSONObject jsonObj = new JSONObject(response.toString());
	                movie[k][0] = jsonObj.getString("title");//영화이름
	                movie[k][5] = jsonObj.getString("release_date");//오픈일자
	                movie[k][6] = "2024-03-01";//종료일자	                
	                movie[k][11] = Double.toString(jsonObj.getDouble("vote_average"));//평점
	                try {
	                	movie[k][7] = "https://image.tmdb.org/t/p/original" + jsonObj.getString("poster_path");//포스터URL
					} catch (Exception e) {
						movie[k][7] = "https://3.bp.blogspot.com/-WhBe10rJzG4/U4W-hvWvRCI/AAAAAAAABxg/RyWcixpgr3k/s1600/noimg.jpg";//이미지URL
					}                	                
	                
	                String[] dummy = getMovieDetail(movie[k][0]);
	                if(dummy[0] != null) {
		                movie[k][8] = dummy[0];//상영시간
		                movie[k][1] = dummy[3];//디렉터                
		                movie[k][2] = dummy[4];//배우            
		                movie[k][3] = dummy[5];//장르
		                movie[k][4] = dummy[2];//영화 설명
		                if(movie[k][4] == null || movie[k][4].equals("")) {
		                	movie[k][4] = jsonObj.getString("overview");
		                }
			            movie[k][9] = getTrailerURL(movieList[i]);	
		                movie[k][10] = dummy[1]; //연령제한		                
				        System.out.println("[ " + (k+1) + " 추가 ] " + movie[k][0]);
				        k++;
				    	if(k==500) break;
	                }

	            }
	        }
	        String[][] movie2 = new String[k][12];
	        for(int i = 0; i < movie2.length; i++) {
	        	for(int j = 0; j < 12; j++) {
	        		movie2[i][j] = movie[i][j];	
	        	}	        	
	        }
	        return movie2;
		} catch (Exception e) {
			e.printStackTrace();
		}  
        return null; 
	}
	//인기 영화 ID 목록
	public int[] popularMovieIdList() throws Exception {

		int k = 0;
        int[] movieList = new int[1000];
        
        for(int i = 1; i < 50; i++) {
	        String url = "https://api.themoviedb.org/3/movie/popular?api_key=b747505050bb2b9ee61098bfeca5cee0&language=ko-KR&page="+i;
	        URL obj = new URL(url);
	        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
	
	        con.setRequestMethod("GET");
	        con.setRequestProperty("User-Agent", "Mozilla/5.0");
	
	        int responseCode = con.getResponseCode();
	
	        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	
	        while ((inputLine = in.readLine()) != null) {
	            response.append(inputLine);
	        }
	        in.close();
	        JSONObject jsonObj = new JSONObject(response.toString());
	        JSONArray jsonArray = jsonObj.getJSONArray("results");
	        for (int j = 0; j < jsonArray.length(); j++) {
	            JSONObject jsonObject = jsonArray.getJSONObject(j);
	            if(jsonObject.getInt("vote_count") > 500) {
		            movieList[k] = jsonObject.getInt("id");//영화 ID
		            k++;
	        	}
	        }
        }
		return movieList;
	}
	
	//영화 트레일러 URL 
	public String getTrailerURL(int movieCode) {
		
        try {            
            // API 요청 주소	        	
            String apiUrl = "https://api.themoviedb.org/3/movie/" + movieCode + "/videos?api_key=b747505050bb2b9ee61098bfeca5cee0";                
            URL url = new URL(apiUrl);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // JSON 파싱
            JSONObject jsonObject = new JSONObject(response.toString());
            JSONArray results = jsonObject.getJSONArray("results");
            JSONObject result = results.getJSONObject(0);           
            return "https://www.youtube.com/watch?v=" + result.getString("key");
		} catch (Exception e) {
			return "https://www.youtube.com/watch?v=1yPsy09mjfE";                  
		}		
    }

	// 영화 이름으로 검색 [0]상영시간 [1]연령제한 [2]영화설명 [3]디렉터 [4]배우
	public String[] getMovieDetail(String movieName) throws Exception {
		String[] boxDetail = new String[6];
		try {
			StringBuilder urlBuilder = new StringBuilder(
					"https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&detail=N&title=");
			urlBuilder.append("=" + URLEncoder.encode(movieName, "UTF-8"));
			urlBuilder.append("&ServiceKey=G8C52Q0G7Y8216GV8056");
			URL obj = new URL(urlBuilder.toString());

			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			con.setRequestMethod("GET");
			con.setRequestProperty("User-Agent", "Mozilla/5.0");

			int responseCode = con.getResponseCode();

			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

			JSONObject jsonObj = new JSONObject(response.toString());
			JSONArray jsonArray = (JSONArray) jsonObj.get("Data");
			for (int j = 0; j < jsonArray.length(); j++) {
				JSONObject jsonArray1 =  (JSONObject)jsonArray.get(j);
				try {
					JSONArray jsonArray2 = jsonArray1.getJSONArray("Result");
					for (int k = 0; k < jsonArray2.length(); k++) {
						JSONObject jsonArray3 = (JSONObject)jsonArray2.get(k);
						if(boxDetail[0]==null || boxDetail[0].equals(""))
							boxDetail[0] = jsonArray3.getString("runtime"); //상영시간
						if(boxDetail[1]==null || boxDetail[1].equals(""))
							boxDetail[1] = jsonArray3.getString("rating"); //연령제한
						if(boxDetail[5]==null || boxDetail[5].equals(""))
							boxDetail[5] = jsonArray3.getString("genre"); //장르
						JSONArray jsonArray4 = jsonArray3.getJSONObject("plots").getJSONArray("plot");
						JSONArray jsonArray6 = jsonArray3.getJSONObject("directors").getJSONArray("director");
						JSONArray jsonArray7 = jsonArray3.getJSONObject("actors").getJSONArray("actor");
						for (int l = 0; l < jsonArray4.length(); l++) {
							JSONObject jsonArray5 =  (JSONObject)jsonArray4.get(j);							
							boxDetail[2] = jsonArray5.getString("plotText"); //영화설명	
						}		
						if(boxDetail[3]==null || boxDetail[3].equals("")) {						
							for (int l = 0; l < jsonArray6.length(); l++) {
								JSONObject jsonArray8 =  (JSONObject)jsonArray6.get(j);				
								boxDetail[3] = jsonArray8.getString("directorNm"); //디렉터	
							}
						}
						if(boxDetail[4]==null || boxDetail[4].equals("")) {
							boxDetail[4] = "";
							for (int l = 0; l < (jsonArray7.length()>6?6:jsonArray7.length()); l++) {
								JSONObject jsonArray9 =  (JSONObject)jsonArray7.get(l);	
								boxDetail[4] = boxDetail[4] + jsonArray9.getString("actorNm") + (l+1!=(jsonArray7.length()>6?6:jsonArray7.length())?"/":"") ; //배우 상위 6명	
							}							
						}
					}
				} catch (Exception e) {
					return boxDetail;
				}	
			}
		} catch (Exception e) {
			return boxDetail;
		}
		return boxDetail;
	}
	
	// 영화 설명 글자수 제한
	public String textLimit(String str) {	 
		if(str.length() > 100) str = str.substring(0, 97) + "...";		
		return str;
	}	
}