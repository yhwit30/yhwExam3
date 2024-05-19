<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="관광지 검색"></c:set>
<%@ include file="../common/head.jspf"%>

<!-- QnA -->
<div class="text-center border-b border-blue-500">
    <form id="qnaForm">
        <div>
            QnA:
            <input id="keyword" value="" type="text" placeholder="검색어를 입력하세요" class="input input-bordered w-full max-w-xs"
                name="searchKeyword" />
            <button type="submit" class="btn btn-active" style="background-color: rgba(255, 255, 255, 0.5)">질문하기</button>
        </div>
    </form>
    <div class="answer"></div>
</div>


<form id="filterForm">
	<div class="course_form">
		<div class="course_formRegionHashtag_wrap flex justify-center gap-4 mt-10 mb-5">
			<div class="course_regionFilter_box">
				<label class="course_regionfilterLabel">지역</label>
				<select id="regionFilter" class="course_regionFilterSelect select select-primary w-full max-w-xs">
					<option value="">전체</option>
					<option value="1">서울</option>
					<option value="6">부산</option>
					<option value="4">대구</option>
					<option value="2">인천</option>
					<option value="5">광주</option>
					<option value="3">대전</option>
					<option value="7">울산</option>
					<option value="8">세종</option>
					<option value="31">경기</option>
					<option value="32">강원</option>
					<option value="33">충북</option>
					<option value="34">충남</option>
					<option value="35">경북</option>
					<option value="36">경남</option>
					<option value="37">전북</option>
					<option value="38">전남</option>
					<option value="39">제주</option>
				</select>
			</div>
			<div class="course_hastagFilter_box">
				<label class="course_hashtagfilterLabel">해시태그</label>
				<select id="hashtagFilter" class="course_hashtagFilterSelect select select-primary w-full max-w-xs">
					<option value="">전체</option>
					<option value="C0112">#가족코스</option>
					<option value="C0113">#나홀로코스</option>
					<option value="C0114">#힐링코스</option>
					<option value="C0115">#도보코스</option>
					<option value="C0116">#캠핑코스</option>
					<option value="C0117">#맛코스</option>
				</select>
			</div>
		</div>
		<div class="course_searchFilter_box text-center">
			<label class="course_searchFilterLabel">키워드</label>
			<input id="searchFilter" class="course_searchFilterInput input input-bordered w-full max-w-xs " type="text"
				placeholder="검색어를 입력하세요">
			<button class="course_formButton btn btn-info">검색</button>
		</div>
	</div>
</form>

<section class="course_content_wrap mt-5"></section>





<style>
/* 코스 컨텐츠 목록 */
.course_content_wrap {
	border-top: 2px solid #2d58a0;
	padding-top: 20px;
	margin-left: 10px;
	margin-right: 10px;
}

.course_contentListItem {
	display: flex;
	height: 280px;
	padding-top: 15px;
	padding-bottom: 15px;
}

.course_contentListItemImg_box {
	width: 354px;
	height: 188px;
}

.course_contentListItemLink {
	width: 354px;
	height: 188px;
}

.course_contentListItemLinkImg {
	width: 354px;
	height: 188px;
	object-fit: cover;
}

