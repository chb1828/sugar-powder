package org.sugarpowder.spas.domain.user;

import org.springframework.stereotype.Service;
import org.sugarpowder.spas.domain.dayday.DDayEntity;
import org.sugarpowder.spas.domain.dayday.DDayService;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
public class UserService {

    private final UserRepository userRepository;
    final List<String> adjectives = Arrays.asList(
            "가까운", "가벼운", "감사한", "같은", "건강한", "고마운", "고픈", "괜찮은", "그런", "긴", "깨끗한", "나쁜", "낮은", "넓은", "높은",
            "늦은", "다른", "단", "더운", "따뜻한", "똑같은", "뜨거운", "많은", "맑은", "맛없는", "맛있는", "매운", "먼", "못한", "무거운", "미안한",
            "바쁜", "반가운", "밝은", "배고픈", "배부른", "복잡한", "비슷한", "비싼", "빠른", "쉬운", "슬픈", "시원한", "싫은", "싼", "아닌",
            "아름다운", "아픈", "안녕한", "어떠한", "어떤", "어려운", "없는", "예쁜", "위험한", "유명한", "이런", "있는", "작은", "재미없는",
            "재미있는", "적은", "조용한", "좋은", "죄송한", "중요한", "즐거운", "짠", "짧은", "추운", "친절한", "큰", "피곤한", "필요한", "힘든"
    );

    final List<String> flowers = Arrays.asList(
            "스노드롭", "노랑수선화", "사프란", "히아신스", "노루귀", "흰제비꽃", "튤립", "보랏빛", "회양목", "측백나무", "향기", "수선화",
            "시클라멘", "가시", "수영", "어저귀", "소나무", "미나리아재비", "담쟁이덩굴", "이끼", "부들", "가을에", "점나도나물", "미모사",
            "마가목", "검은", "매쉬", "노란", "앵초", "모과", "황새냉이", "빨간앵초", "양치", "바위솔", "물망초", "범의귀", "은매화", "서향",
            "멜리사", "쥐꼬리망초", "갈풀", "카모밀레", "삼나무", "월계수", "야생화", "떡갈나무", "칼미아", "네모필라", "무궁화", "살구꽃",
            "빙카", "사향장미", "아도니스", "아라비아의", "보리", "아르메리아", "낙엽송", "느릅나무", "씀바귀", "수양버들", "산옥잠화", "아몬드",
            "독당근", "박하", "콩꽃", "아스파라거스", "치자나무", "보라색", "벚꽃난", "당아욱", "글라디올러스", "금영화", "덩굴성", "흰앵초",
            "칼세올라리아", "꽃아카시아나무", "우엉", "금작화", "흑종초", "아네모네", "나팔수선화", "무화과", "공작고사리", "벚나무", "꽃고비",
            "복사꽃", "페르시아", "흰나팔꽃", "독일", "자운영", "참제비고깔", "배나무", "과꽃", "도라지", "제라늄", "논냉이", "수련", "빨간",
            "동백나무", "금사슬나무", "카우슬립", "민들레", "딸기", "은방울꽃", "비단향나무꽃", "겹벚꽃", "꽃창포", "사과", "라일락", "산사나무",
            "매발톱꽃", "조팝나물", "옥슬립", "아리스타타", "괭이밥", "담홍색", "귀고리꽃", "헬리오토로프", "삼색제비꽃", "올리브나무", "데이지",
            "토끼풀", "무릇", "장미", "아마", "메리골드", "슈미트티아나", "재스민", "스위트피", "수염패랭이꽃", "중국패모", "레제다", "디기탈리스",
            "뚜껑별꽃", "카네이션", "튜베", "백리향", "꼬리풀", "달맞이꽃", "가막살나무", "접시꽃", "버베나", "나팔꽃", "시계꽃", "인동", "단양쑥부쟁이",
            "금어초", "자목련", "라벤더", "해바라기", "서양까지밥나무", "버드푸트", "아이비", "초롱꽃", "아스포델", "좁은입배풍동", "플록스", "들장미",
            "비단향꽃무", "흰색장미", "백부자", "가지", "노랑장미", "패랭이꽃", "연령초", "말오줌나무", "향쑥", "선인장", "서양종", "호박", "수레국화",
            "수박풀", "옥수수", "엘리카", "능소화", "석류", "진달래", "시스터스", "빨강무늬제라늄", "협죽도", "골든", "저먼더", "타마린드", "튤립나무",
            "로사", "프리지아", "짚신나물", "스피리아", "금잔화", "안스륨", "하이포시스", "고비", "에린지움", "꽃담배", "호랑이꽃", "멕시칸", "마거리트",
            "뱀무", "한련", "오렌지", "갓개매취", "알로에", "클레마티스", "버드나무", "마르멜로", "다알리아", "용담", "에리카", "엉겅퀴", "사초", "로즈메리",
            "퀘이킹", "주목", "메귀리", "색비름", "살구", "단풍나무", "종려나무", "개암나무", "전나무", "파슬리", "희향", "멜론", "부처꽃", "월귤",
            "조팝나무", "스위트", "이끼장미", "포도", "넌출월귤", "벗풀", "흰독말풀", "매화", "해당화", "로벨리아", "칼라", "서양모과", "루피너스", "브리오니아",
            "골고사리", "등골나물", "가는동자꽃", "부용", "흰동백", "레몬", "황금싸리", "머위", "산나리", "뷰글라스", "매자나무", "개옻나무", "서양톱풀",
            "붉나무", "바카리스", "낙엽", "쑥국화", "앰브로시아", "바위취", "갈대", "국화", "목화", "자홍색", "오리나무", "세이지", "스노",
            "파인애플", "백일홍", "플라타너스", "겨우살이", "서양호랑가시나무", "꽈리", "납매", "노송나무"
    );

