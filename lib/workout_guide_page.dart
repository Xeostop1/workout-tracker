import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class WorkoutGuidePage extends StatelessWidget {
  final player=AudioPlayer();
  WorkoutGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WorkoutGuide"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spacer(),
              Text(
                "스쿼트",
                  style: TextStyle(
                    fontFamily: "Pretendard",
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationThickness: 2.0,
                ),
              ),
              SizedBox(width: 20,),//공백을 넣을 때 많이 사용
              Text(
                '산을 오르는 자세를 닮아 붙은\n이름으로 단시간 안에 체지방을\n많이 태워 복부 비만에 제격입니다.',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 12,
                  color: Colors.grey,
              ),
              ),
            ],
          ),
          Container(
            //컨테이너에 사진 끝까지 채우고 화살표를 양사이드 스페이스 비트윈 주기
            height: 300,
              decoration: BoxDecoration(
                 image: DecorationImage(
                  image: AssetImage('assets/squat.png'),
                  fit: BoxFit.cover,
                ),
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){
                      player.play(AssetSource('squat.mp3'));
                    },
                    icon: Icon(Icons.arrow_back_ios),
                ),
                // Expanded(child: Image.asset('assets/squat.png')),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 160,
                height: 100,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "운동부위",
                      style:TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      "배, 상체, 근육",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        color: Colors.grey,
                    )
                    ),

                  ],
                ),
              ),
              Container(
                width: 160,
                height: 100,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "이런 사람에게 강추",
                      style:TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                        "뱃살이 고민이예요. \n상체지방 태우고 싶어요",
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          color: Colors.grey,
                          fontSize: 12,
                        )
                    ),

                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child:
                  Center(
                    child: Text(
                      '30분',
                      style:TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: (){
              player.play(AssetSource('squat.mp3'));
            },
            icon: Icon(Icons.play_circle, color: Colors.blue,),
            iconSize: 70,
          )
        ],
      ),
    );
  }
}