.course_contentListItemText_box {
	padding-left: 52px;
	height: 188px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.course_contentListItemTextLink {
	display: block;
}

.course_contentListItemTextLinkTitle {
	font-size: 20px;
	margin-bottom: 10px;
	text-overflow: ellipsis;
	white-space: normal;
	word-wrap: break-word;
	line-height: 1.6;
	color: #333;
}

.course_contentListItemTextLinkText {
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	font-size: 15.4px;
	color: #777;
	margin-bottom: 10px;
}

.course_contentListItemTextList {
	margin-bottom: 20px;
}

.course_contentListItemTextListRegion {
	font-size: 15.4px;
	color: #777;
	padding-bottom: 10px;
}

.course_contentListItemTextListHashtag {
	font-size: 15.4px;
	color: #777;
}
</style>


<!-- 질문 ajax -->
<script>
	
	function dofindanswer() {

 	    var input_keyword = $("#keyword").val();
 	    
 	    console.log("input_keyword: "+input_keyword);
 	   
 	    $.ajax({
 	        type: "POST",
 	        url: "/usr/article/dofind", 
 	        data: { keyword: input_keyword },
 	        success: function(data) {

 	        	console.log(data);
 	           	// 답변 정보 업데이트
 	        	$(".answer").empty(); // 기존 내용 지우기
 	            var modifiedData = data.map(function(item) {
 	                return "요청 질문 : "+input_keyword+" ➡ 답변: " + item;
 	            });
 	            var answerHtml = modifiedData.join("<br>"); // 각 데이터를 <br> 태그로 구분하여 연결
 	            $(".answer").html(answerHtml);
 	        },
 	        error: function(error) {
 	            console.error("Error during registration:", error);
 	        }
 	    });
 	    
 	}
	
	 $("#qnaForm").submit(function(event) {
	        event.preventDefault(); // 폼 제출을 막음
	        dofindanswer(); // 질문 데이터를 가져오는 함수 호출
	        $("#keyword").val(""); // 입력값을 지움
	    });
	
</script>


<!-- 관광지 api -->

<script>
//지역 선택값을 저장하는 변수
let currentRegion='';
//해시태그 선택값을 저장하는 변수
let currentHashtag='';
// 사용자가 검색한 값을 저장하는 변수
let currentEncodedData;

// 폼 태그를 지정
const filterForm = document.getElementById('filterForm');
// 폼 태그 안 지역 필터를 지정
const regionFilter = document.getElementById('regionFilter');
// 폼 태그 안 해시태그 필터를 지정
const hashtagFilter = document.getElementById('hashtagFilter');
// 폼 태그 안 검색어 필터를 지정
const searchFilter = document.getElementById('searchFilter');
// 검색 버튼
const filterButton = document.querySelector('.course_formButton');
// 컨텐츠가 로드되는 영역
const courseContent = document.querySelector('.course_content_wrap');


// 폼 태그의 검색 이벤트를 제거한다.
filterForm.addEventListener('submit', (event)=>{
    event.preventDefault();
})
// 사용자의 검색 데이터를UTF-8 문자열로 반환한 후 변수에 할당한다.
function encodeUTF8(){
    currentEncodedData=encodeURIComponent(searchFilter.value);
}


//카테고리 선택 시 이벤트발생
filterButton.addEventListener('click', async ()=>{
    currentRegion=regionFilter.value;
    currentHashtag=hashtagFilter.value;
    encodeUTF8();
    courseRenderHTML();
})

// tour apikey
const API_KEY = '';
async function fetchDataByCategory() {
	const url = 'http://apis.data.go.kr/B551011/KorService1/areaBasedList1?serviceKey='+API_KEY+ '&pageNo=1&numOfRows=10&MobileApp=AppTest&MobileOS=ETC&arrange=Q&areaCode='+currentRegion+'&contentTypeId=25&cat1=C01&cat2='+currentHashtag+'&_type=json';
	const response = await fetch(url);
	const jsonData = await response.json();
	
	console.log("카테고리", jsonData);
// 	console.log("data1", jsonData.response.body.items.item[0].mapy);
// 	console.log("data1", jsonData.response.body.items.item[0].mapx);
	
	
// 	var lat= jsonData.response.body.items.item[0].mapy;
// 	var long =  jsonData.response.body.items.item[0].mapx;

// 	getWeatherByCoordinates(lat, long);
	
	return jsonData;
}


 async function fetchDataByInput(){
		const url = 'http://apis.data.go.kr/B551011/KorService1/searchKeyword1?serviceKey='+API_KEY+ '&pageNo=1&numOfRows=10&MobileApp=AppTest&MobileOS=ETC&arrange=Q&contentTypeId=25&keyword='+currentEncodedData+'&_type=json';
		const response = await fetch(url);
		const jsonData = await response.json();
		
		console.log("검색", jsonData);
		
		return jsonData;
 }

  async function fetchDataMoreInfo(courseId){
		const url = 'http://apis.data.go.kr/B551011/KorService1/detailCommon1?serviceKey='+API_KEY+ '&pageNo=1&numOfRows=10&MobileApp=AppTest&MobileOS=ETC&contentId='+courseId+'&contentTypeId=25&overviewYN=Y&_type=json';
		const response = await fetch(url);
		const jsonData = await response.json();
		
		console.log("디테일", jsonData);
		
		return jsonData;
	  
  }
  
  async function getWeatherByCoordinates(latitude, longitude){
	  
// 	  openweather apikey
	  const API_KEY = '';

	  const url = 'https://api.openweathermap.org/data/2.5/weather?lat=' +latitude+ '&lon='+longitude+ '&appid='+API_KEY + '&units=metric&lang=kr';
	    const response = await fetch(url);
	    const data = await response.json();
	    
	    return {
	        temperature: data.main.temp,
	        humidity: data.main.humidity,
	        windspeed: data.wind.speed,
	        place: data.name,
	        description: data.weather[0].description,
	        weatherIconAdrs: 'http://openweathermap.org/img/wn/'+data.weather[0].icon+'@2x.png'
	    };
	};
  
 

  async function courseRenderHTML() {
	    courseContent.innerHTML = '';

	    try {
	        let jsonData;
	        if (currentEncodedData) {
	            jsonData = await fetchDataByInput();
	        } else {
	            jsonData = await fetchDataByCategory();
	        }
	        const jsonDataArray = jsonData.response.body.items.item;
	        await insertHTML(jsonDataArray);
	    } catch (error) {
	        window.alert('검색된 데이터가 없습니다.');
	    }
	}

  async function insertHTML(jsonDataArray) {
	    const newUl = $('<ul>').addClass('course_contentListChange_box');

	    for (const data of jsonDataArray) {
	        const courseRenderImageUrl = data.firstimage ? data.firstimage : '';
	        const courseId = data.contentid;
	        let courseRenderAddr = data.addr1 || data.addr2 || '전국';
	        let courseRenderHashtag;

	        switch (data.cat2) {
	            case 'C0112':
	                courseRenderHashtag = '#가족코스';
	                break;
	            case 'C0113':
	                courseRenderHashtag = '#나홀로코스';
	                break;
	            case 'C0114':
	                courseRenderHashtag = '#힐링코스';
	                break;
	            case 'C0115':
	                courseRenderHashtag = '#도보코스';
	                break;
	            case 'C0116':
	                courseRenderHashtag = '#캠핑코스';
	                break;
	            case 'C0117':
	                courseRenderHashtag = '#맛코스';
	                break;
	            default:
	                courseRenderHashtag = '#추천코스';
	        }

	        const detailedData = await fetchDataMoreInfo(courseId);
	        const courseRenderOverview = detailedData.response.body.items.item[0].overview || '정보가 없습니다.';

	        // 위도, 경도 데이터
	        const lat = data.mapy;
	        const long = data.mapx;

	        // 날씨 데이터 가져오기
	        const weatherData = await getWeatherByCoordinates(lat, long);

	        const $li = $('<li>').addClass('course_contentListItem');
	        const $imgBox = $('<div>').addClass('course_contentListItemImg_box');
	        const $imgLink = $('<p>').addClass('course_contentListItemLink');
	        const $img = $('<img>').addClass('course_contentListItemLinkImg').attr('src', courseRenderImageUrl).attr('alt', '');

	        $imgLink.append($img);
	        $imgBox.append($imgLink);

	        const $textBox = $('<div>').addClass('course_contentListItemText_box');
	        const $textLink = $('<p>').addClass('course_contentListItemTextLink');
	        const $title = $('<h4>').addClass('course_contentListItemTextLinkTitle').text(data.title);
	        const $overview = $('<p>').addClass('course_contentListItemTextLinkText').text(courseRenderOverview);

	        $textLink.append($title).append($overview);

	        const $textList = $('<ul>').addClass('course_contentListItemTextList');
	        const $region = $('<li>').addClass('course_contentListItemTextListRegion').text(courseRenderAddr);
	        const $hashtag = $('<li>').addClass('course_contentListItemTextListHashtag').text(courseRenderHashtag);

	        $textList.append($region).append($hashtag);
	        $textBox.append($textLink).append($textList);
	        $li.append($imgBox).append($textBox);

	        // 날씨 데이터 추가
	        const $weatherBox = $('<div>').addClass('course_weather');
	        const $weatherInfo = $('<div>').addClass('weather_info').css({
	            width: '200px',
	            borderRadius: '10px',
	            textAlign: 'left',
	            background: 'linear-gradient(to right, rgba(79, 195, 247, 0.6), rgba(0, 147, 196, 0.6))',
	            fontSize: 'small'
	        });

	        const $weatherTitle = $('<div>').css({
	            textAlign: 'center',
	            paddingTop: '.75rem'
	        }).text('현재 날씨');

	        const $weatherDetails = $('<div>').addClass('pl-3 pt-2');
	        const $place = $('<div>').addClass('place').text('장소: ' + weatherData.place);
	        const $temp = $('<div>').addClass('temp').text('온도: ' + weatherData.temperature + '°C');
	        const $desc = $('<div>').addClass('desc').text('날씨: ' + weatherData.description);
	        const $humidity = $('<div>').addClass('humidity').text('습도: ' + weatherData.humidity + '%');
	        const $windspeed = $('<div>').addClass('windspeed').text('풍속: ' + weatherData.windspeed + 'm/s');
	        const $weatherIcon = $('<img>').addClass('weatherIcon').attr('src', weatherData.weatherIconAdrs);

	        $weatherDetails.append($place).append($temp).append($desc).append($humidity).append($windspeed).append($weatherIcon);
	        $weatherInfo.append($weatherTitle).append($weatherDetails);
	        $weatherBox.append($weatherInfo);

	        $li.append($weatherBox); // 추가된 부분: 날씨 정보를 리스트 항목에 추가

	        newUl.append($li);
	    }

	    $('.course_content_wrap').html(newUl);
	}


  

</script>





<!-- 페이지 하단 -->
<%@ include file="../common/foot.jspf"%>