    final int adjLength = adjectives.size();
    final int flowerLength = flowers.size();
    final Random random = new Random();

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User getUser(String token) {
        Optional<UserEntity> userEntity = userRepository.findByToken(token);
        UserEntity entity = userEntity.orElseThrow(() -> { throw new IllegalArgumentException("not exists user");});

        User user = new User();
        user.setNickname(entity.getNickname());
        user.setToken(entity.getToken());
        user.setDeviceToken(entity.getDeviceToken());
        user.setNotiYn(entity.isNotiYn());
        return user;
    }

    public User registerUser(User.Create user) {
        user.setNickname(generateRandomNickname());

        Optional<UserEntity> userEntity = userRepository.findByToken(user.getToken());

        userEntity.ifPresent(u -> {
            throw new IllegalArgumentException("already exists");
        });

        UserEntity entity = userRepository.save(UserEntity.of(user));

        User userResult = new User();
        userResult.setNickname(entity.getNickname());
        userResult.setToken(entity.getToken());
        userResult.setDeviceToken(entity.getDeviceToken());
        return userResult;
    }

    public String generateRandomNickname() {
        return adjectives.get(random.nextInt(adjLength)) + flowers.get(random.nextInt(flowerLength));
    }

    public void updateUser(User.Update user) {
        Optional<UserEntity> userEntity = userRepository.findByToken(user.getToken());

        UserEntity entity = userEntity.orElseThrow(() -> { throw new IllegalArgumentException("not exists user");});
        entity.setDeviceToken(user.getDeviceToken());
        entity.setNotiYn(user.isNotiYn());
        entity.setNickname(user.getNickname());

        userRepository.flush();
    }

    public void deleteUser(User.Delete user) {
        Optional<UserEntity> userEntity = userRepository.findByToken(user.getToken());
        UserEntity entity = userEntity.orElseThrow(() -> { throw new IllegalArgumentException("not exists user");});
        userRepository.delete(entity);
    }
}
