// timeBefore();
	// elem을 파라미터로 받아와 time 변수에 값을 넣어주고, 변경하려는 시간을 찾는 코드를 받아온 elem 코드로 수정
    function timeBefore(elem){
    	var time = parseInt(elem.innerHTML);
        //현재시간
        var now = new Date(); 
        console.log(now);
        //글쓴 시간 
        var writeDay = new Date(time);
        var minus;
        if(now.getFullYear() > writeDay.getFullYear()){
            minus= now.getFullYear()-writeDay.getFullYear();
            elem.innerHTML = minus+"년 전";
            console.log(minus+"년 전");
        }else if(now.getMonth() > writeDay.getMonth()){
            minus= now.getMonth()-writeDay.getMonth();
            elem.innerHTML = minus+"달 전";
            console.log(minus+"달 전");
        }else if(now.getDate() > writeDay.getDate()){
            minus= now.getDate()-writeDay.getDate();
            elem.innerHTML = minus+"일 전";
            console.log(minus+"일 전");
        }else if(now.getDate() == writeDay.getDate()){
            var nowTime = now.getTime();
            var writeTime = writeDay.getTime();
            if(nowTime>writeTime){
                sec =parseInt(nowTime - writeTime) / 1000;
                day  = parseInt(sec/60/60/24);
                sec = (sec - (day * 60 * 60 * 24));
                hour = parseInt(sec/60/60);
                sec = (sec - (hour*60*60));
                min = parseInt(sec/60);
                sec = parseInt(sec-(min*60));
                if(hour>0){
                    elem.innerHTML = hour+"시간 전";
                    console.log(hour+"시간 전");
                }else if(min>0){
                    elem.innerHTML = min+"분 전";
                    console.log(min+"분 전");
                }else if(sec>0){
                    elem.innerHTML = sec+"초 전";
                    console.log(sec+"초 전");
                }
            }
        }
    }