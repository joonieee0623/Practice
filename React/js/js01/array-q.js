'use strict'
/*
class Student {
    constructor(name, age, enrolled, score){
        this.name = name;
        this.age = age;
        this.enrolled = enrolled;
        this.score = score;
    }
}
const students= [
    new Student('홍길동',30, true, 46),
    new Student('이순신',29, false, 81),
    new Student('강감찬',31, true, 91),
    new Student('유관순',40, false, 67),
    new Student('세종대왕',19, true, 89),
];
*/

const students= [
  {name:'홍길동', age:30, enrolled:true, score:46},
  {name:'이순신', age:29, enrolled:false, score:81},
  {name:'강감찬', age:31, enrolled:true, score:91},
  {name:'유관순', age:40, enrolled:false, score:67},
  {name:'세종대왕', age:19, enrolled:true, score:89},
];

//[Q1] 91점을 받은 학생을 찾으시오
{
  //find<S extends T>(predicate: (value: T, index: number, obj: T[]) => value is S, thisArg?: any): S | undefined; //단 하나의 요소
  let result = students.find(function(currentValue){ return currentValue.score == 91 })
  console.log(result)
  console.clear()
}

//[Q2] 등록된 학생들 배열을 만드시오
{
  //filter<S extends T>(predicate: (value: T, index: number, array: T[]) => value is S, thisArg?: any): S[];
  let result = students.filter(function(currentValue){ return currentValue.enrolled })
  console.log(result)
  console.clear()
}

//[Q3] 점수들의 배열을 만드시오 ( 결과: [46, 81, 91, 67, 89] )
{
  //map<U>(callbackfn: (value: T, index: number, array: T[]) => U, thisArg?: any): U[];
  let result = students.map( student => student.score )
  console.log(result)
  // console.clear()
}

//[Q4] 50점보다 낮은 학생이 있는 지 체크하시오
{
  //some(predicate: (value: T, index: number, array: T[]) => unknown, thisArg?: any): boolean; //truthy, falsy
  let result = students.some( student => student.score<50 )
  if (result){ console.log('50점 미만 학생 있음') }
  // console.clear()
}

//[Q5] 스코어의 평균을 출력하시오
{
  //forEach(callbackfn: (value: T, index: number, array: T[]) => void, thisArg?: any): void;
  //map<U>(callbackfn: (value: T, index: number, array: T[]) => U, thisArg?: any): U[];
  //(1) map과 forEach 이용
  let sum1 = 0
  students.map( student => student.score ).forEach( item => sum1 += item )
  let result = sum1 / students.length
  console.log(result)


  //reduce<U>(callbackfn: (previousValue: U, currentValue: T, currentIndex: number, array: T[]) => U, initialValue: U): U;
  //(2) reduce 이용
  let score = students.map( student => student.score )
  let sum2 = score.reduce( (pValue, cValue) => pValue+cValue, 0 )
  let average = sum2 / students.length
  console.log(average)
//   console.clear()
}

//[Q6] 50점 이상 점수들의 문자열을 만드시오 ( 결과: '81,91,67,89' )
{
  //filter<S extends T>(predicate: (value: T, index: number, array: T[]) => value is S, thisArg?: any): S[];
  //(1) 변수를 이용 (map 과 filter 이용)
  let highscore = students.filter( student => student.score>50 )
  let result = highscore.map( item => item.score ).join(',')
  console.log(result)


  //(2) 변수를 이용X
  console.log(students.filter( student => student.score>50 ).map( item => item.score ).join(','))
//   console.clear() 
}

//[Q7] 점수들을 오름차순으로 정렬된 '문자열'을 만드시오 ( 결과: '46,67,81,89,91' )
{
  //(1) 점수배열
  let scoreArr = students.map( student => student.score )
  console.log(scoreArr)

  //(2) 정렬
  let result = scoreArr.sort( (a, b) => a-b ) //음수면 a가 b보다 앞
  console.log(result)

  //(3) (1)과 (2)를 결합
  console.log(result.join(','))
  // console.clear()
}

//[Q8] 이름들을 내림차순 정렬한 '문자열'을 만드시오 ( ex: 홍길동|이순신|유관순|세종대왕|강감찬 )
{
  //(1) 이름들 배열
  let names = students.map( student => student.name )
  console.log(names)

  //(2) 정렬
  let result = names.sort( (a, b) => b.localeCompare(a) )
  console.log(result)

  //(3) (1)과 (2)를 결합
  console.log(result.join('|'))
  // console.clear()
}